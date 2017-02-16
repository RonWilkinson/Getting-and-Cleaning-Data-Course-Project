# script for loading and tidying Cell Phone Activity Measurement Data for Getting and Cleaning Data Course Project
# Submission  by Ronald Wilkinson

require(dplyr)
require(tidyr)
require(caret)

## Load the data labels

flabels <- read.table("./data/UCI HAR Dataset/features.txt")
names(flabels) <- c("fnumber","fname")

alabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")


## Load the feature measurements data

x_train <- read.table("./data/UCI HAR Dataset/train/x_train.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/x_test.txt")
x_full <- bind_rows(x_train,x_test)


## Determine which feature columns contain the desired mean and standard deviation measurement data

mean_var_rows <- grep("mean()", flabels[, "fname"], fixed=TRUE)
std_var_rows  <- grep("std()",  flabels[, "fname"], fixed=TRUE)
mean_std_var_rows <- c(mean_var_rows, std_var_rows)

flabels_mean_std <- flabels[ mean_std_var_rows,]
flabels_mean_std <- arrange(flabels_mean_std, fnumber) %>% #put in original variable order
        mutate(  # and fix typo: "BodyBody" should just be "Body" when it occurs
                fname = ifelse((substring(fname,2,9)!="BodyBody"),
                               paste(fname), paste(substring( fname,1,1),substring(fname,6), sep="")))


## Extract just the feature columns that have the mean and standard deviation data
## and give the column headers their proper feature names

x_full_mean_std <- x_full[, flabels_mean_std$fnumber]
names(x_full_mean_std) <- flabels_mean_std$fname


## Load the activity keys for the observations and substitute the activity label names for the keys

y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
y_full <- bind_rows(y_train,y_test)
y_full <- transmute(y_full, activity = alabels$V2[V1])


## Load the subject ids for the observations.  There are no names.  The subjects are only identified by id.

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
subject_full <- bind_rows(subject_train,subject_test)
subject_full <- rename(subject_full, subjectid = V1)


## Bind the subject ids, activity labels, and feature measurements into one dataframe.

detail_measures <- bind_cols(subject_full, y_full, x_full_mean_std)


## Create a simple summary of the contents of detail_measures
##  -- contains the average measure value per subject/activity/feature

basic_measures_summary <- gather(detail_measures, featuremeasure, value,-(subjectid:activity)) %>%
        group_by(subjectid, activity, featuremeasure) %>%
        summarize(average=mean(value))


## Create a more flexible summary of the contents of detail_measures using tiday data principles
##  -- Breaks the features into component parts useful for comparative analysis
##  -- contains the averagge measure value per subject/activity/featuretype/domain/metric/axis

flexible_measures_summary <-
        gather(detail_measures, measure, value,-(subjectid:activity)) %>%
        separate(measure,c("feature","metric","axis"),fill="right",sep="-") %>%
        mutate(domain = ifelse(substring(feature, 1, 1) == "t","time", 
                               ifelse(substring(feature, 1, 1) == "f","frequency", NA))) %>%
        mutate(feature = substring(feature, 2)) %>%
        mutate(metric = substr(metric, 1, nchar(metric)-2)) %>%
        rename( featuretype = feature) %>%
        group_by(subjectid, activity, featuretype, domain, metric, axis) %>%
        summarize(average=mean(value))

write.table(flexible_measures_summary, "flexible_measures_summary.txt",row.names=FALSE)
