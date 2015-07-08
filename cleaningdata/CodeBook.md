## Getting and Cleaning Data course. Author: Marko Mitic ##

### This is a code book file for the programming assignment ###

The variables and corresponding data (variable values) of the '**tidydataset.txt**' file are obtained using `run_analysis.R` and *Human Activity Recognition Using Smartphones Dataset*, available at the address:
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  "HAR dataset") 

For detailed description of transformation of the original dataset into the **tidydataset**, please see **README.md** given in this repository.


`README.txt` **from the original dataset** explains in details how the experiments are carried out, how variables are defined, and what consist each record in the dataset. Please see this file for more information:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

----------

###DATA DICTIONARY for the `tidydataset.txt`###

**tidydataset** refers to a data obtained using unified original dataset (training and testing data are unified into one table). New dataset has 180 values (rows) of the **68 variables** (columns) related to the following:


**1. subject** (1 column):
 
- include values from 1 to 30
- each value refers to one (individual) volunteer that participated in the experiment

**2. activity** (1 column):

-  refers to activity description (labels) for each subject
-  six descriptive activity names are defined: 
    `WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING`

**3. features of the dataset that come from the accelerometer (tAcc-XYZ) and gyroscope (tGyro-XYZ)  raw signals** (66 columns):

Please see `features_info.txt` **in original dataset** for detailed description of the features. 

*Description of the features*

The signals used to estimate variables of the feature vector for each pattern (**33 features in total**) are:

> tBodyAcc-X; tBodyAcc-Y; tBodyAcc-Z; tGravityAcc-X; tGravityAcc-Y; tGravityAcc-Z; tBodyAccJerk-X; tBodyAccJerk-Y; tBodyAccJerk-Z; tBodyGyro-X; tBodyGyro-Y; tBodyGyro-Z; tBodyGyroJerk-X; tBodyGyroJerk-Y; tBodyGyroJerk-Z; tBodyAccMag; tGravityAccMag; tBodyAccJerkMag; tBodyGyroMag; tBodyGyroJerkMag; fBodyAcc-X; fBodyAcc-Y; fBodyAcc-Z; fBodyAccJerk-X; fBodyAccJerk-Y; fBodyAccJerk-Z; fBodyGyro-X; fBodyGyro-Y; fBodyGyro-Z;  fBodyAccMag; fBodyAccJerkMag; fBodyGyroMag; fBodyGyroJerkMag;

**tidydataset** includes **two** components in the set of variables that were estimated from these signals (obtained also from original dataset):

> mean(): Mean value

AND

> std(): Standard deviation 

**This gives 33x2=66 columns (variables) for the feature vector, and 66+2=68 total variables in the tidydataset!**


*Description of the values of the features*

- **Each value of the 66 features is the average of each variable for each activity and each subject.** 
- In total, there are **180 average values** (average for 6 activities and 30 subjects): 
 **6x30=180**


----------


For detailed description of the transformation of the original dataset into the **tidydataset**, please see **README.md** given in this repository. 