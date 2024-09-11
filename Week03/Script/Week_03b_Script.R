## Lecture 3b script
## Creator: Kassie Jensen
## Date: 09/11/2024

## Libraries
library(palmerpenguins)
library(tidyverse)
library(here)
library(praise)
library(ggthemes)

# Data is already loaded
glimpse(penguins)
str(penguins)

ggplot(data= penguins,
       mapping = aes(x = bill_depth_mm,
                     y= bill_length_mm,
                     group = species,
                     color = species)) +
  geom_point() +
 geom_smooth(method = "lm", se = TRUE) +
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)",
       color = "Species",
       title = "Penguin Species Comparisons",
       subtitle = "Comparison of bill depth and length") +
  scale_color_viridis_d() +
  theme_bw()+
  theme(axis.title = element_text(size = 20,
                                  color = "violet"),
        panel.background = element_rect(fill = "pink")) # dif from color = which would just change the outline 
#  coord_fixed(ratio = 0.5) # changes ratio! no ratio = 1x1 ratio
#  coord_flip() # will flip the axis (can use other versions of coord_ to manipulate graph)
#  scale_color_manual(values = c("orange", "purple","green""))#manually change colors
#  scale_x_continuous(breaks = c(0,14,17,21)) #specific numbers on axis
# scale_x_continuous(limits = c(15,24)) +
# scale_y_continuous(limits = c(30,62)) # puts axis scale

#p + theme_bw() ## lots of theme() that can change the background/ theme 

ggsave(here("Week03", "Output", "Penguin.png"),
       width = 10, height = 5)

praise()


## Plating with another data set
ggplot(data= diamonds,
       mapping = aes(x = carat,
                     y= price,
                     )) +
  geom_point() +
  coord_trans(x = "log10", y = "log10") # you can log within the graph
#geom_smooth(method = "lm", se = TRUE) +
labs(x = "Bill depth (mm)",
     y = "Bill length (mm)",
     color = "Species",
     title = "Penguin Species Comparisons",
     subtitle = "Comparison of bill depth and length") +
  scale_color_viridis_d() 
