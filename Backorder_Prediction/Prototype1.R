rm(list= ls())
#Data Reading
data <- read.csv("datasets/Kaggle_Training_Dataset.csv", header = TRUE)

#Data CRIPS-DM Data Understanding Phase:
data1<- data

#data1<- options("scipen"=100, "digits"= 4)
data2<-data1
#View(data2)
#data2$lead_time <- sub("^$","NA",data2$lead_time)
View(data2)
sum(is.na(data2$lead_time)) #101334 total NA values #We removed it because it is tergeting almost Majority entity.
summary(data2$national_inv)
#Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
#-33400        4       15      494       81 12300000 
summary(data2$lead_time)# Have to Handle NA Values..
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#    0       4       8       8       9      52     101334 
summary(data2$in_transit_qty)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0       0       0      40       0  489000 
summary(data2$forecast_3_month)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0       0       0     182       4    1510000
summary(data2$forecast_6_month)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0       0       0       343      12   2220000
summary(data2$forecast_9_month)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0       0       0     502      20 3230000 
summary(data2$sales_1_month)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0       0       0      54       4  742000 
summary(data2$sales_3_month)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0       0       1     174      14 1190000 
summary(data2$sales_6_month)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0       0       2     341      31 2130000 
summary(data2$sales_9_month)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0       0       4     512      47 3210000
summary(data2$min_bank)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0       0       0      52       3  366000 
summary(data2$potential_issue)
#  No     Yes 
#1692237     813
summary(data2$pieces_past_due)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0       0       0       2       0  162000 
summary(data2$perf_6_month_avg)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#-99.00    0.61    0.82   -6.89    0.96    1.00
summary((data2$perf_12_month_avg))
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#-99.00    0.66    0.81   -6.44    0.95    1.00
summary((data2$local_bo_qty))
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0       0       0       1       0   15000 
summary(data2$deck_risk)
#  No     Yes 
#1347759  345291
summary(data2$oe_constraint)
#No     Yes 
#1692744     306 
summary(data2$ppap_risk)
#  No     Yes 
#1491577  201473 
summary(data2$stop_auto_buy)
#No     Yes 
#65713 1627337 
summary((data2$rev_stop))
#No     Yes 
#1692340     710 
summary(data2$went_on_backorder)
#  No     Yes 
#1682136   10914 


#check how many lead_time NA whose corresponding went_on_backorder is NO
new_data <- subset(data2, is.na(data2$lead_time))
View(new_data)
dt <- new_data 
dt$sku <- NULL
dt$national_inv <-NULL
dt$in_transit_qty<-NULL
dt$forecast_3_month<-NULL
dt$forecast_6_month<- NULL
dt$forecast_9_month <- NULL
dt$sales_1_month<-NULL
dt$sales_3_month <-NULL
dt$sales_3_month<-NULL
dt$sales_6_month<-NULL
dt$sales_9_month<-NULL
dt$stop_auto_buy<-NULL
dt$min_bank<-NULL
dt$potential_issue<-NULL
dt$pieces_past_due<-NULL
dt$perf_6_month_avg<-NULL
dt$perf_12_month_avg<-NULL
dt$local_bo_qty<-NULL
dt$deck_risk<-NULL
dt$oe_constraint<-NULL
dt$ppap_risk<-NULL
dt$rev_stop<-NULL
View(dt)

# We removed NA Values as all the major NA values are targeting the Majority Entity.
sum(dt$went_on_backorder == "Yes")#[1] 341
sum(dt$went_on_backorder == "No")#[1] 100993 we can remove these records as we have almost 1682136 records respecting to 0.

d <- data2
#as.data.frame(d)
d <- subset(data2, !is.na(data2$lead_time))
summary(d$went_on_backorder)
#No     Yes 
#1581143   10573 

new<- d
library("ggplot2")
qplot(data2$in_transit_qty,xlim = c(0,1500),ylim = c(0,1000))
options("scipen"=1000,"digits"= 4)
boxplot(data2$in_transit_qty,xlim=c(0,50000),ylim=c(50000,200000)) # We have only four items which have quantities more than 20,000 which are basically outliers and impacting not a much on to the other data so We decided to remove it too.

#remove outliers... already removed as the lead_time values are not specified ... 
new <- subset(new, !new$stop_auto_buy=="No") #all the values considering NO is dominating the only majority entity that's why we deleted it.
new$rev_stop <- NULL
View(new)

