# File:    R_3_BoxPlots.R
# Course:  Introduction to R
# Section: 4: Curve Fitting
# Author:  Christopher Solis, uic.edu, @csolisoc
# Date:    2019-04-23
# Based on https://github.com/shalevy1/jupyter
Dir = dirname(rstudioapi::getSourceEditorContext()$path) # find working directory (where this R script is!)
setwd(Dir) # set your current directory to where your R script is
getwd() # confirm that the new directory is rihgt

# 0. Load packages and data ####################################
# If you didn' t download tidyversetype the follwing command in the console:
# install.packages(c("tidyverse","doBy"))
library(ggplot2) # Notice that ggplot2 was downloaded from tidyverse
library(dplyr) # If dplyr is not installed use install.packages(dplyr)
library(broom) # If broom is not installed use install.packages(broom)
library(tidyr) # If tidyr is not installed use install.packages(dplyr)
library(purrr) # If purrr is not installed use install.packages(broom)
require(ggplot2)
head(mtcars)

# 1. Begin plotting scatter plot #################################
# aes() is a function that describes how variables are mapped to visual properties
gp <- ggplot(aes(x = wt, y = mpg), data = mtcars) aes()
gp + geom_point()

# Change size of dots in scatter plot
gp + geom_point(size = 4)

# geom_point() change size of dots proportionally to the magitude of the variable wt
gp + geom_point(aes(size = wt))

#  Change x-,y-axis lismits using the ggplot2 functions scale_x_continuous and scale_y_continuous
gp <- ggplot(aes(x = wt, y = mpg), data = mtcars) + geom_point()
gp + scale_y_continuous(limits=c(1, 40)) + scale_x_continuous(limits=c(0, 6))

# You can also change the number of ticks
gp + scale_y_continuous(limits=c(1, 35), breaks=seq(1, 35, 5)) +
     scale_x_continuous(limits=c(1.5, 5.5), breaks=seq(1.5, 5.5, 1))

# Group by using color argument and factor fucntion to change variables vs to a factor
gp <- ggplot(aes(x=wt, y=mpg, color=factor(vs)),  data=mtcars)
gp + geom_point()

# Add a regression line
mtcars$vs <- as.factor(mtcars$vs)
gp <-ggplot(aes(x=wt, y=mpg, color=vs), data=mtcars)
#gp + geom_point()
gp + geom_point() + geom_smooth(method = "lm", se = FALSE)

# dding a bivariate distribution on the scatter plot using the geom_density2d() function
gp <- ggplot(aes(x=wt, y=mpg), 
             data=mtcars)
gp + geom_point() + geom_density2d()

# 2. Add text to a scatter plot #################################

# Do a correlation analysis to extract the r– and p-values
require(dplyr)
require(broom)
corr <- mtcars  %$%
  cor.test(mpg, wt) %>%
  tidy %>%
  mutate_if(is.numeric, round, 4)
corr  # prints the correlation output in the console

# Display the r– and p-values in the console
text = paste0('r = ', corr$estimate, ', ',
              ifelse(corr$p.value <= 0, 'p < 0.05', paste('p = ', corr$p.value))
)
text # prints the r– and p-values in the console

# add text using the annotate function
gp <- ggplot(aes(x = wt, y = mpg), 
             data = mtcars)
gp + geom_point() + geom_smooth(method = "lm", se = TRUE) +
  annotate('text',  x = 4.5, y = 35, label=text)

# 3. Save figures #################################################
# save as PDF
ggsave("MyFirstScatterPlot.pdf", device = "pdf",
       width = 12, height = 8,
       units = "cm", dpi = 300)
# save as TIFF
ggsave("MMyFirstScatterPlot.tiff", device = "tiff",
       width = 12, height = 8,
       units = "cm", dpi = 300)

# 2. Clean up #################################################
# clear packages
detach("package:ggplot2", unload = TRUE)  # For base
detach("package:dplyr", unload = TRUE)  # For base
detach("package:broom", unload = TRUE)  # For base
detach("package:tidyr", unload = TRUE)  # For base
detach("package:purrr", unload = TRUE)  # For base

# Clear plots
dev.off()  # But only if there IS a plot

rm(list = ls()) # removes variables from local environment (variables displayed on Top right quadrant under Environment)

# Clear console
cat("\014")  # ctrl+L

# FIN!

