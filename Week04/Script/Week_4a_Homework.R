### Lecture 4A Homework ####
### Created by: Kassandra Jensen #############
### Updated on: 2024-09-20 ####################
#### Load Libraries ######
library(palmerpenguins)
library(tidyverse)
library(here)
### Load data ######
# The data is part of the package and is called penguins
glimpse(penguins)
view(penguins)

## Homework Assignment/ Data Analysis
## 1. Calculate the mean and variance of body mass by species, island, and sex without any NAs

penguins %>% ## Assign data frame
  group_by(species, island, sex) %>% ## group by each of the types
  drop_na(species, island, sex) %>% ## drop the NA's of each 
  summarise(mean_bill_length = mean(body_mass_g, na.rm = TRUE), ## calculate mean
            max_bill_length = var(body_mass_g, na.rm=TRUE)) ## calculate variance 

## 2. Filter out (i.e. excludes) male penguins, then calculates the log body mass, then selects only the columns for species, 
## island, sex, and log body mass, then use these data to make any plot. Make sure the plot has clean and clear labels and follows 
## best practices. Save the plot in the correct output folder.

penguins %>%
  filter(sex == "female") %>% #select females, not males
  mutate(log_body_mass_g = log(body_mass_g)) %>% #calculate log body mass
  select(species, island, sex, log_body_mass_g) %>%
  ggplot(aes(x = sex, 
             y = log_body_mass_g,
             color = island)) +
  geom_boxplot()+
  facet_grid( ~ island) +       
    labs(x = "Penguin Sex",           
         y = "Log Body Mass",
         color = "Species",
         title = "Penguin Species Comparisons",
         subtitle = "Log transformed size comparisons of females by island") +
    theme_minimal() +                                           
    theme(
      axis.title = element_text(size = 15),
      panel.background = element_rect(fill = "linen"),
      plot.background = element_rect(fill = "white"),     
      plot.title = element_text(size = 20),
      plot.subtitle = element_text(size = 10)
    )

# Save plot
ggsave(here("Output", "Homework_Week04a.png"),
        width = 10, height = 5)

