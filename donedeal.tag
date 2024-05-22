dump adtitle,year,engine,odometer,date_posted,date_scraped,location,price,seller,details to `timestamp()`_donedeal.csv

params = 'transmission=Automatic&bodyType=Saloon&fuelType=Petrol&year_from=2015&price_from=15000&price_to=25000&mileage_to=100000&engine_from=1400&engine_to=1800'

https://www.donedeal.ie/cars?`params`

// get nbr cars returned
read //*[@id="__next"]/div[1]/div[2]/div[3]/div/div/div[2]/div[1]/h2/span/strong[1] to totalCount

resultsPerPage = 30
totalPages = Math.floor(totalCount / resultsPerPage)
hasRemainder = totalCount % resultsPerPage !== 0
numberOfPages = totalPages + (hasRemainder ? 1 : 0)

echo `numberOfPages` pages to scrape
start = 0
for (i from 1 to `numberOfPages`)
    https://www.donedeal.ie/cars?start=`start`&`params`
    for (n=1; n<=30; n=n+2)
        if present ('//html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div/div[2]/div[1]/p')
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div/div[2]/div[1]/p to title
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div/div[2]/div[1]/ul/li[1] to year
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div/div[2]/div[1]/ul/li[2] to engine
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div/div[2]/div[1]/ul/li[3] to odometer
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div/div[2]/div[1]/ul/li[4] to date_posted
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div/div[2]/div[1]/ul/li[5] to loc
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div/div[2]/div[2] to price
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div[1]/div/div[2] to seller
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div/div[2]/ul to details
        else if present ('//html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div[2]/div[1]/p') 
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div[2]/div[1]/p to title
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div[2]/div[1]/ul/li[1] to year
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div[2]/div[1]/ul/li[2] to engine
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div[2]/div[1]/ul/li[3] to odometer
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div[2]/div[1]/ul/li[4] to date_posted
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div[2]/div[1]/ul/li[5] to loc
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div[2]/div[2] to price
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div[1]/div/div[2] to seller
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/div/div/div[2]/ul to details
        else if present ('//html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/a/div/div/div[2]/div[1]/p') 
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/a/div/div/div[2]/div[1]/p to title
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/a/div/div/div[2]/div[1]/ul/li[1] to year
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/a/div/div/div[2]/div[1]/ul/li[2] to engine
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/a/div/div/div[2]/div[1]/ul/li[3] to odometer
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/a/div/div/div[2]/div[1]/ul/li[4] to date_posted
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/a/div/div/div[2]/div[1]/ul/li[5] to loc
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/a/div/div/div[2]/div[2] to price
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/a/div/div[1]/div/div[2] to seller
            read //html/body/div[2]/div[1]/div[2]/div[3]/div/div/div[2]/ul/li[`n`]/a/div/div/div[2]/ul to details
        else
            continue
        write `title.replace(",", "")`,`year`,`engine`,`odometer.replace(",", "")`,`date_posted`,`timestamp2()`,`loc.split(".")[1].trim()`,`price.replace(",", "")`,`seller`,`details.replace(",","")` to `timestamp()`_donedeal.csv
    start = `start` + 30