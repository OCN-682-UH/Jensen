#### Week 5b Lecture Practice
### Created by Kassandra Jensen on 2024-09-26
### 

library(tidyverse)
library(here)
library(lubridate)

## get time now and can add timezone
now()
now(tzone = "HST")

## get today and can add timezone
today()
today(tzone = "GMT")

am(now()) # is it morning?
leap_year(now()) # is it a leap year?

## Dates must be a character

ymd("2021-02-24")
mdy("02/24/2021")
mdy("February 24 2021")
ymd("02-12-24")

## Can make it convert to differnt date formats
ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:20")
mdy_hm("February 24 2021 10:22 PM")

## Let's make a vector of dates
# make a character string
## Must be the same formats
datetimes<-c("02/24/2021 22:22:20",
             "02/25/2021 11:21:10",
             "02/26/2021 8:01:52")
# convert to datetimes
datetimes <- mdy_hms(datetimes) 
month(datetimes, label = TRUE)
month(datetimes, label = TRUE, abbr = FALSE) ## spell it out

### make a vector of dates and covert them to datetimes. Extract the months from the character string.
# make a character string
datetimes<-c("02/24/2021 22:22:20", 
             "02/25/2021 11:21:10", 
             "02/26/2021 8:01:52") 
# convert to datetimes
datetimes <- mdy_hms(datetimes) 
month(datetimes)

###make a vector of dates and covert them to datetimes. 
## Extract the months from the character string. You can also save it as the month name.
datetimes<-c("02/24/2021 22:22:20", 
             "02/25/2021 11:21:10", 
             "02/26/2021 8:01:52") 
# convert to datetimes
datetimes <- mdy_hms(datetimes) 
month(datetimes, label = TRUE)

## make a vector of dates and covert them to datetimes. Extract the days.
datetimes<-c("02/24/2021 22:22:20", 
             "02/25/2021 11:21:10", 
             "02/26/2021 8:01:52") 
# convert to datetimes
datetimes <- mdy_hms(datetimes) 
month(datetimes, label = TRUE, abbr = FALSE) #Spell it out
day(datetimes) # extract day     ##Extract hour, minute, second.
wday(datetimes, label = TRUE) # extract day of week

### hour() vs hours() : hour() extracts hour data; hours() allows you to add time
## this goes for seconds, days, minutes, etc

## adding time (maybe bc the time zones are different or something)
datetimes + hours(4) # this adds 4 hours
datetimes + days(2) # this adds 2 days

#rounding to nearest time
round_date(datetimes, "minute") # round to nearest minute
round_date(datetimes, "5 mins") # round to nearest 5 minute


### Challenge in class:
### Read in the conductivity data (CondData.csv) and convert the date column to a datetime. 
### Use the %>% to keep everything clean.

### This is temperature and salinity data taken at a site with groundwater 
### while being dragged behind a float. Data were collected every 10 seconds. 
### You will also notice depth data. That dataset will be used later during homework. 
### Those data are taken from a pressure sensor, also collected data every 10 seconds.

### Hint: Always look at your data in R after you read it in. 
### Don't trust what the excel format looks like... 
### There may be some seconds hiding, but excel only wants to show you the minutes. 
### Also sometimes excel gets it right and says it's a date and other times it doesn't. 
### Check to see if it's reading in as a character or date already or something 
### totally different (in which case you need to make it a character in R)

#### Load Libraries ######
library(tidyverse)
library(here)
library(lubridate)

Cond_Data <- read_csv(here("Week05","Data", "CondData.csv"))
view(Cond_Data)

Cond_Data_clean <- Cond_Data %>%
  mutate(date = mdy_hms(date))
 view(Cond_Data_clean)
 