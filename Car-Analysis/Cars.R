#R-Data Analysis with the mtcars Dataset 
library(ggplot2)
library(data.table)

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
