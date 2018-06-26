setwd("C:\\Users\\jlgon\\Documents\\João Luis\\Cursos\\Coursera - Getting and Cleaning Data\\Project Assignment\\getdata%2Fprojectfiles%2FUCI HAR Dataset\\UCI HAR Dataset")
library("dplyr")

# read train and test files

dfXTrain <- read.table("train\\X_train.txt", header=FALSE, strip.white=TRUE)
dfXTest  <- read.table("test\\X_test.txt"  , header=FALSE, strip.white=TRUE)

dfYTrain <- read.table("train\\y_train.txt")
dfYTest  <- read.table("test\\y_test.txt")

dfSubjectTrain <- read.table("train\\subject_train.txt")
dfSubjectTest  <- read.table("test\\subject_test.txt")

#####################
# Step 1. merge data
#####################

dfMergedData <- rbind(cbind(dfSubjectTrain, dfYTrain, dfXTrain), cbind(dfSubjectTest,  dfYTest,  dfXTest))

#####################
# Step 4. rename variables
#####################

# read features table that contains the names of each variable
dfFeaturesNames <- read.table("features.txt", stringsAsFactors=FALSE)
dfNames <- rbind(c(0, "subject"), c(0, "activity"), dfFeaturesNames)  # add rows for <subject> and <activity>

# use more descriptive variable names
dfNames$V2 <- sub("^t(.*)", "time\\1", dfNames$V2) # change from "t" to "time"
dfNames$V2 <- sub("^f(.*)", "freq\\1", dfNames$V2) # change from "f" to "freq"

# rename columns from merged data frame
names(dfMergedData) <- dfNames$V2

# solve duplicate column name problem
names(dfMergedData) <- make.names(names=names(dfMergedData), unique=TRUE, allow_ = TRUE) 

#####################
# 2. select only mean and standard deviation columns
#####################

# select columns <subject>, <acitivity> and columns that contain the words "mean" or "std"
dfMeanStd <- select(dfMergedData, "subject", "activity", contains("mean"), contains("std"))

#####################
# 3. name activities
#####################
dfActivityLabels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)    # read activities labels
names(dfActivityLabels) <- c("activityId", "activityDesc")                       # rename columns

# join activities labels with the data frame produced in step 2
dfMeanStdActivities <- merge(dfActivityLabels, dfMeanStd, by.x="activityId", by.y="activity", all=TRUE) 

# remove the <activityId> column in order to get a tidy dataframe
dfMeanStdActivities$activityId <- NULL

#####################
# 5. create average data set
#####################

dfAverages <- dfMeanStdActivities %>% group_by(subject, activityDesc) %>% summarise_all(funs(mean))

# save the final dataframe
write.table(dfAverages, "step5.txt", row.name=FALSE) 
