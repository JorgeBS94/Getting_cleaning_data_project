################### SCRIPT TO ANALYSE THE DATA OF THE GETTING AND CLEANING DATA COURSE PROJECT

##### Download the data and unzip it

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "S5_dataset.zip",method = "curl")
zipF <- "C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset.zip"
outDir<- "C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset"
unzip(zipF,exdir=outDir)

##### Upload the training and the test datasets

#Training dataset
training <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/train/X_train.txt",row.names = NULL)
training_labels <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/train/y_train.txt",row.names = NULL)

#Test dataset
testing <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/test/X_test.txt",row.names = NULL)
testing_labels <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/test/y_test.txt",row.names = NULL)

##### Upload and use the feature vector and the activity and subject names

#Feature vector
features <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/features.txt",row.names = NULL)
features <- as.character(features[,2])

#Rename the variables in our data set according the the feature names
names(training) <- features
names(testing) <- features

#Subjects
subject_train <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/test/subject_test.txt")

#We add the subjects as a column to the dataframes
training$subject <- as.factor(subject_train$V1)
testing$subject <- as.factor(subject_test$V1)

#Activity names
activity <- read.table("C:/Users/jorge_000/Desktop/ONLINE_COURSES/DATA_SCIENCE_COURSERA/3_CLEANING_DATA/Getting_cleaning_data_project/S5_dataset/UCI HAR Dataset/activity_labels.txt",row.names = NULL)

#We add the labels to the training and testing sets, changing the names according to activity names
training$labels <- factor(training_labels$V1,labels = as.character(activity$V2))
testing$labels <- factor(testing_labels$V1,labels = as.character(activity$V2))

#### Merging the training and the test sets to create one data set (we do it by common column names)
my_data <- rbind(testing,training)
dim(my_data)

#### Extracts only the measurements on the mean and standard deviation for each measurement.

#We use regular expressions to identify which columns in our dataset contain the words mean and sd:

good_cols<- grepl("\\bmean()\\b|\\bstd()\\b",colnames(my_data))
new_data <- my_data[,good_cols]
colnames(new_data)
                 
#### Create a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)

#Now we use the ddply function to subset the dataframe and summarize it according to the mean function:
tidy_data <- ddply(new_data,.(labels,subject),colwise(mean,na.rm = TRUE))

#Note that ddply eliminates the duplicated columns automatically, so we see that the number of dimensions has changed
dim(tidy_data)

#Another way to do it is with the aggregate function. However, in this case duplicated columns are not handled for us, 
#so we must get them rid of them manually:

tidy_data2 <- aggregate(new_data, by = list(new_data$subject, new_data$labels),mean)
#We use the unique () function of the dplyr package to subset the unique columns from our dataframe:
tidy_data2 <- tidy_data2[,unique(colnames(new_data))]
#We see that the dimensions are equal to those above
dim(tidy_data2)
