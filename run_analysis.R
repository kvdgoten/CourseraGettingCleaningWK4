#### run_analysis.R
####
#### assignment Getting & Cleaning WK4
####
#### Koen Van der Goten

### initialize
library(readr)
### set working directory
setwd("c:/Users/tn93760/Desktop/Coursera/M3 Getting and Cleaning")

###### 
###### 1. Merges the training and the test sets to create one data set.
###### 

### we will create a structure as visualized below as a first step
#
# ----------------------------------------------------------------------------
#       | subject  | activity  |  561 columns/vars from results (features.txt)
# ----------------------------------------------------------------------------
#    T  |          |           |
#    R  |          |           |
#    A  |   WHO    |   WHAT    |  7352 rows (train/X_train.txt)
#    I  |          |           |
#    N  |          |           |
# ----------------------------------------------------------------------------
#    T  |          |           |
#    E  |          |           |
#    S  |   WHO    |   WHAT    |  2947 rows (test/X_test.txt)
#    T  |          |           |
#       |          |           |
# ----------------------------------------------------------------------------
#
### the subject information is in the "subject_train.txt" and "subject_tests.txt" 
### files
### the activity information is in the "y_train.txt" and "y_tests.txt" files

### read training data
trainResults <- read_table(file="./train/X_train.txt", col_names = FALSE)
trainActivity <- factor(scan(file = "./train/y_train.txt"))
trainSubject <- factor(scan(file = "./train/subject_train.txt"), levels = 1:30 )

### read test data
testResults <- read_table(file="./test/X_test.txt", col_names = FALSE)
testActivity <- factor(scan(file = "./test/y_test.txt"))
testSubject <- factor(scan(file = "./test/subject_test.txt"), levels = 1:30 )

### Get the column names and add to the dataset
#### read the file containing the column names: "features.txt"
columnNames <- read_table(file="./features.txt", col_names = FALSE )
#### The values contain a "column name" preceeded by a row number and a space
#### split the value in a number and a name seperated by " ", and save in a list
#### select only the second element from the list with an anonymous function
#### Finally, assign this result as the column names for trainResults and testResults
columnNamesSplit <- strsplit(columnNames[[1]], split = " ", fixed = TRUE  )
secondElement <- function(x) { x[2] }
ColumnNamesFinal <- sapply(columnNamesSplit, secondElement)
names(trainResults) <- ColumnNamesFinal
names(testResults) <- ColumnNamesFinal

### compose the data sets for training and testing: columns
### 1:              Subject
### 2:              Activity
### 3 and further:  Measures (Results in 561 variables)
### Assign the right names to column 1 and 2 (Subject, Activity)
### for testSet: add a column names trainTest with the value "test" (to know 
### whether train or test)
### for trainSet: add a column names trainTest with the value "train" (to know 
### whether train or test)
trainSet <- cbind(trainSubject, trainActivity, trainResults)
names(trainSet)[1] <- "Subject"
names(trainSet)[2] <- "Activity"
trainSet <- cbind( trainTest = "train", trainSet)

testSet <- cbind(testSubject, testActivity, testResults)
names(testSet)[1] <- "Subject"
names(testSet)[2] <- "Activity"
testSet <- cbind( trainTest = "test", testSet)

### combine the test and train set
totalSet <- rbind(trainSet, testSet)


###### 
###### 2. Extracts only the measurements on the mean and standard deviation for
######    each measurement. 
######
###### 0. of course we keep the first three columns: Subject, trainTest, Activity
###### a. only those with "mean()" at the end
###### b. only those with "std()" at the end
###### c. excluding those with "BodyBody" in the heading (not explained in the
######    original "read.me"-file or "features_info.txt
library(stringr)
names(totalSet)

partSet <-  totalSet[  (  str_detect(names(totalSet), "Subject")
                          | str_detect(names(totalSet), "trainTest")
                          | str_detect(names(totalSet), "Activity")
                          | str_detect(names(totalSet), "mean\\(\\)")
                          | str_detect(names(totalSet), "std\\(\\)")  )
                       & !str_detect(names(totalSet), "BodyBody")
                       ] 


###### 
###### 3. Uses descriptive activity names to name the activities in the data set
###### 
###### the activity labels are in the file "activity_labels.txt"
######

