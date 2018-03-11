# Cookbook

1. First, we read relevant data files and save data into data frames, add appropriate column headers, and combine the training and test sets into a single data set.
2. Remove the feature columns that did not contain the exact string "mean()" or "std()". After this step, 66 feature columns are left, plus the subjectID and activity columns.
3. Convert the activity column from a integer to a factor using labels describing the activities.
4. A tidy data set was created containing the mean of each feature for each subject and each activity. Each subject has six rows for six activities, and each row has mean for 66 features. Since there are 30 subjects, there are a total of 180 rows.
5. The tidy data set was output to a .txt file.
