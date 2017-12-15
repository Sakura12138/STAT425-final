library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)
lmod <- lm(housevalue ~ mean_income + population + employment_rate + metro, data = paneldata2)


  function(input,output,session){
    output$mymap <- renderLeaflet({
      leaflet()%>%
        addTiles()%>%
        setView(lng = -89, lat = 40, zoom = 7)
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
            radius <- newdata_price_to_rental[[sizeBy]]/10
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
                radius <- newdata_price_to_rental[[sizeBy]]/10
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
                  radius <- newdata_price_to_rental[[sizeBy]]/10
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
    
    
    
#############page 2
    output$plot <- renderPlot({
      v <- input$variable
      t <- input$time
     if(t == 2012){
        paneldata2 <- subset(paneldata2, subset = paneldata2$year == 2012)
      if(v == "mean_income"){
        ggplot(data = paneldata2, aes(mean_income, housevalue,color = metro,
                                       shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
                                       geom_smooth(model = lm, se = FALSE) +
                                       geom_text(aes(label = county), check_overlap = TRUE)
      }else{
        if(v == "employment_rate"){
          ggplot(data = paneldata2, aes(employment_rate, housevalue,color = metro,
                                       shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
            geom_smooth(model = lm, se = FALSE) +
            geom_text(aes(label = county), check_overlap = TRUE)
        }else{
            ggplot(data = paneldata2, aes(population, housevalue,color = metro,
                                       shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
            geom_smooth(model = lm, se = FALSE) +
            geom_text(aes(label = county), check_overlap = TRUE)
        }
      }
     }else{
       if(t == 2013){
         paneldata2 <- subset(paneldata2, subset = paneldata2$year == 2013)
         if(v == "mean_income"){
           ggplot(data = paneldata2, aes(mean_income, housevalue,color = metro,
                                        shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
             geom_smooth(model = lm, se = FALSE) +
             geom_text(aes(label = county), check_overlap = TRUE)
         }else{
           if(v == "emploment_rate"){
             ggplot(data = paneldata2, aes(emploment, housevalue,color = metro,
                                          shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
               geom_smooth(model = lm, se = FALSE) +
               geom_text(aes(label = county), check_overlap = TRUE)
           }else{
               ggplot(data = paneldata2, aes(population, housevalue,color = metro,
                                            shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
                 geom_smooth(model = lm, se = FALSE) +
                 geom_text(aes(label = county), check_overlap = TRUE)
           }
         }
       }else{
         if(t == 2014){
           paneldata2 <- subset(paneldata2, subset = paneldata2$year == 2014)
           if(v == "mean_income"){
             ggplot(data = paneldata2, aes(mean_income, housevalue,color = metro,
                                          shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
               geom_smooth(model = lm, se = FALSE) +
               geom_text(aes(label = county), check_overlap = TRUE)
           }else{
             if(v == "emploment_rate"){
               ggplot(data = paneldata2, aes(emploment, housevalue,color = metro,
                                            shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
                 geom_smooth(model = lm, se = FALSE) +
                 geom_text(aes(label = county), check_overlap = TRUE)
             }else{
                 ggplot(data = paneldata2, aes(population, housevalue,color = metro,
                                              shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
                   geom_smooth(model = lm, se = FALSE) +
                   geom_text(aes(label = county), check_overlap = TRUE)
             }
           }
         }else{
           if(t == 2015){
             paneldata2 <- subset(paneldata2, subset = paneldata2$year == 2015)
             if(v == "mean_income"){
               ggplot(data = paneldata2, aes(mean_income, housevalue,color = metro,
                                            shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
                 geom_smooth(model = lm, se = FALSE) +
                 geom_text(aes(label = county), check_overlap = TRUE)
             }else{
               if(v == "emploment_rate"){
                 ggplot(data = paneldata2, aes(emploment, housevalue,color = metro,
                                              shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
                   geom_smooth(model = lm, se = FALSE) +
                   geom_text(aes(label = county), check_overlap = TRUE)
               }else{
                   ggplot(data = paneldata2, aes(population, housevalue,color = metro,
                                                shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
                     geom_smooth(model = lm, se = FALSE) +
                     geom_text(aes(label = county), check_overlap = TRUE)
               }
             }
           }else{
             paneldata2 <- subset(paneldata2, subset = paneldata2$year == 2016)
             if(v == "mean_income"){
               ggplot(data = paneldata2, aes(mean_income, housevalue,color = metro,
                                            shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
                 geom_smooth(model = lm, se = FALSE) +
                 geom_text(aes(label = county), check_overlap = TRUE)
             }else{
               if(v == "emploment_rate"){
                 ggplot(data = paneldata2, aes(emploment, housevalue,color = metro,
                                              shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
                   geom_smooth(model = lm, se = FALSE) +
                   geom_text(aes(label = county), check_overlap = TRUE)
               }else{
                   ggplot(data = paneldata2, aes(population, housevalue,color = metro,
                                                shape = as.factor(metro))) + geom_point(alpha = 0.5) + 
                     geom_smooth(model = lm, se = FALSE) +
                     geom_text(aes(label = county), check_overlap = TRUE)
         }
       }
           }
         }
       } 
     }
    })
    
    
    
###########page3
    observeEvent(input$action,{
      output$prediction <- renderPrint({
        mean_income <- input$income
        population <- input$population
        employment_rate <- input$employment_rate
        metro <- input$metro
        sum(lmod$coef*c(1,mean_income,population,employment_rate,as.numeric(metro)))
    
    })
      })
    

    
    
##########page4    
  output$paneldata2 <- DT::renderDataTable({
    paneldata2
  })
  }
