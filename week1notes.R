###Exploratory Analysis Week 1 Notes

##1D plots

boxplot(pollution$pm25, col = "blue")
hist(pollution$pm25, col = "green")

hist(pollution$pm25, col = "green")
rug(pollution$pm25) #plots the points below the histogram

hist(pollution$pm25, col = "green", breaks = 100) #increase number of bars

boxplot(pollution$pm25, col = "blue")
abline(h = 12) #adds a horizontal line in boxplot

hist(pollution$pm25, col = "green")
#add 2 vertical lines in histogram with diff color and widths
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)

#barplot for categorical data
barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")


#Multiple bloxplots
boxplot(pm25 ~ region, data = pollution, col = "red")

#Multiple Histograms
par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")

#Scatterplot
with(pollution, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)

#with color
with(pollution, plot(latitude, pm25, col = region))

#on multiple scatterplots
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))
abline(h = 12, lwd = 2, lty = 2)
