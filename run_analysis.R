##Loading the required libraries...
library(dplyr)

##Open the data files...
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")

train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")

col_names <- read.table("./UCI HAR Dataset/features.txt")

##Renaming the columns of the test and train datasets..
colnames(test_data) <- col_names[, 2]
colnames(train_data) <- col_names[, 2]
colnames(test_labels) <- "ID"
colnames(train_labels) <- "ID"
train <- data.frame(train_labels, train_data)
test <- data.frame(test_labels, test_data)

##Subset the measurements on the mean and standard deviation only..
test_mean <- select(test, contains("mean"))
test_sd <- select(test, contains("std"))
train_mean <- select(train, contains("mean"))
train_sd <- select(train, contains("std"))

##Creating the test and training data stes with IDs...
train <- data.frame(train_labels, train_mean, train_sd)
test <- data.frame(test_labels, test_mean, test_sd)

##Remocving the unneccessary variables>>
rm(col_names, test_data, test_labels, test_mean, test_sd,
     train_data, train_labels, train_mean, train_sd)

##Merging the two data frames and removing the old ones...
merged_data <- rbind(train, test)
rm(train, test)
merged_data <- arrange(merged_data, ID)

##Creating a tidy data set contains the average of each variable
##for each activity and each subject.
tidy_data <- aggregate(merged_data[2], list(ID = merged_data$ID), function(x) mean(x))
for(i in 3: ncol(merged_data)) {
  tidy_data[, i] <- aggregate(merged_data[i], list(ID = merged_data$ID), function(x) mean(x))[, 2]
}
rm(merged_data)

##Creating a vector containing descreptive names of the tidy data elements...
final_names <- c("ID", "Time Body Acceleration Mean-X", "Time Body Acceleration Mean-Y",
                 "Time Body Acceleration Mean-Z", "Time Gravity Acceleration Mean-X",
                 "Time Gravity Acceleration Mean-Y", "Time Gravity Acceleration Mean-Z",
                 "Time Body Acceleration Jerk Mean-X", "Time Body Acceleration Jerk Mean-Y",
                 "Time Body Acceleration Jerk Mean-Z", "Time Body Gyroscope Mean-X",
                 "Time Body Gyroscope Mean-Y", "Time Body Gyroscope Mean-Z",
                 "Time Body Gyroscope Jerk Mean-X", "Time Body Gyroscope Jerk Mean-Y",
                 "Time Body Gyroscope Jerk Mean-Z", "Time Body Acceleration Magnitude Mean",
                 "Time Gravity Acceleration Magnitude Mean", "Time Body Acceleration Jerk Magnitude Mean",
                 "Time Body Gyroscope Magnitude Mean", "Time Body Gyroscope Jerk Magnitude Mean",
                 "Transformed Body Acceleration Mean-X", "Transformed Body Acceleration Mean-Y",
                 "Transformed Body Acceleration Mean-Z", "Transformed Frequency Body Acceleration Mean-X",
                 "Transformed Frequency Body Acceleration Mean-Y", "Transformed Frequency Body Acceleration Mean-Z",
                 "Transformed Body Acceleration Jerk Mean-X", "Transformed Body Acceleration Jerk Mean-Y",
                 "Transformed Body Acceleration Jerk Mean-Z", "Transformed Frequency Body Acceleration Jerk Mean-X",
                 "Transformed Frequency Body Acceleration Jerk Mean-Y", "Transformed Frequency Body Acceleration Jerk Mean-Z",
                 "Transformed Body Gyroscope Mean-X", "Transformed Body Gyroscope Mean-Y",
                 "Transformed Body Gyroscope Mean-Z", "Transformed Frequency Body Gyroscope Mean-X",
                 "Transformed Frequency Body Gyroscope Mean-Y", "Transformed Frequency Body Gyroscope Mean-Z",
                 "Transformed Body Acceleration Magnitude Mean", "Transformed Frequency Body Acceleration Magnitude Mean",
                 "Transformed Body Body Acceleration Jerk Magnitude Mean", "Transformed Frequency Body Body Acceleration Jerk Magnitude Mean",
                 "Transformed Body Body Gyroscope Magnitude Mean", "Transformed Frequency Body Body Gyroscope Magnitude Mean",
                 "Transformed Body Body Gyroscope Jerk Magnitude Mean", "Transformed Frequency Body Body Gyroscope Jerk Magnitude Mean",
                 "Angle: Body Acceleration Mean & Gravity", "Angle: Body Acceleration Jerk Mean & Gravity",
                 "Angle: Body Gyroscope Mean & Gravity", "Angle: Body Gyroscope Jerk Mean & Gravity",
                 "Angle: X & Gravity Mean", "Angle: Y & Gravity Mean", "Angle: Z & Gravity Mean",
                 "Time Body Acceleration SD-X", "Time Body Acceleration SD-Y",
                 "Time Body Acceleration SD-Z", "Time Gravity Acceleration SD-X",
                 "Time Gravity Acceleration SD-Y", "Time Gravity Acceleration SD-Z",
                 "Time Body Acceleration Jerk SD-X", "Time Body Acceleration Jerk SD-Y",
                 "Time Body Acceleration Jerk SD-Z", "Time Body Gyroscope SD-X",
                 "Time Body Gyroscope SD-Y", "Time Body Gyroscope SD-Z",
                 "Time Body Gyroscope Jerk SD-X", "Time Body Gyroscope Jerk SD-Y",
                 "Time Body Gyroscope Jerk SD-Z", "Body Acceleration Magnitude SD",
                 "Gravity Acceleration Magnitude SD", "Body Acceleration Jerk Magnitude SD",
                 "Body Gyroscope Magnitude SD", "Body Gyroscope Jerk Magnitude SD",
                 "Transformed Body Acceleration SD-X", "Transformed Body Acceleration SD-Y",
                 "Transformed Body Acceleration SD-Z", "Transformed Body Acceleration Jerk SD-X",
                 "Transformed Body Acceleration Jerk SD-Y", "Transformed Body Acceleration Jerk SD-Z",
                 "Transformed Body Gyroscope SD-X", "Transformed Body Gyroscope SD-Y",
                 "Transformed Body Gyroscope SD-Z", "Transformed Body Acceleration Magnitude SD",
                 "Transformed Body Body Acceleration Jerk Magnitude SD", "Transformed Body Body Gyroscope Magnitude SD",
                 "Transformed Body Body Gyroscope Jerk Magnitude SD")

##Renaming the columns in the tidy data set...
colnames(tidy_data) <- final_names

##Printing the tidy data set of means to a .txt file...
write.table(tidy_data, file = "Tidy Data.txt", row.names = FALSE)
