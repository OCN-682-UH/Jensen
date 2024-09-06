### This is my first script. I am learning how to import data
### Created by Kassie Jensen
### Created on 2024-09-06
################################################################

### load libraries ###
library(tidyverse)
library(here)

### Read in data ###
WeightData <- read_csv(here("Week_02", "Data", "weightdata.csv"))

### Data Analysis ###
head(WeightData) ## first 6 lines
tail(WeightData) ## last 6 lines
view(WeightData) ## entire data set in new window

##
