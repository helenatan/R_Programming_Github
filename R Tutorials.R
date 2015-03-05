## Excercise 1
## From 'USArrests', Select 25% of states with least Murder's with:
## 1. Row Postitions Changed
## 2. Row Positions Unchanged

## Solution 1
##Examine the dataset
USArrests
## Create a sorted dataset
sortedset <-USArrests[order(USArrests$Murder),]
sortedset
## Only collect the lowerest 25%
sortedset[1:ceiling(nrow(sortedset)*0.25),]

## Solution 2
quantile(USArrests$Murder)
perc<-quantile(USArrests$Murder)[2]
subset (USArrests,USArrests$Murder < perc )

## Exercise 2
## From "USArrests', select states with more than 75% Urban Population or "Rape" variable value more than 20
subset(USArrests,USArrests$UrbanPop>75|USArrests$Rape>20)

## Exercise 3
## Randomly select 75% of the dataset "USArrests" as "trainingData" and the remaining 25% of observations as "testData"
sub <- sample(nrow(USArrests),round(nrow(USArrests)*0.75))
trainingData <- USArrests[sub,]
testData <- USArrests[-sub,]
trainingData
testData


## Exercise 4
## Dealing with Dates
dt<-"05Oct2008"
class(dt)
dt1<-as.Date(dt, format ="%d%B%Y")
dt1
class(dt1)

dt2 <-"10-05-2001"
dt3<-as.Date(dt2,format ="%d-%m-%Y")
dt3

## convert the following dates in character to date format
d1<-"aug061999"
d2<-"May 27 1994"
d3<-"1998-07-22"
d4<-"20041024"
d5<-"22.10.2004"

## source for the date format in R
new_d1 <-as.Date(d1,format ="%b%d%Y")
new_d1

new_d2 <-as.Date(d2, format="%b %d %Y")
new_d2

new_d3<-as.Date(d3,format="%Y-%m-%d")
new_d3
class(d3)
class(new_d3)

new_d4<-as.Date(d4,format ="%Y%m%d")
new_d4

new_d5<-as.Date(d5,format="%d.%m.%Y")
new_d5

new_d5-new_d4
unlist(new_d5)


## Write functions in R


