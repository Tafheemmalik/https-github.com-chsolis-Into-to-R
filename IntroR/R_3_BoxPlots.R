# File:    R_3_BoxPlots.R
# Course:  Introduction to R
# Section: 3: Box Plots
# Author:  Christopher Solis, uic.edu, @csolisoc
# Date:    2019-04-23
# Based on Advanced Topics in R from UIC Research Informatics Core (March 5, 2020)

Dir = dirname(rstudioapi::getSourceEditorContext()$path) # find working directory (where this R script is!)
setwd(Dir) # set your current directory to where your R script is
getwd() # confirm that the new directory is rihgt

# 0. Load packages ################################################
# If you didn' t download tidyversetype the follwing command in the console:
# install.packages(c("tidyverse","doBy"))
library(ggplot2) # Notice that ggplot2 was downloaded from tidyverse

# 1. Begin plotting ############################################
# Create a basic frame
ggplot(mtcars, aes(x=factor(cyl), y=mpg)) 
# Add a box plot using mtcars
ggplot(mtcars, aes(x=factor(cyl), y=mpg)) + geom_boxplot() 
# Set the fill color
ggplot(mtcars, aes(x=factor(cyl), y=mpg)) + geom_boxplot(aes(fill=factor(cyl))) 
# Set the custom color and shape for outlier points
ggplot(mtcars, aes(x=factor(cyl), y=mpg)) + 
  geom_boxplot(aes(fill=factor(cyl)),
               outlier.fill="red",  outlier.color="red",
               outlier.shape=8, outlier.size=2)
# Create the plot using variables
boxParam <- geom_boxplot(aes(fill=factor(cyl)), outlier.fill="red",
                         outlier.color="red", outlier.shape=8, outlier.size=2)

boxTitle <- labs(title="MPG Vs Number of cylinders",
                 y="Miles per Gallon", x="cylinder",
                 caption="Source: R MTCARS Dataset", fill="Number of cylinders")

boxTheme <- theme(plot.title = element_text(hjust = 0.5),
                  legend.background =element_rect(fill = "darkgray"))

ggplot(mtcars, aes(x=factor(cyl), y=mpg)) + boxParam + boxTitle + boxTheme

# Change the theme
boxTheme <- theme_bw() + boxTheme
ggplot(mtcars, aes(x=factor(cyl), y=mpg)) + boxParam + boxTitle + boxTheme

# Add a facet
ggplot(mtcars, aes(x=factor(cyl), y=mpg)) + boxParam +
  boxTitle + boxTheme + facet_grid(~ am, labeller=label_both)

# Add dotplot
ggplot(mtcars, aes(x=factor(cyl), y=mpg)) + boxParam +
  boxTitle + boxTheme + facet_grid(~ am, labeller=label_both) +
  geom_dotplot(binaxis="y", stackdir="center")

# Change to violin plot
ggplot(mtcars, aes(x=factor(cyl), y=mpg)) + geom_violin(aes(fill=factor(cyl))) + boxTitle + boxTheme + facet_grid(~ am, labeller=label_both) +
  geom_dotplot(binaxis="y", stackdir="center")

# 2. Save figures #################################################
# save as PDF
ggsave("MyFirstBoxPlot.pdf", device = "pdf",
       width = 12, height = 8,
       units = "cm", dpi = 300)
# save as TIFF
ggsave("MyFirstBoxPlot.tiff", device = "tiff",
       width = 12, height = 8,
       units = "cm", dpi = 300)

# 2. Clean up #################################################
# clear packages
detach("package:ggplot2", unload = TRUE)  # For base

# Clear plots
dev.off()  # But only if there IS a plot

rm(list = ls()) # removes variables from local environment (variables displayed on Top right quadrant under Environment)

# Clear console
cat("\014")  # ctrl+L

# FIN!
