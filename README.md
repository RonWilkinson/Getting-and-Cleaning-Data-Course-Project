# Getting-and-Cleaning-Data-Course-Project

This repository contains:  

(1) A single R script called run_analysis.R that:  
  + loads the data files provided by the "Human Activity Recognition Using Smartphones" dataset, which are assumed to be in a "/data/UCI HAR Dataset" below the current working directory.
  + combines the data files into a detailed feature measurement dataframe in which the observation measurements tagged by subjectid and activity are the rows and the features measured are the labeled columns.
  + creates two dataframes summarizing the detailed data, 
  + one a basic summary showing the average value for each subject/activity/featuremeasure.
  + one a flexible summary, using tidy data principles that breaks each featuremeasure into component categories useful for data manipulation ans provides an average value for each subject/activity/featuretype/domain/metric/axis combination  
  
(2) A codebook for describing the detailed and summaized data in Codebook.md.  
(3) Copies of the summarized datasets as csv files.
