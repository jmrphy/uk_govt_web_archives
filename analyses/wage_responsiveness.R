### Load required packages
require(XML)
require(lubridate)
require(Quandl)
require(reshape)
require(arm)

### Load lists of results saved from /scrape
load("data/api/api_wage.Rdata")

### Parse the lists of XML docs
wagedata<-lapply(DF.wage, function(x) try(xmlParse(x)))

### Extract the timestamps
wagedates <- lapply(wagedata, function(x) try(xpathSApply(x,'//item/nutch:date',xmlValue)))

### Make time-series
wagedf<-as.data.frame(unlist(wagedates))
names(wagedf)<-c("timestamp")
wagedf$year<-substr(wagedf$timestamp, start=1, stop=4)
wagetimeseries<-as.data.frame(table(wagedf$year))
wagetimeseries$Year<-as.Date(as.character(wagetimeseries$Var1), "%Y")
wagetimeseries$year<-year(wagetimeseries$Year)
wagetimeseries$Term<-"Wage"
wagetimeseries<-wagetimeseries[2:8,]

realwages<-read.csv('http://www.quandl.com/api/v1/datasets/MWORTH/4_2.csv?&trim_start=1790-12-31&trim_end=2009-12-31&sort_order=desc', colClasses=c('Year'='Date'))
realwages$year<-year(realwages$Year)

df<-merge(wagetimeseries, realwages, by="year")
df$FrequencyIndex<-rescale(df$Freq)
df$RealWageIndex<-rescale(df$Value)
df<-df[,c("year", "FrequencyIndex", "RealWageIndex")]
df<-melt(df, id="year")
#df$year<-as.Date(as.character(df$year), "%Y")
#df$year<-substr(df$year, start=1, stop=4)
#df$year<-year(df$year)

png("graphs/wage_responsiveness.png")
qplot(year, value, data=df, geom="line", colour=variable,
      main="Real Wages and UKGWA Mentions of \"Wage\"") + theme_bw()
dev.off()
