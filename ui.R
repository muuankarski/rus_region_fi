
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(theme = "bootstrap_spacelab.css",
                  
                  title = "Correlation gadget on Quality of Govenment data",
                  
                  tabsetPanel(
                    tabPanel("dat1", verbatimTextOutput("dat1")),
                    tabPanel("dat1", verbatimTextOutput("dat2"))
                  )
))
