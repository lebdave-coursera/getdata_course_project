#########################################################################################
# 1. Merges the training and the test sets to create one data set.
#########################################################################################

# Read test data.
test_features <- read.table("./UCI HAR Dataset/test/X_test.txt", header=F)
test_activities<- read.table("./UCI HAR Dataset/test/Y_test.txt", header=F)
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=F)

# Read training data.
train_features <- read.table("./UCI HAR Dataset/train/X_train.txt", header=F)
train_activities <- read.table("./UCI HAR Dataset/train/Y_train.txt", header=F)
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=F)

# Merge data.
features <- rbind(test_features, train_features)
activities <- rbind(test_activities, train_activities)
subjects <- rbind(test_subjects, train_subjects)


#########################################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#########################################################################################

feature_labels <- read.table("./UCI HAR Dataset/features.txt")

mean_std_cols <- grep("-(mean|std)\\(\\)", feature_labels[,2], ignore.case=T)
mean_std_cols_names <- grep("-(mean|std)\\(\\)", feature_labels[,2], ignore.case=T, value=TRUE)

mean_std_features <- features[, mean_std_cols]

#########################################################################################
# 3. Uses descriptive activity names to name the activities in the data set
#########################################################################################
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activities <- factor(activities[, 1], labels = activity_labels[, 2])


#########################################################################################
# 4. Appropriately labels the data set with descriptive variable names. 
#########################################################################################

all_data <- cbind(subjects, activities, mean_std_features)
colnames(all_data) <- c("Subject", "Activity", mean_std_cols_names)

#########################################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set with the
#    average of each variable for each activity and each subject.
#########################################################################################
library(plyr)

tidy <- ddply(all_data, .(Subject, Activity), numcolwise(mean))
write.table(tidy, "tidy.txt",row.names=FALSE)