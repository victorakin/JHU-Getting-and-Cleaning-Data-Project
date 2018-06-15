# JHU-Getting-and-Cleaning-Data-Project
JHU Getting and Cleaning Data Project code

This project pulls in various data files, manipulates the data, and 
produces an output file with tidy data

The R code is in run_analysis.R

To run this code, you need eight files that were provided in various folders
of the zip file located at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The 8 files that need to be in your working directory are:
activity_labels.txt
features.txt
subject_test.txt
subject_train.txt
X_test.txt
X_train.txt
y_test.txt
y_train.txt

The R function run_analysis() will return a tidy data set with the mean of columns selected from the original data for each subject and activity.  The selected columns were data that either contianed a mean or a standard deviation.

Appropriate use of the function can be one of two methods:

run_analysis()     will produce a text file on your local directory named CleaningDataProject.txt with the tidy data set
                    and return the tidy data set

DFname <- run_analysis   will in addition to producing the text file, will return the tidy data set to a dataframe named DFname
