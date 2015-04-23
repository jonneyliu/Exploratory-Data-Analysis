### Explanatory Data Analysis: Course Project 2

###Plot 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County,
# California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

library(plyr)
library(ggplot2)

##Read in data
NEI <- readRDS("./exploratory analysis/Course Project 2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exploratory analysis/Course Project 2/exdata-data-NEI_data/Source_Classification_Code.rds")


##Similar to plot 5, we define criteria that equates to motor vehicle in EI.Sector
criteria <- unique(SCC$EI.Sector)[21:24]
paste(criteria,collapse="|")
onroad_mobile <- grepl(criteria,SCC$EI.Sector,ignore.case=TRUE)
SCC_mobile <- SCC[onroad_mobile,]$SCC ##return emission sources that are 'motor vehicle


##select only data in the 2 areas
LA_Baltimore <- NEI[(NEI$fips=="24510")|(NEI$fips=="06037"),] 

#Filters out data so condition above is satisfied in NEI
NEI_LA_Baltimore_mobile <- LA_Baltimore[LA_Baltimore$SCC %in% SCC_mobile,] 

#Create data frame summary
df_LA_Baltimore_mobile <- ddply(NEI_LA_Baltimore_mobile,c("year","fips"),summarise,total = sum(Emissions))


##Since we are examing change over time as relative measure, we want to see progress of emissions from beginning 1999
df1 <- df_LA_Baltimore_mobile
mutate(df1[df1$fips=="06037",],change = total/total[1]) #divide all LA county emissions by 1999 count
mutate(df1[df1$fips=="24510",],change = total/total[1]) #divide all Baltimore city emissions by 1999 count as base

##bind the 2 subsets
df1 <-rbind(mutate(df1[df1$fips=="06037",],change = total/total[1]),mutate(df1[df1$fips=="24510",],change = total/total[1]))



##ggplot graph
d <- ggplot(data=df1, aes(x=factor(year), y=change, fill=fips)) + geom_bar(stat="identity", position=position_dodge()) + 
  scale_fill_brewer(palette="Set2") 
d <- d + ggtitle("Proportion of PM2.5 emissions 1999-2008:\nBaltimore City vs. LA County Vehicle & Traffic\n(1999 as base 100)") 
d <- d + theme(plot.title = element_text(size=14, lineheight=.8, face="bold")) 
d <- d + scale_y_continuous(name="Emissions (tons)") + theme(axis.title.y = element_text(face="bold", size=15))
d <- d + theme(axis.title.x = element_text(face="bold", size=15), axis.text.x = element_text(size=12))
d <- d + scale_fill_discrete("FIPS", breaks=c("24510", "06037"), labels=c("Baltimore", "LA County")) 
d <- d+ theme(legend.title = element_text(size=12, face="bold")) + theme(legend.text = element_text(size=12))
d


dev.copy(png, file="./exploratory analysis/Course project 2/plot6.png", height=480, width=480)
dev.off()

?ifelse
