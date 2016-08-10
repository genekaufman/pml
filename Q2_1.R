library(caret)
library(AppliedPredictiveModeling)

rm(list = ls())

data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis,p=0.5,list=FALSE)
training = adData[trainIndex,]
testing = adData[trainIndex,]