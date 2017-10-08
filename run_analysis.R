
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile="dataset.zip",
              method="curl")
unzip("dataset.zip")

activitylabels<-read.table("UCI HAR Dataset/activity_labels.txt")
features<-read.table("UCI HAR Dataset/features.txt")
strain<-read.table("UCI HAR Dataset/train/subject_train.txt")
stest<-read.table("UCI HAR Dataset/test/subject_test.txt")
xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")
xtest<-read.table("UCI HAR Dataset/test/X_test.txt")
ytrain<-read.table("UCI HAR Dataset/train/y_train.txt")
ytest<-read.table("UCI HAR Dataset/test/y_test.txt")
alls<-rbind(stest, strain)
xall<-rbind(xtest, xtrain)
yall<-rbind(ytest, ytrain)
names(xall)<-features$V2
names(alls)<-c("subject")
names(yall)<-c("activity")
alldata<-cbind(alls, yall, xall)
alldata$activity <- factor(alldata$activity,activitylabels[[1]],activitylabels[[2]])
meansd<-grepl("subject|activity|mean|std", names(alldata))
data<-alldata[meansd]
write.table(data, file="mean_std.txt")
finaldata<-aggregate(alldata, by=list(alldata$subject, alldata$activity), FUN=mean)
write.table(finaldata, file="independent_data_set.txt", row.names=FALSE)
