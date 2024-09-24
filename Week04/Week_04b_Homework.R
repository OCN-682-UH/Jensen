### Lecture 4B Homework ####
### Created by: Kassandra Jensen #############
### Updated on: 2024-09-20 ###################

## Homework directions
## Create a new clean script
### Remove all the NAs
## Separate the Tide_time column into appropriate columns for analysis
## Filter out a subset of data (your choice)
## use either pivot_longer or pivot_wider at least once
## Calculate some summary statistics (can be anything) and export the csv file into the output folder
## Make any kind of plot (it cannot be a boxplot) and export it into the output folder
## Make sure you comment your code and your data, outputs, and script are in the appropriate folders

#### Load Libraries ######
library(tidyverse)
library(here)

ChemData <- read_csv(here("Week04", "data", "chemicaldata_maunalua.csv"))
