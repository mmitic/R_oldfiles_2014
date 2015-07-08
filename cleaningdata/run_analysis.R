# The variables and corresponding data (variable values) of the generated 'tidydataset.txt' 
# file (final dataset) are obtained using run_analysis.R and Human Activity Recognition 
#Using Smartphones Dataset, available at the address: 

# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# PLEASE SEE README.txt in the original dataset for the detailed description of
# variables and corresponding values. 

## SEE ALSO README.md in the GITHUB repo, where assumprtions an code explanation is given in details!

## NOTE: BEFORE starting with the code, ensure that you downloaded the zip. file, and that 
## your train and test data (i.e. X, Y, subject data) exist in the same working directory!

## IT IS ASSUMED THAT YOU CAN CALL LIBRARIES "PLYR" AND "RESHAPE2", i.e. that you install the packages:
# install.packages("plyr")
# install.packages("reshape2")

########################################################### START ASSIGNMENT

#### 1. Merge the training and the test sets to create one data set.########

##READ THE TEST DATA 
x<-read.table("X_test.txt")
y<-read.table("Y_test.txt")
z<-read.table("subject_test.txt")

## READ THE TRAIN DATA
x2<-read.table("X_train.txt")
y2<-read.table("Y_train.txt")
z2<-read.table("subject_train.txt")

## GROUP (BIND) the test  data COLUMNWISE
xx<-cbind(x,y,z)
## GROUP (BIND) the train data COLUMNWISE
yy<-cbind(x2,y2,z2)

## READ THE NAMES OF THE COLUMNS FOR THE DATASETS
nam<-read.table("features.txt")
nn<-as.character(nam[,2])

## ADD TWO NAMES FOR TABLES in subject_test/train.txt files
cnames<-c(nn,"activity_code","subject")

## GROUP TEST AND TRAIN DATA INTO ONE DATA FRAME
nt<-rbind(xx,yy)
## SET NAMES FOR THAT FRAME
colnames(nt)<-(cnames)

#### 2.Extract only the measurements on the mean and standard deviation for each measurement.#### 

## EXTRACT THE names of columns with "mean()" and "std()"
sol11<-grepl('mean()', nam[,2], fixed=TRUE)
sol2<-grepl('std()', nam[,2], fixed=TRUE)

## GET THE indexes of the extracted names
idx1<-which(sol11)
idx2<-which(sol2)
idx<-c(idx1,idx2)

## GENERATE NEW FRAME WITH the desired columns
newtable<-nt[idx]
## DEFINE NEW FRAME SO THAT FIRST TWO COLUMNS ARE SUBJECT AND ACTIVITY_CODE
fin<-data.frame(nt[,ncol(nt):(ncol(nt)-1)],newtable)

#### 3. Use descriptive activity names to name the activities in the data set ####

## READ THE TABLE WITH THE DESCRIPTION OF ACTIVITIES
alt<-read.table("activity_labels.txt")
altc<-as.character(alt$V2)

##ADD A COLUMN "ACTIVITY" USING DESCRIPTIVE NAMES WITH REGARDS TO "ACTIVITY_CODE" COLUMN!!!
fin$activity=altc[fin$activity_code]


#### 4. Appropriately label the data set with descriptive activity names. ####
## PLACE COLUMN "ACTIVITY" AFTER THE "SUBJECT" COLUMN and ERASE "ACTIVITY_CODE" COLUMN
finnames<-names(fin)
df <- subset(fin, select=c(finnames[1],finnames[length(finnames)],finnames[4:length(finnames)-1]))


##ARRANGE GENERATED DATA FRAME ACCORDING TO SUBJECT COLUMN
library(plyr)
df<-arrange(df,df$subject)

#### 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. #######
##MELT THE DATA FRAME ON FIRST TWO COLUMNS 
library(reshape2)
molten_df<-melt(df, id<-c("activity","subject"))
##DCAST THE NEW DATA FRAME WITH MEAN OVER ALL COLUMNS FOR EACH ACTIVITY AND EACH SUBJECT
cast_df<-dcast(molten_df,  subject + activity ~ variable, mean)
########################

## WRITE THE TIDY DATASET AS A NEW TXT FILE: "tidydataset.txt"
write.table(cast_df, "C:/Users/MM/Desktop/Rcodes/tidydataset.txt", sep="\t")

############################################################# END