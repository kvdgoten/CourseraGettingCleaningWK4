# CourseraGettingCleaningWK4
Coursera Assignment for Getting and Cleaning Data WK4 : Samsung Movement Data


#### Original data
The original data come and a full description is available at URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 

The source data may be found at URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

For each record in the original dataset is provided: ## New data sets

##### Tidy Data Set
In several steps, described in the R script "run_analysis.R" the dataset was constructed fromseveral subdata sets. The structure of the first resulting dataset is as follows: 

**please look at the "raw" version for visualisation, button top-right**


       | subject  | activity  |  561 columns/vars from results (features.txt) 
-------|----------|-----------|----------------------------------------------
TRAIN  |   WHO    |   WHAT    |  7352 rows (train/X_train.txt)    
-------|----------|-----------|----------------------------------------------
TEST   |   WHO    |   WHAT    |  2947 rows (test/X_test.txt)    


- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment. 

The original data set was split in a number of subsets: 
- train, test
- names of the activities
- names of the measures (columns)


##### Citation for the data
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 

##

In a first step, the train and test sets were combined and enriched with subjet, activity,and measure (column) information.The subject information is in the "subject_train.txt" and "subject_tests.txt" files. The activity information is in the "y_train.txt" and "y_tests.txt" files.The column names were read from "features.txt", and transformed as needed.

In a second step, only the measurements with "mean()" or "std()" at the end of their nameswere kept. In addition we kept the first three columns: "trainTest", "subject", and "activity".Moreover, the measures with "BodyBody" in the heading were not retained, as they are not explained in the original "read.me"-file or "features_info.txt". 

In a third step, the activity labels (e.g. "walking", "standing", ...) were used to replace thenumbers identifying the activities.  

In a fourth step, the identifiers for the different measures were transformed: abbreviations were replaces with the full words to increase readibility. At the same time, we opted for a tidy data setin "long format". We choose to have one observation per row. 

**please look at the "raw" version for visualisation, button top-right**

---------------------------------------------------------------------------  
Train/Test |  subject   | activity      |  measure     | value 
---------------------------------------------------------------------------            
           |            |               |              |
Train or   |    WHO     |   WHAT        |  WHAT        | the value  
Test       |    1:30    |  6 activities |  60 measures | 617940 observations            
|          |            |               |              |
--------------------------------------------------------------------------- 

##### Mean Tidy Data Set 

In a fifth step, a second tidy data set was created with the average of each variable foreach activity and subject.

For readibilities sake we chose the following structure: 180 rows x 62 columns. 

**please look at the "raw" version for visualisation, button top-right**

-------------------------------------------------------------  
subject  | activity  |  measures (60 measures) 
-------------------------------------------------------------           
  WHO    |   WHAT    |  the mean of the 60 measures  
 1:30    |  6 act    |  for every combination of 
ordered  | ordered   |  subject and activity     
-------------------------------------------------------------
