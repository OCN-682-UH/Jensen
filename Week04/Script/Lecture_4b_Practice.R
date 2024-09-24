### Lecture 4B practice ####
### Created by: Kassandra Jensen #############
### Updated on: 2024-09-20 ####################
#### Load Libraries ######
library(tidyverse)
library(here)

## Load data
ChemData <- read_csv(here("Week_04", "data", "chemicaldata_maunalua.csv"))
view(ChemData)                     
glimpse(ChemData)

ChemData_clean<-ChemData %>%
  filter(complete.cases(.)) #filters out everything that is not a complete row
View(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_" ) # separate by _
head(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col ## this data exists so no need for quotes
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>% # keep the original tide_time column
  unite(col = "Site_Zone", # the name of the NEW col ## needs quotes
        c(Site,Zone), # the columns to unite ## does not need quotes because it already exists
        sep = ".", # lets put a . in the middle
        remove = FALSE) # keep the original
head(ChemData_clean)

## Move long ## Makes it easier to do group_by
ChemData_long <-ChemData_clean %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") # names of the new column with all the values
View(ChemData_long)

ChemData_long %>%
  group_by(Variables, Site) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
            Param_vars = var(Values, na.rm = TRUE)) # get variance

## Think-pair-share: Calculate mean, variance, and standard deviation for all variables by site, zone, and tide
ChemData_long %>%
  group_by(Site, Zone, Tide) %>% # group by everything we want 
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean 
            Param_vars = var(Values, na.rm = TRUE),
            Param_std_dev = sd(Values, na.rm = TRUE)) # get variance
view(ChemData_long)

## Long data can be helpful for graphing
ChemData_long %>%
  ggplot(aes(x = Site, y = Values))+
  geom_boxplot()+
  facet_wrap(~Variables, scales = "free") ## makes it so scales so can be unique for each box plot


### Now doing wide
ChemData_wide<- ChemData_long %>%
  pivot_wider(names_from = Variables, # column with the names for the new columns ## names_FROM- take from already existing things
              values_from = Values) # column with the values
View(ChemData_wide)

ChemData_clean<-ChemData %>%
  drop_na()  #filters out everything that is not a complete row
View(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE)
View(ChemData_clean)

##combine all these things we learned!
ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols  
               names_to = "Variables", # the names of the new cols with all the column names 
               values_to = "Values") %>% # names of the new column with all the values 
  group_by(Variables, Site, Time) %>% 
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Variables, 
              values_from = mean_vals) %>% # notice it is now mean_vals as the col name
  write_csv(here("Week_04","output","summary.csv"))  # export as a csv to the right folder
### Write and save to where it needs to be

##fun R package
devtools::install_github("R-CoderDotCom/ggbernie@main")
library(ggbernie)
ggplot(ChemData) +
  geom_bernie(aes(x = Salinity, y = NN), bernie = "sitting")
