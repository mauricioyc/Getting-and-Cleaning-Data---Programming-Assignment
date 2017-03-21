if(!file.exists("data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                destfile = "./data.zip")
}

if(!file.exists("UCI HAR Dataset")){
  unzip("data.zip")
}

## Read the activities and features labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c('activityID','activity')
feature_labels <- read.table("./UCI HAR Dataset/features.txt")

## Read the subjects, activities and features resultes for the test experiment
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
## Set a experiment to identify the test
test_set<- rep("test",nrow(subject_test))

## Gather the test data
test_data <- cbind(subject_test,y_test,test_set,x_test)
colnames(test_data) <- c("subjectID","activityID","experiment",as.character(feature_labels[,2]))


## Read the subjects, activities and features resultes for the train experiment
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
## Set a experiment to identify the train
train_set<- rep("train",nrow(subject_train))

## Gather the train data
train_data <- cbind(subject_train,y_train,train_set,x_train)
colnames(train_data) <- c("subjectID","activityID","experiment",as.character(feature_labels[,2]))

## Merge train and test data
merge_data <- rbind(test_data,train_data)

## cols with mean and std
cnames <- colnames(merge_data)
x<- c(grep("mean..", cnames),grep("std..", cnames))
mean_std_data <- merge_data[,c(1,2,3,x)]

## Define activity by name
mean_std_anames <- merge(mean_std_data,activity_labels,by = "activityID", all.x = TRUE )

## Create a independent data file with the mean of each feature grouped by subject and activity
by_subj_act<- group_by(mean_std_anames,subjectID,activity,experiment)
group_data<-summarise_each(by_subj_act,funs(mean),4:83)
write.table(group_data, "group_data.txt")
