
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyServer(function(input, output) {
  
  
  variableInputIndicator <- reactive({
    switch(input$indicator,
           "keskipalkka" = "average_nominal_monthly_salary" ,
           "keskitulo" = "average_percapita_income" ,
           "keskimääräinen eläke" = "average_size_of_pensions" ,
           "syntyvyys" = "crude_birth_rate" ,
           "bruttokansantuote aluetasolla" = "gross_regional_product" ,
           "imeväiskuolleisuus" = "infant_mortality_rate" ,
           "eliniänodote" = "life_expectancy" ,
           "eliniänodote miehillä" = "life_expectancy_men" ,
           "eliniänodote keskimäärin" = "life_expectancy_total" ,
           "eliniänodote naisilla" = "life_expectancy_women" ,
           "kuolleisuus" = "mortality_rate" ,
           "teatterikäyntejä per 1000 ihmistä" = "number_of_theater_goers_per_1000_population" ,
           "museokäyntejä per 1000 ihmistä" = "number_of_visits_to_museums_per_1000_population" ,
           "urheilupaikkoja" = "planar_sports_facilities_(playgrounds_and_fields)" ,
           "maaseutuväestön määrä" = "population_rural" ,
           "väestömäärä" = "population_total" ,
            "kaupunkiväestön määrä" = "population_urban" ,
            "sanomalehtiä per 1000 ihmistä" = "publication_of_newspapers_per_1000_people" ,
            "urheiluhalleja" = "sports_halls" ,
            "urheilustadioneita" = "stadiums_with_stands_for_1500_seats_or_more" ,
            "uima-altaita" = "swimming_pools")
  })
  
  
datasetInput_reg <- reactive(function() {
#     load("data/datReg.RData")
#     load("data/datFedDist.RData")
    load("data/tab_geo_reg.RData")
    plotDat <- tab_geo_reg[tab_geo_reg$indicator == variableInputIndicator(),]
    plotDat <- plotDat[plotDat$year == input$year,]
    plotDat <- plotDat[order(plotDat$order),]
#    load("data/tab_geo_fd.RData")
  })

datasetInput_fd <- reactive(function() {
  load("data/tab_geo_fd.RData")
  plotDat <- tab_geo_fd[tab_geo_fd$indicator == variableInputIndicator(),]
  plotDat <- plotDat[plotDat$year == input$year,]
  plotDat <- plotDat[order(plotDat$order),]
})

  
  plotInput_reg <- reactive(function() {
    plotDat <- datasetInput_reg()
    cnames <- stats:::aggregate.formula(cbind(long, lat) ~ region_en, data=plotDat, mean)
        library(ggplot2)
    # subset data for highlighiting Russia
    ggplot(plotDat, aes(long,lat,group=group)) +
      geom_polygon(aes(fill = value)) +
      geom_polygon(data = plotDat, aes(long,lat), fill=NA, color = "white") + # white borders
      geom_text(data=cnames, aes(long, lat, label = region_en, group=region_en), size=3, color="black") +
      coord_map(project="orthographic", xlim=c(25,190),
                ylim=c(45,70))  + # projection
      labs(title=paste(input$indicator," vuonna ",input$year,sep="")) +
      theme(legend.position="top")
    
  })
  
  output$plot_reg <- reactivePlot(function() {
    print(plotInput_reg())
  })
  
  plotInput_fd <- reactive(function() {
    
    plotDat <- datasetInput_fd()
    cnames <- stats:::aggregate.formula(cbind(long, lat) ~ region_en, data=plotDat, mean)
    library(ggplot2)
    ggplot(plotDat, aes(long,lat,group=group)) +
      geom_polygon(aes(fill = value)) +
      geom_polygon(data = plotDat, aes(long,lat), fill=NA, color = "white") + # white borders
      geom_text(data=cnames, aes(long, lat, label = region_en, group=region_en), size=4, color="black") +
      coord_map(project="orthographic", xlim=c(25,190),
                ylim=c(45,70))  + # projection
      labs(title=paste(input$indicator," vuonna ",input$year,sep="")) +
      theme(legend.position="top")
    
  })
  
  output$plot_fd <- reactivePlot(function() {
    print(plotInput_fd())
  })

output$downloadPlot_reg <- downloadHandler(
  filename = function() { paste("indicator_",input$indicator,"_year_",input$year,Sys.time(),'.png', sep='') },
  content = function(file) {
    png(file, width=1600, height=1600,res=72)
    print(plotInput_reg())
    dev.off()
  })

output$downloadPlot_fd <- downloadHandler(
  filename = function() { paste("indicator_",input$indicator,"_year_",input$year,Sys.time(),'.png', sep='') },
  content = function(file) {
    png(file, width=1600, height=1600,res=72)
    print(plotInput_fd())
    dev.off()
  })
})
