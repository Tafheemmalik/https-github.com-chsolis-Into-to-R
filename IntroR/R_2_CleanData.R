# File:    R_2_CleanData.R
# Course:  Introduction to R
# Section: 2: Clean Data
# Author:  Christopher Solis, uic.edu, @csolisoc
# Date:    2019-04-23
# Based on Advanced Topics in R from UIC Research Informatics Core (March 5, 2020)

Dir = dirname(rstudioapi::getSourceEditorContext()$path) # find working directory (where this R script is!)
setwd(Dir) # set your current directory to where your R script is
getwd() # confirm that the new directory is rihgt

# 0. Load data ################################################

patients <- read.table("http://public-data.cri.uic.edu/adv_R/clinical.data.txt", header=T, sep="\t")

patients[1:15, ] # preview the first 15 rows
head(patients) # preview the first 6 rows

# 1. Fix “PatientID” ############################################
# fix patient IDs (i.e. rownames of data frame)
# remove "-KP" at the end; "$" means to match at the end of string 
patients$PatientID <- sub("-KP$", "", patients$PatientID) 
head(patients)

# replace "-" with "."
patients$PatientID <- gsub("-", ".", patients$PatientID, fixed=TRUE) 
head(patients)

# 2. Fix “Age” #################################################
# Age: Change missing values with the average age in all patients
# is.na() will test which elements are missing values.
# na.rm=T: missing values (NA) should be stripped before the computation proceeds.
patients$Age[is.na(patients$Age)] <- mean(patients$Age, na.rm=TRUE)
head(patients)

# 3. Fix “Gender” #################################################
# check unique names for gender
unique(patients$Gender)

# change "Female" to "F"; change "Male" to "M"
patients$Gender <- sub("Female", "F", patients$Gender) 
patients$Gender <- sub("Male", "M", patients$Gender) 
patients$Gender <- factor(patients$Gender) 
unique(patients$Gender)
head(patients)

# 4. Fix “Disease” #################################################
# change "." or "" to NA (missing value) 
# preview the first 15 rows
unique(patients$Disease)
patients$Disease[patients$Disease == "."] <- NA 
patients$Disease[patients$Disease == ""] <- NA
patients$Disease <- factor(patients$Disease, levels=c("0", "1")) 
unique(patients$Disease)
head(patients)

# 5. Fix “Genotype” #################################################
unique(patients$Genotype)
# change any string starting with "w" (or "W") to "WT";
# change any string starting with "m" (or "M") to "MT"
# ^ means to match at the beginning of string
patients$Genotype <- sub("^w.*", "WT", patients$Genotype, ignore.case=TRUE) 
patients$Genotype <- sub("^m.*", "MT", patients$Genotype, ignore.case=TRUE) 
patients$Genotype <- factor(patients$Genotype)
unique(patients$Genotype)
head(patients)

# 6. Save data #################################################
# write the cleaned data into a file
# remove the index column using row.names=F; output missing values (NA) as empty string
write.table(patients, file="clean.clinical.data.txt", quote=FALSE, sep = "\t",
            row.names=FALSE, na="")

# Or save as a CSV file
write.csv(patients, file="clean.clinical.data.csv", quote=FALSE,
            row.names=FALSE, na="")

# 7. Clean up your workspace #################################################

rm(list = ls()) # removes variables from local environment (variables displayed on Top right quadrant under Environment)

# Clear console
cat("\014")  # ctrl+L

# FIN!

