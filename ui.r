library(leaflet)
library(shiny)
#choices for drop downs
vars <- c(
  "Income" = "average_income",
  "Employment Rate" = "employment_rate",
  "population" = "population",
  "Crime Rate" = "crime_rate",
  "House Value" = "value"
)
metro <- c(
  "there is a metro" = 1,
  "there is no metro" = 0,
  "both" = 2
)

navbarPage("House Value in Illinois", 
           
           tabPanel("Interactive map",
                    leafletOutput("mymap"),
                    absolutePanel(fixed = TRUE,
                                  draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                  width = 330, height = "auto",
                    selectInput("metro","is there a metro?", metro),
                    selectInput("color","Color",vars),
                    selectInput("size","Size",vars))),   
           tabPanel("House Value Prediction")
)

