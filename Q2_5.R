rm(list = ls())

library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

names(training)
grep("^IL",names(training))
trainingIL<-training[,grep("^IL",names(training))];
trainingIL2<- subset(training, select=c(training$diagnosis,grep("^IL",names(training))));
preProcObj<-preProcess(trainingIL)
