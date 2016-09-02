#https://rstudio-pubs-static.s3.amazonaws.com/29426_041c5ccb9a6a4bedb204e33144bb0ad4.html
#http://benakiva.github.io/practicalML/
#http://rstudio-pubs-static.s3.amazonaws.com/22340_99f11768d2ca4f209f747c9f587f1e6e.html
#
library(caret)
library(AppliedPredictiveModeling)

rm(list = ls())

training_csv <- "pml-training.csv";
#RawData <- read.csv(training_csv, colClasses = "character");
RawData <- read.csv(training_csv, na.strings=c("NA","#DIV/0!",""));
#First 7 columns identify the user and/or the time of the record, which is not relevant for our purpose
RawData <- RawData[,8:160];
RawData$classe <- as.factor(RawData$classe);

testing_csv <- "pml-testing.csv";
testData <- read.csv(testing_csv, na.strings=c("NA","#DIV/0!",""));
testData <- testData[,8:160];
#testData$classe <- as.factor(testData$classe);

# The test data has many columns for which all rows are NA. Since that doesn't
#   help us, we will remove those columns from both the test data and the
#   training set (since we won't be able to predict on them when testing).
# Create logical vector based on whether all of the rows for a given column
# are all NA's. one way to do this is to sum the value of is.na for it. If
# the sum is zero, that indicates that there are no NA's, and therefore we want
# to use that field
non_na_fields <- names(testData[,colSums(is.na(testData)) == 0]);
# training data's last column is classe, not problem_id
RawDataClean <- RawData[,c(replace(non_na_fields,"problem_id","classe")];
TestDataClean <- testData[,c(non_na_fields)];



set.seed(42);

trainIndex = createDataPartition(y=RawData$classe,p=0.75,list=FALSE);
training = RawData[trainIndex,];
validation = RawData[-trainIndex,];

print("24");
trainFit <- train(classe~ .,data=training,method="rf",prox=TRUE);
print("25");
predTrain <- predict(trainFit,validation);
print("27");
confusionMatrix(predTrain,validation$classe);
print("29");

names(testData)
