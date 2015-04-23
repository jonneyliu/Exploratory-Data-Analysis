### Explanatory Data Analysis: Course Project 2

###Plot 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999???2008?

library(plyr)
library(ggplot2)

##Read in data
NEI <- readRDS("./exploratory analysis/Course Project 2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exploratory analysis/Course Project 2/exdata-data-NEI_data/Source_Classification_Code.rds")

## Using grepl in SCC we find relevant SCC codes that are from combustion sources by searching in "level.one"
comb <-  grepl("comb",SCC$SCC.Level.One,ignore.case= TRUE) #returns logical array

## Do the same with "coal" sources in "level.four"
coal <- grepl("coal",SCC$SCC.Level.Four,ignore.case= TRUE) #returns logical arrag
comb_coal_extract <- (comb&coal) ##returns logical array if both conditions satisfy

SCC_combcoal <- SCC[comb_coal_extract,]$SCC #extract the relevant SCC codes
NEI_combcoal <- NEI[NEI$SCC %in% SCC_combcoal,] # match the relevant SCC codes in NEI database

##Aggregate the function (using diff method from ddply for sake of learning)
df_NEIcombcoal <-  aggregate(NEI_combcoal$Emissions, list(NEI_combcoal$year), FUN=sum)

##bar plot
barplot(t(as.matrix(df_NEIcombcoal$x))/10e3, beside=FALSE, xlab= "year",names.arg=df_Baltimore$year,ylab="PM2.5 emissions (10^3 Tons)", main="PM 2.5 Emissions from Coal Combustion")
dev.copy(png, file="./exploratory analysis/Course project 2/plot4.png", height=480, width=480)
dev.off()
