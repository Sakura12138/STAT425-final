library(shiny)
library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)



  function(input,output,session){
    output$mymap <- renderLeaflet({
      leaflet()%>%
        addTiles()%>%
        setView(lng = -89, lat = 40, zoom = 10)
    })
    observe({
      colorBy <- input$color
      sizeBy <- input$size
    colorData <- newdata[[colorBy]]
    pal <- colorBin("viridis",colorData,5,pretty = FALSE)
    if(sizeBy == "income"){
      radius <- newdata[[sizeBy]]/4000
    }else{
      if(sizeBy == "employment_rate"){
        radius <- (newdata[[sizeBy]]/newdata$population)*29000
      }else{
        if(sizeBy == "population"){
          radius <- newdata[[sizeBy]]/100
        }else{
            radius <- newdata[[sizeBy]]*10
          }
        }
      }
    leafletProxy("mymap", data = newdata)%>%
      clearShapes()%>%
      addCircles(~long,~lat,radius = radius, fillOpacity = 0.4,
                 fillColor = pal(colorData), stroke = FALSE)%>%
      addLegend("bottomleft", pal =pal, values = colorData, title = colorBy)
    })
  }


