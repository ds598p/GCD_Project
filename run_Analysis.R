## Project Getting & Cleaning Data

##  Phase 1: verify needed libraries

install.packages("data.table")
library(data.table)
install.packages("dplyr")
library(dplyr)
install.packages("sqldf")
library(sqldf)
install.packages("reshape2")
library(reshape2)

## Phase 2: verify directory

if(!file.exists("GDCproj")){dir.create("GDCproj")}

## Phase 3: Download project data

pdURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(pdURL, dest="./GDCproj/pdata.zip")
unzip ("./GDCproj/pdata.zip")

## Phase 4: read data

testSet <- read.table("./UCI HAR Dataset/test/x_test.txt")
trainSet <- read.table("./UCI HAR Dataset/train/x_train.txt")

testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

testActivity <- read.table("./UCI HAR Dataset/test/y_test.txt")
trainActivity <- read.table("./UCI HAR Dataset/train/y_train.txt")

headers <- read.table("./UCI HAR Dataset/features.txt")
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Phase 5:  applying activity labels

testActivityLabels <- sqldf("select a.*, b.v2 from testActivity a join activityLabels b on a.v1 = b.v1")
trainActivityLabels <- sqldf("select a.*, b.v2 from trainActivity a join activityLabels b on a.v1 = b.v1")

## Phase 6:  merging data sets

testSetFull <-cbind(testSubject,testActivityLabels,testSet)
trainSetFull <-cbind(trainSubject,trainActivityLabels,trainSet)

##  Phase 7:  combine data sets then apply headers

setFull <- rbind(testSetFull,trainSetFull)
headNames <- as.character(headers[,2])
colnames(setFull) <- c("Subject","Act","Activity",headNames)

## Phase 8:  subsetting final table to only desired columns

meanStdVars <- sqldf("select v2 from headers where v2 like '%mean(%' or v2 like '%std(%'")
colSelect <- c("Subject","Activity",as.character(meanStdVars[,1]))
setUse <- subset(setFull,,colSelect)

## Phase 9:  melting and casting to get means of attributes

meltSet <- melt(setUse,id = c("Subject","Activity"),measure.vars=c(as.character(meanStdVars[,1])))
castSet <- dcast(meltSet,Subject+Activity~variable,mean)

## Phase 10:  output tidy text file

write.table(castSet,file = "Activity_Means_Tidy.txt", row.name=F)
