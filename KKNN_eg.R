# iris dataset - very popular
data(iris)
View(iris)

mmnorm <- function(x,minx,maxx){
  z <- ((x-minx)/(maxx-minx))
  return(z)
}

mmnorm(5,0,10)
x<-0:10
mmnorm(x,min(x),max(x))

# packages
installed.packages()
#install.packages("NAME OF THE PACKAGE")
#install.packages("ggplot2")
library(ggplot2)

library(class)
?knn()

?sample()
range_1_100 <- 1:100
saml80 <- sample(range_1_100,80)

# creating 70% of the total iris rows random sample

idx <- sample(nrow(iris),as.integer(.70*nrow(iris)))
idx

# for knn divide dataset into training and test data(usually 20-30% of total data: data that is not considered in knn function)

training <- iris[idx,]
test <- iris[-idx,]
View(training)
View(test)

# take last one column as validation of knn result
# this is supervised prediction knn algo
training2 <- training[,-5]
test2 <- test[,-5]
# training2
# test2
outcome <- training[,5]
# outcome

predict <- knn(training[,-5],test[,-5],training[,5],k=4)
predict
table(predict,test[,5])
