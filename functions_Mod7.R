#function for normalization

mmnorm <- function(x,minx,maxx){
  z <- ((x-minx)/(maxx-minx))
  return(z)
}

myvector <- 1:20
myvector
mmnorm(myvector,1,20)

minx <- 10
maxx <- 25
# scope of the variable; from block to global
mmnorm2 <- function(x){
  minx <- 0
  z <- list(x)
}

f_print <- function(x1,x2,x3,x4,x5){
  print(c('value of x1',x1))
  print(c('value of x2',x2))
  print(c('value of x3',x3))
  print(c('value of x4',x4))
  print(c('value of x5',x5))
}

f_print(10,5,3,2,1)
f_print(x2=10,x5=5,3,2,1)
# error : f_print(x2=10,x5=5,3,2), f_print(x2=10,x5=5,3,2,1,10)

rm(list = ls())