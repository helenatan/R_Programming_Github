## Part 1
## Write a function named 'pollutantmean' that calculates the mean of 
## a pollutant (sulfate or nitrate) across a specified list of monitors.
pollutantmean <- function(directory, pollutant, id=1:332) {
## 'directory' is a character vector of length 1 indicating
## the location of the CSV files
  
## 'pollutant' is a character vector of length 1 indicating
## the name of the pollutant for which we will calculate the
## mean; either "sulfate" or "nitrate".
  
## 'id' is an integer vector indicating the monitor ID numbers
## to be used
  
## Return the mean of the pollutant across all monitors list
## in the 'id' vector (ignoring NA values)
    all_files <-list.files("specdata", full.name=TRUE)
    tmp <-vector(mode="list", length = length(id))
    
    for (i in seq_along(id)){
        tmp[[i]]<-read.csv(all_files[id[i]])
    }
    combined <-do.call(rbind,tmp)
    mean(combined[,pollutant],na.rm=TRUE)
}

## Part 2
## Write a function that reads a directory full of files and reports the 
## number of completely observed cases in each data file. The function should return a data 
## frame where the first column is the name of the file and the second column is the number 
## of complete cases. A prototype of this function follows
complete <- function(directory, id = 1:332) {
## 'directory' is a character vector of length 1 indicating
## the location of the CSV files
    
## 'id' is an integer vector indicating the monitor ID numbers
## to be used
    
## Return a data frame of the form:
## id nobs
## 1  117
## 2  1041
## ...
## where 'id' is the monitor ID number and 'nobs' is the
## number of complete cases
    all_files <-list.files(directory, full.name=TRUE)
    tmp <-vector(mode="list",length=length(id))
    nobs <-vector(mode="list",length=length(id))
    for (i in seq_along(id)) {
        tmp[[i]]<-read.csv(all_files[id[i]])
        tmp[[i]]<-complete.cases(tmp[[i]])
        nobs[i]<-sum(tmp[[i]])
    }
    data.frame(cbind(id,nobs))

}

## Part 3
## Write a function that takes a directory of data files and a threshold for complete cases and calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. The function should return a vector of correlations for the monitors that meet the threshold requirement. If no monitors meet the threshold requirement, then the function should return a numeric vector of length 0. A prototype of this function follows
corr <- function(directory, threshold = 0) {
## 'directory' is a character vector of length 1 indicating
## the location of the CSV files
    
## 'threshold' is a numeric vector of length 1 indicating the
## number of completely observed observations (on all
## variables) required to compute the correlation between
## nitrate and sulfate; the default is 0
    
## Return a numeric vector of correlations
    all_files <-list.files(directory,full.names=TRUE)
    tmp <- vector(mode="list",length=length(all_files))
    complete_size<-vector(mode="list",length=length(all_files))
    cor_file<- c()
    
    for (i in seq_along(all_files)){
        tmp[[i]] <- read.csv(all_files[[i]])
        complete_size[i] <- sum(complete.cases(tmp[[i]]))
        if (complete_size[i]>threshold) {
            cor_file<-c(cor_file,cor(tmp[[i]]$sulfate,tmp[[i]]$nitrate, use="complete.obs"))
        }   
   }
   cor_file
}

source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript1.R")
submit()



##================================================================================================
## TESTING CASES
## QUESTION 1
source("pollutantmean.R")
pollutantmean("specdata", "sulfate", 1:10)
## [1] 4.064
pollutantmean("specdata", "nitrate", 70:72)
## [1] 1.706
pollutantmean("specdata", "nitrate", 23)
## [1] 1.281

## QUESTION 2
source("complete.R")
complete("specdata", 1)
##   id nobs
## 1  1  117
complete("specdata", c(2, 4, 8, 10, 12))
##   id nobs
## 1  2 1041
## 2  4  474
## 3  8  192
## 4 10  148
## 5 12   96
complete("specdata", 30:25)
##   id nobs
## 1 30  932
## 2 29  711
## 3 28  475
## 4 27  338
## 5 26  586
## 6 25  463
complete("specdata", 3)
##   id nobs
## 1  3  243

## QUESTION 3
source("corr.R")
source("complete.R")
cr <- corr("specdata", 150)
head(cr)
## [1] -0.01896 -0.14051 -0.04390 -0.06816 -0.12351 -0.07589
summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -0.2110 -0.0500  0.0946  0.1250  0.2680  0.7630
cr <- corr("specdata", 400)
head(cr)
## [1] -0.01896 -0.04390 -0.06816 -0.07589  0.76313 -0.15783
summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -0.1760 -0.0311  0.1000  0.1400  0.2680  0.7630
cr <- corr("specdata", 5000)
summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## 
length(cr)
## [1] 0
cr <- corr("specdata")
summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -1.0000 -0.0528  0.1070  0.1370  0.2780  1.0000
length(cr)
## [1] 323
