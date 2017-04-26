?hclust()
?dist()

x_dataset <- c(7, 10, 13, 21, 28, 28, 35, 43, 44, 50)
y_dataset <- c(57, 62, 63, 71, 78, 88, 89, 90, 94, 98)

cluster <- hclust(dist(x_dataset, method="euclidean"), method ="average")
plot(cluster)

cluster2 <- hclust(dist(y_dataset, method = "euclidean"), method = "average")
plot(cluster2)

combined <- cbind(x_dataset, y_dataset)
cluster3 <- hclust(dist(combined), method = "average")
plot(cluster3)