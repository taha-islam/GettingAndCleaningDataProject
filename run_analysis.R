setwd("F:/Coursera/Johns Hopkins Data Science Specialization//3. Getting and Cleaning Data/Project//UCI HAR Dataset")
testData <- read.table("./test//X_test.txt")
trainData <- read.table("./train//X_train.txt")
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")
subject_test <- read.table("./test//subject_test.txt")
subject_train <- read.table("./train//subject_train.txt")
y_test <- read.table("./test//y_test.txt")
y_train <- read.table("./train//y_train.txt")
y_test2 <- factor(y_test[,1], levels=activity_labels[,1], labels=activity_labels[,2])
y_train2 <- factor(y_train[,1], levels=activity_labels[,1], labels=activity_labels[,2])

names(testData) <- features[,2]
names(trainData) <- features[,2]
testData$activity_label <- y_test2
trainData$activity_label <- y_train2
testData$subject <- subject_test[,1]
trainData$subject <- subject_train[,1]
#mergedData <- merge(testData,trainData,all=TRUE)
mergedData <- rbind(testData,trainData)
index <- vector("logical", length=length(mergedData))
a<-as.character(features[,2])
index[substr(a,nchar(a)-7,nchar(a)-2)=="mean()"] <- TRUE
index[substr(a,nchar(a)-6,nchar(a)-2)=="std()"] <- TRUE

mergedData2 <- mergedData[,index,drop=FALSE]

mergedData3 <- aggregate(mergedData2[,1:(length(mergedData2)-2)]
                         ,list(subject=mergedData2$subject,activity=mergedData2$activity_label)
                         , mean)
