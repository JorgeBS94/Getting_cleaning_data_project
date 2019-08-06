# Getting and cleaning data course project

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

Throughout this project, we have obtained and cleaned data from accelerometers from a Samsung Galaxy S device. The goal is to provide a tidy dataset that can be further analysed. This repository contains all the files employed, which are the following:

- `run_analysis.R`: this file contains the main steps used to download and transform the data up to the obtention of a tidy dataset. 

- `CodeBook.md`: it describes the variables, the data and every transformation we performed in order to clean up the data.

- `tidy_data.txt`: it is a text file containing the tidy dataset generated as an output of the "run_analysis.R" file.

## Data set information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Cleaning data procedure

The file `run_analysis.R` allows to perform all the neccessary steps to obtain and clean the data, producing the `tidy_data.txt` file which contains the cleaned dataset. The main steps carried out in this project are explained in detail in the `CodeBook.md` file.


