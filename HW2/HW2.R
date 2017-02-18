x <- c(1,2,3)
y <- c(11,12,13,14,15,16)

z <- x + y
# EXP: There is size mismatch here, So R copy the 'x' vector's elemnts in order to-
# perform addition, However this is only possible if length of 'x' is less than-
# 'y' or vice versa
lastName <- "Patel"
firstName <- "Dhruvin"
id <- 10420356

length(lastName)
mode(lastName)
# EXP: Length of lastName reflects 1 because default datatype of R is vector and we-
# assigned only one element to it. Mode of it is character vector.

myinfo <- c(firstName,lastName,id)
myinfo
length(myinfo)
mode(myinfo)
rm("firstName")
myinfo

#

roster <- data.frame(First=c("fname1,fname2"),Last=c("lname1","lname2"),ID=c(1111,2222))
View(roster)

write.csv(roster, file="exportedRoster.csv",row.names=FALSE)

importedCsv <- read.csv("http://www.math.smith.edu/sasr/datasets/help.csv")
View(importedCsv)

rm(list=ls())
