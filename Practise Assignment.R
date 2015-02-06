## Task Description
## Date: Feb 5, 2015
## 1. Download the file "diet_data.zip" from http://s3.amazonaws.com/practice_assignment/diet_data.zip
## and unzip it into your R working directory
## 2. Get Steve's weight on the last day, and determine if he has lost any 
## weight compared to the first day
## 3. Among all 5 people, who weights the most on the first day? 
## 4. Develop a function that calculates the average weight for a given day

## QUESTION 1
## Double check working directory and download the files from the specified URL
getwd()
dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
download.file(dataset_url, "diet_data.zip")
unzip("diet_data.zip", exdir="diet_data")
list.files("diet_data")

## QUESTION 2
## Open the Steve.csv file and see what's in it
steve <-read.csv("diet_data/Steve.csv")
head(steve)

## Check the last day of Steve's file
## Ensure that the last day is Day 30
max(steve$Day)
min(steve$Day)

## Steve's weight on Day 30
steve_30 <-subset(steve$Weight, steve$Day==30)
steve_30

## Steve's weight on Day1
steve_1 <-subset(steve$Weight, steve$Day==1)
steve_1

## Check to see if Steve lost any weight
steve_30-steve_1
## -11, so yes, Steve lost weight!

## QUESTION 3
## Combine all 5 csv files into one
all_files <-list.files("diet_data", full.names=TRUE) ## append the files including their names
all_files[1]

tmp <-vector(mode="list",length=length(all_files))
summary(tmp)
for (i in seq_along(all_files)) {
  tmp[[i]]<-read.csv(all_files[[i]])
}
## do.call(function_you_want_to_use, list_of_arguments)
## this approach avoicds all the messy copying and pasting
combined <-do.call(rbind,tmp)
summary(combined)

day1_file <-subset(combined, Day==1)
chub_day1 <-subset(day1_file, Weight==max(day1_file$Weight))
chub_day1

## Steve weights the heaviest on Day 1, 225 lb

## QUESTION 4
## 
mean_weight <-function(directory,day) {
  all_files2 <-list.files(directory, full.names=TRUE)
  tmp<-vector(mode="list", length=length(all_files2))
  for (i in seq_along(all_files2)){
    tmp[[i]]<-read.csv(all_files[[i]])
  }
  combined<-do.call(rbind,tmp)
  subset_day <- subset(combined,Day==day)
  mean(subset_day[,"Weight"], na.rm=TRUE)
}

mean_weight("diet_data",20)







