# Codebook for course project:
## Human Activity Recognition

This is a codebook for the script run_analysis.R which was 
written to complete the course project for the Getting and Cleaning
Data course from Johns Hopkins University on Coursera.org.

##The data source
The original data was taken from [here] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "zip file")

The dataset author's description can be found [here]
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "UCI Machine Learning Repo")

## Data set generation

The data were generated as part of an experiment done by university researchers to quantitatively describe human motion. They used signals from cell phone accelerometers and gyroscopes to generate data as 30 human participants did six activities

*WALKING

*WALKING UPSTAIRS

*WALKING DOWNSTAIRS

*SITTING

*STANDING

*LAYING

## Description of the variables
For each particpant for each activity, data were gathered measuring their translational
and angular acceleration in the x, y and z directions. The researchers gathered the data
and performed additional calculations such as calculating means, standard deviations, jerk, and fast fourier transforms into the frequency domain. This resulted in data tables
with 561 variables (columns).

## The raw data

The data that was downloaded came divided into two folders for the two study groups in the experiment, a "Train" group and a "Test" group.

The data come with the following descriptive files:

* activity_labels.txt 
  - Indexes of the 6 activities

* features.txt 
  - The names of the 561 variables in the data as processed by the original researchers.

* features_info.txt
  - The dataset authors' descriptions of the variables in features.txt

* README.txt
  - Dataset authors' Readme file.

The files containing the data used by the script are the following. All data are treated as numeric by R.

* X\_train.txt  and  X\_test.txt 
  - Contain the 561 columns of data for
the train(7352 observations) and test groups (2947 observations)
  - These datasets have been processed by the researchers as described above.

* y\_train.txt and y\_test.txt
  - Contain the activity ID column for the datasets.

* subject\_train.txt and subject_test.txt
  - Contain the participant ID number column for the datasets.

In addition, there are folders named
"Inertial Signals" with unprocessed datasets from the accelerometers and gyroscopes.

## Transformations performed

The transformations that were performed on the data files above are:

1) Adding the subject and activity ID numbers to the train and test group data sets
2) Merging the data of the train and test groups
3) Adding column names to the merged data set
4) Replacing the Activity ID number with a description
5) Selecting the columns with means and standard deviations
6) Sorting, and grouping the data by Subject ID and Activity
7) Taking the mean of the activity data of each activity for each subject 

## Implementation by run_analysis.R

All files were read into R using read.table()
The dplyr package was used in steps 3 and 5-7.

1) Adding the subject and activity ID numbers to the train and test group data sets:
* column bind the subject ID and activity to data obtained from
X\_train.txt  and  X\_test.txt

2) Merging the data of the train and test groups:
* row bind the data created in step 1

3) Adding column names to the merged data set
* Read in column names from feature.txt, select column with the names
* Create a vector with column names for the Subject ID and Activity columns
* Bind the two to make a vector length 563
* Use make.names() to make the names in the vector syntatically valid and unique (use unique = TRUE)
* Assign the column names to the data frame using colnames()

4) Replacing the Activity ID number with a description
* Make a character vector in which the index of each element matches the number of the activity. The element is the activity ('Walking', 'sitting', etc.)
* Use a for loop along the Activity column replacing the activity number with a character description
* Each pass through the loop calls a naming function act_FUN()

5) Selecting the columns with means and standard deviations
* Use select() and contains() to select the columns Subject.ID and Activity and any other column with the string "mean" and "std" for standard deviation.

6) Sorting, and grouping the data by Subject ID and Activity
* Use the arrange() and group_by() functions to sort and group the data by Subject ID and Activity

7) Taking the mean of the activity data of each activity for each subject 
* Use summarize_each() with the data frame in step 6 and function mean() as arguments.

As the last step, the script outputs a file named HAR_Tidy.txt using write.table() with
the argument row.name = FALSE.
