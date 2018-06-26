# coursera_PA_getData
Coursera - Getting and Cleaning Data - Program Assignment

The script run_analysis.R runs as follows:

0. Preliminary setup
Setup working directory and read files

1. Step 1 - merge data
Uses cbind and rbind to merge the 6 files into a single one: dfMergedData

2. Step 4 - rename variables
I preferred to go to directly to step 4, rename variables in the working dataframe
The first two column names are chosen to be "subject" and "activity", the other colum names are read from features.txt
I renamed columns starting with t to start with time
I renamed columns starting with f to start with freq

3. Step 2 - select only mean and standard deviation columns
Created a dataframe dfMeanStd with columns "subject", "activity" and columns that contain the words "mean" or "std"

4. Step 3 - name activities
Substitute the activity number by its description, read from activity_labels.txt
Stored the result in the dataframe dfMeanStdActivities

5. Step 5 - create the average data set
Create the tidy dataframe with "subject", "activity" and the means of other columns

6. Write the results to the file step5.txt

