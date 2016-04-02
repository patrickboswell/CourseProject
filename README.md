# Course Project

The purpose of this project was to demonstrate collecting, working with, and cleaning a data set. 

##Information on the data used for this demonstration can be found at the link below

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data for this project was retrieved from the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 
##Analysis

run_analysis.R  contains the script to carry out the following functions:

### Section 1. Merge the training and the test sets.
Reads the following files and assign approriate column labels
- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

## Section 2. Extract only the measurements on the mean and standard deviation for each measurement. 
Create a vector that contains the columns that meet the conditions for mean and standard deviation.
x_test data and x_train data tables are transformed to only contain desired columns.
All tables are then merged into a single data set including descriptive activity names.

## Section 3. Appropriately label the data set with descriptive activity names.
Use gsub function for pattern replacement to clean up the data labels.

## Section 4. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
aggregate() function is used to aggregate the mean for each variable by subject and activity. Resulting table is written to tidydata.txt.
