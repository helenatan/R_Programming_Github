##SCORE: 20/20

## QUESTION 1: 
## The R language is a dialect of which of the following programming languages?
## ANSWER: S
## EXPLANATION: R is a dialect of the S language which was developed at Bell Labs.

## QUESTION 2:
## The definition of free software consists of four freedoms (freedoms 0 through 3). 
## Which of the following is NOT one of the freedoms that are part of the definition?
##Answer: The freedom to prevent users from using the software for undesirable purposes.

## QUESTION 3:
## In R the following are all atomic data types EXCEPT
## ANSWER:list

## QUESTION 4:
## If I execute the expression x <- 4L in R, what is the class of the object `x' as determined by the `class()' function?
## ANSWER: integer
## EXPLANATION: The 'L' suffix creates an integer vector as opposed to a numeric vector.
x<-4L
class(x)

## QUESTION 5:
## What is the class of the object defined by x <- c(4, TRUE)?
## ANSWER: numeric
## EXPLANATION: The numeric class is the "lowest common denominator" here and so all elements will be coerced into that class.

## QUESTION 6: 
##If I have two vectors x <- c(1,3, 5) and y <- c(3, 2, 10), what is produced by the expression cbind(x, y)?
## ANSWER: a matrix with 2 columns and 3 rows
## EXPLANATION: The 'cbind' function treats vectors as if they were columns of a matrix. It then takes those vectors and binds them together column-wise to create a matrix.

## QUESTION 7: 
## A key property of vectors in R is that
## ANSWER: elements of a vector all must be of the same class

## QUESTION 8:
## Suppose I have a list defined as x <- list(2, "a", "b", TRUE). What does x[[2]] give me?
## ANSWER: a character vector of length 1.

## QUESTION 9:
## Suppose I have a vector x <- 1:4 and y <- 2:3. What is produced by the expression x + y?
## ANSWER: an integer vector with the values 3, 5, 5, 7.

## QUESTION 10:
## Suppose I have a vector x <- c(3, 5, 1, 10, 12, 6) and I want to set all elements of this 
## vector that are less than 6 to be equal to zero. What R code achieves this?
## ANSWER: x[x %in% 1:5] <- 0

## QUESTION 11:
## In the dataset provided for this Quiz, what are the column names of the dataset?
## ANSWER: Ozone, Solar.R, Wind, Temp, Month, Day
## CODE: 
quiz1data<-read.csv("hw1_data.csv")
quiz1data[0,]

## QUESTION 12:
##Extract the first 2 rows of the data frame and print them to the console. What does the output look like?
## ANSWER: 
## Ozone Solar.R Wind Temp Month Day
##1    41     190  7.4   67     5   1
##2    36     118  8.0   72     5   2
## CODE:
quiz1data[1:2,]

## QUESTION 13:
## How many observations (i.e. rows) are in this data frame?
## ANSWER: 153
## CODE: 
nrow(quiz1data)

## QUESTION 14: 
## Extract the last 2 rows of the data frame and print them to the console. 
## What does the output look like?
## ANSWER:
##     Ozone Solar.R Wind Temp Month Day
## 152    18     131  8.0   76     9  29
## 153    20     223 11.5   68     9  30
## CODE:
tail(quiz1data,n=2)

## QUESTION 15: 
## What is the value of Ozone in the 47th row?
## ANSWER: 21
## CODE
quiz1data[47,"Ozone"]

## QUESTION 16:
## How many missing values are in the Ozone column of this data frame?
## ANSWER: 37
##CODE: 
sum(is.na(quiz1data[,"Ozone"]))

## QUESTION 17:
## What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.
## ANSWER: 42.1
## CODE:
mean(quiz1data[,"Ozone"],na.rm=TRUE)

## QUESTION 18: 
## Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. 
## What is the mean of Solar.R in this subset?
## ANSWER: 212.8
subset1<-subset(quiz1data,Ozone>31 & Temp>90)
subset1
mean(subset1[,"Solar.R"], na.rm=TRUE)

## QUESTION 19:
## What is the mean of "Temp" when "Month" is equal to 6?
## ANSWER: 79.1
## CODE:
subset2<-subset(quiz1data,Month==6)
subset2
mean(subset2[,"Temp"], na.rm=TRUE)

## QUESTION 20:
## What was the maximum ozone value in the month of May (i.e. Month = 5)?
## ANSWER: 115
## CODE:
subset3<-subset(quiz1data, Month==5)
subset3
max(subset3[,"Ozone"], na.rm=TRUE)

