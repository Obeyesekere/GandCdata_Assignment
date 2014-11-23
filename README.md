==================================================================
Output dataset for Assignment - Getting and Cleaning Data
================================================================== 
Creator: Anthony Obeyesekere
Date: 23 Nov 2014
Location: New Zealand
==================================================================
Description: 
This newdata dataset is the result of data manipulation undertaken upon the following original dataset: Human Activity Recognition Using Smartphones Dataset. 

The original data can be found here: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip

A description of that original dataset can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data manipulations that were performed on the original dataset can be summarised as follows: 
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The code used to perform these manipulations is presented in run_analysis.R

To load the data in R, you can use the following command: read.table(file="newdata.txt", header=T, check.names=FALSE)

The dataset contains 180 rows and 68 columns. 
In each row, data is provided on student ID, an activity name, and corresponding averages for 66 measurements. 
For more information about the data content please refer to the Codebook. 
==================================================================
Explanation of run_analysis.R:

1. We load in the data from the test set (i.e. X_test, y_test, subject_test). We cbind these into one single dataframe and also ensure that the appropriate column headers have been designated. 
2. We load in the data from the train set (i.e. X_train, y_train, subject_train). We cbind these into one single dataframe and also ensure that the appropriate column headers have been designated. 
3. We use rbind to merge the two datafames generated from steps 1 and 2, above. 
4. We get the activity name strings from activity_labels.txt and substitute these into the dataset, where previously these were identified by integers.  
5. We used grep to remove all columns aside from student_ID, activity_name, and those which contain the strings mean() or std().
6. We create an empty dataframe to store our next set of calculations into, and we give it the appropriate column headings.
7. We use a nested for loop to calculate averages of different measurements, for each unique student_ID and activity_name combination. This works as follows:
	a) Choose the first student_ID
	b) Choose the first activity_name
	c) Get column means for this combination of student_ID and activity_name. Save these in a row in our newdata dataframe, together with details of the student_ID and activity_name. 
	d) Holding student_ID fixed, loop through the remaining activity_name elements, performing step c). 
	e) Move on to the next student_ID, and repeat steps b) through d). 

