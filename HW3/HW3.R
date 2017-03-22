# First Name : Dhruvin
# Last Name : Patel
# Lecture : B
# CWID  : 10420356

# loading data from link
csv_data <- read.csv("http://www.math.smith.edu/sasr/datasets/help.csv")
attach(csv_data)

#1
d1 <- data.frame(id, pcs1, mcs1, substance, racegrp)
View(d1)

#2
mean_of_mcs1 <- mean(mcs1, na.rm = TRUE)
mean_of_mcs1
max_of_mcs1 <- max(mcs1, na.rm = TRUE)
max_of_mcs1
sd_of_mcs1 <- sd(mcs1, na.rm = TRUE)
sd_of_mcs1
median_of_mcs1 <- median(mcs1, na.rm = TRUE)
median_of_mcs1
min_of_mcs1 <- min(mcs1, na.rm = TRUE)
min_of_mcs1

#3
table(substance,racegrp)

#4
mcs1[is.na(mcs1)] <- mean_of_mcs1
summary(mcs1)
