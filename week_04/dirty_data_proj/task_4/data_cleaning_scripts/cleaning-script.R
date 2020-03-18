library(tidyverse)
library(janitor)
library(readxl)

candy_2015 <- read_excel("candy_ranking_data/boing-boing-candy-2015.xlsx")
candy_2016 <- read_excel("candy_ranking_data/boing-boing-candy-2016.xlsx")
candy_2017 <- read_excel("candy_ranking_data/boing-boing-candy-2017.xlsx")


candy_2015_clean <- candy_2015 %>% 
  pivot_longer(
    cols = starts_with("["), 
    names_to = "candy",
    values_to = "response"
    ) %>% 
  separate(
    Timestamp, 
    c("date", "time"), 
    sep = " "
    ) %>%
  clean_names() %>% 
  select(date, time, how_old_are_you, candy, response)

##2016
candy_2015_clean <- candy_2015 %>% 
  pivot_longer(
    cols = starts_with("["), 
    names_to = "candy",
    values_to = "response"
  ) %>% 
  separate(
    Timestamp, 
    c("date", "time"), 
    sep = " "
  ) %>%
  clean_names() %>% 
  select(date, time, age, candy, response)


dim(candy_2016)
dim(candy_2017)
names(candy_2016)
names(candy_2017)