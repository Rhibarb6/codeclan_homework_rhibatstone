library(tidyverse)
library(readr)
library(treemap)


# Reading in the clean data
cancer_incidents <- read_csv("clean_cancer_incidence_data.csv")


# Variables for Plots -----------------------------------------------------

# A summary of total incidences by year
yearly_cancer_data <- cancer_incidents %>% 
  group_by(
    year
  ) %>%
  mutate(
    yearly_incidences = sum(incidences_all_ages)
  ) %>% 
  select(
    year, cancer_site, yearly_incidences)


# Generalised data frame for all cancer types and all genders
general_data <- cancer_incidents %>% 
  filter(cancer_site == "All cancer types", sex == "All")
  
# Average incidences across all years by cancer type
avg_cancer_incidences <- cancer_incidents %>% 
  group_by(
    cancer_site
  ) %>%
  summarise(
    median_incidences = median(incidences_all_ages)
  ) %>% 
  arrange(
    desc(median_incidences)
  )
