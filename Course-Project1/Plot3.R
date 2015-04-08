##Exploratory Dat Analysis Course Project 1

####Plot 3

#Read full data
dt_full <- read.csv("./exploratory analysis/household_power_consumption.txt",sep = ';',header = TRUE,na.strings="?")

#take subset with below conditions
dt <- dt_full[dt_full$Date=="1/2/2007"|dt_full$Date=="2/2/2007",]

#convert date format using ?strptime example in new column
dt$DateTime <- strptime(paste(dt$Date, dt$Time), "%d/%m/%Y %H:%M:%S")

##draw graph
##plot lines one by one using lines function to plot on top of graph
plot(dt$DateTime,as.numeric(dt$Sub_metering_1),type ="l",ylab="Energy sub metering",xlab="")
lines(dt$DateTime,as.numeric(dt$Sub_metering_2),col="Red")
lines(dt$DateTime,as.numeric(dt$Sub_metering_3),col="Blue")

#add legend
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1, 1, 1), col=c("black", "red", "blue"))

#create png file
dev.copy(png, file="./exploratory analysis/Course project1/plot3.png", height=480, width=480)
dev.off()
