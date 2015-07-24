# Coursera Getting and Cleaning Data Project

The purpose of this file is to explain how the run_analysis.R script file works.

## Setup

Prior to running the script, the data should be downloaded and unzipped in the scripts working folder. This is to avoid useless redownloads and reunzips in case someone wants to change the script.

The data comes from the "Human Activity Recognition Using Smartphones Data Set" and is available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Once unzipped, the folder should be named "UCI HAR Dataset".

The plyr library must also be installed for step 5.

## Goal

The purpose of the script is to accomplish the following steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Here is how it accomplishes each steps:

#### 1. Merges the training and the test sets to create one data set.

1. Reads the subject, X and y files in the train folder.
1. Reads the subject, X and y files in the test folder.
1. Concatenates the subject, X, and y from both 1.1 and 1.2 to create the final 3 sujects, activities and features dataframes.


#### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

1. Reads the feature labels.
2. Get the column indexes and names of all the columns that contain either -mean() or -std()
3. Extracts the mesurments from the columns found in step 2.


#### 3. Uses descriptive activity names to name the activities in the data set

1. Reads the activity labels.
2. Create a factor variable out of the labels and apply it to the activities merged from step 1.3


#### 4. Appropriately labels the data set with descriptive variable names. 

1. Concatenates the subjects, activities and means/std from step 2 into 1 dataframe.
2. Names the columns "Subject", "Activity", and the names of the mean/std columns extracted in step 2.2.


#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In this step the plyr library is used.

1. Create a new data set with the average of each variable for each activity and each subject using ddply.
2. Write the data set as a table in the file "tidy.txt".
