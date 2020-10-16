### Getting and cleaning data project

The data used in this project was obtained from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

It represents data collected a Samsung Galaxy S smartphone in a set of experiments described below:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## Data Introduction:

In this project, the data used was:
- The training data set composed by the subject that did each activity, the activities' labels and the sensor data:
    - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
    - 'train/y_train.txt': Training labels.
    - 'train/X_train.txt': Training set.
    
- The test data set composed by the subject that did each activity, the activities' labels and the sensor data:
    - 'test/subject_test.text': : Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
    - 'test/y_train.txt': Test labels.
    - 'test/X_train.txt': Test set.
    
- The activity labels and names:
    - 'activity_labels.txt': Links the class labels with their activity name.
    
- Information about the captured sensor data:
    - 'features_info.txt': Shows information about the variables used on the feature vector.
    
## Data Transformations:

All the processment done on top of the collected that is done within the script: `run_analysis.R`.

This script downloads the data from the source url and creates data tables that follow a structure similar to the one described in the `Data Introduction` section.
After that, the script goes through 5 major steps in order to reach the desired final result:

1. Merge the training and test data sets to create single data set.
In this step, the data from `x_data.txt`, `y_data.txt`, `subject_data.txt` for the training and test data sets are binded by row.

2. Extract only the measurements on the mean and standard deviation for each measurement. 
A new data set is created that reduces the columns of the original data set to the measurements of the mean and standard deviation

3. Use descriptive activity names to name the activities in the data set.
Attributes the label of the activity to each element of the activity column - effectively replacing its index with the name of the activity

4. Appropriately label the data set with descriptive variable names. 
In this step, the name of the columns of the data set are set to more clearly provide information about what each column contains.
The name of the measurement columns is cleaned up and the subject and activities columns are appropriately labeled as `SubjectID` and `Activity`

Note: in order to facilitate the manipulation of the various columns/elements, the step 3 and 4 is mixed together in the `run_analysis.R` script

5. From the data set in step 4, an independent tidy data set with the average of each variable for each activity and each subject is created.
A tidy data set is created from the ouput of step 4 where for each subject the mean of each variable is associated to each type of activity.
This tidy data set is written out to "tidyDataSet.txt"

## Tidy Data description:

The first two columns of the final tidy data set are `SubjectID`and `Activity` that represent the subject that did the experiments and each of the activities performed.
The remaining 66 columns represent the average of the selected features - mean and standard deviation of each measurement. 
