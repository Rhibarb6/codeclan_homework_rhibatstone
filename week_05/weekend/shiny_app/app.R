# # library(ggplot2)
# # library(dplyr)
# # library(shiny)
# # library(CodeClanData)
# # 
# # game_sales <- game_sales
# # max_score <- max(game_sales$user_score)
# # min_score <- min(game_sales$user_score)
# # 
# # 
# # ui <- fluidPage(
# #   
# #   sliderInput("rating", 
# #               "User rating up to:", 
# #               min = 0, 
# #               max = 10,
# #               value = max_score
# #               
# #   ),
# # 
# #   plotOutput("games_plot")
# # 
# # ) 
# # 
# # 
# # server <- function(input, output) {
# #   
# #   rating_filtered <- reactive({
# #     
# #   game_sales %>% 
# #     filter(user_score <= input$rating)
# # })
# #     
# #   output$games_plot <- renderPlot({
# # 
# #       ggplot() +
# #       geom_point(aes(y = sales, x = rating_filtered()))
# #   })
# # }
# # 
# # 
# # shinyApp(ui = ui, server = server)
# # 
# 
# library(tidyverse)
# library(shiny)
# library(CodeClanData)
# 
# ui <- fluidPage(
#   
#   titlePanel("Game Sales"),
# 
#   tabsetPanel(
#     tabPanel("Graph Style",
#     
#   sidebarLayout(
#     sidebarPanel(
#       radioButtons("colours",
#                    "Colour of points",
#                    choices = c(Blue = "#3891A6", 
#                                Yellow = "#CCCC00", 
#                                Red = "#E3655B")
#       ),
#       
#       sliderInput("transparency",
#                   "Transparency of points", 
#                   min = 0, 
#                   max = 1, 
#                   value = 0.5
#       ),
#       
#       selectInput("shapes",
#                   "Shape of points",
#                   choices = c(Square = 15, Circle = 16, Triangle = 17),
#                   selected = 1
#       ),
#       
#       textInput("titles",
#                 "Title of graph",
#                 "Game Sales by User Rating"
#       )
#     )
#   )
#   tabPanel(
#     mainPanel(
#       plotOutput("scatter_plot")
#     )
#   )
#     )
#   )
# )
# 
# 
# server <- function(input, output) {
#   
#   
#   output$scatter_plot <- renderPlot({
#     
#     game_sales %>% 
#       filter(sales <= 40) %>% 
#       ggplot() +
#       aes(x = user_score, y = sales) +
#       geom_point(shape = as.numeric(input$shapes), 
#                  colour = input$colours, 
#                  alpha = input$transparency) +
#       labs(title = input$titles,
#            x = "Game Score by User",
#            y = "Sales of Game")
#   })
#   
# }
# 
# shinyApp(ui = ui, server = server)

library(ggplot2)
library(dplyr)
library(shiny)
library(CodeClanData)


ui <- fluidPage(
  fluidRow(
    column(4,
           checkboxGroupInput("publisher",
                              "Publisher?",
                              choices = unique(game_sales$publisher))
    ),
    column(4,
           selectInput("year",
                       "Year of Release?",
                       choices = unique(game_sales$year_of_release))
    ),
    column(4,
           actionButton("update", "Update")
    )
  ),
  
  fluidRow(
    column(6,
           plotOutput("sales_barchart")
    ),
    column(6,
           plotOutput("score_barchart")
    )
  )
)

server <- function(input, output) {
  
  filtered_data <- eventReactive(input$update,{
    game_sales %>%
      filter(publisher == input$publisher)
  })
  
  output$sales_barchart <- renderPlot({
    game_sales %>% 
    filter(year_of_release == input$year) %>% 
    ggplot(filtered_data(), cols = "white") +
      geom_bar(aes(x = genre, fill = publisher))
  })
  
  output$score_barchart <- renderPlot({
    ggplot(filtered_data()) +
      geom_bar(aes(x = year_of_release, fill = publisher)) 
  })
}

shinyApp(ui = ui, server = server)
