### Load lists of results saved from /scrape
load("data/api/api_wage.Rdata")
load("data/api/api_profit.Rdata")
load("data/api/api_unemployment.Rdata")
load("data/api/api_inflation.Rdata")
load("data/api/api_inequality.Rdata")

### Parse the lists of XML docs
wagedata<-lapply(DF.wage, function(x) try(xmlParse(x)))
profitdata<-lapply(DF.profit, function(x) try(xmlParse(x)))
unemploymentdata<-lapply(DF.unemployment, function(x) try(xmlParse(x)))
inflationdata<-lapply(DF.inflation, function(x) try(xmlParse(x)))
inequalitydata<-lapply(DF.unemployment, function(x) try(xmlParse(x)))

### Extract the timestamps
wagedates <- lapply(wagedata, function(x) try(xpathSApply(x,'//item/nutch:date',xmlValue)))
profitdates <- lapply(profitdata, function(x) try(xpathSApply(x,'//item/nutch:date',xmlValue)))
unemploymentdates <- lapply(unemploymentdata, function(x) try(xpathSApply(x,'//item/nutch:date',xmlValue)))
inflationdates <- lapply(inflationdata, function(x) try(xpathSApply(x,'//item/nutch:date',xmlValue)))
inequalitydates <- lapply(inequalitydata, function(x) try(xpathSApply(x,'//item/nutch:date',xmlValue)))

#titles <- lapply(data, function(x) xpathSApply(x,'//item/title',xmlValue))
#descriptions <- lapply(data, function(x) xpathSApply(x,'//item/description',xmlValue))
#contents <- lapply(data, function(x) xpathSApply(x,'//item/nutch:content',xmlValue))
#dates <- lapply(data, function(x) xpathSApply(x,'//item/nutch:date',xmlValue))

### Make time-series
require(lubridate)

wagedf<-as.data.frame(unlist(wagedates))
names(wagedf)<-c("timestamp")
wagedf$year<-substr(wagedf$timestamp, start=1, stop=4)
wagetimeseries<-as.data.frame(table(wagedf$year))
wagetimeseries$Year<-as.Date(as.character(wagetimeseries$Var1), "%Y")
wagetimeseries$Year<-year(wagetimeseries$Year)
wagetimeseries$Term<-"Wage"

profitdf<-as.data.frame(unlist(profitdates))
names(profitdf)<-c("timestamp")
profitdf$year<-substr(profitdf$timestamp, start=1, stop=4)
profittimeseries<-as.data.frame(table(profitdf$year))
profittimeseries$Year<-as.Date(as.character(profittimeseries$Var1), "%Y")
profittimeseries$Year<-year(profittimeseries$Year)
profittimeseries$Term<-"Profit"

unemploymentdf<-as.data.frame(unlist(unemploymentdates))
names(unemploymentdf)<-c("timestamp")
unemploymentdf$year<-substr(unemploymentdf$timestamp, start=1, stop=4)
unemploymenttimeseries<-as.data.frame(table(unemploymentdf$year))
unemploymenttimeseries$Year<-as.Date(as.character(unemploymenttimeseries$Var1), "%Y")
unemploymenttimeseries$Year<-year(unemploymenttimeseries$Year)
unemploymenttimeseries$Term<-"Unemployment"

inflationdf<-as.data.frame(unlist(inflationdates))
names(inflationdf)<-c("timestamp")
inflationdf$year<-substr(inflationdf$timestamp, start=1, stop=4)
inflationtimeseries<-as.data.frame(table(inflationdf$year))
inflationtimeseries$Year<-as.Date(as.character(inflationtimeseries$Var1), "%Y")
inflationtimeseries$Year<-year(inflationtimeseries$Year)
inflationtimeseries$Term<-"Inflation"

inequalitydf<-as.data.frame(unlist(inequalitydates))
names(inequalitydf)<-c("timestamp")
inequalitydf$year<-substr(inequalitydf$timestamp, start=1, stop=4)
inequalitytimeseries<-as.data.frame(table(inequalitydf$year))
inequalitytimeseries$Year<-as.Date(as.character(inequalitytimeseries$Var1), "%Y")
inequalitytimeseries$Year<-year(inequalitytimeseries$Year)
inequalitytimeseries$Term<-"Inequality"

df<-rbind(wagetimeseries,profittimeseries,unemploymenttimeseries, inflationtimeseries,inequalitytimeseries)

### Graph
require(ggplot2)
png("graphs/term_comparison_graph.png", width = 600, height = 480)
qplot(Year, Freq, data=df, geom="line", colour=Term, main="Frequency of Economic Terms Across All UK Gov't Websites") + theme_bw()
dev.off()