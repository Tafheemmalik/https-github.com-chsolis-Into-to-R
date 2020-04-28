# File:    R_1_Basics.R
# Course:  Introduction to R
# Section: 1: The basics
# Author:  Christopher Solis, uic.edu, @csolisoc
# Date:    2019-04-23
# Based on Mhairi McNeill Base R Cheat Sheet

# Some good introductory guides to R:
# https://rladiessydney.org/courses/ryouwithme/01-basicbasics-2/
# https://moderndive.netlify.app/1-getting-started.html

# 1. Getting Help ########################################################

?mean # Get help of a particular function
help.search("weighted mean") # Search the help files for a word or phrase
help(package = "dplyr") #Find help for a package.

# 2. Using Libraries #####################################################

install.packages("dplyr") # Download and install a package from CRAN
library(dplyr) # Load the package into the session, making all its functions available to use
dplyr::select # Use a particular function from a package. 
# Try to find "dplyr" under Packages tab in the bottom-rith quadrant

# 3. Working Direactory #################################################

getwd() # Find the current working directory (where inputs are found and outputs are sent).
setwd("~/Desktop") #Change the current working directory.

# 4. Vectors ############################################################
2:6 # just an interger sequence
c(2,4,6) #Join elements into a vector
seq(2, 3, by=0.5)# A complex sequence 
rep(1:2, times=3)# Repeat a vector
rep(1:2, each=3) # Repeat elements of a vector
A <- sample(1:10, 12, replace = TRUE) 
A # shows content of vector a
print(A) # shows values of vector a
sort(A) # Return A sorted
table(A) # See counts of values (makes a frequency distribution list)
rev(A) # Return x reversed
unique(A) # See unique values
rm(A) # removes A
A 

# 5. "<-" vs. "="  #####################################################
#<- is preferred and advised in R Coding style guides:
#https://google.github.io/styleguide/Rguide.xml#assignment
#http://adv-r.had.co.nz/Style.html

# Example of interchangeable orientations with arrows
A <-  12
13 -> B 
A
B
A -> B
A <- B
A
B
# Example of how this doesn't apply to "="
A =  12
13 = B # doesn't work!

# 6. Pick elements from vectors  ###########################################
A <- sample(1:10, 12, replace = TRUE) 
A[4] # Pick the fourth element in A
A[-4] # Pick all but the fourth
A[2:4] # Elements two to four
A[-(2:4)] # All elements except two to four
A[c(1, 5)] # Elements one and five
A[x == 10] # Elements which are equal to 10
A[A < 4] # All elements less than four

B = c(George = "apple", Maria = "orange", John = "cherry",Anthony = "apple")
B[2] # Call one element based on its index
B["Maria"] # Call one element based on the name
names(B)[B == "apple"] # Call names that selected apples

# 7. Programming ##############################################################

# For loop. Structure: 
#for (variable in sequence){
#  Do something
#}
for (i in 1:4){
  j <- i + 10
  print(j) }

# Functions. Structure:
#function_name <- function(var){
#  Do something
#  return(new_variable)
#}
square <- function(x){
  squared <- x*x
  return(squared)
}
square(9)

# 8. Math Functions ############################################################
A <- sample(1:10, 6, replace = TRUE) 
A
log(A) # Natural log
exp(A) # Exponential
max(A) # Largest element
min(A) # Smallest element
round(exp(A), 2) # Round to n decimal places
signif(exp(A), 3) # Round to n significant figures
cor(A, rev(A)) # Correlation. Pearson is the default
sum(A) # Sum
mean(A) # Mean
median(A) # Median
quantile(A) # Percentage quantiles
rank(A) # Rank of elements 
var(A) # The variance
sqrt(var(A)) # The sqaure root of the variance... (What's that?)
sd(A) # The standard deviation

# 9. Matrices ################################################################
M <- matrix(A, nrow = 3, ncol = 2)
A
M
class(M)
M[2, ] # Select a row
M[ , 1] # Select a column. Notice that it's displayed horizontally in the console
M[3, 2] # Select an element
t(M) # Transpose
M %*% t(M) # Matrix Multiplication
diag(3) # creates and identity matrix (aka I)
N <- solve(diag(3), M) # Find x in: I * x = M
N # this is the inverse matrix of M (aka M^-1)
diag(3) %*% N # identity matrix I times the inverse of M (aka M^-1) gives M back!

# 10. Data Frames ################################################################
A <- data.frame(x = 1:8, y = c("a","b","c","d","e","f", "g","h"))
View(A) # See full data frame
head(A) # See the first 6 rows
nrow(A) # number of rows (also works with matrices)
ncol(A) # number of columns (also works with matrices)
dim(A)# number of rows and columns (also works with matrices)
A$x # gets "x" subset
A$y # gets "y" subset
A[[2]] # gets "y" subset. Similar to typing A$y

cbind(A,A$y,A$x) # bind columns
rbind(A,A[3:4, ]) # bind rows
rbind(A,A[3:6, ],A[3:6, ]) # bind rows

# 11. Strings ################################################################
A <- c("a","b","c","d","e","f", "g","h")
B <- c("I","J","K","L","M","N", "O","P") 
paste(A,B, sep = ' ') # Join multiple vectors together
paste(A, collapse = ' ') # Join elements of a vector together
toupper(A) # Convert to uppercase
tolower(B) # Convert to lowercase
nchar(A) # Number of characters in a string
A <- paste(A, collapse = ' ')# join elements in A 
nchar(A) # when all the elements in A are previously joined
factor(A) # Turn a vector into a factor. Can set the levels of the factor and the order
A <- c(1:4) 
cut(A, breaks = 4) # Turn a numeric vector into a factor but ‘cutting’ into sections

# 12. Clean up your workspace #################################################
# clear packages
detach("package:datasets", unload = TRUE)  # For base. detaches the previously loaded packge "dplyr"

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L

rm(list = ls()) # removes variables from local environment (variables displayed on Top right quadrant under Environment)

# FIN!