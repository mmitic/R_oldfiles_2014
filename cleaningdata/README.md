## Getting and Cleaning Data course. Author: Marko Mitic ##

### This is an information file for the programming assignment ###

The variables and corresponding data (variable values) of the '**tidydataset.txt**' file are obtained using `run_analysis.R` and *Human Activity Recognition Using Smartphones Dataset*, available at the address:
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  "HAR dataset") 

For detailed description of the data variables in the **tidydataset**, please see **CodeBook.md** given in this repository.

`README.txt` **from the original dataset** explains in details how the experiments are carried out, how variables are defined, and what consist each record in the dataset. Please see this file for more information:

Likewise, please see comments in `run_analysis.R`, in which every task in the assignment  list is briefly explained.

----------

Main tasks of the programming assignment:

> You should create one R script called `run_analysis.R` that does the following.
>  
> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
> 3. Uses descriptive activity names to name the activities in the data set.
> 4. Appropriately labels the data set with descriptive activity names. 
> 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

**Note (assumptions)**:

- Original dataset is downloaded from the web page given above, and unzipped in desired directory.
- Files from the training (`X_train.txt`,`Y_train.txt`,`subject_train`) and testing directories (`X_test.txt`,`Y_test.txt`,`subject_test`) are placed in the working directory, together with `run_analysis.R`.
- `run_analysis.R` uses `plyr` and `reshape2` packages, so it is assumed that the user installed those libraries using: `install.packages("plyr")`, `install.packages("reshape2")`

**Code explanation:**

> **1. Merges the training and the test sets to create one data set.**

Read the test and train data

    x<-read.table("X_test.txt")
    y<-read.table("Y_test.txt")
    z<-read.table("subject_test.txt")

    x2<-read.table("X_train.txt")
    y2<-read.table("Y_train.txt")
    z2<-read.table("subject_train.txt")
    
Group (bind) the test and train data (columnwise)

    xx<-cbind(x,y,z)
    yy<-cbind(x2,y2,z2)

Read the names of the columns for the datasets

    nam<-read.table("features.txt")
    nn<-as.character(nam[,2])

Add two names for tables given in `subject_test.txt` and `subject_train.txt` files


    cnames<-c(nn,"activity_code","subject")

Group test and train data into one data frame

    nt<-rbind(xx,yy)

Set names for that frame


    colnames(nt)<-(cnames)

>**2. Extracts only the measurements on the mean and standard deviation for each measurement.**

Extract the names of columns with "`mean()`" and "`std()`"

    sol11<-grepl('mean()', nam[,2], fixed=TRUE)
    sol2<-grepl('std()', nam[,2], fixed=TRUE)

Get the indexes of the extracted names

    idx1<-which(sol11)
    idx2<-which(sol2)
    idx<-c(idx1,idx2)

Generate new frame with the desired columns

    newtable<-nt[idx]

Define new frame so that first two columns are `subject` and `activity_code`

    fin<-data.frame(nt[,ncol(nt):(ncol(nt)-1)],newtable)

> **3. Uses descriptive activity names to name the activities in the data set.**

Read the table with the description of activities

    alt<-read.table("activity_labels.txt")
    altc<-as.character(alt$V2)

Add a column "`activity`" using descriptive names with regards to "`activity_code`" column

    fin$activity=altc[fin$activity_code]

> **4. Appropriately labels the data set with descriptive activity names.**

Place column "`activity`" after the "`subject`" column and erase "`activity_code`" column

    finnames<-names(fin)
    df <- subset(fin, select=c(finnames[1],finnames[length(finnames)],finnames[4:length(finnames)-1]))


Arrange generated data frame according to `subject` column
   
	library(plyr)
    df<-arrange(df,df$subject)

> **5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

Melt the data frame on first two columns
 
    library(reshape2)
    molten_df<-melt(df, id<-c("activity","subject"))

`DCAST` the new data frame with mean over all columns for each activity and each subject


    cast_df<-dcast(molten_df,  subject + activity ~ variable, mean)

Finally, a new **tidydataset.txt** file is created using the following command:

    write.table(cast_df, "C:/Users/.... /tidydataset.txt", sep="\t")
