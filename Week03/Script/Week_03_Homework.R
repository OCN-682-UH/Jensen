## MBIO Week 3 homework
## Creator: Kassie Jensen
## Date: 09/11/2024

## Libraries
library(palmerpenguins)
library(tidyverse)
library(here)
library(praise) # Just for fun <3
library(wesanderson) # for colors

## Data is already loaded
view(penguins) # View all data
glimpse(penguins) # Quick overview of data
str(penguins) # Look at structure 
wes_palettes # Look at different options for color palettes

## Graphing
ggplot(data= penguins, # Call data
       mapping = aes(x = sex,
                     y= body_mass_g,
                     group = species,
                     fill = species)) +
  geom_violin() +                   ## Violin plot
  facet_grid(species ~ sex) +       ## Facet_grid by species and sex. Formatting looked best as grid rather than wrap
  labs(x = "Penguin Sex",           ## Add titles
       y = "Body Mass (g)",
       color = "species",
       title = "Penguin Species Comparisons",
       subtitle = "Size comparison of penguins by species and sex") +
  scale_fill_manual(values = wes_palette("GrandBudapest1")) + ## Add color palette from wesanderson package
  theme_minimal() +                                           ## theme_minimal() to add customizations on top
  theme(
    axis.title = element_text(size = 15, color = wes_palette("GrandBudapest1")[3]),
    panel.background = element_rect(fill = "linen"),
    plot.background = element_rect(fill = "white"),           ## Background saved as grey before so changed it to white
    plot.title = element_text(size = 20, color = wes_palette("Moonrise1")[2]),
    plot.subtitle = element_text(size = 10, color = wes_palette("IsleofDogs1")[2])) ## Just having fun with all the color options. 


# Save plot
ggsave(here("Week03", "Output", "Homework_Week03.png"),
       width = 10, height = 5)
