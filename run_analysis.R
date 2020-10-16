library(data.table)
library(reshape2)

# Get the data for the project from the provided link

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filePath <- getwd()
fileName <- "projectData.zip"
download.file(url, file.path(filePath, fileName))
unzipedFile <- unzip(zipfile = fileName)


# Get the path for the files with the test/train data and feature/activity information

startOfPathToRemove <- "^\\./"

activitiesFilePath <- file.path(filePath,
                                gsub(startOfPathToRemove, "", unzipedFile[grep("activity_labels.txt$", unzipedFile)]))

featureInfoFilePath <- file.path(filePath, 
                                 gsub(startOfPathToRemove, "", unzipedFile[grep("features.txt$", unzipedFile)]))

testFilesPaths <- file.path(filePath,
                            gsub(startOfPathToRemove, "", unzipedFile[grep("/test/[^/]*test.txt$", unzipedFile)]))

trainFilesPaths <- file.path(filePath,
                             gsub(startOfPathToRemove, "", unzipedFile[grep("/train/[^/]*train.txt$", unzipedFile)]))

# Get the test and training data from the files

testDataList <- lapply(testFilesPaths, fread)
trainDataList <- lapply(trainFilesPaths, fread)

# STEP 1: Merge the training and test sets

data <- mapply (rbind, testDataList, trainDataList)
names(data) <- c("subjects", "set", "activity")

# STEP 2: Extract only the measurements on the mean and standard deviation for each measurement

features <- fread(featureInfoFilePath, col.names = c("index", "featureNames"))
featuresFilter <- grep("(mean|std)\\(\\)", features[,featureNames])

dataSet <- data$set[, featuresFilter, with = FALSE]

# STEP 3: Use descriptive activity names to name the activities in the data set
# STEP 4: Appropriately label the data set with descriptive variable names

activities <- fread(activitiesFilePath, col.names = c("label", "activityNames"))
dataSet <- cbind(data$subjects, data$activity, dataSet)

subjectActivityLabels <- c("SubjectID", "Activity")

variableNames <- gsub("[()]", "", features[featuresFilter, featureNames])
variableNames <- append(variableNames, subjectActivityLabels, 0)
names(dataSet) <- variableNames

dataSet$Activity <- factor(dataSet$Activity, levels = activities$label, labels = activities$activityNames)
dataSet$SubjectID <- as.factor(dataSet$SubjectID)

# STEP 5: Create an independent tidy data set with the average of each variable for each activity and each subject

tidyDataSet <- reshape2::melt(data = dataSet, id = subjectActivityLabels)
tidyDataSet <- reshape2::dcast(data = tidyDataSet, SubjectID + Activity ~ variable, fun.aggregate = mean)

# Write tidy data set to output file

write.table(tidyDataSet, file = "tidyDataSet.txt", row.names = FALSE)
