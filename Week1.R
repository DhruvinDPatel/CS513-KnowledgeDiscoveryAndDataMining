# Introduction to R
# First Name  : Dhruvin
# Last Name   : Patel
# CWID        : 10420356
# Email       : dpate78@stevens.edu

hello <- "Hello World"
print(hello)
# use c
x <- c(1,2,2,2,5,10)
x
min(x)
max(x)
mean(x)
summary(x)
x
x <- c(1,2,2,2,5,NA,10)
min(x)
max(x)
mean(x)
summary(x)
# without using summary
min(x, na.rm = TRUE)
max(x, na.rm = TRUE)
#to find help
?min()
summary(x)
y <- mean(x, na.rm = TRUE)
summary(y)
# List memory for stored objects
ls()
# to remove object
rm(x)
ls()
#
length(hello)
?length()
?nchar()
nchar(hello)
#
?is()
?vector()
is.vector(hello)
mode(hello)
num <- 1233456
is.vector(num)
mode(num)
numchar <- '123456'
is.vector(numchar)
mode(numchar)
c <- 'c'
is.vector(c)
mode(c)
#
x1 <- c(10,5,6,6,6,7)
x1
x2 <- c(1,2,3)
x2
# wrong way of doing vector addition(two diff sizes of vector)
x3 <- x1 + x2
x3
x2 <- c(1,2,3,4)
x3 <- x1 + x2
x3
#
?seq()
x3 <- seq(from=1, to=6, by=1)
x3
typeof(x3)
mode(x3)
x4 <- 1:6
typeof(x4)
mode(x4)
x5 <- as.integer(x3)
typeof(x5)
?as()
#
x6 <- c(x3,x4)
x6
typeof(x6)
x7 <- c(as.integer(x3),x4)
x7
typeof(x7)
# reverse casting of data types : numbers to character
x9 <- c(x7,hello)
x9
mode(x9)
typeof(x9)
#
myfirstname <- "Dhrvin"
mylastname <- "Patel"
fullname <- c(myfirstname,mylastname)
fullname
rm(myfirstname)
myfirstname
#
avector <- c(1,2,3,4)
names(avector) <- c("one","two","three","four")
avector
typeof(avector)
elementnames <- names(avector)
elementnames
# to free up memory
?rm()
ls()
rm(list = ls())
ls()