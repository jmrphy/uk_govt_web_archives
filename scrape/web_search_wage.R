#### Scrape public web search for a term and 
#### create time series data

searchterm<-"wage"
totalresults<-"5000"


### Creates the sequence of numbers to paginate with
pages<-seq(0, as.numeric(totalresults), 10) 

### Make a character vector of URLs of all the search results
urls<-sprintf("http://webarchive.nationalarchives.gov.uk/search/?lang=en&noneW=&format=all&department_id_51=on&department_id_56=on&site=number10.gov.uk&department_id_54=on&search_type=website&start=%s&x=17&y=13&query=%s&exactW=&where=text", pages, searchterm)

### Read the html of each results page into a list
for(i in 1:length(urls)){
  DF<-lapply(urls, function(x) readLines(x))
}

### Save list of result pages into /data/web_search_scrapes/wage_5000.Rdata"
save(DF, file="/Users/justin/Dropbox/Side Projects/uk_govt_web_archives/data/web_search_scrapes/wage_5000.Rdata")

df<-unlist(DF) ### Convert list of html docs to one character vector

foundlines<-df[grep('Archived at',df)] ### Select only lines in html containing "Archived at"

mypattern = 'Archived at: ([^<]*)</span>' # Define a pattern to identify dates

datelines = grep(mypattern,foundlines,value=TRUE)

getexpr = function(s,g)substring(s,g,g+attr(g,'match.length')-1)
gg = gregexpr(mypattern,datelines)
matches = mapply(getexpr,datelines,gg)
result = gsub(mypattern,'\\1',matches)
names(result) = NULL
result

data <- as.data.frame(matrix(result,ncol=1,byrow=TRUE))
names(data) = c('date')
head(data)

require(lubridate)
data$year<-year(data$date)
timeseries<-as.data.frame(table(data$year))
timeseries$Year<-as.Date(timeseries$Var1, "%Y")

require(ggplot2)
qplot(Year, Freq, data=timeseries, geom="line", main="Frequency of \"wage\" in National Archive of Prime Minister's Website") + theme_bw()