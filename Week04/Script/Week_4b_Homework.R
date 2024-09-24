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

## Read Data
ChemData <- read_csv(here("data", "chemicaldata_maunalua.csv"))
view(ChemData)
glimpse(ChemData)

## Clean up data, pivot longer, calculate summary statistics, and export.
New_ChemData <-ChemData %>%
  drop_na() %>%                                               ## Drop any NA's in data
  separate(col = Tide_time,                                   ## Call column that you want to separate
           into = c("Tide","Time"),                           ## Separate it into two columns Tide and time
           sep = "_" ) %>%                                    ## Separate by _
  pivot_longer(cols = Phosphate:pH,                           ## Pivot from phosphate to pH
               names_to = "Variables",                        ## Change name of colum to variables  
               values_to = "Values")  %>%                     ## Name of new column with values
  group_by(Variables, Tide, Time, Season) %>%                 ## Grouped by these columns
  summarise(MeanValues = mean(Values, na.rm = TRUE),          ## calculate mean
            VarianceValues = var(Values, na.rm = TRUE),       ## calculate variance
            MedianValues = median(Values, na.rm = TRUE))      ## calculate median 

write_csv(New_ChemData, here("Output", "Homework_4b_summary.csv")) ## Save new file

view(New_ChemData)

## Plot new data
New_ChemData %>%                                              ## Calling new cleaned data
  filter(Variables == "Phosphate") %>%                        ## Only want to look at phosphate out of all variables
  ggplot(aes(x= Tide, y= MeanValues,                          ## Assign X and Y
             fill = Time)) +                                  ## Show more information with fill
  geom_col() +                                                ## Call geom to represent values
  facet_grid(~Season) +                                       ## Facet by season
    labs(x= "Tide",                                           ## Assign labels
         y= "Mean Phosphate (mmol/L)",
         color= "Time",
         title = "Phosphate Level Comparison",
         subtitle = "Effects of time, season, and tide on phosphate") +
  theme_minimal() +                                           ## Use minimal theme
  theme(
    axis.title = element_text(size = 15),                     ## Change font size 
    panel.background = element_rect(fill = "linen"),          ## Change panel background color
    plot.background = element_rect(fill = "white"),           ## Change plot background color
    plot.title = element_text(size = 20),                     ## Change font size
    plot.subtitle = element_text(size = 10)                   ## Change font size
  )


ggsave(here("Output", "Homework_Week04b.png"),                ## Save plot
       width = 10, height = 5)





