###Week 2 Notes
##ggplot2

Plotting Systems in R: Base

???Artist???s palette??? model
Start with blank canvas and build up from there
Start with plot function (or similar)
  Use annotation functions to add/modify (text, lines, points, axis)
Plotting Systems in R: Base

Convenient, mirrors how we think of building plots and analyzing data
Can???t go back once plot has started (i.e. to adjust margins); need to plan in advance
Difficult to ???translate??? to others once a new plot has been created (no graphical ???language???)
Plot is just a series of R commands
Plotting Systems in R: Lattice

Plots are created with a single function call (xyplot, bwplot, etc.)
Most useful for conditioning types of plots: Looking at how $y$ changes with $x$ across levels of $z$
  Things like margins/spacing set automatically because entire plot is specified at once
Good for putting many many plots on a screen
Plotting Systems in R: Lattice

Sometimes awkward to specify an entire plot in a single function call
Annotation in plot is not intuitive
Use of panel functions and subscripts difficult to wield and requires intense preparation
Cannot ???add??? to the plot once it???s created
Plotting Systems in R: ggplot2

Split the difference between base and lattice
Automatically deals with spacings, text, titles but also allows you to annotate by ???adding???
Superficial similarity to lattice but generally easier/more intuitive to use
Default mode makes many choices for you (but you can customize!)


##EXAMPLE1

library(ggplot2)
str(mpg)
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, color = drv)
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))
qplot(hwy, data = mpg, fill = drv)
qplot(displ, hwy, data = mpg, facets = . ~ drv)
qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 2)


##EXAMPLE 2
data(maacs)
str(maacs)
load("/Users/jonneyliu/Downloads/maacs.Rda")
qplot(log(eno), data = maacs)
qplot(log(eno), data = maacs, fill = mopos)
qplot(log(eno), data = maacs, geom = "density")
qplot(log(eno), data = maacs, geom = "density", color = mopos)

qplot(log(pm25), log(eno), data = maacs)
qplot(log(pm25), log(eno), data = maacs, shape = mopos)
qplot(log(pm25), log(eno), data = maacs, color = mopos)

qplot(log(pm25), log(eno), data = maacs, color = mopos, 
      geom = c("point", "smooth"), method = "lm")

qplot(log(pm25), log(eno), data = maacs, geom = c("point", "smooth"), 
      method = "lm", facets = . ~ mopos)


##Example 3 building in layers
library(ggplot2)
qplot(logpm25, NocturnalSympt, data = maacs, facets = . ~ bmicat, 
      geom = c("point", "smooth"), method = "lm")
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
summary(g)
print(g)
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
g + geom_point()
g + geom_point() + geom_smooth()
g + geom_point() + geom_smooth(method = "lm")
head(maacs)
First Plot with Point Layer

g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
g + geom_point()
plot of chunk unnamed-chunk-5
Adding More Layers: Smooth

g + geom_point() + geom_smooth()
g + geom_point() + geom_smooth(method = "lm")
plot of chunk unnamed-chunk-6 plot of chunk unnamed-chunk-6
Adding More Layers: Facets

g + geom_point() + facet_grid(. ~ bmicat) + geom_smooth(method = "lm")
plot of chunk unnamed-chunk-7
Annotation

Labels: xlab(), ylab(), labs(), ggtitle()
Each of the ???geom??? functions has options to modify
For things that only make sense globally, use theme()
Example: theme(legend.position = "none")
Two standard appearance themes are included
theme_gray(): The default theme (gray background)
theme_bw(): More stark/plain
Modifying Aesthetics

g + geom_point(color = "steelblue", size = 4, alpha = 1/2)
g + geom_point(aes(color = bmicat), size = 4, alpha = 1/2)
plot of chunk unnamed-chunk-8 plot of chunk unnamed-chunk-8
Modifying Labels

g + geom_point(aes(color = bmicat)) + labs(title = "MAACS Cohort") + 
  labs(x = expression("log " * PM[2.5]), y = "Nocturnal Symptoms")
plot of chunk unnamed-chunk-9
Customizing the Smooth

g + geom_point(aes(color = bmicat), size = 2, alpha = 1/2) + 
  geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)
plot of chunk unnamed-chunk-10
Changing the Theme

g + geom_point(aes(color = bmicat)) + theme_bw(base_family = "Times")
plot of chunk unnamed-chunk-11
A Note about Axis Limits

testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50,2] <- 100  ## Outlier!
plot(testdat$x, testdat$y, type = "l", ylim = c(-3,3))

g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line()
plot of chunk unnamed-chunk-12 plot of chunk unnamed-chunk-12
Axis Limits

g + geom_line() + ylim(-3, 3)
g + geom_line() + coord_cartesian(ylim = c(-3, 3))
plot of chunk unnamed-chunk-13 plot of chunk unnamed-chunk-13
More Complex Example

How does the relationship between PM$_{2.5}$ and nocturnal symptoms vary by BMI and NO$_2$?
Unlike our previous BMI variable, NO$_2$ is continuous
We need to make NO$_2$ categorical so we can condition on it in the plotting
Use the cut() function for this
Making NO$_2$ Tertiles

## Calculate the tertiles of the data
cutpoints <- quantile(maacs$logno2_new, seq(0, 1, length = 4), na.rm = TRUE)

## Cut the data at the tertiles and create a new factor variable
maacs$no2tert <- cut(maacs$logno2_new, cutpoints)

## See the levels of the newly created factor variable
levels(maacs$no2tert)
[1] "(0.378,1.2]" "(1.2,1.42]"  "(1.42,2.55]"
Final Plot

plot of chunk unnamed-chunk-15
Code for Final Plot

## Setup ggplot with data frame
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))

## Add layers
g + geom_point(alpha = 1/3) + 
  facet_wrap(bmicat ~ no2tert, nrow = 2, ncol = 4) + 
  geom_smooth(method="lm", se=FALSE, col="steelblue") + 
  theme_bw(base_family = "Avenir", base_size = 10) + 
  labs(x = expression("log " * PM[2.5])) + 
  labs(y = "Nocturnal Symptoms") + 
  labs(title = "MAACS Cohort")