#Data Preparing....
#experimenting KNN...First try..
n1<- new
n1$sku<-NULL

#Convert into Binary Values... # Yes=1 No =0
n1$potential_issue <- as.integer(n1$potential_issue)
n1$potential_issue[n1$potential_issue == "2"] <- 0

n1$deck_risk<- as.integer(n1$deck_risk)
n1$deck_risk[n1$deck_risk == "2"] <- 0 # Yes=1 No =0

n1$oe_constraint<-as.integer(n1$oe_constraint)
n1$oe_constraint[n1$oe_constraint == "2"] <- 0

n1$ppap_risk <- as.integer(n1$ppap_risk)
n1$ppap_risk[n1$ppap_risk == "2"]<-0

n1$stop_auto_buy<-NULL

n1$went_on_backorder <-as.integer(n1$went_on_backorder)
n1$went_on_backorder[n1$went_on_backorder == "2"]<- 0

View(n1)
write.csv(n1,file = "datasets/Production_Backtracking_Prediction.csv")

#Data Spliting 70% training 30% Testing...
library(class)
mmnorm <- function(x){return((x -min(x, na.rm = TRUE))/(max(x,na.rm = TRUE)-min(x,na.rm = TRUE)))}
norm <- data.frame(apply(n1,2,mmnorm))
View(norm)
set.seed(1)
idx<-sample(nrow(norm),as.integer(.70*nrow(norm)))
test<-norm[-idx,]
training_ds<-norm[idx,]

#KNN
predict_knn_k03<-knn(training_ds[,-20],test[,-20],training_ds[,20],k=150)

#Undersampling using Random Forest
table(training_ds$went_on_backorder) 
#0       1 
#7152 1076483

#table(test$went_on_backorder)
#0      1 
#3070 461346 
#install.packages("caret")
library(caret)
?twoClassSim()
set.seed(1)
training_ds_2 <- twoClassSim(1083635,intercept = -13)
test_2<-twoClassSim(464416,intercept = -13)
table(training_ds_2$Class)
#Class1 Class2 
#930012 153623 

nmin<-sum(training_ds_2$Class=="Class2")
nmin # 153623

help("trainControl")
ctrl<-trainControl(method="cv",classProbs = TRUE,summaryFunction = twoClassSummary)
set.seed(2)
library(randomForest)
require(randomForest)
?rep()
?train()
rfDownsampled <- train(Class ~ .,data=training_ds_2,method="rf",ntree=1500,tunelength=5,metric="ROC",trControl=ctrl, strata = training_ds_2$Class, sampsize = rep(nmin,2))

View(n1)

n1$went_on_backorder <- factor(n1$went_on_backorder)
every_50th <- seq(1,nrow(n1),by=10)
test_rf <- n1[every_50th,]
training_rf <- n1[-every_50th,]

out <- randomForest(n1$went_on_backorder~., data=n1[,1:20], importance=TRUE, ntree=20)
importance(out)
varImpPlot(out)
Prediction <- predict(out, test_rf[, 1:19])
table(Prediction, test_rf$went_on_backorder)
accuracy_rf<-(802+153828)/(802+1+175+153828)
accuracy_rf

#Prediction      0      1
#0    802      1
#1    175 153828
#plot - 1st-perf_6_month_avg 2nd- national_inv

###################################
#Naive Bayes

library('e1071')
out2 <- naiveBayes(n1$went_on_backorder~., data=n1[,1:20])
category <- predict(out2,n1[,1:19])
table(category,n1$went_on_backorder)
#category       0       1
#0    9939 1421132
#1     283  116697
accuracy_nb<-(9939+116697)/(9939+283+116697+1421132)
accuracy_nb


###################################

# Tell rf to sample by strata. Here, that means within each class
#set.seed(1)
#rfUnbalanced<-train(Class ~ .,data=training_ds,method="rf",ntree=1500,tunelength=5,metric="ROC",trControl=ctrl)
##############################################################################################################################
#       SMOTE
##########################################################################################################################
install.packages("mlr")
install.packages("DMwR")
install.packages("unbalanced")
install.packages("pROC")
install.packages("class")
rm(list = ls())
library(unbalanced)
library(class)
library(DMwR)
library(pROC)
library(caret)
# remove all objects
rm(list=ls())
data2<- read.csv("datasets/Production_Backtracking_Prediction.csv")
data2$X<- NULL
data2$stop_auto_buy<-NULL
View(data2)
train <- data2
#View(train)
dput(colnames(train))

