#rm(list = ls())

library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

train_noy <- subset(vowel.train,select=-c(y));
test_noy <- subset(vowel.test,select=-c(y));

set.seed(33833)

library(caret)
if (!exists("rfFit")) {
  print("generating rfFit");
  start.time <- Sys.time()
#  rfFit <- train(y~ .,data=vowel.train,method="rf",prox=TRUE)
  rfFit <- train(y~ .,data=vowel.train,method="rf",prox=TRUE, trControl=trainControl(method="cv"), number=3)
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
# ????????

#predRF <-predict(rfFit,newdata=vowel.test);
#table(predRF,vowel.test$y)

#sqrt(sum((rfFit$finalModel$y-vowel.train$y)^2))
predRF <- predict(rfFit,vowel.test);
predGBM <- predict(gbmFit,vowel.test);
#qplot(predRF,predGBM,color=y,data=vowel.test);

#RMSE_RF <- sqrt(sum((as.numeric(predRF)-as.numeric(vowel.test$y))^2));
#RMSE_GBM <- sqrt(sum((as.numeric(predGBM)-as.numeric(vowel.test$y))^2));
#predCombDF <- data.frame(predRF,predGBM,y=vowel.test$y);

RMSE_RF <- sqrt(sum((as.numeric(predRF)-as.numeric(vowel.test$y))^2));
RMSE_GBM <- sqrt(sum((as.numeric(predGBM)-as.numeric(vowel.test$y))^2));
predCombDF <- data.frame(predRF,predGBM,y=vowel.test$y);

combModFit <- train(y~.,method="gam",data=predCombDF);
combPred <- predict(combModFit,predCombDF);
RMSE_Combo <- sqrt(sum((as.numeric(combPred)-as.numeric(vowel.test$y))^2));

acc_RF <- confusionMatrix(predRF,vowel.test$y)$overall[1];
acc_GBM <- confusionMatrix(predGBM,vowel.test$y)$overall[1];
acc_Combo <- confusionMatrix(combPred,vowel.test$y)$overall[1];

equalPredictions = (predGBM ==predRF)


