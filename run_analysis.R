rm(list=ls())

## reading taining data from dataset
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")

## reading test data from dataset
X_test<-read.table("./UCI HAR Dataset//test/X_test.txt")
Y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")

## 1. Merges the training and the test sets to create one data set

X<-rbind(X_train,X_test)
Y<-rbind(Y_train,Y_test)
## 2. Extracts only the measurements on the mean and standard deviation for each
## measurement.

features<-read.table("./UCI HAR Dataset//features.txt")
f<-which(grepl("mean\\(\\)|std\\(\\)",features$V2))

X<-X[f]

## 3. Uses descriptive activity names to name the activities in the data set
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
Y<-activity_labels$V2[Y$V1]


## 4. Appropriately labels the data set with descriptive variable names.
colnames(X)<-features$V2[f]


## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
Subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
Subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
Subject<-c(Subject_train$V1,Subject_test$V1)

df<-cbind(X,Y,Subject)
tidy<-aggregate(x = df, by = list(Y, Subject), FUN = "mean")
tidy<-tidy[,1:68]
colnames(tidy)[c(1,2)]<-c("activity","subject")

## Writing data to text file.
write.table(x=tidy,file="tidy_dataset.txt",row.names=FALSE)

