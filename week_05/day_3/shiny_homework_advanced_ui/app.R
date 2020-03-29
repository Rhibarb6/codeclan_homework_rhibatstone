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
    #Choosing a theme
    theme = shinytheme("flatly"),
    
    #Page title
    titlePanel(tags$h1("Olympic Team Medal Comparison")),
    
    
    tabsetPanel(
        # Tab 1 - the selection options
        tabPanel("Slection",
    
            fluidRow(
                
                column(4,
                    selectInput(
                        "season",
                        tags$h3(tags$b(tags$i("Which season?"))),
                        seasons
                    )
                ),
                
                column(4,
                    selectInput(
                        "medal",
                        tags$h3(tags$b(tags$i("Which medal?"))),
                        medals
                    )
                ),
            
                column(4,
                    checkboxGroupInput(
                        "team",
                        tags$h3(tags$b(tags$i("Which team?"))),
                        teams
                    )
                ),
            ),
        ),
        # Tab 2 - the plot output
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

