### Scraping and Analyzing the UK Government Website Archive @ The National Archives

This repository contains scripts for scraping data from the full-text search API as well as the public web search of UK Government Web Archives hosted by The National Archives. The API requires IP address authorization (email them), but the public web search does not.

This work began as part of the Web Science Research Week at University of Southampton, February 24-28, 2014.

**The data**: The graphs below reflect data scraped from more than 5,0000 government websites since 2000. The scripts can easily download information from millions of websites, but time and computing constraints limited this exploratory analysis to 1000 results for each keyword (100 pages of results each).

**Hypotheses**: We began with the idea of analyzing the frequency of economic terms over time across government websites, with the possibility of comparing these frequencies to real movements in the economy. We were curious to see whether government website attention to economic issues tracked (or failed to track) shifts in the real economy.

**Impact**: Given the nature of this data, this approach could potentially provide one of the largest, data-intensive studies of government responsiveness to the real economy, and one of the first to emphasize the linguistic-ideological character of this responsiveness.

**Limitations**: There is one crucial and significant barrier to the exploratory research question which motivated this first probe of the data. Specifically, the dates associated with each archived web page reflect when they were archived, not when they were posted. Ideally, we'd have dates for when each webpage matching a search query was posted. Qualitative inspection seems to suggest that dates of archive are correlated with the dates on which web pages appeared (if only because pages archived in 2000 presumably reflect pages posted before 2000, pages archived in 2001 reflecting those which appeared after 2000 but before 2001, and so forth), but there is the possibility that pages archived in 2010 were live beginning in 2000 but were simply not found by the archivers until 2010. Obviously, to the degree this characterizes the archiving process, the time series of term-mentions would be very misleading. In other words, there appears to be a systematic component but likely far too much noise to conclude anything at all from these graphs.

**Future work**: A much better approach to capturing the time series of terms' salience, which I would like to consider in the future, would be to scrape the actual article's posted dates from the text of the web pages. This seems doable. Additionally, the API scrapes are very nicely suited to quantitative text analysis, as the API provides the actual text of web items within nicely structured XML.

Again, **the graphs below are purely exploratory proofs of concept**. There are no responsible conclusions one could draw from them at this point. They are demonstrations of an idea and how to possibly pose a question, but in their current form they are likely more noise than signal!




![Comparison of term frequencies](https://raw.github.com/jmrphy/uk_govt_web_archives/master/graphs/term_comparison_graph.png)