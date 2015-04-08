##Exploratory Dat Analysis Course Project 1

####Plot 4

#Read full data
dt_full <- read.csv("./exploratory analysis/household_power_consumption.txt",sep = ';',header = TRUE,na.strings="?")

#take subset with below conditions
dt <- dt_full[dt_full$Date=="1/2/2007"|dt_full$Date=="2/2/2007",]

#convert date format using ?strptime example in new column
dt$DateTime <- strptime(paste(dt$Date, dt$Time), "%d/%m/%Y %H:%M:%S")


##mfrow allows for 2 by 2 graphs, mar adjusts the graph margins
par(mfrow=c(2, 2),oma=c(0,0,0,0),mar=c(2,4,3,1)) 

#plot graphs
plot(dt$DateTime, dt$Global_active_power, type="l", ylab="Global active power",xlab="")
plot(dt$DateTime, dt$Voltage, type="l", ylab="Global active power",xlab="datetime")
plot(dt$DateTime,as.numeric(dt$Sub_metering_1),type ="l",ylab="Energy sub metering",xlab="")
lines(dt$DateTime,as.numeric(dt$Sub_metering_2),col="Red")
lines(dt$DateTime,as.numeric(dt$Sub_metering_3),col="Blue")
#add legend
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1, 1, 1), col=c("black", "red", "blue"),cex=0.5)

plot(dt$DateTime, dt$Global_reactive_power, type="l", ylab="Global_reactiv_power",xlab="datetime")


dev.copy(png, file="./exploratory analysis/Course project1/plot4.png", height=480, width=480)
dev.off()
