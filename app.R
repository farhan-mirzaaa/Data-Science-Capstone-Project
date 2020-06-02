#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

source("Scripts\\PredictNextWords.R")

ui <- fluidPage(

    
    titlePanel("Data Science Capstone Coursera Swiftkey Project"),
    h4("Muhammad Farhan Mirza"),
    p("This app takes an input from user and predicts possible next words..."),
    
    hr(),
    hr(),
    hr(),
    
    mainPanel(
             textInput("userInput", h4("Please enter text here:"), width = 1000),
                         h4("Predicted next words:"),
                         h4(em(span(textOutput("predictedNextWords"), style="color:black")))),
            
        
    
)

server <- function(input, output) {

    output$predictedNextWords <- renderText({
        PredictNextWords(input$userInput)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
