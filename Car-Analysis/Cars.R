#R-Data Analysis with the mtcars Dataset 

#Install Packages
install.packages('plotly')

#Import libraries
library(ggplot2)
library(data.table)
library(ggthemes)
library(plotly)

#Print the mtcars dataset
cars <- mtcars
cars

#Analyse the data
head(cars)
tail(cars)
summary(cars)

#Histogram 
a <- ggplot(data=cars, aes(x=mpg))
a2 <- a + geom_histogram(color = 'blue', fill = 'orange')
print(a2)

#Boxplot
bp <- ggplot(cars, aes(factor(cyl), hp))
bp2 <- bp + geom_boxplot(aes(fill=factor(cyl)))
print(bp2)

#Scatterplot
head(cars)
sp <- ggplot(cars, aes(x=hp, y = qsec))
sp2 <- sp + geom_point(aes(color=factor(qsec)))
print(sp2)

#Different themes
th1 <- ggplot(cars, aes(x=mpg,y=hp)) + geom_point()
print(th1)
th2 <-th1 + theme_bw()
th3 <-th1 + theme_classic()
th4 <-th1 + theme_dark()
th5 <-th1 + theme_economist_white()
th6 <-th1 + theme_wsj()
print(th6) 

#Interactive diagram with plotly
abc <- ggplot(cars, aes(mpg, wt)) + geom_point()
abc2 <- abc + theme_wsj()
plotly <- ggplotly(abc2)
print(plotly)

#Prediction
my_pr <- lm(mpg ~ cyl + hp, data = cars)
predict(my_pr, data.frame(cyl = 12, hp = 400))
