# Correct: Cement
# Wrong:FineAggregate
# wrong????: CoarseAggregate ??????
# https://rpubs.com/cheyu/pmlQ4
set.seed(3523)
library(AppliedPredictiveModeling)

data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(233)

mod_lasso <- train(CompressiveStrength ~ ., data = training, method = "lasso")
library(elasticnet)
plot.enet(mod_lasso$finalModel, xvar = "penalty", use.color = TRUE)