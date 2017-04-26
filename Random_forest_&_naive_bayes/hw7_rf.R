
library(randomForest)
setwd('~/graduate_work/CS513/')
cdata_frame <- read.csv('HW7/cancer.csv')
set.seed(123)

cdata_frame$F1 <- factor(cdata_frame$F1)
cdata_frame$F2 <- factor(cdata_frame$F2)
cdata_frame$F3 <- factor(cdata_frame$F3)
cdata_frame$F4 <- factor(cdata_frame$F4)
cdata_frame$F5 <- factor(cdata_frame$F5)
cdata_frame$F7 <- factor(cdata_frame$F6)
cdata_frame$F8 <- factor(cdata_frame$F8)
cdata_frame$F9 <- factor(cdata_frame$F9)
cdata_frame$Sample <- factor(cdata_frame$Sample)
cdata_frame$diagnosis <- factor(cdata_frame$diagnosis)

every_5th <- seq (1,nrow(cdata_frame),by=5)
test_cancer<-cdata_frame[every_5th,]
training_cancer<-cdata_frame[-every_5th,]
str(cdata_frame)

?importance()

out <- randomForest(diagnosis~., data=cdata_frame[, 2:11], importance=TRUE, ntree=1000)
importance(out)
varImpPlot(out)
Prediction <- predict(out, test_cancer[, 2:10])
table(Prediction, test_cancer$diagnosis)

# most important: F2, F6, F7
# output table:
# Prediction  2  4
# 2 94  0
# 4  0 46
