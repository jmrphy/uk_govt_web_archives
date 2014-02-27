### Search and Analyze the National Archives of www.number10.gov.uk


#############################################################
#### Enter your search term and the total number of results
#### displayed by a search in the web browser.
searchterm<-"bailout"
totalresults<-"1786"
############################################################

### Creates the sequence of numbers to paginate with
pages<-seq(0, as.numeric(totalresults), 10) 

### Make a character vector of URLs of all the search results
urls<-sprintf("http://webarchive.nationalarchives.gov.uk/search/?lang=en&noneW=&format=all&department_id_51=on&department_id_56=on&site=number10.gov.uk&department_id_54=on&search_type=website&start=%s&x=17&y=13&query=%s&exactW=&where=text", pages, "wage")

### Read the html of each results page into a list
for(i in 1:length(urls)){
  DF<-lapply(urls, function(x) readLines(x))
}