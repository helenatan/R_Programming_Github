## Question 1 Plot the 30-day mortality rates for heart attack
## Read the outcome data into R via the read.csv function and look at the first few rows.

outcome <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
ncol(outcome)
names(outcome)

##  make a simple histogram of the 30-day death rates from heart attack (column 11 in the outcome dataset)
outcome[,11]<-as.numeric(outcome[,11])
hist(outcome[,11])

## Question 2 Finding the best hospital in a state
best <- function(state, outcome) {
    ## Read outcome data
    dataset<- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
    ## Check that outcome is valid
    dataset_state <- subset(dataset, dataset$State==state)
    col_index<-0
  
    outcome_trim <-gsub(" ","",tolower(outcome))
    if (outcome_trim =="heartattack") {
        col_index<-11
    }else if(outcome_trim =="heartfailure") {
        col_index<-17
    }else if(outcome_trim=="pneumonia") {
        col_index<-23
    }else{
        stop("invalid outcome")
    }
    ## Check that state is valid
    ## Return hospital name in that state with lowest 30-day death    
    if(nrow(dataset_state)!=0) {
        dataset_state[,col_index]<-suppressWarnings(as.numeric(dataset_state[,col_index]))
        min_outcome <- min(dataset_state[,col_index], na.rm=TRUE)
        best_hospital <-subset(dataset_state, dataset_state[,col_index] ==min_outcome)
        best_hospital <-best_hospital$"Hospital.Name"
        best_hospital
    }else {
        stop("invalid state")
    }
}

## 3 Ranking hospitals by outcome in a state
rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    dataset<- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
    ## Check that state and outcome are valid
    dataset_state <- subset(dataset, dataset$State==state)
    col_index<-0
    
    outcome_trim <-gsub(" ","",tolower(outcome))
    if (outcome_trim =="heartattack") {
        col_index<-11
    }else if(outcome_trim =="heartfailure") {
        col_index<-17
    }else if(outcome_trim=="pneumonia") {
        col_index<-23
    }else{
        stop("invalid outcome")
    }

    ## Return hospital name in that state with the given rank
    ## 30-day death rate
   subset_state<-subset(dataset_state[,c(1,2,col_index)])
   colnames(subset_state)[3]<-"Rate"
   subset_state$Rate <-suppressWarnings(as.numeric(subset_state$Rate))
   subset_state<-subset(subset_state,!is.na(subset_state$Rate))
   ordered_subset<-subset_state[order(subset_state$Rate,subset_state$"Hospital.Name"),]
 
   if(num=="best") {
       best<-ordered_subset[1,]$"Hospital.Name"
    }else if(num=="worst"){
        best<-ordered_subset[nrow(ordered_subset),]$"Hospital.Name"
    }else if(num>nrow(ordered_subset)){
        best<-"NA"
    }else{
        best<-ordered_subset[num,]$"Hospital.Name"
    }
 best
}


## 4 Ranking hospitals in all states
rankall <- function(outcome, num = "best") {    
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    
    ## Read outcome data
    dataset<-read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
   
    ## Check that outcome is valid
    col_index<-0
    outcome_trim <-gsub(" ","",tolower(outcome))
    if (outcome_trim =="heartattack") {
        col_index<-11
    }else if(outcome_trim =="heartfailure") {
        col_index<-17
    }else if(outcome_trim=="pneumonia") {
        col_index<-23
    }else{
        stop("invalid outcome")
    }
    
    dataset_sub<-subset(dataset[,c(2,7,col_index)])
    colnames(dataset_sub)[3]<-"Rate"
    dataset_sub$Rate<-suppressWarnings(as.numeric(dataset_sub$Rate))
    
    ## For each state, find the hospital of the given rank
    state_list <-sort(unique(dataset_sub[,2]))  
    hospital_list<-c()
    for (i in seq_along(state_list)){
        dataset_state<-subset(dataset_sub,dataset_sub$State==state_list[i]&!is.na(dataset_sub$Rate))
        dataset_state<-dataset_state[order(dataset_state$Rate,dataset_state$"Hospital.Name"),]
       if(num=="best"){
            hospital<-dataset_state[1,]$"Hospital.Name"
        }else if(num=="worst"){
            hospital<-dataset_state[nrow(dataset_state),]$"Hospital.Name"
        }else if(num>nrow(dataset_state)){
            hospital<-"NA"
        }else{
            hospital<-dataset_state[num,]$"Hospital.Name"
        }
        hospital_list<-c(hospital_list,hospital)    
    }
    result_list<-data.frame(hospital_list,state_list)
    colnames(result_list) <-c("hospital","state")
    result_list
}



## TESTING CASES
## source("best.R")
best("TX", "heart attack")
## [1] "CYPRESS FAIRBANKS MEDICAL CENTER"
best("TX", "heart failure")
## [1] "FORT DUNCAN MEDICAL CENTER"
best("MD", "heart attack")
## [1] "JOHNS HOPKINS HOSPITAL, THE"
best("MD", "pneumonia")
## [1] "GREATER BALTIMORE MEDICAL CENTER"
best("BB", "heart attack")
## Error in best("BB", "heart attack") : invalid state
best("NY", "hert attack")
## Error in best("NY", "hert attack") : invalid outcome

## source("rankhospital.R")
rankhospital("TX", "heart failure", 4)
## [1] "DETAR HOSPITAL NAVARRO"
rankhospital("MD", "heart attack", "worst")
## [1] "HARFORD MEMORIAL HOSPITAL"
rankhospital("MN", "heart attack", 5000)
## [1] NA


## source("rankall.R")
head(rankall("heart attack", 20), 10)
## hospital state
## AK <NA> AK
## AL D W MCMILLAN MEMORIAL HOSPITAL AL
## AR ARKANSAS METHODIST MEDICAL CENTER AR
## AZ JOHN C LINCOLN DEER VALLEY HOSPITAL AZ
## CA SHERMAN OAKS HOSPITAL CA
## CO SKY RIDGE MEDICAL CENTER CO
## CT MIDSTATE MEDICAL CENTER CT
## DC <NA> DC
## DE <NA> DE
## FL SOUTH FLORIDA BAPTIST HOSPITAL FL
tail(rankall("pneumonia", "worst"), 3)
## hospital state
## WI MAYO CLINIC HEALTH SYSTEM - NORTHLAND, INC WI
## WV PLATEAU MEDICAL CENTER WV
## WY NORTH BIG HORN HOSPITAL DISTRICT WY
tail(rankall("heart failure"), 10)
## hospital state
## TN WELLMONT HAWKINS COUNTY MEMORIAL HOSPITAL TN
## TX FORT DUNCAN MEDICAL CENTER TX
## UT VA SALT LAKE CITY HEALTHCARE - GEORGE E. WAHLEN VA MEDICAL CENTER UT
## VA SENTARA POTOMAC HOSPITAL VA
## VI GOV JUAN F LUIS HOSPITAL & MEDICAL CTR VI
## VT SPRINGFIELD HOSPITAL VT
## WA HARBORVIEW MEDICAL CENTER WA
## WI AURORA ST LUKES MEDICAL CENTER WI
## WV FAIRMONT GENERAL HOSPITAL WV
## WY CHEYENNE VA MEDICAL CENTER WY


