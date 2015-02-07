## Question 1
## Take a look at the 'iris' dataset that comes with R. The data can be loaded with the code:
##    library(datasets)
## data(iris)
## A description of the dataset can be found by running
## ?iris
## There will be an object called 'iris' in your workspace. 
## In this dataset, what is the mean of 'Sepal.Length' for the species virginica? 
## (Please only enter the numeric result and nothing else.)
library(datasets)
data(iris)
?iris
head(iris)
x<-subset(iris,Species=="virginica")
mean(x$Sepal.Length)

## Question 2
## Continuing with the 'iris' dataset from the previous Question, 
## what R code returns a vector of the means of the variables 'Sepal.Length', 'Sepal.Width', 
## 'Petal.Length', and 'Petal.Width'?
apply(iris[,1:4],2,mean)

## Question 3
## Load the 'mtcars' dataset in R with the following code
## library(datasets)
## data(mtcars)
## There will be an object names 'mtcars' in your workspace. 
## You can find some information about the dataset by running
## ?mtcars
library(datasets)
data(mtcars)
head(mtcars)
?split
sapply(split(mtcars$mpg,mtcars$cyl),mean)

## Question 4
## Continuing with the 'mtcars' dataset from the previous Question, 
## what is the absolute difference between the average horsepower of 4-cylinder cars and the average horsepower of 8-cylinder cars?
head(mtcars)
?mtcars

meanset<-sapply(split(mtcars$hp,mtcars$cyl),mean)
meanset[3]-meanset[1]

## Question 5
## If you run
## debug(ls)
## what happens when you next call the 'ls' function?
debug(ls)
ls()























