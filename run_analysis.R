## Getting and Cleaning Data Course Project

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  # This script will 

library(dplyr)
library(reshape2)

## Read features & acticity files for labeling the train and test data sets.
features <- read.table("./features.txt", header = FALSE, col.names = c("fid","feature"))
activitylabels <- read.table("./activity_labels.txt", header = FALSE, col.names = c("activityid", "activitytype"))

## Read the training and test files with column labels
subjecttrain <- read.table("./subject_train.txt", header = FALSE, col.names = "subjectid")
xtrain <- read.table("./X_train.txt", header = FALSE, col.names = features$feature)
ytrain <- read.table("./y_train.txt", header = FALSE, col.names = "activityid")
subjecttest <- read.table("./subject_test.txt", header = FALSE, col.names = "subjectid")
xtest <- read.table ("./X_test.txt", header = FALSE, col.names = features$feature)
ytest <- read.table("./y_test.txt", header = FALSE, col.names = "activityid")

## Filter variables that are not either mean or standard deviation
meanstd <- grep("-(mean|std|activityid)\\(\\)", features[, 2])
xtest <- xtest[, c(meanstd)]
xtrain <- xtrain[ ,c(meanstd)]

## Merge all tables into a single table
testdata <- cbind(xtest, subjecttest, ytest)
traindata <- cbind(xtrain, subjecttrain, ytrain)
hardata <- rbind(testdata, traindata)
hardata <- merge(hardata,activitylabels,by='activityid',all.x=TRUE)

## Appropriately label data set with descriptive variable names
names(hardata)<-gsub("^t", "time", names(hardata))
names(hardata)<-gsub("^f", "frequency", names(hardata))
names(hardata)<-gsub("Acc", "Accelerometer", names(hardata))
names(hardata)<-gsub("Gyro", "Gyroscope", names(hardata))
names(hardata)<-gsub("Mag", "Magnitude", names(hardata))
names(hardata)<-gsub("BodyBody", "Body", names(hardata))

## Aggregate data by mean on Subject and Activity
aggdata <- aggregate(. ~ subjectid + activitytype, hardata, mean)

## Create independent tidy data set with aggregated data
write.table(aggdata, file = "tidydata.txt",row.name=FALSE)
