rm(list=ls())

#install.packages('randomForest')

library(randomForest)
 
?randomForest()
?importance()
?tuneRF()
Titanic<-read.csv("Titanic_rows.csv")
str(Titanic)
set.seed(123)



index <- seq (1,nrow(Titanic),by=5)
test<-Titanic[index,]
training<-Titanic[-index,]

fit <- randomForest( Survived~., data=Titanic, importance=TRUE, ntree=2000)
importance(fit)
varImpPlot(fit)
Prediction <- predict(fit, test)
table(actual=test[,4],Prediction)

table(actual=test[,4],Prediction )
wrong<- (test[,4]!=Prediction )
error_rate<-sum(wrong)/length(wrong)
error_rate