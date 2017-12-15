library(leaflet)
library(shiny)
library(DT)
#choices for drop downs
vars <- c(
  "Income" = "average_income",
  "Employment Rate" = "employment_rate",
  "population" = "population",
  "House Value" = "value"
)
metro <- c(
  "there is a metro" = 1,
  "there is no metro" = 0,
  "both" = 2
)
page2 <- c(
  "Income" = "mean_income",
  "Employment Rate" = "employment_rate",
  "Population" = "population"
)


navbarPage("House Value in Illinois", 
           
           tabPanel("Interactive map",
                    tags$style(type = "text/css","html, body{width:100%;height:100%}"),
                    leafletOutput("mymap", width = "100%", height = 600),
                    absolutePanel(fixed = TRUE,
                                  draggable = TRUE, top = 60, left = "auto",
                                  right = 20, bottom = "auto",
                                  width = 330, height = "auto",
                    selectInput("metro","is there a metro?", metro),
                    selectInput("color","Color",vars),
                    selectInput("size","Size",vars))),
           tabPanel("PanelData",
                    plotOutput("plot"),
                    selectInput("variable", "Variable", page2),
                    sliderInput("time", "year", value = 2012, min = 2012, max = 2016)
                    ),
           tabPanel("House Value Prediction",
                    numericInput("income", "Income", value = NULL),
                    numericInput("population", "population", value = NULL),
                    numericInput("employment_rate", "employment", value = NULL),
                    numericInput("metro", "Is it a metro?", value = NULL, min = 0, max = 1, step = 1),
                    actionButton("action", "Get House Value"),
                    verbatimTextOutput("prediction")
                 ),
           tabPanel("Data",
                    DT::dataTableOutput("paneldata2"))
           
)

