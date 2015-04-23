###week 1 part2

library(datasets)
data(cars)
with(cars, plot(speed, dist))


#lattice plot - unlike boxplot, you plot all at once
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))

##ggplot2
library(ggplot2) 
data(mpg)
qplot(displ, hwy, data = mpg)


#base plot
library(datasets)
hist(airquality$Ozone)  ## Draw a new plot
with(airquality, plot(Wind, Ozone))

airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")
# 
# Some Important Base Graphics Parameters
# 
# The par() function is used to specify global graphics parameters that affect all plots in an R session. These parameters can be overridden when specified as arguments to specific plotting functions.
# 
# las: the orientation of the axis labels on the plot
# bg: the background color
# mar: the margin size
# oma: the outer margin size (default is 0 for all sides)
# mfrow: number of plots per row, column (plots are filled row-wise)
# mfcol: number of plots per row, column (plots are filled column-wise)

#adds title
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City")  ## Add a title

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City")) #use main to add title
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue")) #highlight all with months of may


##more subsets
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", type = "n")) #sets up the frame
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months")) #adds legend


##adding regression line
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)


par(mfrow = c(1, 2)) #1 row 2 column for multiple plot
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})

par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0)) ##sets number of plots, margin for graph and blank space on each side
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Temp, Ozone, main = "Ozone and Temperature")
  mtext("Ozone and Weather in New York City", outer = TRUE)
})


##example
dev.off() ##resets par values for base plot
x <- rnorm(100)
y <- rnorm(100)
z <- rpois(50,2)
g <-gl(2,50,labels=c("Male","Female"))
plot(x,y,type="n")
points(x[g=="Male"],y[g=="Male"],col = "green")
points(x[g=="Female"],y[g=="Female"],col = "blue")

