### Explanatory Data Analysis: Course Project 2

###Plot 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

library(plyr)
library(ggplot2)

##Read in data
NEI <- readRDS("./exploratory analysis/Course Project 2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exploratory analysis/Course Project 2/exdata-data-NEI_data/Source_Classification_Code.rds")

##Aggregate data by summing total emissions per year using ddply, can alsop be done with tapply and aggregate
df <- ddply(NEI,c("year"),summarise,total = sum(Emissions))

## Barplot
barplot(t(as.matrix(df$total))/10e6, beside=FALSE, xlab= "year",names.arg=df$year,ylab="PM2.5 emissions (10^6 Tons)", main="Total PM 2.5 Emissions in US")

# ##Simple line plot
# plot(df$year,df$total, type= "l", xlab= "Year", ylab= "PM2.5 Emissions (10^6 Tons)", main="PM2.5 Emissions in US")


#Create png file
dev.copy(png, file="./exploratory analysis/Course project 2/plot1.png", height=480, width=480)
dev.off()
