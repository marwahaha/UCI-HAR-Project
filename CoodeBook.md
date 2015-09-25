#CodeBook

## Introduction
This document explains the code inside `run_analysis.R` 

It is worth notice that we omit using the raw files inside Inertial Signals folder, thus we are only using "X_train" and "X_test" as data input for our analysis as they are already processed. Along with these two, we start the code reading column names from features.txt file, activity labels from activity_labels.txt, subject from subject_test.txt and subject_train.txt files and activity from y_test.txt and y_train.txt files. 

## Loading datasets into R
Header files apart, we have two groups of three files each. Corresponding to train and test datasets, each group contains files for measures, activity (LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS or WALKING_UPSTAIRS) and subject (from 1 to 30).
To avoid aditional steps, we add $V1 to the end of `read.table` call to convert automatically from data frame to a vector.  
In the first lines of code, we load the data into two different data frames and then we add activity and subject columns to each.

##Binding and renaming

We then proceed to store the data into a sort table data frame defined in the `dplyr` package after we bind both data frames together. Next step is to remove duplicated columns if any.

Now we change to factor the class of `activity` column and rename values from 1 to 6 to the previous mentioned activity labels. Once we have a neat data frame, we select only the columns that contain means or standard deviations values by calling `grep`.

##Cooking the data frame: selecting, grouping and summarising.

Last part of the code It's when we really play with It. After selecting only `activity`, `subject` and columns containing "mean" or "std" values, we proceed to melt the data frame into a only four column one (before was 81): `activity`, `subject`, `measurement` and `acceleration`, being acceleration the column name for the values itself. We then split `measurement` into four: `type` (time or frequency domain signals), `magnitude`, `measure` (mean or std), and `axis` (X, Y or Z) to fit our data frames within tidy data protocols having just one variable per column. 
`extra = "merge"` option inside `separate` second call does split measurement names as `BodyGyro-mean-Z`into three parts. 
Sometimes we will have names like "BodyBodyAccJerkMag-mean" which does not have any angle mark. For those names, we use `fill = "right"` to fill with NA's the `axis` column. 
Finally, we group by activity and subject and summarise the data by displaying the mean of every magnitude for every subject and every activity. 

## List of variables
For every variable we have time or frequency domains which is obtained doing a Fast Fourier Transformation. We then have mean or standard deviation measures and for the most of them we have angles X, Y or Z. We also split variables into the ones originated due the body movements of the subject (Body) and the ones originated due the gravity itself (Gravity). None of the variables have units since they have been normalized and bounded within [-1,1].


* **BodyAcc** corresponds to the part of the acceleration originated by the body of the subject carrying the accelerometer.
* **GravityAcc** corresponds to the parto of the acceleration originated by the gravity itself over the accelerometer. 
* **BodyAccJerk** is the rate of change of acceleration
* **BoyGyro** is the angular acceleration given by the gyroscope carried by the subject
* **BodyGyroJerk** is the rate of change of acceleration given the gyroscpe carried by the subject
* **BodyAccMag** is the magnitude of the linear acceleration due to the subject. You can imagine this as the length of the vector pointing from (0,0,0) to a given position in a 3D space.
* **GravityAccMag** is the magnitude of the linear acceleration due to the gravity.
* **BodyAccJerkMag** is the magnitude of the rate of change of linear acceleration due to the gravity 
* **BodyGyroMag** is the magnitude of the angular acceleartion due to the body movements of the subject
* **BodyGyrojerkMag** is the magnitude of the rate of change of angular acceleration due to the body movements of the subject



