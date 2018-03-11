library(reshape2)
# 1. Merges the training and the test sets to create one data set.

# Read data
subject_train <- read.table("./train/subject_train.txt")
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_test <- read.table("./test/subject_test.txt")
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")

# Add column name for subject files
names(subject_train) <- "subjectID"
names(subject_test) <- "subjectID"

# Add column names for measurement files
featureNames <- read.table("features.txt")
names(X_train) <- featureNames$V2
names(X_test) <- featureNames$V2

# Add column name for label files
names(y_train) <- "activity"
names(y_test) <- "activity"

# Combine files into one dataset
train <- cbind(subject_train, y_train, X_train)
test <- cbind(subject_test, y_test, X_test)
combined <- rbind(train, test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Find columns that contain "mean()" or "std()"
meanstdcols <- grepl("mean\\(\\)", names(combined)) | grepl("std\\(\\)", names(combined))
meanstdcols[1:2] <- TRUE # Keep the subjectID and activity columns
combined <- combined[, meanstdcols] # Remove unuseful columns

# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names
combined$activity <- factor(combined$activity, labels=c("Walking",
                                                        "Walking Upstairs", 
                                                        "Walking Downstairs", 
                                                        "Sitting",  
                                                        "Standing", 
                                                        "Laying"))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
melted <- melt(combined, id=c("subjectID","activity"))
tidy <- dcast(melted, subjectID+activity ~ variable, mean)
write.table(tidy, "tidy_data.txt", row.names=FALSE)
