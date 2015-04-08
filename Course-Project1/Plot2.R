##Exploratory Dat Analysis Course Project 1

####Plot 2

#Read full data
dt_full <- read.csv("./exploratory analysis/household_power_consumption.txt",sep = ';',header = TRUE)

#take subset with below conditions
dt <- dt_full[dt_full$Date=="1/2/2007"|dt_full$Date=="2/2/2007",]

#convert date format using ?strptime example in new column
dt$DateTime <- strptime(paste(dt$Date, dt$Time), "%d/%m/%Y %H:%M:%S")

##draw graph
plot(dt$DateTime,as.numeric(dt$Global_active_power),type ="l",ylab="Global Active Power (kilowatts)",xlab="")
#create png file
dev.copy(png, file="./exploratory analysis/Course project1/plot2.png", height=480, width=480)
dev.off()