### create a lookup table and use it to aid the transformation for "Activity"
trans <- c("Walking", "WalkingUpstairs", "WalkingDownstairs", "Sitting", 
           "Standing", "Laying")
names(trans) <- c(1, 2, 3, 4, 5, 6)
### now simply translate
partSet$Activity <- trans[ partSet$Activity ]
partSet$Activity <- factor(partSet$Activity, 
                           levels = c("Walking", "WalkingUpstairs", 
                                      "WalkingDownstairs", "Sitting", 
                                      "Standing", "Laying")
                           )


###### 
###### 4. Appropriately labels the data set with descriptive variable names. 
######
###### first tidy the set by "gathering" the different measures
######

#### we choose the long format for the data set
#### One measure per row
#### otherwise too many NAs or empty cells as a result

### we will create a structure as visualized below
#
# ---------------------------------------------------------------------------
#  Train/Test | subject  | activity      |  measure     | value
# ---------------------------------------------------------------------------
#             |          |               |              |
#             |          |               |              |
#  Train or   |   WHO    |   WHAT        |  WHAT        | the value
#   Test      |  1:30    |  6 activities |  60 measures | 617940 observations
#             |          |               |              | 
# ---------------------------------------------------------------------------
library(tidyr)
tidySet <- gather(data = partSet, key = measure, value = value, -(trainTest:Activity))

