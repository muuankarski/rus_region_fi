
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
                    tabPanel("Aluetaso", plotOutput("plot_reg", height="650px", width="100%")),
                    tabPanel("Federaatiopiirit", plotOutput("plot_fd", height="650px", width="100%"))
                  ),
        hr(),
        fluidRow(
          column(3,
                 h4("Karttahärveli Venäjän alueista")
                ),
          column(4, offset = 1,
                 h4("Muokkaa kuviota"),
                 selectInput("indicator", "Valitse indikaattori:", 
                             choices = c("keskipalkka","keskitulo","keskimääräinen eläke",
                                         "syntyvyys","bruttokansantuote aluetasolla","imeväiskuolleisuus",
                                         "eliniänodote","eliniänodote miehillä","eliniänodote keskimäärin",
                                         "eliniänodote naisilla","kuolleisuus","teatterikäyntejä per 1000 ihmistä",
                                         "museokäyntejä per 1000 ihmistä","urheilupaikkoja","maaseutuväestön määrä",
                                         "väestömäärä","kaupunkiväestön määrä","sanomalehtiä per 1000 ihmistä",
                                         "urheiluhalleja","urheilustadioneita","uima-altaita")),
                 br(),
                 selectInput("year", "Valitse vuosi:", 
                             choices = c("2010","2011","2010","2009","2008",
                                         "2007","2006","2005","2004",
                                         "2003","2002","2001","2000",
                                         "1995","1990","1989")),
                 hr()
                 ),
          column(3,
                 h4("Tallenna kartat"),
                 downloadButton('downloadPlot_reg', 'Lataa aluetason kartta'),
                 downloadButton('downloadPlot_fd', 'Lataa fed.piiritason kartta')
                 )
                 )
        
        ))