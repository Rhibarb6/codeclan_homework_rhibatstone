# Librarys
library(tidyverse)
library(janitor)
library(readxl)

# 2015
candy_2015_clean <- read_excel("candy_ranking_data/boing-boing-candy-2015.xlsx"
    ) %>% 
  #Pivoting to combine candy into one column
  pivot_longer(
    cols = starts_with("["), 
    names_to = "candy",
    values_to = "response"
    ) %>% 
  #separating time stamp to separate into date and time cols
  separate(
    Timestamp, 
    c("date", "time"), 
    sep = " "
    ) %>%
  #cleaning column names to snake case
  clean_names() %>% 
  #renaming complicated column names
  rename(age = how_old_are_you,
         going_out = are_you_going_actually_going_trick_or_treating_yourself
         ) %>% 
  #selecting to drop unecessary columns
  select(date, time, age, candy, response, going_out)


# 2016
candy_2016_clean <- read_excel("candy_ranking_data/boing-boing-candy-2016.xlsx"
    ) %>% 
  #Pivoting to combine candy into one column
  pivot_longer(
    cols = starts_with("["), 
    names_to = "candy",
    values_to = "response"
    ) %>% 
  #separating time stamp to separate into date and time cols
  separate(
    Timestamp, 
    c("date", "time"), 
    sep = " "
    ) %>%
  #cleaning column names to snake case
  clean_names() %>% 
  #renaming complicated column names
  rename(
    age = how_old_are_you, 
    gender = your_gender, 
    country_unclean = which_country_do_you_live_in,
    going_t_or_t = are_you_going_actually_going_trick_or_treating_yourself
    ) %>% 
  #selecting to drop unecessary columns
  select(date, time, age, gender, country_unclean, candy, response, going_t_or_t)

# 2017

candy_2017_clean <- read_excel("candy_ranking_data/boing-boing-candy-2017.xlsx"
    ) %>%
  #Pivoting to combine candy into one column
  pivot_longer(
    cols = starts_with("Q6"),
    names_to = "candy",
    values_to = "response"
    ) %>% 
  #cleaning column names to snake case
  clean_names() %>%
  #renaming complicated column names
  rename(
    age = q3_age,
    gender = q2_gender,
    country_unclean = q4_country,
    going_t_or_t = q1_going_out
    ) %>% 
  #selecting to drop unecessary columns
  select(age, gender, country_unclean, candy, response, going_t_or_t)

# Binding table rows 
clean_candy <- bind_rows(candy_2015_clean, candy_2016_clean, candy_2017_clean)

# Writing to CSV
write_csv(clean_candy, "clean_data/candy_clean.csv")



##---------------------------- AGE -----------------------------------
# cleaning up age data
# clean_candy <- clean_candy[!is.na(as.numeric(as.character(clean_candy$age))),]

# clean_candy <- clean_candy %>% 
#   filter(!is.na(as.numeric(as.character(clean_candy$age))

# is.numeric(clean_candy$age)

# clean_candy$country_unclean <- tolower(clean_candy$country_unclean)

# unique(clean_candy$age)




##---------------------------- COUNTRY --------------------------------
countries <- unique(clean_candy$country_unclean)

countries_test <- str_replace_all(countries, pattern = "[:punct:]|\\`|\\.|[[0-9]+]", replacement = "")
countries_test <- str_replace_all(countries_test, pattern = "españa", replacement = "spain")
countries_test <- str_replace_all(countries_test, pattern = "^[a-s]$|atlantis|narnia|a tropical (.*)|neverland|cascadia|subscribe(.*)|fear (.*)|i dont (.*)|soviet (.*)|insanity (.*)|earth|europe|denial|this one|not the usa (.*)|somewhere|one of (.*)|there isnt (.*)", replacement = "")
countries_test
#
#
# countries_test_usa <- str_replace(countries_test, pattern = "united st(.*)|u s a|(usa ){2}(.*)|^(.*?)america(.*)", replacement = "usa")
# countries_test_usa
# unique(countries_test_usa)
#
# # countries_test_a <- str_replace_all(countries_test,
# #                                   pattern = "^[usa ](.*)", replacement = "####################################")
# # countries_test_a
#
# unique(clean_candy$gender)
#
# candy_clean_test <- gsub("\\[", "", as.character(clean_candy$candy) n)
#
# candy_clean_test <- clean_candy %>%
#   gsub("\\[", "", candy)
#
#
