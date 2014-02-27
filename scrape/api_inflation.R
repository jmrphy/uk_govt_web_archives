##############################################################################
### Scrape full-text search results from the UK Government Website Archive API
##############################################################################
#############################################################
#### Enter your search term and the total number of API pages
#### to paginate through
searchterm<-"inflation"
totalpages<-"100" 
############################################################
require(XML)
require(RCurl)

### Creates the sequence of numbers to paginate with
pages<-seq(0, as.numeric(totalpages), 1) 

### Make a character vector of URLs of all the search results
urls<-sprintf("http://tnaftindex.internetmemory.org/nutch-1.0-tna-distrib-ssd/opensearch?query=%s?page=%s", searchterm, pages)

### Read the html of each results page into a list
DF.inflation<-lapply(urls, function(x) suppressWarnings(try(readLines(x), TRUE)))

### Save
save(DF.inflation, file="data/api/api_inflation.Rdata")