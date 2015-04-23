### Explanatory Data Analysis: Course Project 2

###Plot 5
# How have emissions from motor vehicle sources changed from 1999???2008 in Baltimore City?

library(plyr)
library(ggplot2)

##Read in data
NEI <- readRDS("./exploratory analysis/Course Project 2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exploratory analysis/Course Project 2/exdata-data-NEI_data/Source_Classification_Code.rds")


## We first need to define what 'motor vehicle sources' is.

unique(SCC$EI.Sector)

##By looking at EI.Sector in data SCC, we define motor vehicle as Mobile and On-road which happens to be 21-24 element in the list

#Define criteria and use grepl function to return logical array
criteria <- unique(SCC$EI.Sector)[21:24]
paste(criteria,collapse="|") #used for the grepl function or statement
onroad_mobile <- grepl(criteria,SCC$EI.Sector,ignore.case=TRUE)

SCC_mobile <- SCC[onroad_mobile,]$SCC #return SCC number that satisfy criteria
Baltimore <- NEI[NEI$fips==24510,]  ## Returns emissions data in NEI that is in Baltimore

NEI_Baltimore_mobile <- Baltimore[Baltimore$SCC %in% SCC_mobile,] #Filters out data so condition above is satisfied in NEI

#Summarize the data
df_Baltimore_mobile <- ddply(NEI_Baltimore_mobile,c("year"),summarise,total = sum(Emissions))

#PLot graph
barplot(t(as.matrix(df_Baltimore_mobile$total)), beside=FALSE,col="Blue", xlab= "year",
        names.arg=df_Baltimore_mobile$year,ylab="PM2.5 emissions (Tons)", main="Total PM 2.5 Emissions in Baltimore")


## Create png
dev.copy(png, file="./exploratory analysis/Course project 2/plot5.png", height=480, width=480)
dev.off()
