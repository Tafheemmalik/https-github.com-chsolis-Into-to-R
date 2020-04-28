# File:    R_5_Histograms.R
# Course:  Introduction to R
# Section: 5: Histograms
# Author:  Christopher Solis, uic.edu, @csolisoc
# Date:    2019-04-23
# Based on  Barton Poulson from datalab.cc

Dir = dirname(rstudioapi::getSourceEditorContext()$path) # find working directory (where this R script is!)
setwd(Dir) # set your current directory to where your R script is
getwd() # confirm that the new directory is rihgt

# 0. Load packages ################################################

library(datasets)

# 1. Basic histograms ############################################
# load data
?iris
head(iris)

hist(iris$Sepal.Length)
hist(iris$Sepal.Width)
hist(iris$Petal.Length)
hist(iris$Petal.Width)



# 2. Histogram by group #################################################
# Put graphs in 3 rows and 1 column
par(mfrow = c(3, 1))

# Histograms for each species using options
hist(iris$Petal.Width [iris$Species == "setosa"],
     xlim = c(0, 3),
     breaks = 9,
     main = "Petal Width for Setosa",
     xlab = "",
     col = "red")

hist(iris$Petal.Width [iris$Species == "versicolor"],
     xlim = c(0, 3),
     breaks = 9,
     main = "Petal Width for Versicolor",
     xlab = "",
     col = "purple")

hist(iris$Petal.Width [iris$Species == "virginica"],
     xlim = c(0, 3),
     breaks = 9,
     main = "Petal Width for Virginica",
     xlab = "",
     col = "blue")

# Restore graphic parameter
par(mfrow=c(1, 1))


# 2. Overlaying plots #################################################
# Default
hist(lynx)

# Add some options
hist(lynx,
     breaks = 14,          # "Suggests" 14 bins
     freq   = FALSE,       # Axis shows density, not freq.
     col    = "thistle1",  # Color for histogram
     main   = paste("Histogram of Annual Canadian Lynx",
                    "Trappings, 1821-1934"),
     xlab   = "Number of Lynx Trapped")

# Add a normal distribution
curve(dnorm(x, mean = mean(lynx), sd = sd(lynx)),
      col = "thistle4",  # Color of curve
      lwd = 2,           # Line width of 2 pixels
      add = TRUE)        # Superimpose on previous graph

# Add two kernel density estimators
lines(density(lynx), col = "blue", lwd = 2)
lines(density(lynx, adjust = 3), col = "purple", lwd = 2)

# Add a rug plot
rug(lynx, lwd = 2, col = "gray")

# 3. Clean up #################################################
# clear packages
detach("package:datasets", unload = TRUE)  # For base

# Clear plots
dev.off()  # But only if there IS a plot

rm(list = ls()) # removes variables from local environment (variables displayed on Top right quadrant under Environment)

# Clear console
cat("\014")  # ctrl+L

# FIN!
