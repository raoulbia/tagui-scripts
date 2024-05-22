
// REMOVE SCREENSHOT DIR AND ZIP
py begin
import shutil, os
shutil.rmtree('C:\\tagui\\flows\\nta\\mate\\screenshots_db')
shutil.rmtree('C:\\tagui\\flows\\nta\\mate\\screenshots_mentz')
shutil.rmtree('C:\\tagui\\flows\\nta\\mate\\screenshots_combined')
os.remove('C:\\tagui\\flows\\nta\\mate\\test_results_screenshots.zip')
py finish

// PART 1 GET 3 SETS OF START AND DESTINATION STOP NAMES AND PLATES CODE TO SEARCH FOR
py begin
import random
import json
from collections import defaultdict
import pandas as pd
fp = 'C:\\tagui\\flows\\nta\\data\\input\\dublinbus_alpharoutes_and stops.csv'
json_data = None
foo = defaultdict(lambda: defaultdict(lambda: defaultdict(dict)))
df = pd.read_csv(fp,
                 dtype=str,
                 encoding='Windows-1252')
for i in range(1, 21):
    random_integer_from = random.randint(1, 2390)
    random_integer_to = random.randint(1, 2390) + 10
    platecode_from = df.iloc[random_integer_from][1]
    platecode_to = df.iloc[random_integer_to][1]
    foo[f'test_{i}']['1'] = platecode_from
    foo[f'test_{i}']['2'] = platecode_to
    json_data = json.dumps(foo)
print(json_data)
py finish

echo `py_result`
res = JSON.parse(py_result)

// PART 2 PERFORM SEARCH ON WEBSITE


py from collections import defaultdict
py from pprint import pprint
py from datetime import datetime, timedelta

// Dict to store results
py d = {}

// INIT TEST RUN ID
py TRID = 1

// TEST RUN LOOP
for i from 1 to 20
    py print(f'TESTRUN: {TRID}')
    echo `py_result`
    wait 1
    
    // capture test time
    py testtime = datetime.now()
    py testtime = testtime.strftime("%H:%M")
    // py print(testtime)
    // echo `py_result`

    // init idx var    
    idx = 'test_'+ (i)

    // capture stop number
    stop_id = res[idx][1]
    py_step('stop_id = "' + stop_id + '"')
    // echo `stop_id`

    // MENTZ /////////////////////////////////////////////////////////////////////////////////////////////
    http://a-b.ie/nta/XSLT_DM_REQUEST?itdLPxx_template=odvbox&language=en
    wait 1
    click //*[@id="onetrust-accept-btn-handler"]
    click //*[@id="std3_dm_input"]
    type //*[@id="std3_dm_input"] as `res[idx][1]`, stop[enter]
    wait 2

    // take screenshot
    snap page to screenshots_mentz\\`timestamp()`_TRID_`i`_MENTZ.png    
    
    

    // DB //////////////////////////////////////////////////////////////////////////////////////////////
    https://www.dublinbus.ie/RTPI/Sources-of-Real-Time-Information/?searchtype=view&searchquery=`res[idx][1]`
    wait 2

    // take screenshot
    snap page to screenshots_db\\`timestamp()`_TRID_`i`_DB.png
        
        
    py TRID = TRID + 1

py pprint(d)
echo `py_result`

// PART 3 POST PROCESSING AFTER ALL TEST RUNS ARE COMPLETED
py begin
import os
import cv2
import numpy as np
from pathlib import Path
import win32com.client as win32



img_dir_db = Path('C:\\tagui\\flows\\nta\\mate\\screenshots_db')
img_dir_mentz = Path('C:\\tagui\\flows\\nta\\mate\\screenshots_mentz')
img_out_dir = Path('C:\\tagui\\flows\\nta\\mate\\screenshots_combined')
try:
    img_out_dir.mkdir(parents=True, exist_ok=False)
    print('Done creating directory')
except FileExistsError:
    print('Folder already exists')


for img_db, img_mentz in zip (img_dir_db.rglob('*.png'), img_dir_mentz.rglob('*.png')):
    fp_db = Path(os.fsdecode(img_db))
    fn_db = fp_db.stem

    fp_mentz = Path(os.fsdecode(img_mentz))
    fn_mentz = fp_mentz.stem

    fn_out = fn_db[:-3]

    img1 = cv2.imread(str(fp_db))
    img2 = cv2.imread(str(fp_mentz))


    h1, w1 = img1.shape[:2]
    h2, w2 = img2.shape[:2]

    #create empty matrix
    vis = np.zeros((max(h1, h2), w1+w2,3), np.uint8)

    #combine 2 images
    vis[:h1, :w1,:3] = img1
    vis[:h2, w1:w1+w2,:3] = img2


    cv2.imwrite(f'{img_out_dir}/{fn_out}.png', vis)

def zip_screenshots():
    dir = f'C:\\tagui\\flows\\nta\\mate\\screenshots_combined'    
    output_filename = 'C:\\tagui\\flows\\nta\\mate\\test_results_screenshots'
    shutil.make_archive(output_filename, 'zip', dir)
    print('done zipping...')

def send_email():
    sender = 'raoulbia@gmail.com'
    receivers = 'raoul.biagioni@nationaltransport.ie;Mate.Mirkovic@nationaltransport.ie'
    outlook = win32.Dispatch('outlook.application')
    mail = outlook.CreateItem(0)
    mail.To = receivers
    mail.Subject = f'Journey Planner testing'
    mail.Body = 'Message body'
    mail.HTMLBody = '<p>This is an automated email.</p>'

    fp = 'C:\\tagui\\flows\\nta\\mate\\test_results_screenshots.zip'
    mail.Attachments.Add(f'{Path(fp)}')

    mail.Send()
    print("Email has been sent!")
    
zip_screenshots()
send_email()
py finish
echo `py_result`