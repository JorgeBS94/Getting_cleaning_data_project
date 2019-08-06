################### SCRIPT TO ANALYSE THE DATA OF THE GETTING AND CLEANING DATA COURSE PROJECT

##### Set the working directory

setwd("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project")

##### Download the data folder and unzip it

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "S5_dataset.zip",method = "curl")
zipF <- "C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset.zip"
outDir<- "C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset"
unzip(zipF,exdir=outDir)

##### Upload the training and the test datasets and their subject and label informations

#Training dataset
training <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/train/X_train.txt",row.names = NULL)
training_labels <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/train/y_train.txt",row.names = NULL)
training_subjects <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/train/subject_train.txt")

#Test dataset
testing <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/test/X_test.txt",row.names = NULL)
testing_labels <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/test/y_test.txt",row.names = NULL)
testing_subjects <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/test/subject_test.txt")

# Upload the vector of features
features <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/features.txt",row.names = NULL)
features <- as.character(features[,2])

#Rename the variables in our data according to feature names
names(training) <- features
names(testing) <- features

#Add the activity labels and the subject info to both the training and the testing data
training$label <- training_labels$V1
testing$label <- testing_labels$V1
training$subject <- training_subjects$V1
testing$subject <- testing_subjects$V1

################################

# 1. Merging the training and the test sets to create one data set (we pile them up together)

my_data <- rbind(testing,training)

################################

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

#Use regular expressions to extract only the column names containing means or stds
good_cols<- grep("mean|std|subject|label",colnames(my_data))
my_data <- my_data[,good_cols]

################################

# 3: Add the labels to the training and testing sets, changing the names according to activity names

#Read the activity names
activity <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/activity_labels.txt",row.names = NULL)

#We replace the label numbers by the corresponding activity name in our data frame
my_data$activity <- factor(my_data$label, levels = activity$V1, labels = activity$V2)

#We eliminate the label column, as we no longer need it
my_data$label <- NULL

################################

# 4: replace variable names by informative values
var_names <- colnames(my_data)

#We can apply a series of changes using regular expressions in order to make the names more 
#informative. We will use the magrittr package to avoid writing too much

library(magrittr)
var_names %<>%
    gsub("^t","Time_domain",.) %>%
    gsub("^f","Frequency_domain",.) %>%
    gsub("Acc","Accelerometer",.) %>%
    gsub("Gyro","Gyroscope",.) %>%
    gsub("Mag","Magnitude",.) %>%
    gsub("std","Standard_deviation",.)

#We apply our variable name changes back to the original data
names(my_data) <- var_names

################################

# 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr)

#Now we use the ddply function to subset the dataframe and summarize it according to the mean function:
tidy_data <- ddply(my_data,.(activity,subject),colwise(mean,na.rm = TRUE))

##### Save tidy dataset as a text file
write.table(tidy_data,"tidy_data.txt",row.names = FALSE)