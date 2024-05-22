
// to chabge browser settings: tagui/src/tagui_config.txt
// REMOVE SCREENSHOT DIR AND ZIP
// py begin
// import shutil, os
// dir = '/home/baba/tagui/flows/nta/data/output/screenshots'
// shutil.rmtree(dir)
// os.remove('/home/baba/tagui/flows/nta/test_results_screenshots.zip')
// py finish

// PART 1 GET 3 SETS OF START AND DESTINATION STOP NAMES AND PLATES CODE TO SEARCH FOR
py begin
import random
import json
from collections import defaultdict
import pandas as pd
fp = '/home/baba/tagui/flows/nta/data/input/route_short_names.csv'
json_data = None
foo = defaultdict()
df = pd.read_csv(fp,
                 dtype=str,
                 encoding='Windows-1252')

for i in range(1, len(df)):
    foo[i] = df.iloc[i][0]
    json_data = json.dumps(foo)
print(json_data)
py finish

echo `py_result`
res = JSON.parse(py_result)

// PART 2 PERFORM SEARCH ON WEBSITE
for i from 1 to 760
    echo `res[i]`
    // stop_id = `res[i]`

    // MENTZ Route Maps tab /////////////////////////////////////////////////////////////////////////////////////////////
    http://a-b.ie/nta/XSLT_SELTT_REQUEST?itdLPxx_page=rop&language=en
    click //*[@id="onetrust-accept-btn-handler"]
    click //*[@id="std3_sel_seltt_input"]
    type //*[@id="std3_sel_seltt_input"] as `res[i]`[enter]
    wait 1
    if exist ('//*[text()="Operated by"]')
        click //*[text()="Operated by"]
        click //html/body/div[1]/div[1]/main/div/div/div/div[2]/div/div/div/div[2]/div[1]/label
        wait 1
        // take screenshot
        snap //*[@id="std3_map"] to /home/baba/tagui/flows/nta/data/output/screenshots_TISS/`res[i]`.png
    
        
    // Trapeze /////////////////////////////////////////////////////////////////////////////////////////////
    //https://nta-lts-staging.trapezegroupazure.co.uk/timetables
    //https://nta-lts-staging.trapezegroupazure.co.uk/departures
    // https://nta-lts-staging.trapezegroupazure.co.uk/departures?serviceId=WFRD%20`stop_id`
    // wait 
    //click //html/body/div[1]/div/div/div/div/div/nz-auto-option/div
    //wait 10
    //click //html/body/div[1]/div/div/div/div/div/nz-auto-option
    // snap //html/body/lts-root/ion-app/ion-router-outlet/lts-page/div/lts-web-departures-page/div/div[2]/lts-web-departures-map/corus-map/corus-osm-map to /home/baba/tagui/flows/nta/data/output/screenshots_TISS/`stop_id`_TPZ.png
        

