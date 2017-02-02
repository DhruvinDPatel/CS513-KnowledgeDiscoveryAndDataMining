#
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
