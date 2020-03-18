## Library's
library(tidyverse)
library(here)
library(janitor)
library(readxl)

# Read in the data
bird_data <- read_excel(here("raw_data/seabirds.xls"), sheet = "Bird data by record ID")
ship_data <- read_excel(here("raw_data/seabirds.xls"), sheet = "Ship data by record ID")

# Clean up the column names
bird_data <- clean_names(bird_data)
ship_data <- clean_names(ship_data)

# Selecting only the necessary columns
bird_data <- bird_data %>% 
  select(record_id, 
         species_common_name_taxon_age_sex_plumage_phase, 
         species_scientific_name_taxon_age_sex_plumage_phase, species_abbreviation,
         count)

ship_data <- ship_data %>% 
  select(record_id, 
         date, 
         time, 
         lat, 
         long)

# Joining the ship & bird tables
ship_and_bird_data <- bird_data %>% 
  left_join(ship_data, by = "record_id")

# Writing to CSV into clean data folder
ship_and_bird_data %>%
  write_csv("clean_data/bird_data_clean")





