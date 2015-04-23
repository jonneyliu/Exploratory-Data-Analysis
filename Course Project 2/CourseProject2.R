###Explanatory Data Anaysis Course Project 2

library(plyr)
library(ggplot2)


### Read Data using readRDS
NEI <- readRDS("./exploratory analysis/Course Project 2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exploratory analysis/Course Project 2/exdata-data-NEI_data/Source_Classification_Code.rds")

# NEI_byyear <- tapply(NEI$Emissions,NEI$year,sum)
# NEI_byyear <- tapply(NEI$Emissions,NEI$year,sum,simplify = FALSE)
# 
# NEI_byyear <- apply(NEI, 2, function(x) tapply(x, NEI$year, sum))



### Question 1


##Aggregate data by summing total emissions per year using ddply, can alsop be done with tapply and aggregate
df <- ddply(NEI,c("year"),summarise,total = sum(Emissions))


# totalEmission <- aggregate(NEI$Emissions, list(NEI$year), FUN=sum)
# totalEmission1 <- aggregate(NEI$Emissions, NEI$year, FUN=sum)


# plot(NEI_byyear,type="l",xlab="Year",ylab="Total Emissions")

##Plot line graph
plot(df,type="l",xlab="Year",ylab="Total Emissions")
# plot(totalEmission, type="l", xlab="Year", main="Total Emissions in the US from 1999 until 2008")

##Plot bar graph, but must first change df to matrix
barplot(t(as.matrix(df$total))/10e6, beside=FALSE, xlab= "year",names.arg=df$year,ylab="PM2.5 emissions (10^6 Tons)", main="Total PM 2.5 Emissions in US")
##Create png in folder
dev.copy(png, file="./exploratory analysis/Course project 2/plot1.png", height=480, width=480)
dev.off()


### Question 2

###select susbet from baltimore i.e. fips == 24510
Baltimore <- NEI[NEI$fips==24510,]
df_Baltimore <- ddply(Baltimore,c("year"),summarise,total = sum(Emissions))
barplot(t(as.matrix(df_Baltimore$total)), beside=FALSE, xlab= "year",names.arg=df_Baltimore$year,ylab="PM2.5 emissions (10^6 Tons)", main="Total PM 2.5 Emissions in Baltimore")
dev.copy(png, file="./exploratory analysis/Course project 2/plot2.png", height=480, width=480)
dev.off()


### Question 3
df_type_Baltimore <- ddply(Baltimore,c("year","type"),summarise,total = sum(Emissions))

g <- ggplot(df_type_Baltimore,aes(x=year,y=total,col=type))+geom_line()
g <- g + ggtitle("PM2.5 Emission by Baltimore")
g <- g + scale_color_discrete(name="Source Type")
g <- g + ylab("PM2.5 Emission (Tons)")
g
dev.copy(png, file="./exploratory analysis/Course project 2/plot3.png", height=480, width=480)
dev.off()


### Question 4

comb <-  grepl("comb",SCC$SCC.Level.One,ignore.case= TRUE)
coal <- grepl("coal",SCC$SCC.Level.Four,ignore.case= TRUE)
comb_coal_extract <- (comb&coal)

SCC_combcoal <- SCC[comb_coal_extract,]$SCC
NEI_combcoal <- NEI[NEI$SCC %in% SCC_combcoal,]

df_NEIcombcoal <-  aggregate(NEI_combcoal$Emissions, list(NEI_combcoal$year), FUN=sum)

barplot(t(as.matrix(df_NEIcombcoal$x))/10e3, beside=FALSE, xlab= "year",names.arg=df_Baltimore$year,ylab="PM2.5 emissions (10^3 Tons)", main="PM 2.5 Emissions from Coal Combustion")
dev.copy(png, file="./exploratory analysis/Course project 2/plot4.png", height=480, width=480)
dev.off()

### Question 5
unique(SCC$EI.Sector)
criteria <- unique(SCC$EI.Sector)[21:24]
paste(criteria,collapse="|")
onroad_mobile <- grepl(criteria,SCC$EI.Sector,ignore.case=TRUE)
SCC_mobile <- SCC[onroad_mobile,]$SCC
Baltimore <- NEI[NEI$fips==24510,]
NEI_Baltimore_mobile <- Baltimore[Baltimore$SCC %in% SCC_mobile,]

df_Baltimore_mobile <- ddply(NEI_Baltimore_mobile,c("year"),summarise,total = sum(Emissions))
barplot(t(as.matrix(df_Baltimore_mobile$total)), beside=FALSE,col="Blue", xlab= "year",names.arg=df_Baltimore_mobile$year,ylab="PM2.5 emissions (Tons)", main="Total PM 2.5 Emissions in Baltimore")

dev.copy(png, file="./exploratory analysis/Course project 2/plot5.png", height=480, width=480)
dev.off()
  ###ggplot version

g <- ggplot(df_Baltimore_mobile,aes(x=year,y=total))+geom_bar(aes(fill=year))

g<-ggplot(data=df_Baltimore_mobile, aes(x=year, y=total)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
  ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
  ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
  geom_text(aes(label=round(total,0), size=1, hjust=0.5, vjust=2))
g



### Question 6

criteria <- unique(SCC$EI.Sector)[21:24]
paste(criteria,collapse="|")
onroad_mobile <- grepl(criteria,SCC$EI.Sector,ignore.case=TRUE)
SCC_mobile <- SCC[onroad_mobile,]$SCC

LA_Baltimore <- NEI[(NEI$fips=="24510")|(NEI$fips=="06037"),]
df_LA_Baltimore_mobile <- ddply(LA_Baltimore,c("year","fips"),summarise,total = sum(Emissions))

maxlim = max(ceiling($tons))
d <- ggplot(data=df_LA_Baltimore_mobile, aes(x=year, y=total, fill=fips)) + geom_bar(stat="identity", position=position_dodge()) + 
  scale_fill_brewer(palette="Set2") 
d <- d + ggtitle("PM2.5 emissions 1999-2008:\nBaltimore City vs. LA County Vehicle & Traffic\n") 
d <- d + theme(plot.title = element_text(size=14, lineheight=.8, face="bold")) 
d <- d + scale_y_continuous(name="Emissions (tons)") + theme(axis.title.y = element_text(face="bold", size=15))
d <- d + theme(axis.title.x = element_text(face="bold", size=15), axis.text.x = element_text(size=12))
d <- d + scale_fill_discrete("FIPS", breaks=c("24510", "06037"), labels=c("Baltimore", "LA County")) 
d <- d+ theme(legend.title = element_text(size=12, face="bold")) + theme(legend.text = element_text(size=12))
d
dev.copy(png, file="./exploratory analysis/Course project 2/plot6.png", height=480, width=480)
dev.off()


features_extract <-  grepl("mean|std", features[,2])

head(SCC)
head(NEI)
tail(SCC)
tail(NEI)
unique(NEI$type)
unique(SCC$EI.Sector)
