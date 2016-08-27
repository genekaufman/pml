
# Stacked Accuracy: 0.80 is better than random forests and lda and the same as boosting.
library(caret)
library(gbm)

set.seed(3433)

library(AppliedPredictiveModeling)

data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,];

set.seed(62433)

if (!exists("rfFit")) {
  print("generating rfFit");
  start.time <- Sys.time()
  rfFit <- train(diagnosis~ .,data=training,method="rf",prox=TRUE)
  #  rfFit <- train(y~ .,data=vowel.train,method="rf",prox=TRUE, trControl=trainControl(method="cv"), number=3)
  end.time <- Sys.time()
  time.taken <- paste( as.numeric(round(end.time - start.time,3)*1000), "milliseconds");
  print(time.taken);

}
if (!exists("gbmFit")) {
  print("generating gbmFit");
  start.time <- Sys.time()
  gbmFit <- train(diagnosis~ .,data=training,method="gbm",verbose=FALSE)
  #  rfFit <- train(y~ .,data=vowel.train,method="rf",prox=TRUE, trControl=trainControl(method="cv"), number=3)
  end.time <- Sys.time()
  time.taken <- paste( as.numeric(round(end.time - start.time,3)*1000), "milliseconds");
  print(time.taken);

}
if (!exists("ldaFit")) {
  print("generating ldaFit");
  start.time <- Sys.time()
  ldaFit <- train(diagnosis~ .,data=training,method="lda")
  #  rfFit <- train(y~ .,data=vowel.train,method="rf",prox=TRUE, trControl=trainControl(method="cv"), number=3)
  end.time <- Sys.time()
  time.taken <- paste( as.numeric(round(end.time - start.time,3)*1000), "milliseconds");
  print(time.taken);

}
predRF <- predict(rfFit,testing);
predGBM <- predict(gbmFit,testing);
predLDA <- predict(ldaFit,testing);

acc_RF <- confusionMatrix(predRF,testing$diagnosis)$overall[1];
acc_GBM <- confusionMatrix(predGBM,testing$diagnosis)$overall[1];
acc_LDA <- confusionMatrix(predLDA,testing$diagnosis)$overall[1];

predDF <- data.frame(predRF,predGBM,predLDA, diagnosis=testing$diagnosis)
combModFit <- train(diagnosis ~.,method="gam",data=predDF)
combPred <- predict(combModFit,predDF)

acc_Combo <- confusionMatrix(combPred,testing$diagnosis)$overall[1];
