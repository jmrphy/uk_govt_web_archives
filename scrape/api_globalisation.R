##############################################################################
### Scrape full-text search results from the UK Government Website Archive API
##############################################################################
#############################################################
#### Enter your search term and the total number of API pages
#### to paginate through
searchterm<-"globalisation"
totalpages<-"15000" 
############################################################
require(XML)
require(RCurl)

### Creates the sequence of numbers to paginate with
pages<-seq(0, as.numeric(totalpages), 1) 

### Make a character vector of URLs of all the search results
urls<-sprintf("http://tnaftindex.internetmemory.org/nutch-1.0-tna-distrib-ssd/opensearch?query=%s?page=%s", searchterm, pages)

### Read the html of each results page into a list
DF.globalisation<-lapply(urls, function(x) suppressWarnings(try(readLines(x), TRUE)))

### Save
setwd("~/Desktop")
save(DF.globalisation, file="api_globalisation.Rdata")
rm(DF.globalisation)


searchterm<-"capitalism"
totalpages<-"15000" 
############################################################

### Creates the sequence of numbers to paginate with
pages<-seq(0, as.numeric(totalpages), 1) 

### Make a character vector of URLs of all the search results
urls<-sprintf("http://tnaftindex.internetmemory.org/nutch-1.0-tna-distrib-ssd/opensearch?query=%s?page=%s", searchterm, pages)

### Read the html of each results page into a list
DF.capitalism<-lapply(urls, function(x) suppressWarnings(try(readLines(x), TRUE)))

### Save
save(DF.capitalism, file="api_capitalism.Rdata")
rm(DF.capitalism)


searchterm<-"market"
totalpages<-"15000" 
############################################################

### Creates the sequence of numbers to paginate with
pages<-seq(0, as.numeric(totalpages), 1) 

### Make a character vector of URLs of all the search results
urls<-sprintf("http://tnaftindex.internetmemory.org/nutch-1.0-tna-distrib-ssd/opensearch?query=%s?page=%s", searchterm, pages)

### Read the html of each results page into a list
DF.market<-lapply(urls, function(x) suppressWarnings(try(readLines(x), TRUE)))

### Save
save(DF.market, file="api_market.Rdata")
rm(DF.market)



searchterm<-"global%20economy"
totalpages<-"15000" 
############################################################

### Creates the sequence of numbers to paginate with
pages<-seq(0, as.numeric(totalpages), 1) 

### Make a character vector of URLs of all the search results
urls<-sprintf("http://tnaftindex.internetmemory.org/nutch-1.0-tna-distrib-ssd/opensearch?query=%s?page=%s", searchterm, pages)

### Read the html of each results page into a list
DF.globaleconomy<-lapply(urls, function(x) suppressWarnings(try(readLines(x), TRUE)))

### Save
save(DF.globaleconomy, file="api_globaleconomy.Rdata")
rm(DF.globaleconomy)



searchterm<-"economy"
totalpages<-"15000" 
############################################################

### Creates the sequence of numbers to paginate with
pages<-seq(0, as.numeric(totalpages), 1) 

### Make a character vector of URLs of all the search results
urls<-sprintf("http://tnaftindex.internetmemory.org/nutch-1.0-tna-distrib-ssd/opensearch?query=%s?page=%s", searchterm, pages)

### Read the html of each results page into a list
DF.economy<-lapply(urls, function(x) suppressWarnings(try(readLines(x), TRUE)))

### Save
save(DF.economy, file="api_economy.Rdata")
rm(DF.economy)


searchterm<-"financial"
totalpages<-"15000" 
############################################################

### Creates the sequence of numbers to paginate with
pages<-seq(0, as.numeric(totalpages), 1) 

### Make a character vector of URLs of all the search results
urls<-sprintf("http://tnaftindex.internetmemory.org/nutch-1.0-tna-distrib-ssd/opensearch?query=%s?page=%s", searchterm, pages)

### Read the html of each results page into a list
DF.financial<-lapply(urls, function(x) suppressWarnings(try(readLines(x), TRUE)))

### Save
save(DF.financial, file="api_finance.Rdata")
rm(DF.financial)


searchterm<-"bank"
totalpages<-"15000" 
############################################################

### Creates the sequence of numbers to paginate with
pages<-seq(0, as.numeric(totalpages), 1) 

### Make a character vector of URLs of all the search results
urls<-sprintf("http://tnaftindex.internetmemory.org/nutch-1.0-tna-distrib-ssd/opensearch?query=%s?page=%s", searchterm, pages)

### Read the html of each results page into a list
DF.bank<-lapply(urls, function(x) suppressWarnings(try(readLines(x), TRUE)))

### Save
save(DF.bank, file="api_bank.Rdata")
rm(DF.bank)
