## Library's
library(tidyverse)
library(janitor)


## Reading in the decathalon data 
decathalon <- read_rds("raw_data/decathlon.rds")

## Removing row names and replacing them as a column called "surnames" 
## then cleaning the column names 
## then chanign surnames to lowercase
## ten combines the type of sport
decathalon <- decathalon %>% 
  rownames_to_column(var = "surnames") %>%
  clean_names() %>% 
  mutate(surnames = tolower(surnames)) %>% 
  pivot_longer(x100m:x1500m, "type")

# saving as cleaned data as a new .CSV
decathalon %>% 
  write_csv("clean_data/decathalon_cleaned")