colnames(train) <- c("national_inv", "lead_time", "in_transit_qty", "forecast_3_month", 
                     "forecast_6_month", "forecast_9_month", "sales_1_month", "sales_3_month", 
                     "sales_6_month", "sales_9_month", "min_bank", "potential_issue", 
                     "pieces_past_due", "perf_6_month_avg", "perf_12_month_avg", "local_bo_qty", 
                     "deck_risk", "oe_constraint", "ppap_risk", "went_on_backorder")
head(train,2)
table(train$went_on_backorder)
#0       1 
#10222 1537829 
prop.table(table(train$went_on_backorder)) #overall Probability of the Table
#0           1 
#0.006603142 0.993396858 
str(train)
ind <- sapply(train, is.character)
train[ind] <- lapply(train[ind], as.numeric)
ind <- sapply(train, is.numeric)
ind
#str(train)
set.seed(10)
splitIndex <- createDataPartition(train$went_on_backorder, p=.50, list = FALSE, times = 1)
trainSplit <- train[splitIndex,]
testSplit <- train[ -splitIndex,]
table(trainSplit$went_on_backorder)
#    0      1 
#5074 768952 
prop.table(table(trainSplit$went_on_backorder))
#0           1 
#0.006555335 0.993444665 
ctrl <- trainControl(method = "cv", number = 5)
tbmodel <- train(went_on_backorder ~ ., data= trainSplit, method = "treebag", trControl = ctrl)
predictors <- names(trainSplit)[names(trainSplit)!='went_on_backorder']
pred <- predict(tbmodel$finalModel, testSplit[,predictors])
#install.packages("pROC")
library(pROC)
library(DMwR)
auc<-roc(testSplit$went_on_backorder, pred)
print(auc)
#Call:
 # roc.default(response = testSplit$went_on_backorder, predictor = pred)

#Data: pred in 5148 controls (testSplit$went_on_backorder 0) < 768877 cases (testSplit$went_on_backorder 1).
#Area under the curve: 0.6855
#install.packages("DMwR")
library(DMwR)
#rm(list=ls())
trainSplit$went_on_backorder<-as.factor(trainSplit$went_on_backorder)
#trainSplit<- SMOTE(target ~ ., trainSplit, perc.over=100, perc.under=200) #meaning over sample 100 % target variable and give me undersample twice the oversample.
#table(trainSplit$target)
#0 1
#9702 9702
#trainSplit<- SMOTE(target ~ ., trainSplit, perc.over=200, perc.under=800)
#Best balanced data with undersampling 300 and oversampling 200 rows.
set.seed(100)
#rm(trainSplit)
trainSplit<- SMOTE(went_on_backorder ~ ., trainSplit, perc.over=200, perc.under=300)
table(trainSplit$went_on_backorder)
#0     1 
#15222 30444 
prop.table(table(trainSplit$went_on_backorder)) #overall Probability of the Table
#0         1 
#0.3333333 0.6666667 

#trainSplit<- SMOTE(went_on_backorder ~ ., trainSplit, perc.over=300, perc.under=400)
#table(trainSplit$went_on_backorder)
#0      1 
#60888 182664 


#trainSplit<- SMOTE(went_on_backorder ~ ., trainSplit, perc.over=300, perc.under=300)
#table(trainSplit$went_on_backorder)

dim(trainSplit)
#[1] 45666    20 for 200 300

trainSplit$went_on_backorder<- as.numeric(trainSplit$went_on_backorder)
tbmodel <- train(went_on_backorder ~ ., data= trainSplit, method = "treebag", trControl = ctrl)
pred <- predict(tbmodel$finalModel, testSplit[,predictors])
auc<-roc(testSplit$went_on_backorder, pred)
print(auc)
#Call:
 # roc.default(response = testSplit$went_on_backorder, predictor = pred)

#Data: pred in 5148 controls (testSplit$went_on_backorder 0) < 768877 cases (testSplit$went_on_backorder 1).
#Area under the curve: 0.8759

write.csv(trainSplit, file = "datasets/Balanced_Data.csv")
View(trainSplit)





