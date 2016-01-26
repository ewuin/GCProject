# Getting and Cleaning Data Course Project
# Readme

## Author: Ewuin

This readme accompanies the R script run_analysis.R
The script transforms selected data from the Human Activity Recognition
experiment performed by Anguita et al. and available for public use at the
[UCI repository] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "UCI Machine Learning Repo").

The data is transformed into a tidy data set in which means are calculated for
each study participant for each physical activty performed for selected variables in
the original [data set]. (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "zip file").

The script was written using R Version 3.2.2 (2015-08-14)
Platform: x86_64-w64-mingw32/x64 (64-bit)
in R studio Version 0.99.489

## Instructions

Run the script run_analysis.R after downloading and extracting the [zip file] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "zip file"). The folder containing the files must be in your working directory.

The dplyr package must be installed as well.

See the file CodeBook.md for more specific details of how the script works.

## Script summary
The transformations that were performed on the data files are:

1) Adding the subject and activity ID numbers to the train and test group data sets
2) Merging the data of the train and test groups
3) Adding column names to the merged data set
4) Replacing the Activity ID number with a description
5) Selecting the columns with means and standard deviations
6) Sorting, and grouping the data by Subject ID and Activity
7) Taking the mean of the activity data of each activity for each subject

The script will output a txt file (HAR_Tidy.txt) with the tidy data table.

## References
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012