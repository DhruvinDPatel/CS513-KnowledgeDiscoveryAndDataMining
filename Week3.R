?factor()
cat <- c("good","bad","good","bad","bad","bad","good")
typeof(cat)
cat2<-factor(cat)
cat2
typeof(cat2)
#
cat3<-factor(cat,levels = (c("good","bad")))
cat3
catnumb<-as.numeric(cat3)
#
days<-c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
days
factor(days)
days_factor <- factor(days,levels=(c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")))
asint<- as.integer(days_factor)