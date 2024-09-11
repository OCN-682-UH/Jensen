### This is my for week 3.
### Created by Kassie Jensen
### Created on 2024-09-10
################################################################

## Install libraries 
library(palmerpenguins) 
library(tidyverse)

## Data analysis 
view(penguins)
head(penguins)
tail(penguins)
glimpse(penguins)

# Make plot; commas are used within functions but + connect functions
###aes/ aesthetics = things that are related to the data 
ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm, 
                     y = bill_length_mm, 
                     color = species, 
                    )) + #what is going on the graph
  geom_point(size = 2, alpha = 0.5) + #adds the type of functions
  labs(title= "Bill depth and length", #labs means labels
       subtitle = "Penguin comparisons",  
         x = "Bill Depth (mm)", y = "Bill Length (mm)",
       color= "Species",
       caption = "You can caption with citations or something here!") +
  scale_color_viridis_d()


#faceting
#facet_grid is rows by columns- u do not determine the dimensions; 
# wrap is a "ribbon" - you determine the dimensions
# putting true or false for things just means yes or no
ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm, 
                     y = bill_length_mm, 
                     color = species, 
       )) + #what is going on the graph
  geom_point(size = 2, alpha = 0.5) + #adds the type of functions
  facet_grid(species ~ sex) + #splits it up
  labs(title= "Bill depth and length", #labs means labels
       subtitle = "Penguin comparisons",
       x = "Bill Depth (mm)", y = "Bill Length (mm)",
       color= "Species",
       caption = "You can caption with citations or something here!") +
  scale_color_viridis_d() +
  guides (color = FALSE)

