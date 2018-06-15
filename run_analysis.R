run_analysis <- function() {
  ## This script executes all of the steps for the 
  ## JHU Getting and Cleaning Data class project
  
  ## Get the data.table and dplyr packages
  library(data.table)
  library(dplyr)
  
  ## start by reading in the six files plus the features files which has descriptive column names
  ## assumes the files are located in your working directory
  subtest <- read.table("subject_test.txt")
  xtest <- read.table("X_test.txt")
  ytest <- read.table("y_test.txt")
  subtrain <- read.table("subject_train.txt")
  xtrain <- read.table("X_train.txt")
  ytrain <- read.table("y_train.txt")
  feats <- read.table("features.txt")
  acts <- read.table("activity_labels.txt")
  ## rename the column headings for the subject and activity files since they overlap with the main data
  setnames(subtest,"V1","subject")
  setnames(ytest,"V1","activity")
  setnames(subtrain,"V1","subject")
  setnames(ytrain,"V1","activity")
  
  ## rename the column headings for the main data files using the labels in the features.txt file
  colnames(xtest2) <- feats2[,2]
  colnames(xtrain2) <- feats2[,2]
  
  ## modify column names that are missing the "X', "y" or "z", otherwise we have duplicate names
  ## I am sure this could have been cleaner, but here it is
  colnames(xtest2)[303:316] <- sapply(feats[303:316,2],paste,"-X")
  colnames(xtest2)[382:395] <- sapply(feats[382:395,2],paste,"-X")
  colnames(xtest2)[461:474] <- sapply(feats[461:474,2],paste,"-X")
  colnames(xtrain2)[303:316] <- sapply(feats[303:316,2],paste,"-X")
  colnames(xtrain2)[382:395] <- sapply(feats[382:395,2],paste,"-X")
  colnames(xtrain2)[461:474] <- sapply(feats[461:474,2],paste,"-X")
  colnames(xtest2)[317:330] <- sapply(feats[317:330,2],paste,"-Y")
  colnames(xtest2)[396:409] <- sapply(feats[396:409,2],paste,"-Y")
  colnames(xtest2)[475:488] <- sapply(feats[475:488,2],paste,"-Y")
  colnames(xtrain2)[317:330] <- sapply(feats[317:330,2],paste,"-Y")
  colnames(xtrain2)[396:409] <- sapply(feats[396:409,2],paste,"-Y")
  colnames(xtrain2)[475:488] <- sapply(feats[475:488,2],paste,"-Y")
  colnames(xtest2)[331:344] <- sapply(feats[331:344,2],paste,"-Z")
  colnames(xtest2)[410:423] <- sapply(feats[410:423,2],paste,"-Z")
  colnames(xtest2)[489:502] <- sapply(feats[331:344,2],paste,"-Z")
  colnames(xtrain2)[331:344] <- sapply(feats[331:344,2],paste,"-Z")
  colnames(xtrain2)[410:423] <- sapply(feats[410:423,2],paste,"-Z")
  colnames(xtrain2)[489:502] <- sapply(feats[331:344,2],paste,"-Z")
  #hopefully I learn how to do this easier :)
  
  ## now combine the files for each of test and train
  testdata <- cbind(subtest,ytest,xtest2)
  traindata <- cbind(subtrain,ytrain,xtrain2)
  data <- rbind(testdata,traindata)
  
  ## now reset the data items in the activity column
  ## with the descriptive labels instead of numbers
  ## from the activity labels file
  newvector = character(nrow(data))
  for (i in 1:nrow(data)) {newvector[i] <- as.character(acts$V2[data[i,2]])}
  data[,2] <- newvector
  
  
  ## This section keeps the first two columns plus all columns with mean() or std()
  retcols <- c("subject","activity",grep("mean()",names(data),value=TRUE),grep("std()",names(data),value=TRUE))
  data2 <- data [,retcols]

  ## Now we calculate the mean for each column by subject/activity grouping
  data3 <- data2 %>% group_by(subject,activity) %>% summarize_all(funs(mean))
  
  ## Write the table to a text file in the current directory
  write.table(data3,"CleaningDataProject.txt", row.name=FALSE)
  
  ## returns the data
  return(data3)
}