### RF Accuracy = 0.6082
### GBM Accuracy = 0.5152
### Agreement Accuracy = 0.6361

#rm(list = ls())

library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

set.seed(33833)

library(caret)
if (!exists("rfFit")) {
  print("generating rfFit");
  start.time <- Sys.time()
  rfFit <- train(y~ .,data=vowel.train,method="rf",prox=TRUE)
#  rfFit <- train(y~ .,data=vowel.train,method="rf",prox=TRUE, trControl=trainControl(method="cv"), number=3)
  end.time <- Sys.time()
  time.taken <- paste( as.numeric(round(end.time - start.time,3)*1000), "milliseconds");
  print(time.taken);

}
if (!exists("gbmFit")) {
  print("generating gbmFit");
  start.time <- Sys.time()
  gbmFit <- train(y~ .,data=vowel.train,method="gbm",verbose=FALSE)
  end.time <- Sys.time()
  time.taken <- paste( as.numeric(round(end.time - start.time,3)*1000), "milliseconds");
  print(time.taken);

}

predRF <- predict(rfFit,vowel.test);
predGBM <- predict(gbmFit,vowel.test);

acc_RF <- confusionMatrix(predRF,vowel.test$y)$overall[1];
acc_GBM <- confusionMatrix(predGBM,vowel.test$y)$overall[1];
acc_Combo <- confusionMatrix(predRF,predGBM)$overall[1];



