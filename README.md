# Getting-and-Cleaning-Data-Course-Project

This repository contains:  

(1) A single R script called run_analysis.R that:  
  + loads the data files provided by the "Human Activity Recognition Using Smartphones" dataset, which are assumed to be in a "/data/UCI HAR Dataset" below the current working directory.
  + combines the data files into a detailed feature measurement dataframe in which the observation measurements tagged by subjectid and activity are the rows and the features measured are the labeled columns.
  + creates a basic summary dataframe from the detailed feature dataframe showing the average value for each subject/activity/featuremeasure.
  + creates a flexible summary dataframe using tidy data principles that breaks each featuremeasure into component categories useful for data manipulation ans provides an average value for each subject/activity/featuretype/domain/metric/axis combination
  + writes the flexible summary dataframe into a file called flexible_measures_summary.txt using write.table().
  
(2) A codebook for describing the detailed and summaized data in Codebook.md.
