### Lecture 5a Practice ####
### Created by: Kassie Jensen #############
### Updated on: 2024-09-24 ####################

#### Load Libraries ######
library(tidyverse)
library(here)

### Load data ######

# Environmental data from each site
EnviroData<-read_csv(here("Week05","data", "site.characteristics.data.csv"), show_col_types = FALSE)
view(EnviroData)
limpse(EnviroData)

#Thermal performance data
TPCData<-read_csv(here("Week05","data","Topt_data.csv"), show_col_types = FALSE)
view(TPCData)
glimpse(TPCData)

## Pivot enviro data
EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured,
              values_from = values) %>%
  arrange(site.letter)                          ## This arranges the order in alp shabetical order by column of your choosing
view(EnviroData_wide)


## left_join(x,y) <-- x and y ARE the data frames will get rid of data that both don't have 
## if all data is the same then left, right, or full join doesn't matter

FullData_left <- left_join(TPCData, EnviroData_wide)
view(FullData_left)

FullData_left<- left_join(TPCData, EnviroData_wide) %>%
  relocate(where(is.numeric), .after = where(is.character))    # relocate all the numeric data after the character data
## basically says where are the numeric characters and will tell you column by column
view(FullData_left)

## Think-pair-share ## calculate the means and variances of all the numeric data 
##vars= variables then you just chose column to column mean and var then all good
FullData_summary <- FullData_left %>%
  group_by(site.letter) %>%
  summarise_at(vars(E:substrate.cover), mean, var, na.rm = TRUE)
view(FullData_summary)

#can also be var(E:Topt, light:substrate.cover),
##          funs(mean =mean, var, = var), na.rm = TRUE

## another way
Pivot_FullData_summary <- FullData_left %>%
  pivot_longer(cols = E:substrate.cover,                          
               names_to = "Variables",                      
               values_to = "Values")  %>%  
  group_by(site.letter, Variables) %>%               ## need to group by site and parameter/ variables
  summarise(MeanValues = mean(Values, na.rm = TRUE),         
            VarianceValues = var(Values, na.rm = TRUE))   
view(Pivot_FullData_summary)

## another another way
full_data_mean_var <- FullData_left %>%
  group_by(site.letter) %>%
  summarise(across(where(is.numeric),
                  list(mean = mean, var = var), na.rm= TRUE ))
view(full_data_mean_var)

## another another another way
FullData_summarise_if <- FullData_left %>%
  group_by(site.letter) %>%
  select(-site.block) %>%      ## take out site.block 
  summarise_if(is.numeric,
               funs(mean=mean, var = var), na.rm = TRUE)
view(FullData_summarise_if)

### moving on #####
# Make 1 tibble
T1 <- tibble(Site.ID = c("A", "B", "C", "D"), 
             Temperature = c(14.1, 16.7, 15.3, 12.8))
T1

# make another tibble
T2 <-tibble(Site.ID = c("A", "B", "D", "E"), 
            pH = c(7.3, 7.8, 8.1, 7.9))
T2

## Joining with by = join_by(Site.ID)
left_join(T1, T2) ## data lost
right_join(T1, T2) ## data lost
inner_join(T1, T2) ## data deleted if not the same in both data sets
full_join(T1, T2) ## data not lost but have bc data incoomplete together ## this is the same as merge so this is good for me. data not lost

semi_join(T1, T2) ## keeps only the rows from the first data set but only the ones where there are matching in both
anti_join(T1, T2) ##saves all the rows in the first data set that don't match anything in the second data set 
         ## so in this case only T1 C is not like anything else 



install.packages("cowsay")
library(cowsay)
# I want a shark to say hello
say("hello", by = "shark")

say("I want pets", by = "cat")

say("Hi", by = "stegosaurus")
