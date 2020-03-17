library(tidyverse)
library(here)
library(janitor)

cake_1961 <- read_csv(here("raw_data/cake/cake-ingredients-1961.csv"))
cake_code <- read_csv(here("raw_data/cake/cake_ingredient_code.csv"))

cakes_cleaned <- cake_1961 %>% 
  pivot_longer(AE:ZH, 
               names_to = "code", 
               values_to = "amount",
               values_drop_na = TRUE,
               ) %>% 
  left_join(cake_code, "code") %>% 
  select(-code)

cakes_cleaned <- cakes_cleaned %>% clean_names() 

cakes_cleaned %>% 
write_csv("clean_data/cakes_clean.csv")  

  

