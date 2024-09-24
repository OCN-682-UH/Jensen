### Lecture 4A practice ####
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

## Only females
filter(.data = penguins, 
       sex == "female" )

## Only 2008
filter(.data = penguins, 
       year == "2008" )

## Body mass greater than 5000
filter(.data = penguins, 
       body_mass_g > "5000" )

## Give same data regardless of comma
filter(.data = penguins, sex == "female", body_mass_g >5000)
filter(.data = penguins, sex == "female" & body_mass_g >5000)

## Think-pair-share
## Penguins that were collected in either 2008 or 2009
filter(.data = penguins, year == "2008" | year == "2009")

## Penguins that are not from the island Dream
filter(.data = penguins, island != "Dream")

## Penguins in the species Adelie and Gentoo
filter(.data = penguins, 
       species %in% c("Adelie","Gentoo"))

## Mutate - add new columns
data2<-mutate(.data = penguins, 
              body_mass_kg = body_mass_g/1000)
View(data2)

## Mutate with ifelse
## Makes a new column that separates by if before or after 2008
data3<- mutate(.data = penguins,
               after_2008 = ifelse(year>2008, "After 2008", "Before 2008"))
View(data3)

## Use mutate to create a new column to add flipper length and body mass together
data4<-mutate(.data = penguins, 
              flipper_and_body_mass = flipper_length_mm + body_mass_g)
View(data4)

## Use mutate and ifelse to create a new column where body mass greater than 4000 is labeled as big and everything else is small
data5<- mutate(.data = penguins,
               Body_size = ifelse(body_mass_g>4000, "Big", "Small"))
View(data5)

## %>% "pipe" practice
penguins %>% # use penguin dataframe
  filter(sex == "female") %>% #select females
  mutate(log_mass = log(body_mass_g)) #calculate log biomass

penguins %>% # use penguin dataframe
  filter(sex == "female") %>% #select females
  mutate(log_mass = log(body_mass_g)) %>% #calculate log biomass
  select(species, island, sex, log_mass)

penguins %>% # use penguin dataframe
  filter(sex == "female") %>% #select females
  mutate(log_mass = log(body_mass_g)) %>% #calculate log biomass
  select(Species = species, island, sex, log_mass)

## Calculate the mean flipper length (and exclude any NAs)
penguins %>% # 
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE))

## Calculate mean and mean flipper length
penguins %>% # 
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE),
            min_flipper = min(flipper_length_mm, na.rm=TRUE))

## Calculate the mean and max bill length by island
penguins %>%
  group_by(island) %>%
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            max_bill_length = max(bill_length_mm, na.rm=TRUE))

## Group by both island and sex
penguins %>%
  group_by(island, sex) %>%
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            max_bill_length = max(bill_length_mm, na.rm=TRUE))

## Drop all the rows that are missing data on sex
penguins %>%
  drop_na(sex)

## Drop all the rows that are missing data on sex calculate mean bill length by sex
penguins %>%
  drop_na(sex) %>%
  group_by(island, sex) %>%
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))


## Drop NAs from sex, and then plot boxplots of flipper length by sex
penguins %>%
  drop_na(sex) %>%
  ggplot(aes(x = sex, y = flipper_length_mm)) +
  geom_boxplot()

## Dad jokes!
library(devtools) # load the development tools library
devtools::install_github("jhollist/dadjoke")

library(dadjoke)
dadjoke()

#yay!