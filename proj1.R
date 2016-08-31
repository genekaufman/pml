library(caret)
library(AppliedPredictiveModeling)

rm(list = ls())

training_csv <- "pml-training.csv";
RawData <- read.csv(training_csv, colClasses = "character");
RawData$classe <- as.factor(RawData$classe);

data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)
trainIndex1 = createDataPartition(adData,p=0.75,list=FALSE);
#RawDataDF = data.frame(RawData);
trainIndex = createDataPartition(y=RawData$classe,p=0.75,list=FALSE);
#training = RawData[trainIndex,];
#validation = RawData[-trainIndex,];