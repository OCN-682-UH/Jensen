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
class(Cond_Data$date)                                             ## This is a character

Cond_Data_clean <- Cond_Data %>%
  mutate(date = mdy_hms(date)) %>%                                  ## Convert to datetime
  mutate(date = round_date(date, "10 seconds"))                     ## Round to nearest 10 seconds
view(Cond_Data_clean)

Depth_Data <- read_csv(here("Week05","Data", "DepthData.csv"))
view(Depth_Data)                                                    ## This is already in the same format

###### Data analysis ############
Cond_Depth_Data <- inner_join(Cond_Data_clean, Depth_Data).         ## Join data frames 
view(Cond_Depth_Data)                                               ## Used inner join so data deleted if not the same in both data sets

Cond_Depth_Data_long <- Cond_Depth_Data %>%                       
  select(date, Depth, Temperature, Salinity) %>%                    ## Only want to look at depth, temp, and salinity
  mutate(minutedate = floor_date(date, "1 minute")) %>%             ## Round to nearest minute
  pivot_longer(cols = Depth:Salinity,                               ## Use columns from depth to salinity
               names_to = "Variables",                              ## Rename new column to Variables
               values_to = "Values")  %>%                           ## Rename column to values
  group_by(minutedate, Variables) %>%                               ## need to group by site and parameter/ variables
  summarise(MeanValues = mean(Values, na.rm = TRUE))                ## Summarize averages
  
view(Cond_Depth_Data_long)                                          ## View to make sure it looks okay

######### Make plot ########
ggplot(Cond_Depth_Data_long, 
       aes(x = minutedate, y = MeanValues,                          ## Assign x and y values
           color= Variables))+                                      ## Assign color 
  geom_line() +                                                     ## Use geom_line (I didn't want to put points because I thought this looked cleaner)
  facet_wrap(~Variables, scales = "free") +                         ## Facet by Variables, scales free for cleaner look
  labs(x= "Time",                                                   ## Assign labels
       y= "Mean Value",
       title = "Average depth, salinity, and temperature over time") +
  theme_minimal() +                                                 ## Use minimal theme
  scale_x_datetime(date_breaks = "30 min", date_labels = "%H:%M") + ## Change time scale on x axis
  theme(
    axis.title = element_text(size = 15),                           ## Change font size 
    panel.background = element_rect(fill = "linen"),                ## Change panel background color
    plot.background = element_rect(fill = "white"),                 ## Change plot background color
    plot.title = element_text(size = ),                           ## Change font size
    plot.subtitle = element_text(size = 10),                        ## Change font size
    legend.position = "none"                                        ## Legend label not necessary
  )

ggsave(here("Week05", "Output", "Homework_Week05.png"),                ## Save plot
       width = 10, height = 5)
