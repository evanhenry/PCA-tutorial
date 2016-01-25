#######PCA Teaching Module

#install packages
#download plotting packages using devtools function
install.packages("devtools")
library(devtools)
install_github("ggbiplot", "vqv")
library(ggbiplot)

#import data 
#"Import Dataset" - screen captures are in the .doc

#subset data to the variables of interest
Hives<-subset(na.omit(HivesOcthr[2:7]))

#visualize
plot(Hives) #can you see any correlations? 
#temp from each sensor look alike

#covariance of reduced dataset
covariance_test<-cov(Hives)
covariance_test #why is the output an 6x6 matrix?

#eigenvalues and eigenvector
cov_eigen<-eigen(covariance_test)
cov_eigen 

####the big move that relates eigen vectors/values with PCA

#the eigen vectors are the principal components
#re-name columns to make compairson easier
colnames(cov_eigen$vectors)=c("PC1", "PC2", "PC3", "PC4", "PC5", "PC6")
row.names(cov_eigen$vectors)=c("22t", "11t", "22h", "11h", "db", "pa")
cov_eigen

#the data in the rows are called loadings, which 
#indicate the strenght of these variables to the PC

#we will compare this with the pca

#pca
pca<-princomp(Hives,scale=TRUE, retx=FALSE)
pca
#summary(pca):shows the st dev, proportion of variance,
#and cumulative proportion (of variance) of our principal components.
summary(pca)

#The loadings (or eigenvectors).
loadings <- pca$loadings
loadings # this is the same as just entering "pca" into the console 
##crosscheck with
cov_eigen

########
#visualizing data:

#scree plot comparing how much variation each PC explains. sum = 100%
#add title
plot(pca, type ="l",main="Scree Plot")
plot(pca, type ="b",main="Scree Plot")

#You might want to see how the raw data
#contribute to the principal components,
#how observations are explained by components, 
#and how the directionality of the compenonets.
#Note that "choices" is the argument defining which
#PCs will be used on the biplot

#let's run visualize the relatedness of the PC
#between PC 1 and PC 2

ggbiplot(pca_plot, choices=c(1,2), obs.scale = 1, var.scale = 1)
#2 and 3
ggbiplot(pca_plot, choices=c(2,3), obs.scale = 1, var.scale = 1)
#1 and 3
ggbiplot(pca_plot, choices=c(1,3), obs.scale = 1, var.scale = 1)
