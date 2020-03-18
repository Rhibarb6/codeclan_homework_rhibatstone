library(tidyverse)
library(janitor)
library(readxl)


candy_2015_clean <- read_excel("candy_ranking_data/boing-boing-candy-2015.xlsx"
    ) %>% 
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
  rename(age = how_old_are_you) %>% 
  select(date, time, age, candy, response)

##2016
candy_2016_clean <- read_excel("candy_ranking_data/boing-boing-candy-2016.xlsx"
    ) %>% 
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
  rename(
    age = how_old_are_you, 
    gender = your_gender, 
    country = which_country_do_you_live_in
    ) %>% 
  select(date, time, age, gender, country, candy, response)

## 2017

candy_2017_clean <- read_excel("candy_ranking_data/boing-boing-candy-2017.xlsx"
    ) %>%
  pivot_longer(
    cols = starts_with("Q6"),
    names_to = "candy",
    values_to = "response"
    ) %>% 
  clean_names() %>%
  rename(
    age = q3_age,
    gender = q2_gender,
    country = q4_country
    ) %>% 
  select(internal_id, age, gender, country, candy, response)

candy_clean <- bind_rows(candy_2015_clean, candy_2016_clean, candy_2017_clean)







