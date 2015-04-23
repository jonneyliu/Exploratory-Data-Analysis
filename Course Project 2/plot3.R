### Explanatory Data Analysis: Course Project 2

###Plot 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999???2008 for Baltimore City?
# Which have seen increases in emissions from 1999???2008? Use the ggplot2 plotting system to make a plot answer this question.


library(plyr)
library(ggplot2)

##Read in data
NEI <- readRDS("./exploratory analysis/Course Project 2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exploratory analysis/Course Project 2/exdata-data-NEI_data/Source_Classification_Code.rds")

##Aggregate data by year AND type
df_type_Baltimore <- ddply(Baltimore,c("year","type"),summarise,total = sum(Emissions))

## Using ggplot create emission plot over time for each type (non-road, non-point, on-road, point)
g <- ggplot(df_type_Baltimore,aes(x=year,y=total,col=type))+geom_line()
g <- g + ggtitle("PM2.5 Emission in Baltimore") # add title
g <- g + scale_color_discrete(name="Source Type") #add name to legend
g <- g + ylab("PM2.5 Emission (Tons)") #add y label
g

#Create png
dev.copy(png, file="./exploratory analysis/Course project 2/plot3.png", height=480, width=480)
dev.off()
