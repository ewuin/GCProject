# This script takes the data from mobile wearables testing that used 
# a cell phone's accleremoter and gyroscope to quantitatively identify when
# a person is performing one of six activities (climbing stairs, walking, lying down, etc.)
# and performs some data reorganizing to complete the course project for
# Johns Hopkins University "Getting and Cleaning Data" course on 
# coursera.org.
# The original dataset and readme files were obtained from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# The data was produced by 
# Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
# Smartlab - Non Linear Complex Systems Laboratory
# DITEN - Università degli Studi di Genova.
# Via Opera Pia 11A, I-16145, Genoa, Italy.
# activityrecognition@smartlab.ws
# www.smartlab.ws
# See their readme files for license agreement.

# The objective of this program is to reorganize the data in order
# to extract the mean readings for each subject for each activity.
# The readings (columns) are from the data recorded by the accelerometer
# and gyroscopes (up to 563 variables). The subset, however will only contain
# the readings containing means and standard deviations.


# Steps 0) Read in data 1) Column bind test or train data to activity 
# and subject ID data  2) row bind the test and train data tables to make
# one table 3) Assign names to the 561 variables using the features.txt file
#  and assign character names to the different activity ID's
# 4) USE select function in dplyr subset desired columns  
# 5) USE dplyr package to output data frame with averages for each
#     subsetted column per activity per subject ID


library (dplyr)

#setwd('./R')

#Step 0 - read in data
# train data has 70% of participants data sets
# test data has the other 30%  of observations
# _data has the 561 variables
# _acts has the six activities
# _ID has the subjects' ID numbers

train_data<- read.table('./samsungDataset/UCI HAR Dataset/train/X_train.txt')
train_acts<- read.table('./samsungDataset/UCI HAR Dataset/train/y_train.txt')
train_ID<- read.table('./samsungDataset/UCI HAR Dataset/train/subject_train.txt')

test_data<- read.table( './samsungDataset/UCI HAR Dataset/test/X_test.txt')
test_acts<- read.table( './samsungDataset/UCI HAR Dataset/test/y_test.txt')
test_ID<- read.table( './samsungDataset/UCI HAR Dataset/test/subject_test.txt')

# Step 1 - column bind activities and ID's to 561 variables
# For the data sets, column 1 will now be subject ID (1-30), column two
# will be activity ID (1-6)

trainers_data0=cbind (train_acts,train_data)
trainers_data <- cbind (train_ID,trainers_data0)
  
testers_data0=cbind (test_acts,test_data)
testers_data <- cbind (test_ID,testers_data0)  

# Step 2 - Row bind data sets for the trainers and testers to make
# one data table for all participants
# dimensions of data frame will be 10299 obs. of 563 varibles


HAR_data<- rbind(trainers_data,testers_data)

# Step 3 - Give names to columns and rename activities

shem1<- c('Subject.ID', 'Activity')

shem3<-read.table('./samsungDataset/UCI HAR Dataset/features.txt')
shem3_563<-select(shem3, V2)
shem3_563c <-as.character(shem3_563[,1])

shem0<-c(shem1,shem3_563c)

shem<-make.names(shem0, unique=TRUE)

colnames(HAR_data)<-shem

Activities<-c('WALKING', 'WALKING_UPSTAIRS',
               'WALKING_DOWNSTAIRS', 'SITTING',
               'STANDING', 'LAYING')

act_FUN<-function (x) {
  Act <- Activities[x]
  Act
}


for (i in 1:length (HAR_data$Activity))
  {
  
  z<-as.integer(HAR_data$Activity[i])
 
  HAR_data$Activity[i] <- act_FUN(z)
}

# 4) Subset desired columns. For this assignment, only
# colums showing means and standard deviations are required.

HAR_sub<-select(HAR_data, contains('Subject.ID'), contains('Activity'), 
                contains('mean'), contains('std'))

#5) USE dplyr package to output data frame with averages for each
#     subsetted column per activity per subject ID


HAR_acts <- HAR_sub %>% arrange (Subject.ID, Activity) %>% group_by( Subject.ID, Activity)

HAR_Tidy <- summarize_each (HAR_acts, funs(mean))

#Output file

write.table(HAR_Tidy, './HAR_Tidy.txt', row.names=FALSE)
