
setwd('~/graduate_work/CS513/')
library(class)
library(e1071)

df <- read.csv('HW7/cancer.csv')
View(df)
class(df)
summary(df)
str(df)

df$F1 <- factor(df$F1)
df$F2 <- factor(df$F2)
df$F3 <- factor(df$F3)
df$F4 <- factor(df$F4)
df$F5 <- factor(df$F5)
df$F7 <- factor(df$F6)
df$F8 <- factor(df$F8)
df$F9 <- factor(df$F9)
df$Sample <- factor(df$Sample)
df$diagnosis <- factor(df$diagnosis)
str(df)

table(sample=df$Sample,diagnosis=df$diagnosis)

#model and prediction
?naiveBayes()
nBayes_cancer <- naiveBayes(diagnosis ~., data =df[,2:11])
category <- predict(nBayes_cancer,df[,2:10])
View(category)

table(category, df$diagnosis)
new_data<-cbind(df,category)
table(sample=df$Sample,diagnosis=df$diagnosis)
table(temp=df$Sample,NBayes=category)
table(NBayes=category,diagnosis=df$diagnosis)

#Output
#       diagnosis
# NBayes   2   4
#   2   443   2
#   4   15 239