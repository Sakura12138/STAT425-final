library(leaflet)
library(shiny)
#choices for drop downs
vars <- c(
  "Income" = "income",
  "Employment Rate" = "employment_rate",
  "population" = "population",
  "Crime Rate" = "crime"
)

navbarPage("House Value in Illinois", 
           
           tabPanel("Interactive map",
                    leafletOutput("mymap"),
                    selectInput("color","Color",vars),
                    selectInput("size","Size",vars)),   
           tabPanel("House Value Prediction")
)

