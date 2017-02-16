---
title: "Getting and Cleaning Data Course Project Codebook"
author: "Ronald Wilkinson"
date: "February 15, 2017"
output: html_document
---

## Data Source

Original Data Source: Human Activity Recognition Using Smartphones Dataset  

The original data providers are:  

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.  
Smartlab - Non Linear Complex Systems Laboratory  
DITEN - Universit? degli Studi di Genova.  
Via Opera Pia 11A, I-16145, Genoa, Italy.  
activityrecognition@smartlab.ws  


### Data Collection

The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 


### Feature Selection 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.  


|Time Domain Features | Frequency Domain Features |
|---               |--|
|tBodyAcc-XYZ      |fBodyAcc-XYZ  |    
|tGravityAcc-XYZ   |fBodyAccJerk-XYZ  |
|tBodyAccJerk-XYZ  |fBodyGyro-XYZ     |
|tBodyGyro-XYZ     |fBodyAccMag       |
|tBodyGyroJerk-XYZ |fBodyAccJerkMag   |
|tBodyAccMag       |fBodyGyroMag      |
|tGravityAccMag    |fBodyGyroJerkMag  |
|tBodyAccJerkMag   |
|tBodyGyroMag      |
|tBodyGyroJerkMag  |

### Feature Metrics

This course project uses two of the original dataset's feature metrics.

|Metrics                    |
|---------------------------|
|mean(): Feature mean         |
|std():  Feature standard deviation |  

## Data Wrangling

### Detail Dataset

For ease of depicting the data in R, the separate text files for subjects, activities, feature names, and measurements provided in the original dataset were incorporated into an R dataframe called **detail_measures** in which the rows are individual observation sessions tagged for each subject and activity.  There are columns with identifying headers for subject id, activity label, measurement session mean of each feature, and measurement session standard deviation of each feature.  Most of the feature measurement column headers are the original names provided in the orginal dataset's feature.txt file. The exceptions are where, as a typo, the string "Body" was doubled to "BodyBody" in the names of a few of the frequency domain features.  The extra "Body"  has been removed in those names.   In all, 10299 rows and 68 columns.

### Basic Summary Dataset

A simple summary dataframe called **basic_measures_summary** has been created that represents the data compactly with the average value for each subject/activity/featuremeasure combination.  


### Flexible Summary Tidy Dataset

A dataframe called **flexible_measures_summary** has been created to put the data into a compact and *easily manipulated* form.  The justification is as follows:

All of the features fall have explicit feature type, domain, and metric categories.  All of the features except the magnitude have an axis category. (For the magnitude types, axis is not defined.) For example, the original feature tBodyGyro-mean()-X has FeatureType= BodyGyro, Domain=time, Metric=mean, and Axis=X. Here is are the category lists:  

| Feature Type   |Domain   |Metric|Axis|
|----------------|---------|------|----|
| BodyAcc        |time     |mean  |X   |
| GravityAcc     |frequency|std   |Y   |
| BodyAccJerk    |         |      |Z   |
| GravityAccJerk |
| BodyGyro       |
| BodyGyroJerk   |
| BodyAccMag     |
| GravityAccMag  |
| BodyGyroMag    |
| BodyGyroJerkMag| 


For analysis, it will often be desirable to group and compare the measurements according to these categories.  Therefore, instead of just listing the feature measures by their orginal names in this flexible summary dataframe, I classify them by category. There is a column for subjectid, activity, featuretype, domain, metric, axis, and average (the aggregated measurement).

  


