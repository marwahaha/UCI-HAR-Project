library(dplyr)
library(tidyr)

   ## --Reading data --

##Loading processed files (X_train and X_test), features, subjects and activities into R
train <- read.table("./train/X_train.txt", sep = "")  ## data frame for train data
test <- read.table("./test/X_test.txt", sep = "")  ##data frame for test data
features <- read.table("./features.txt", sep = "")
subtrain <- read.table("./train/subject_train.txt", sep = "")$V1 ## read directly as integer vector
subtest <- read.table("./test/subject_test.txt", sep = "")$V1
act_train <- read.table("./train/y_train.txt")$V1  #files containing activities for every measure
act_test <- read.table("./test/y_test.txt")$V1
activityLabels <- read.table("./activity_labels.txt")$V2

features2 <- as.character(features$V2)  ## storing features data frame as a character vector

tidyNames <- gsub("()","", features2, fixed = TRUE)  ## Removing () from names

  ## -- managing columns --

colnames(test) <- tidyNames  ## naming data frame columns
test$subject <- subtest      ## adding columns subject  
test$activity <- act_test    ## adding column activity

colnames(train) <- tidyNames
train$subject <- subtrain
train$activity <- act_train

  ## --merging data frames

df <- tbl_df(bind_rows(test, train))    ##merging together test and train data frames into a dplyr table. 
df <- df[ , !duplicated(colnames(df))]  ##Delete duplicated column names

df$activity <- as.factor(df$activity)   ## Renaming activity labels
levels(df$activity) <- activityLabels

columnNames <- grep("mean|std", names(df)) ## extracting all columns containing means or standard deviations.

  ## -- cooking the data frame for a nice output

df2 <- df %>% 
  select(subject, activity, columnNames) %>%                          ## extracting all variables containg means or standard deviations plus subject and activity
  gather(measurement, acceleration, -c(subject, activity)) %>%         ## All data except subect and activity gets molten into two columns: measurement and acceleration
  separate(col=measurement, into = c("type", "measure1"), sep = 1) %>%   ## Separate measures into time and frequency types
  separate(col=measure1, into = c("magnitude", "measure","axis"), extra = "merge", fill = "right" )%>% ##Separate measures into magnitude, measure (mean or std) and axis
  group_by(subject, activity,type, magnitude, measure, axis)  %>%                                     ## making activity and subjects groups out of data frame's data. 
  summarise(mean = mean(acceleration))                            ## finally this presents the mean of every measure for every activity and subject. 

df2


