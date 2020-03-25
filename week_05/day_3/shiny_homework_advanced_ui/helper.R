library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)


medal_count_plot <- function(my_medal, my_season, my_team){
  
olympics_overall_medals %>%
  filter(medal == my_medal) %>%
  filter(season == my_season) %>%
  filter(team == my_team) %>%
  ggplot() +
  aes(team, count, fill = medal) +
  geom_col() +
  scale_fill_manual(
    values = c(
      "Gold" = "#DAA520",
      "Silver" = "#C0C0C0",
      "Bronze" = "#CD7F32"
    )
  )
}