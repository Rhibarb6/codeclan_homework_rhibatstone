library(tidyverse)
library(readr)
library(janitor)

cancer_incidents_scot <- read_csv("raw_data/opendata_inc9216_scotland.csv") %>% 
  clean_names()
cancer_incidents_region <- read_csv("raw_data/opendata_inc9317_region.csv") %>% 
  clean_names()
cancer_incidents_health_board <- read_csv("raw_data/opendata_inc9317_hb2018.csv") %>% 
  clean_names()
geog_codes <- read_csv("raw_data/geography_codes_and_labels_hb2014_01042019.csv") %>% 
  clean_names()


joined_cancer_incidents_scot <- cancer_incidents_health_board %>% 
  rename(
    hbr,
    hb = hbr
    ) %>% 
  left_join(
    geog_codes, by = "hb"
    ) %>%
  filter(
    hb_name == "Borders"
    ) %>% 
  write_csv("clean_cancer_incidence_data.csv")
  
 
  