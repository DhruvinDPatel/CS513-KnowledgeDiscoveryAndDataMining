# Name : Dhruvin Patel
# CWID : 10420356
# Batch: B

#1
data(iris)
length(iris)
nrow(iris)
View(iris)

#2
every_fifth_id <- seq(from=1,to=nrow(iris),by=5)
every_fifth_id

# storing every fifth record in test dataset
test_dataset <- iris[every_fifth_id,]
training_dataset <- iris[-every_fifth_id,]
View(test_dataset)
View(training_dataset)

#3 without normalization
library(class)

knn_output <- knn(training_dataset[,-5],test_dataset[,-5],training_dataset[,5],k=1)
knn_output
#4
table(knn_output,test_dataset[,5])
#5
output_for_k2 <- knn(training_dataset[,-5],test_dataset[,-5],training_dataset[,5],k=2)
table(output_for_k2,test_dataset[,5])

output_for_k5 <- knn(training_dataset[,-5],test_dataset[,-5],training_dataset[,5],k=5)
table(output_for_k5,test_dataset[,5])

output_for_k10 <- knn(training_dataset[,-5],test_dataset[,-5],training_dataset[,5],k=10)
table(output_for_k10,test_dataset[,5])

# with normalization
mmnorm <- function(x,minx,maxx){
  z <- ((x-minx)/(maxx-minx))
  return(z)
}

norm_iris <- data.frame(Sepal.Length=mmnorm(iris[,1],min(iris[,1]),max(iris[,1])), Sepal.Width=mmnorm(iris[,2],min(iris[,2]),max(iris[,2])), Petal.Length=mmnorm(iris[,3],min(iris[,3]),max(iris[,3])), Petal.Width=mmnorm(iris[,4],min(iris[,4]),max(iris[,4])), iris[,5])
View(norm_iris)

fifth <- seq(from=1,to=nrow(norm_iris),by=5)

norm_test <- norm_iris[fifth,]
norm_training <- norm_iris[-fifth,]
View(norm_test)
View(norm_training)

norm_output <- knn(norm_training[,-5],norm_test[,-5],norm_training[,5],k=1)
table(norm_output,norm_test[,5])
