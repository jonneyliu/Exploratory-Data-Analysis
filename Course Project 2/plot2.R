### Explanatory Data Analysis: Course Project 2

###Plot 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

library(plyr)
library(ggplot2)

##Read in data
NEI <- readRDS("./exploratory analysis/Course Project 2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exploratory analysis/Course Project 2/exdata-data-NEI_data/Source_Classification_Code.rds")

###select susbet from baltimore i.e. fips == 24510
Baltimore <- NEI[NEI$fips==24510,]

##aggregate data
df_Baltimore <- ddply(Baltimore,c("year"),summarise,total = sum(Emissions))

##bar plot for Baltimore
barplot(t(as.matrix(df_Baltimore$total)), beside=FALSE, xlab= "year",names.arg=df_Baltimore$year,ylab="PM2.5 emissions (10^6 Tons)", main="Total PM 2.5 Emissions in Baltimore")

##Create png
dev.copy(png, file="./exploratory analysis/Course project 2/plot2.png", height=480, width=480)
dev.off()
