### Lecture 5 Homework ####
### Created by: Kassandra Jensen #############
### Updated on: 2024-09-26 ####################
  
###### Homework Directions ##########
## Read in both the conductivity and depth data.
## Convert date columns appropriately
## Round the conductivity data to the nearest 10 seconds so that it matches with the depth data
## Join the two dataframes together (in a way where there will be no NAs... i.e. join in a way where only exact matches between the two dataframes are kept)
## take averages of date, depth, temperature, and salinity by minute
## Make any plot using the averaged data
## Do the entire thing using mostly pipes (i.e. you should not have a bunch of different dataframes). Keep it clean.
## Don't forget to comment!
## Save the output, data, and scripts appropriately

######## Load Libraries #######
library(tidyverse)
library(here)
library(lubridate)

######## Read in data #######
Cond_Data <- read_csv(here("Week05","Data", "CondData.csv"))
view(Cond_Data)

Depth_Data <- read_csv(here("Week05","Data", "DepthData.csv"))
view(Depth_Data)