#Modeling Phase
###################################################################################################################################################
#                                                           KNN                                                                                   #
###################################################################################################################################################
rm(list = ls())
data<- read.csv(file = "datasets/Balanced_Data.csv")
set.seed(10)
View(data)
data$X<-NULL
View(data)
mmnorm <- function(x) {return ((x-min(x, na.rm = TRUE))/(max(x, na.rm = TRUE) -
                                                           min (x, na.rm = TRUE)))}
View(mmnorm)
dnorm<-data.frame(apply(data,2,mmnorm))
View(dnorm)
options(scipen = 999)
View(train)
#Data Splitting 
idx <- sample (nrow(dnorm), as.integer(.70*nrow(dnorm)))
test<- dnorm[-idx,]
training <- dnorm[idx,]
#Implementing KNN
predict_knn<-knn(training[,-20],test[,-20],training[,20],k=3)
table(predict_knn,test$went_on_backorder)
#predict_knn    0    1  for k=3
#0            3702 1131
#1            806 8061

#Accuracy
accuracy<-(3702+8061)/(3702+1131+8061+806)
accuracy #[1] 0.8586131

#Errorrate

error_rate<-1-accuracy
error_rate



#Implementing KNN
predict_knn<-knn(training[,-20],test[,-20],training[,20],k=5)
table(predict_knn,test$went_on_backorder)
#predict_knn    0    1 for k=5
#0 3506 1263
#1 1002 7929

#Accuracy
accuracy<-(3506+7929)/(3506+7929+1263+1002)
accuracy #[1] 0.8346715

#Errorrate
error_rate<-1-accuracy
error_rate


#Implementing KNN
predict_knn<-knn(training[,-20],test[,-20],training[,20],k=10)
table(predict_knn,test$went_on_backorder)
#predict_knn    0    1 for k =10
#0 3217 1274
#1 1291 7918

#Accuracy
accuracy<-(3217+7918)/(3217+7918+1274+1291)
accuracy #[1] 0.8127737

#Errorrate
error_rate<-1-accuracy
error_rate
#fp10  0.1372614

###################################################################################################
#                                           KNN COMPLETE                                          #
###################################################################################################



####################################################################################################
#                                           CART                                                  #
###################################################################################################


rm(list = ls())
train<- read.csv(file = "datasets/Balanced_Data.csv")
train$X <- NULL
set.seed(100)
idxCart<- sample(nrow(train),as.integer(.70*nrow(train)))

testCart <- train[-idxCart,]
trainCart <- train[idxCart,]


trainCart <- subset(trainCart[,-c(16,17,18,19)])
testCart <- subset(testCart[,-c(16,17,18,19)])

View(trainCart)

library(rpart)
library(rpart.plot)
library(rattle)
#install.packages('rattle')
library(RColorBrewer)

#mytree <-rpart(trainCart$went_on_backorder~.,data = trainCart)
install.packages('fancyRpartPlot')
fancyRpartPlot(mytree)

testCart_sub <- subset(testCart[,-16])

trainCart$went_on_backorder <- factor(trainCart$went_on_backorder)
tree <- rpart(trainCart$went_on_backorder~., trainCart)
predicted_classes <- predict(tree, testCart_sub, type = "class") 

Prediction <- data.frame(predicted_classes)
Prediction <- edit(Prediction)
table(predicted_classes,testCart$went_on_backorder )

#predicted_classes    1    2
#                1 3769  878
#                2  886 8167

accuracy <- (3769+8167)/(3769+8167+886+878)
accuracy #0.8712409


#####################################################################################################

#                                   C 4.5                                                           #

####################################################################################################

install.packages("C50")
library(C50)

data<-read.csv("datasets/Balanced_Data.csv")
set.seed(100)
idx<-sample(nrow(data),as.integer(.70*nrow(data)))



test_ds<-data[-idx,]
training_ds<-data[idx,]

test_ds<-subset(test_ds[,-c(16,17,18,19)])
training_ds<-subset(training_ds[,-c(16,17,18,19)])

View(test_ds)
test_ds$X<-NULL
test_ds$ppap_risk <- NULL
training_ds$X<-NULL
training_ds$ppap_risk<- NULL
training_ds$went_on_backorder<-factor(training_ds$went_on_backorder)
View(test_ds)

