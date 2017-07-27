# This mini-project is based on the K-Means exercise from 'R in Action'
# Go here for the original blog post and solutions
# http://www.r-bloggers.com/k-means-clustering-from-r-in-action/

# Exercise 0: Install these packages if you don't have them already

# install.packages(c("cluster", "rattle","NbClust"))
install.packages(c("cluster", "rattle","NbClust"))

# Now load the data and look at the first few rows
data(wine, package="rattle")
head(wine)
View(wine)

# Exercise 1: Remove the first column from the data and scale
# it using the scale() function
wine_data <- wine[-c(1)]
head(wine_data)
scale(wine_data)
# Now we'd like to cluster the data using K-Means. 
# How do we decide how many clusters to use if you don't know that already?
# We'll try two methods.


# Method 1: A plot of the total within-groups sums of squares against the 
# number of clusters in a K-means solution can be helpful. A bend in the 
# graph can suggest the appropriate number of clusters. 

wssplot <- function(wine_data, nc=15, seed=1234){
	              wss <- (nrow(wine_data)-1)*sum(apply(wine_data,2,var))
               	      for (i in 2:nc){
		        set.seed(seed)
	                wss[i] <- sum(kmeans(wine_data, centers=i)$withinss)}
	                
		      plot(1:nc, wss, type="b", xlab="Number of Clusters",
	                        ylab="Within groups sum of squares")
	   }

wssplot(wine_data)

# Exercise 2:
#   * How many clusters does this method suggest?
# This method suggest 3 clusters because that is where the bend occurs. 
#   * Why does this method work? What's the intuition behind it?

#The plot indicates that there is a distinct drop in within groups sum of squares when moving from 1 to 3 clusters. After three clusters, this decrease drops off, suggesting that a 3-cluster solution may be a good fit to the data. 

#   * Look at the code for wssplot() and figure out how it works
#The plot is in essences showing the total witin-groups sums of squares against the numbers of clusters.
#The data parameter show the dataset to be analyzed, nc is the maximum number of clusters to consider, and seed is the random seed number. 
 


# Method 2: Use the NbClust library, which runs many experiments
# and gives a distribution of potential number of clusters.

library(NbClust)
set.seed(1234)
nc <- NbClust(wine_data, min.nc=2, max.nc=15, method="kmeans")
barplot(table(nc$Best.n[1,]),
	          xlab="Numer of Clusters", ylab="Number of Criteria",
		            main="Number of Clusters Chosen by 26 Criteria")


# Exercise 3: How many clusters does this method suggest?
#This method also suggest three clusters because once again there is a drop in the number of clusters when moving from 1 to 3. Subsequently, this decrease drops off, indicating three clusters fit the data well. 


# Exercise 4: Once you've picked the number of clusters, run k-means 
# using this number of clusters. Output the result of calling kmeans()
# into a variable fit.km
fit.km <- kmeans(wine_data, 3, nstart=25)

# Now we want to evaluate how well this clustering does.

# Exercise 5: using the table() function, show how the clusters in fit.km$clusters
# compares to the actual wine types in wine$Type. Would you consider this a good
# clustering?

ct.km <- table(wine$Type, fit.km$cluster)
ct.km
install.packages("flexclust")
library("flexclust")
randIndex(ct.km)

This seems like fairly good clustering. 

# Exercise 6:
# * Visualize these clusters using  function clusplot() from the cluster library
# * Would you consider this a good clustering?
install.packages("cluster")
library("cluster")
clusplot(wine_data, fit.km$cluster, color = TRUE)
#There seems to be a quite a bit of overlap in this clus plot so this may be not be ideal in terms of clustering. 

#clusplot( ... )
