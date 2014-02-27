### Load required packages
require(XML)
require(lubridate)
require(Quandl)
require(reshape)
require(arm)

### Load lists of results saved from /scrape
load("data/api/api_Unemployment.Rdata")

### Parse the lists of XML docs
Unemploymentdata<-lapply(DF.unemployment, function(x) try(xmlParse(x)))

### Extract the timestamps
Unemploymentdates <- lapply(Unemploymentdata, function(x) try(xpathSApply(x,'//item/nutch:date',xmlValue)))

### Make time-series
Unemploymentdf<-as.data.frame(unlist(Unemploymentdates))
names(Unemploymentdf)<-c("timestamp")
Unemploymentdf$year<-substr(Unemploymentdf$timestamp, start=1, stop=4)
Unemploymenttimeseries<-as.data.frame(table(Unemploymentdf$year))
Unemploymenttimeseries$Year<-as.Date(as.character(Unemploymenttimeseries$Var1), "%Y")
Unemploymenttimeseries$year<-year(Unemploymenttimeseries$Year)
Unemploymenttimeseries$Term<-"Unemployment"


realunemployment<-read.csv('http://www.quandl.com/api/v1/datasets/UKONS/LMS_MGSX_M.csv?&trim_start=1971-02-28&trim_end=2013-11-30&sort_order=desc', colClasses=c('Year'='Date'))
realunemployment$year<-year(realunemployment$Year)
realunemployment$year<-substr(realunemployment$year, start=1, stop=4)
realunemployment<-aggregate(realunemployment, by=list(realunemployment$year), mean)
realunemployment$year<-realunemployment$Group.1

df<-merge(Unemploymenttimeseries, realunemployment, by="year")
df$FrequencyIndex<-rescale(df$Freq)
df$RealUnemploymentIndex<-rescale(df$Value)
df<-df[,c("year", "FrequencyIndex", "RealUnemploymentIndex")]
df<-melt(df, id="year")
#df$year<-as.Date(as.character(df$year), "%Y")
#df$year<-substr(df$year, start=1, stop=4)
#df$year<-year(df$year)

png("graphs/Unemployment_responsiveness.png")
qplot(year, value, data=df, geom="line", colour=variable,
      main="Real unemployment and UKGWA Mentions of \"Unemployment\"") + theme_bw()
dev.off()