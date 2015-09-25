***  
Fran Martinez Gomez  
hornet330@gmail.com  
9-26-2015    

***

#README

This document explains the work done with the data from `UCI HAR Dataset`, which is a collection of files containing data from accelerometers and gyroscpes taken during and experiment with 30 different subjects. These subjects were people carrying a Samsung Galaxy S II on their waist and performing six different activities: `walking`, `walking upstairs`, `walking downstairs`, `sitting`, `standing` and `laying`. Accelerometers within the smartphone captured 3-axial lineal accelerations and gyroscopes captured 3-axial angular accelerations. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The goal of this work is to clean the data and present a nice, abreviated output. We achieve that by first binding the two datasets (test and train) together after we rename columns and clean duplicated ones. Next we do some calculations and grouping explained at CoodBook document, for finally present an output displaying only seven columns: `subject`, `activity`, `type`, `magnitude`, `measure`, `axis` and `mean`. I chose this `long` format because I think It is more readable to have a row length that fits in every screen by having every magnitude in a new row. I also chose to separate original variable names into type, magnitude, measure and axis to comply with the one-variable-per-column rule in tidy data protocols, even though this adds some NA when some variables have no axis. Thus NA's correspond to variables that are impossible to read for that obersevation, not to missing values. There are no units since the variables were normalized, and values were bouned within [-1,1]. The columns are like follows: 

* **subject** is an integer column serving as ID for every subject
* **activity** is a factor variable that displays the activity that is making the subject on that observation
* **type** is a character variable for time or frecuency types of observations
* **magnitude** is the magnitude we are measuring
* **measure** is the static measure calculated from raw data: mean or standard deviation
* **axis** X,Y or Z.
* **mean** is were we display the mean value of a magnitude for the given set of variables mentioned before.

