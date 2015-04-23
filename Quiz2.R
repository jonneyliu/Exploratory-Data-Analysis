###Quiz 2

## Question 1
an object of class "trellis"
##Q2
What is produced by the following code?
library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)


##Q3
lpoints()

##Q4
library(lattice)
library(datasets)
data(airquality)
p <- xyplot(Ozone ~ Wind | factor(Month), data = airquality)
The object 'p' has not yet been printed with the appropriate print method.

##Q5
trellis.par.set()

##Q6
the Grammar of Graphics developed by Leland Wilkinson

##Q7
library(datasets)
data(airquality)
qplot(Wind, Ozone, data = airquality, facets = . ~ factor(Month))

# airquality = transform(airquality, Month = factor(Month))
# qplot(Wind, Ozone, data = airquality, facets = . ~ Month)

qplot(Wind, Ozone, data = airquality)

qplot(Wind, Ozone, data = airquality, geom = "smooth")


##Q8
a plotting object like point, line, or other shape

##Q9
library(ggplot2)
g <- ggplot(movies, aes(votes, rating))
print(g)
g
ggplot does not yet know what type of layer to add to the plot.

##Q10
qplot(votes, rating, data = movies)
head(movies)
