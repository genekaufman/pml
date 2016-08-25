rm(list = ls())

library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
set.seed(125)

#adData = data.frame(segmentationOriginal,Case)
adData = data.frame(segmentationOriginal)
inTrain = createDataPartition(segmentationOriginal$Case, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

modFit <- train(Class ~ .,method="rpart",data=training);

print(modFit$finalModel)
plot(modFit$finalModel, uniform=TRUE,
main="Classification Tree")
text(modFit$finalModel, use.n=TRUE, all=TRUE, cex=.8)