### make the name of the measures "understandable", no abbreviations, and more
### readibility
### use a lookup-table to aid the transformation
##### the future state, with readable column names
trans <- c(
    "FrequencyBodyAccelerationMeanX", "FrequencyBodyAccelerationMeanY", "FrequencyBodyAccelerationMeanZ",
    "FrequencyBodyAccelerationStandardDeviationX", "FrequencyBodyAccelerationStandardDeviationY", "FrequencyBodyAccelerationStandardDeviationZ",
    "FrequencyBodyLinearAccelerationMeanX", "FrequencyBodyLinearAccelerationMeanY", "FrequencyBodyLinearAccelerationMeanZ", 
    "FrequencyBodyLinearAccelerationStandardDeviationX", "FrequencyBodyLinearAccelerationStandardDeviationY", "FrequencyBodyLinearAccelerationStandardDeviationZ", 
    "FrequencyMagnitudeBodyAccelarationMean", "FrequencyMagnitudeBodyAccelarationStandardDeviation",
    "FrequencyBodyVelocityMeanX", "FrequencyBodyVelocityMeanY", "FrequencyBodyVelocityMeanZ", 
    "FrequencyBodyVelocityStandardDeviationX", "FrequencyBodyVelocityStandardDeviationY", "FrequencyBodyVelocityStandardDeviationZ", 
    
    "TimeBodyAccelerationMeanX", "TimeBodyAccelerationMeanY", "TimeBodyAccelerationMeanZ",
    "TimeBodyAccelerationStandardDeviationX", "TimeBodyAccelerationStandardDeviationY", "TimeBodyAccelerationStandardDeviationZ",
    "TimeBodyLinearAccelerationMeanX", "TimeBodyLinearAccelerationMeanY", "TimeBodyLinearAccelerationMeanZ", 
    "TimeBodyLinearAccelerationStandardDeviationX", "TimeBodyLinearAccelerationStandardDeviationY", "TimeBodyLinearAccelerationStandardDeviationZ", 
    
    "TimeMagnitudeBodyLinearAccelarationMean", "TimeMagnitudeBodyLinearAccelarationStandardDeviation",
    "TimeMagnitudeBodyAccelerationMean",  "TimeMagnitudeBodyAccelerationStandardDeviation", 
    
    "TimeBodyVelocityMeanX", "TimeBodyVelocityMeanY", "TimeBodyVelocityMeanZ", 
    "TimeBodyVelocityStandardDeviationX", "TimeBodyVelocityStandardDeviationY", "TimeBodyVelocityStandardDeviationZ", 
    
    "TimeBodyAngularVelocityMeanX", "TimeBodyAngularVelocityMeanY", "TimeBodyAngularVelocityMeanZ", 
    "TimeBodyAngularVelocityStandardDeviationX", "TimeBodyAngularVelocityStandardDeviationY", "TimeBodyAngularVelocityStandardDeviationZ", 
    
    "TimeMagnitudeBodyAngularVelocityMean", "TimeMagnitudeBodyAngularVelocityStandardDeviation", 
    "TimeMagnitudeBodyVelocityMean", "TimeMagnitudeBodyVelocityStandardDeviation", 
    
    "TimeGravityAccelerationMeanX", "TimeGravityAccelerationMeanY", "TimeGravityAccelerationMeanZ", 
    "TimeGravityAccelerationStandardDeviationX", "TimeGravityAccelerationStandardDeviationY", "TimeGravityAccelerationStandardDeviationZ", 
    
    "TimeMagnitudeGravityAccelerationMean", "TimeMagnitudeGravityAccelerationStandardDeviation"
)
##### the current state, with column names containing abbreviations
names(trans) <- c(
    "fBodyAcc-mean()-X",      "fBodyAcc-mean()-Y",      "fBodyAcc-mean()-Z",      
    "fBodyAcc-std()-X",       "fBodyAcc-std()-Y",       "fBodyAcc-std()-Z",       
    "fBodyAccJerk-mean()-X",  "fBodyAccJerk-mean()-Y",  "fBodyAccJerk-mean()-Z",  
    "fBodyAccJerk-std()-X",   "fBodyAccJerk-std()-Y",   "fBodyAccJerk-std()-Z",    
    "fBodyAccMag-mean()",     "fBodyAccMag-std()",      
    "fBodyGyro-mean()-X",     "fBodyGyro-mean()-Y",     "fBodyGyro-mean()-Z", 
    "fBodyGyro-std()-X",      "fBodyGyro-std()-Y",      "fBodyGyro-std()-Z",     
    
    "tBodyAcc-mean()-X",      "tBodyAcc-mean()-Y",      "tBodyAcc-mean()-Z",      
    "tBodyAcc-std()-X",       "tBodyAcc-std()-Y",       "tBodyAcc-std()-Z",       
    "tBodyAccJerk-mean()-X",  "tBodyAccJerk-mean()-Y",  "tBodyAccJerk-mean()-Z",  
    "tBodyAccJerk-std()-X",   "tBodyAccJerk-std()-Y",   "tBodyAccJerk-std()-Z",   
    
    "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()",  
    "tBodyAccMag-mean()",     "tBodyAccMag-std()",      
    
    "tBodyGyro-mean()-X",     "tBodyGyro-mean()-Y",     "tBodyGyro-mean()-Z",     
    "tBodyGyro-std()-X",      "tBodyGyro-std()-Y",      "tBodyGyro-std()-Z",
    
    "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z",
    "tBodyGyroJerk-std()-X",  "tBodyGyroJerk-std()-Y",  "tBodyGyroJerk-std()-Z",
    
    "tBodyGyroJerkMag-mean()","tBodyGyroJerkMag-std()",
    "tBodyGyroMag-mean()",    "tBodyGyroMag-std()",             ###
    
    "tGravityAcc-mean()-X",   "tGravityAcc-mean()-Y",   "tGravityAcc-mean()-Z",  
    "tGravityAcc-std()-X",    "tGravityAcc-std()-Y",    "tGravityAcc-std()-Z",    
    
    "tGravityAccMag-mean()",  "tGravityAccMag-std()" 
)

##### transform
tidySet$measure <- trans[ tidySet$measure ]




###### 
###### 5. From the data set in step 4, creates a second, independent tidy data
###### set with the average of each variable for each activity and each subject.
######
#### Calculate the mean for every combination of
#### subject, activity, and measure
####

####
### we will create a structure as visualized below
#
# -------------------------------------------------------------
#  subject  | activity  |  measures (60 measures)
# -------------------------------------------------------------
#           |           |           
#    WHO    |   WHAT    |  the mean of the 60 measures
#   1:30    |  6 act    |  for every combination of
#  ordered  | ordered   |  subject and activity
#           |           |           
# -------------------------------------------------------------
library(reshape)
meanSet <- cast(data = tidySet, formula = Subject + Activity ~ measure , mean)
write.table(meanSet, file = "MeanTidySet.txt", row.names = FALSE)
