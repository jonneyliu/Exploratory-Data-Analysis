###Week 2 notes

# ##lattice plotting systems
# lattice: contains code for producing Trellis graphics, which are independent of the ???base??? graphics system; includes functions like xyplot, bwplot, levelplot
# 
# grid: implements a different graphing system independent of the ???base??? system; the lattice package builds on top of grid
# 
# We seldom call functions from the grid package directly
# The lattice plotting system does not have a "two-phase" aspect with separate plotting and annotation like in base plotting
# 
# All plotting/annotation is done at once with a single function call

# xyplot: this is the main function for creating scatterplots
# bwplot: box-and-whiskers plots (???boxplots???)
# histogram: histograms
# stripplot: like a boxplot but with actual points
# dotplot: plot dots on "violin strings"
# splom: scatterplot matrix; like pairs in base plotting system
# levelplot, contourplot: for plotting "image" data

Lattice functions generally take a formula for their first argument, usually of the form

xyplot(y ~ x | f * g, data)

library(lattice)
library(datasets) 

## Simple scatterplot
xyplot(Ozone ~ Wind, data = airquality)
head(airquality)
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))

p <- xyplot(Ozone ~ Wind, data = airquality)  ## Nothing happens!
print(p)  ## Plot appears


set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2, 1))  ## Plot with 2 panels


xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...)  ## First call the default panel function for 'xyplot'
  panel.abline(h = median(y), lty = 2)  ## Add a horizontal line at the median
})


###add regression line
xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...)  ## First call default panel function
  panel.lmline(x, y, col = 2)  ## Overlay a simple linear regression line
})

###Plotting functions
x <- rnorm(100)
y <- x + rnorm(100, sd = 0.5)
plot(x, y,
     xlab=substitute(bar(x) == k, list(k=mean(x))),
     ylab=substitute(bar(y) == k, list(k=mean(y)))
)
par(mfrow = c(2, 2))
for(i in 1:4) {
  x <- rnorm(100)
  hist(x, main=substitute(theta==num,list(num=i)))
}
