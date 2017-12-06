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
      metroBy <- input$metro
    if(metroBy == 1){
    newdata_price_to_rental <- subset(newdata_price_to_rental, subset = newdata_price_to_rental$metro == 1)    
    colorData <- newdata_price_to_rental[[colorBy]]
    pal <- colorBin("viridis",colorData,5,pretty = FALSE)
    if(sizeBy == "average_income"){
      radius <- newdata_price_to_rental[[sizeBy]]/5
    }else{
      if(sizeBy == "employment_rate"){
        radius <- newdata_price_to_rental[[sizeBy]]*20000
      }else{
        if(sizeBy == "population"){
          radius <- newdata_price_to_rental[[sizeBy]]/100
        }else{
          if(sizeBy == "value"){
            radius <- newdata_price_to_rental[[sizeBy]]
          }else{
            radius <- newdata_price_to_rental[[sizeBy]]*5000000
          }
        }
      }
    }
    }else{
      if(metroBy == 0){
        newdata_price_to_rental <- subset(newdata_price_to_rental, subset = newdata_price_to_rental$metro == 0)    
        colorData <- newdata_price_to_rental[[colorBy]]
        pal <- colorBin("viridis",colorData,5,pretty = FALSE)
        if(sizeBy == "average_income"){
          radius <- newdata_price_to_rental[[sizeBy]]/5
        }else{
          if(sizeBy == "employment_rate"){
            radius <- newdata_price_to_rental[[sizeBy]]*20000
          }else{
            if(sizeBy == "population"){
              radius <- newdata_price_to_rental[[sizeBy]]/100
            }else{
              if(sizeBy == "value"){
                radius <- newdata_price_to_rental[[sizeBy]]
              }else{
                radius <- newdata_price_to_rental[[sizeBy]]*5000000
              }
            }
          }
        }
      }else{
        if(metroBy == 2){
          colorData <- newdata_price_to_rental[[colorBy]]/5
          pal <- colorBin("viridis",colorData,5,pretty = FALSE)
          if(sizeBy == "average_income"){
            radius <- newdata_price_to_rental[[sizeBy]]
          }else{
            if(sizeBy == "employment_rate"){
              radius <- newdata_price_to_rental[[sizeBy]]*20000
            }else{
              if(sizeBy == "population"){
                radius <- newdata_price_to_rental[[sizeBy]]/100
              }else{
                if(sizeBy == "value"){
                  radius <- newdata_price_to_rental[[sizeBy]]
                }else{
                  radius <- newdata_price_to_rental[[sizeBy]]*5000000
                }
              }
            }
          }
        }
      }
    }
    leafletProxy("mymap", data = newdata_price_to_rental)%>%
      clearShapes()%>%
      addCircles(~long,~lat,radius = radius, fillOpacity = 0.4,
                 fillColor = pal(colorData), stroke = FALSE)%>%
      addLegend("bottomleft", pal = pal, values = colorData, title = colorBy,layerId = "colorLegend")
    })
  }


