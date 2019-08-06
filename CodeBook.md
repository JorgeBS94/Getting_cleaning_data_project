### Introduction to the dataset

In this project we have employed the Human Activity Recognition Using
Smartphones Dataset. This dataset was gathered recording six activities
performed by 30 people whose age ranged bewteen 19 and 48. Each of them
performed 6 activities (waking, waking upstairs, walking downstairs,
sitting, standing and laying) while wearing a Samsung Galaxy SII device.
The accelerometer and gyroscope of the phone were used to register the
linear acceleration and angular velocity. Moreover, those signals were
filter and processed and a vector of 561 features was obtained by
computing variables from the time and frequency domain.

### File description

In order to conduct this project, we used the following files:

**"X\_train.txt"**: contains the training data and it has 7352
observations of 561 variables.

**"y\_train.txt"**: contains the training set activity labels and it has
7352 observation of 1 varible.

**"X\_test.txt"**: contains the testing data and it has 2947 obserations
of 561 variables.

**"y\_test.txt"**: contains the testing data activity labels and it has
2947 obserations of 561 variables.

The number of observations of the training and testing data implies that
70% of the whole dataset was used to create the training data, while the
remaining 30% conformed the test data.

Additionally, we used 4 additional files:

**"features.txt"**: it comprises a list of all 561 features or predictor
names.

**"subject\_train.txt"**: it contains an identifier for the person who
performed an exercise, which ranges from 1 to 30.

**"subject\_test.txt"**: it is similar to "subject\_train.txt", but in
the testing dataset.

### Cleaning data procedure

In order to produce a tidy dataset, we have carried out an analysis as
follows:

1.  We have loaded into R studio the training and test data, as well as
    their respective labels, the feature vector and the list of the
    subjects performing the exercises.

2.  We have used the names of the features included in "features.txt" to
    change the column names in our training and test data.

3.  We have added 2 additional columns to the training and test
    datasets: one with the respective labels and another with the
    corresponding subjects that performed each exercise.

4.  Once that the training and the testing data had the correct variable
    names, the information about the subjects and the labels for each
    exercise, we merged them together vertically (by row).

5.  Then, we have extracted the variable names containing the words
    "mean" or "std", as we are only interested in those measurements.

6.  After that, we have used regular expressions to make more
    informative certain variable names (column names) in our dataset.

7.  Finally, we have created a tidy dataset by grouping our previous
    data by subject and by activity label and computing the mean value.
    The final dataframe has been saved as a txt file.