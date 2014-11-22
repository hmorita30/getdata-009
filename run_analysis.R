setwd("C:/Users/hm2487/Desktop/Haruka/R practice/Getting and Cleaning data")

install.packages("dplyr")
library(dplyr)

xtest <- read.table("./test/X_test.txt")
ytest <- read.table("./test/y_test.txt")
xtrain <- read.table("./train/X_train.txt")
ytrain <- read.table("./train/y_train.txt")
subtrain <- read.table("./train/subject_train.txt")
subtest <- read.table("./test/subject_test.txt")
features <- read.table("features.txt")
activity <- read.table("activity_labels.txt")
features2 <- make.names(features$V2, unique = T)

colnames(xtest) <- features2
colnames(xtrain) <- features2
colnames(ytest) <- "activity"
colnames(ytrain) <- "activity"
colnames(subtrain) <- "subject"
colnames(subtest) <- "subject"

xtrain2 <- cbind(subtrain, ytrain, xtrain)
xtest2 <- cbind(subtest, ytest, xtest)

merged <- rbind(xtrain2, xtest2)

merged$activity <- factor(merged$activity, labels = c("walking", 
                                              "walking_upstairs", 
                                              "walking_downstairs", 
                                              "sitting", 
                                              "standing", 
                                              "laying"))

MeanStd <- select(merged, contains("subject"), contains("activity"), contains("mean"), contains("std"))

columnNames <- names(MeanStd)

getMean <- function(data) {
  activityList <- c("walking", 
                     "walking_upstairs", 
                     "walking_downstairs", 
                     "sitting", 
                     "standing", 
                     "laying")
  summary <- data.frame()
  columnNames <- names(MeanStd)
  for(i in 1:30) {
    sub <- subset(MeanStd, subject == i)
    for (j in activityList) {
      sub2 <- subset(sub, activity == j)
      means <- colMeans(sub2[3:88])
      means2 <- data.frame(t(means))
      result <- as.data.frame(cbind(subject = i, activity = j, means2))
      summary <- as.data.frame(rbind(summary, result))
      }
  }
  print(summary)
}

means <- getMean(MeanStd)
write.table(means, file = "tidyData.txt", row.names = F)