training_ds$went_on_backorder <- factor(training_ds$went_on_backorder)
C50_treeModel <- C5.0(x=training_ds[,-15], y= training_ds$went_on_backorder)

C5imp(C50_treeModel)

C5imp(C50_treeModel, metric = "splits")

C50_treeModel_predict <- predict(C50_treeModel,test_ds[,-15])
table(x=C50_treeModel_predict, y= test_ds[,15])
#   y
#x      1    2
# 1 4057  651
# 2  598 8394
Accuracy <- (4057+8394)/(4057+8394+651+598)
Accuracy
#[1] 0.9088321

######################################################################################################
#                                 Random Forest
#####################################################################################################
rm(list = ls())
termCrossell<-read.csv("datasets/Balanced_Data.csv")
termCrossell$X<-NULL

names(termCrossell)

termCrossell<-subset(termCrossell[,-c(16,17,18,19)])

table(termCrossell$went_on_backorder)/nrow(termCrossell)
#33% of the observations has target variable yes and remaning 66% obs take value "NO"


#Now, we will split the data sample into development and validation samples.
sample.ind <- sample(2,nrow(termCrossell),replace = T,prob = c(0.7,0.3))



cross.sell.dev <- termCrossell[sample.ind==1,]#training
cross.sell.val <- termCrossell[sample.ind==2,]#Testing
table(cross.sell.dev$went_on_backorder)/nrow(cross.sell.dev)

#Yes1         2NO 
#0.3348281 0.6651719 
table(cross.sell.val$went_on_backorder)/nrow(cross.sell.val)
##
##   1Yes       2NO 
#0.3297919   0.6702081

#Both development and validation samples have similar target variable distribution. This is just a sample validation.
#If target variable is factor, classification decision tree is built. We can check the type of response variable.
cross.sell.dev$went_on_backorder <- factor(cross.sell.dev$went_on_backorder) #convert ineteger to factor.
cross.sell.val$went_on_backorder <- factor(cross.sell.val$went_on_backorder)
class(cross.sell.dev$went_on_backorder)
class(cross.sell.val$went_on_backorder)



#Class of target or response variable is factor, so a classification Random Forest will be built. The current data frame has a list of independent variables,
#so we can make it formula and then pass as a parameter value for randomForest.
varNames <- names(cross.sell.dev)
# Exclude ID or Response variable
varNames <- varNames[!varNames %in% c("went_on_backorder")]
# add + sign between exploratory variables
varNames1 <- paste(varNames, collapse = "+")
# Add response variable and convert to a formula object
rf.form <- as.formula(paste("went_on_backorder", varNames1, sep = " ~ "))
#Now, we have a sample data and formula for building Random Forest model.
#Let's build 200 decision trees using Random Forest.
set.seed(200)
#install.packages("randomForest")
library(randomForest)
cross.sell.rf <- randomForest(rf.form,
                              cross.sell.dev,
                              ntree=10,
                              importance=T)
plot(cross.sell.rf,main = "Random Forest Errorrate (20 Dtrees)")
#100 decision trees or a forest has been built using the Random Forest algorithm based learning. We can plot the error rate across decision trees. The plot seems to indicate that after 100 decision trees,
#there is not a significant reduction in error rate.
#Variable importance plot is also a useful tool and can be plotted using varImpPlot function.
#Top 5 variables are selected and plotted based on Model Accuracy and Gini value.
#We can also get a table with decreasing order of importance based on a measure
#(1 for model accuracy and 2 node impurity)
# Variable Importance Plot
#varImpPlot(cross.sell.rf,
# sort = T,
## n.var=5)
# Variable Importance Table
var.imp <- data.frame(importance(cross.sell.rf,
                                 type=2))



# make row names as columns
var.imp$Variables <- row.names(var.imp)
var.imp[order(var.imp$MeanDecreaseGini,decreasing = T),]


# Predicting response variable
cross.sell.dev$predicted.response <- predict(cross.sell.rf ,cross.sell.dev)
set.seed(200)
table(cross.sell.dev$predicted.response)
# Load Library or packages
library(e1071)
library(caret)
## Loading required package: lattice
## Loading required package: ggplot2
# Create Confusion Matrix
confusionMatrix(data=cross.sell.dev$predicted.response,
                reference=cross.sell.dev$predicted.response)