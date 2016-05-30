##READ ME FIRST!

This repo contains 2 R scripts and a codebook.
* run_analysis.R is the main script. You must set the working directory at the original path of the data folders. This is, once you UNZIP the file, go to the UCI HAR Dataset FOLDER and set this one as the WORKING DIRECTORY. Either use the setwd() command or do it through the GUI in RStudio or R
* getting_summarised_tiby_data.R is a script that must run AFTER the run_analysis.R script. It will create a smaller data set where you could see the mean values of the MEASUREMENTS for each activity and each subject.
* codebook  describes the final variable names, their units etc.

### Going from raw data to tidy data

*First of all, download the zip file from the following URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
*Unzip the file and set the working directory in R (or RStudio) as the UCI HAR Dataset
*Source the run_analysis.R script. This script is the main one and it does the following steps:
*