
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyServer(function(input, output) {
   
  load("data/datReg.RData")
  load("data/datFedDist.RData")
  
  output$dat1 <- renderPrint({
    head(datReg)
  })
  
  output$dat2 <- renderPrint({
    head(datFedDist)
  })
  
})
