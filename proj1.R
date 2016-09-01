#https://rstudio-pubs-static.s3.amazonaws.com/29426_041c5ccb9a6a4bedb204e33144bb0ad4.html

library(caret)
library(AppliedPredictiveModeling)

rm(list = ls())

training_csv <- "pml-training.csv";
#RawData <- read.csv(training_csv, colClasses = "character");
RawData <- read.csv(training_csv, na.strings=c("NA","#DIV/0!",""));
RawData$classe <- as.factor(RawData$classe);
RawData$user_name <- as.factor(RawData$user_name);
RawData$new_window <- as.factor(RawData$new_window);


set.seed(42);

trainIndex = createDataPartition(y=RawData$classe,p=0.75,list=FALSE);
training = RawData[trainIndex,];
validation = RawData[-trainIndex,];