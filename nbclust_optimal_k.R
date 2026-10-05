# =============================================================================
# Estimation of the optimal number of clusters (NbClust, 26 indices + elbow)
# =============================================================================

model <- "DTI"   # "DTI", "AMURA" or "DTI+AMURA"

## Template to estimate the optimal number of clusters using R
# First, we install (if necessary) and load the packages used to estimate the optimal value
# install.packages(c("factoextra","fpc","NbClust","lattice"))
require(factoextra) # For visualisation
require(fpc) # Validation statistics
require(NbClust) # Optimal number of clusters
require(lattice)

# Example with all subjects (CM+EM)
# We read the file with the values obtained after PCA (saved as csv). nrow = number of subjects; ncol = minimum between latent dimension (autoencoder) and number of selected features
WM_all <- read.csv(paste0("results/pca_AllPatients_", model, ".csv"))

# We obtain the optimal number of clusters. The function employed here shows plots and the results with the optimal number of clusters for 26 out of 27 methods (all techniques except the elbow method). The results related to the optimal number of clusters are displayed in the Rstudio console
res.nbclust <- NbClust(data = WM_all, distance = "euclidean",
                       min.nc = 2, max.nc = 10,
                       method = "kmeans", index ="all")

# Optionally, to plot the results according to the previous output, and adding the results from the elbow method
barplot(c(2,1,9,1,3,3,2,2,1,1,2),col = "#4682B4", xlab = "Number of clusters k", ylab = "Frequency among all methods", main = "Optimal number of clusters - k (WM Diffusion - All)", names.arg = c(0,1,2,3,4,5,6,7,8,9,10))
 # A value of 0 means that a specific method did not converge

# The estimation is repeated with CM and EM separately
WM_CM <- read.csv(paste0("results/pca_CM_", model, ".csv"))
res.nbclust <- NbClust(data = WM_CM, distance = "euclidean",
                       min.nc = 2, max.nc = 10,
                       method = "kmeans", index ="all")
barplot(c(2,1,9,6,1,3,5),col = "#4682B4", xlab = "Number of clusters k", ylab = "Frequency among all methods", main = "Optimal number of clusters - k (WM Diffusion - CM)",names.arg = c(0,1,2,3,7,9,10)) # optional barplot

WM_EM <- read.csv(paste0("results/pca_EM_", model, ".csv"))
res.nbclust <- NbClust(data = WM_EM, distance = "euclidean",
                       min.nc = 2, max.nc = 10,
                       method = "kmeans", index ="all")
barplot(c(2,1,7,5,2,5,5),col = "#4682B4", xlab = "Number of clusters k", ylab = "Frequency among all methods", main = "Optimal number of clusters - k (WM Diffusion - EM)", names.arg = c(0,1,2,3,4,8,10)) # optional barplot
