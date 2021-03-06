## CODEBOOK

Coursera Getting and Cleaning assignment WK4: Samsung movement data

### tidySet

The data set structure is as follows

**please look at the "raw" version for visualisation, button top-right**


Train/Test | subject  | activity      |  measure     | value
-----------|----------|---------------|--------------|---------------------
 Train     |   WHO    |   WHAT        |  WHAT        | the value
           |  1:30    |  6 activities |  60 measures | 441120 observations
-----------|----------|---------------|--------------|---------------------
 Test      |   WHO    |   WHAT        |  WHAT        | the value
           |  1:30    |  6 activities |  60 measures | 176820 observations


### Columns

#### trainTest:  
  + categorical data
  + identifies whether the observation is part of the test or training set
    1. "train": part of the training set
    2. "test":  part of the test set

#### Subject
  + categorical data
  + identifies the subject in an anonymous way
  + 1, 2, ... 30

#### Activity
  + categorical data
  + identifies 1 out of 6 possible activities
    + "Walking",
    + "WalkingUpstairs",
    + "WalkingDownstairs",
    + "Sitting",
    + "Standing",
    + "Laying".
    
            
#### measure
  + categorical data
  + identifies 1 out of 60 possible measures
    + "FrequencyBodyAccelerationMeanX",
    + "FrequencyBodyAccelerationMeanY",
    + "FrequencyBodyAccelerationMeanZ",
    + "FrequencyBodyAccelerationStandardDeviationX",
    + "FrequencyBodyAccelerationStandardDeviationY",
    + "FrequencyBodyAccelerationStandardDeviationZ",
    + "FrequencyBodyLinearAccelerationMeanX",
    + "FrequencyBodyLinearAccelerationMeanY",
    + "FrequencyBodyLinearAccelerationMeanZ",
    + "FrequencyBodyLinearAccelerationStandardDeviationX",
    + "FrequencyBodyLinearAccelerationStandardDeviationY",
    + "FrequencyBodyLinearAccelerationStandardDeviationZ",
    + "FrequencyMagnitudeBodyAccelarationMean",
    + "FrequencyMagnitudeBodyAccelarationStandardDeviation",
    + "FrequencyBodyVelocityMeanX",
    + "FrequencyBodyVelocityMeanY",
    + "FrequencyBodyVelocityMeanZ",
    + "FrequencyBodyVelocityStandardDeviationX",
    + "FrequencyBodyVelocityStandardDeviationY",
    + "FrequencyBodyVelocityStandardDeviationZ",
    + "TimeBodyAccelerationMeanX",
    + "TimeBodyAccelerationMeanY",
    + "TimeBodyAccelerationMeanZ",
    + "TimeBodyAccelerationStandardDeviationX",
    + "TimeBodyAccelerationStandardDeviationY",
    + "TimeBodyAccelerationStandardDeviationZ",
    + "TimeBodyLinearAccelerationMeanX",
    + "TimeBodyLinearAccelerationMeanY",
    + "TimeBodyLinearAccelerationMeanZ",
    + "TimeBodyLinearAccelerationStandardDeviationX",
    + "TimeBodyLinearAccelerationStandardDeviationY",
    + "TimeBodyLinearAccelerationStandardDeviationZ",
    + "TimeMagnitudeBodyLinearAccelarationMean",
    + "TimeMagnitudeBodyLinearAccelarationStandardDeviation",
    + "TimeMagnitudeBodyAccelerationMean",
    + "TimeMagnitudeBodyAccelerationStandardDeviation",
    + "TimeBodyVelocityMeanX",
    + "TimeBodyVelocityMeanY",
    + "TimeBodyVelocityMeanZ",
    + "TimeBodyVelocityStandardDeviationX",
    + "TimeBodyVelocityStandardDeviationY",
    + "TimeBodyVelocityStandardDeviationZ",
    + "TimeBodyAngularVelocityMeanX",
    + "TimeBodyAngularVelocityMeanY",
    + "TimeBodyAngularVelocityMeanZ",
    + "TimeBodyAngularVelocityStandardDeviationX",
    + "TimeBodyAngularVelocityStandardDeviationY",
    + "TimeBodyAngularVelocityStandardDeviationZ",
    + "TimeMagnitudeBodyAngularVelocityMean",
    + "TimeMagnitudeBodyAngularVelocityStandardDeviation",
    + "TimeMagnitudeBodyVelocityMean",
    + "TimeMagnitudeBodyVelocityStandardDeviation",
    + "TimeGravityAccelerationMeanX",
    + "TimeGravityAccelerationMeanY",
    + "TimeGravityAccelerationMeanZ",
    + "TimeGravityAccelerationStandardDeviationX",
    + "TimeGravityAccelerationStandardDeviationY",
    + "TimeGravityAccelerationStandardDeviationZ",
    + "TimeMagnitudeGravityAccelerationMean",
    + "TimeMagnitudeGravityAccelerationStandardDeviation"

#### value
  + numerical data
  + the value for the measure defined under "measure"
  + the values are all normalized and bounded within[-1, +1]


## MeanTidySet

This set contains the means of the 60 values of the previous data set as a combination of subject and activity. 
This is a 180 rows x 62 columns data set. The data structure is as follows:

**please look at the "raw" version for visualisation, button top-right**

subject  | activity  |  measures (60 measures in columns)
---------|-----------|---------------------------------------
  WHO    |   WHAT    |  the value of the mean for the 60
 1:30    |  6 act    |  measures for every combination of
ordered  | ordered   |  subject and activity


The definition of the data is completely identical to the on of the previous data set, but is repeated below for completeness sake.

### Columns

#### Subject
  + categorical data
  + identifies the subject in an anonymous way
  + 1, 2, ... 30
  
#### Activity
  + categorical data
  + identifies 1 out of 6 possible activities
    + "Walking",
    + "WalkingUpstairs",
    + "WalkingDownstairs",
    + "Sitting",
    + "Standing",
    + "Laying".

#### measure
  + categorical data
  + identifies 1 out of 60 possible measures
  + the measures are completely identical as the ones defined under the previous data set "Tidyset".

#### value
  + numerical data
  + the value for the measure defined under "measure"
  + the values are all normalized and bounded within[-1, +1]
