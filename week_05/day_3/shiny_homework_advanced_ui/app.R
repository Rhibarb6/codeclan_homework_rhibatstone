library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)
library(shinythemes)

#Link to the additional code .R file
source("helper.R")

#Making the variables used for the drop down lists
seasons <- unique(olympics_overall_medals$season)
teams <- unique(olympics_overall_medals$team)
medals <- unique(olympics_overall_medals$medal)


ui <- fluidPage(
    
    theme = shinytheme("paper"),
    
    titlePanel(tags$h1("Olympic Team Medal Comparison")),
    
    tabsetPanel(
        tabPanel("Slection",
    
            fluidRow(
                
                column(4,
                    selectInput(
                        "season",
                        "Which season?",
                        seasons
                    )
                ),
                
                column(4,
                    selectInput(
                        "medal",
                        "Which medal?",
                        medals
                    )
                ),
            
                column(4,
                    selectInput(
                        "team",
                        "Which team?",
                        teams
                    )
                ),
            ),
        ),
        tabPanel("Plot",
    
            plotOutput("medal_count_plot")
        
        )
    )
)

server <- function(input, output) {
    
    output$medal_count_plot <- renderPlot({
        
        medal_count_plot(input$medal, 
                         input$season, 
                         input$team
        )
    })
}

shinyApp(ui = ui, server = server)

