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

penguins %>%                                                    ## Assign data frame
  group_by(species, island, sex) %>%                            ## Group by each of the types
  drop_na(species, island, sex) %>%                             ## Drop the NA's of each 
  summarise(mean_bill_length = mean(body_mass_g, na.rm = TRUE), ## Calculate mean
            max_bill_length = var(body_mass_g, na.rm=TRUE))     ## Calculate variance 

## 2. Filter out (i.e. excludes) male penguins, then calculates the log body mass, then selects only the columns for species, 
## island, sex, and log body mass, then use these data to make any plot. Make sure the plot has clean and clear labels and follows 
## best practices. Save the plot in the correct output folder.

penguins %>%
  filter(sex == "female") %>%                                   ## Select females, not males
  mutate(log_body_mass_g = log(body_mass_g)) %>%                ## Calculate log body mass
  select(species, island, sex, log_body_mass_g) %>%             ## Select what I want to use in plot
  ggplot(aes(x = sex,                                           ## Assign x, y, and color
             y = log_body_mass_g,
             color = island)) +
  geom_boxplot()+                                               ## Call boxplot function
  facet_grid( ~ island) +                                       ## Facet by island
    labs(x = "Penguin Sex",                                     ## Create labels
         y = "Log Body Mass",
         color = "Species",
         title = "Penguin Species Comparisons",
         subtitle = "Log transformed size comparisons of females by island") +
    theme_minimal() +                                           ## Use minimal theme
    theme(                                                      ## Change fonts and background colors
      axis.title = element_text(size = 15),
      panel.background = element_rect(fill = "linen"),
      plot.background = element_rect(fill = "white"),     
      plot.title = element_text(size = 20),
      plot.subtitle = element_text(size = 10)
    )

# Save plot
ggsave(here("Output", "Homework_Week04a.png"),                 ## Save plot 
        width = 10, height = 5)

