### Load required packages
require(XML)
require(lubridate)
require(Quandl)
require(reshape)
require(arm)

### Load lists of results saved from /scrape
load("data/api/api_inflation.Rdata")

### Parse the lists of XML docs
inflationdata<-lapply(DF.inflation, function(x) try(xmlParse(x)))

### Extract the timestamps
inflationdates <- lapply(inflationdata, function(x) try(xpathSApply(x,'//item/nutch:date',xmlValue)))

### Make time-series
inflationdf<-as.data.frame(unlist(inflationdates))
names(inflationdf)<-c("timestamp")
inflationdf$year<-substr(inflationdf$timestamp, start=1, stop=4)
inflationtimeseries<-as.data.frame(table(inflationdf$year))
inflationtimeseries$Year<-as.Date(as.character(inflationtimeseries$Var1), "%Y")
inflationtimeseries$year<-year(inflationtimeseries$Year)
inflationtimeseries$Term<-"inflation"


realinflation<-read.csv('http://www.quandl.com/api/v1/datasets/UKONS/MM23_D7G7_M.csv?&trim_start=1989-01-31&trim_end=2014-01-31&sort_order=desc', colClasses=c('Date'='Date'))
realinflation$year<-substr(realinflation$Date, start=1, stop=4)
realinflation<-aggregate(realinflation, by=list(realinflation$year), mean)
realinflation$year<-realinflation$Group.1

df<-merge(inflationtimeseries, realinflation, by="year")
df$FrequencyIndex<-rescale(df$Freq)
df$RealinflationIndex<-rescale(df$Value)
df<-df[,c("year", "FrequencyIndex", "RealinflationIndex")]
df<-melt(df, id="year")
#df$year<-as.Date(as.character(df$year), "%Y")
#df$year<-substr(df$year, start=1, stop=4)
#df$year<-year(df$year)

png("graphs/inflation_responsiveness.png", width = 600, height = 480)
qplot(year, value, data=df, geom="line", colour=variable,
      main="Real inflation and UKGWA Mentions of \"inflation\"") + theme_bw()
dev.off()