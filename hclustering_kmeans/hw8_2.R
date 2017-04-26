df <- read.csv('/Users/dhruvinpatel/graduate_work/CS513/HW8/churn.csv')

View(df)
str(df)

df$Int.l.Plan <- as.integer(df$Int.l.Plan)
df$Int.l.Plan[df$Int.l.Plan == "2"] <- 0

df$VMail.Plan <- as.integer(df$VMail.Plan)
df$VMail.Plan[df$VMail.Plan == "2"] <- 0

mnorm <- function(x, minx, maxx) {
  return ((x-minx)/(maxx-minx))
}

norm_df <- mnorm(df$CustServ.Calls,min(df$CustServ.Calls),max(df$CustServ.Calls))
new_df <- c(df$Int.l.Plan,df$VMail.Plan,norm_df)

?attitude()
?kmeans()
data_cluster <- kmeans(new_df, 3, nstart = 20)

# output:
# K-means clustering with 3 clusters of sizes 5456, 3123, 1420