
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

# Define UI for dataset viewer application
shinyUI(#fluidPage(theme = "bootstrap_spacelab.css",
                  
#                   title = "Correlation gadget on Quality of Govenment data",
#                   
#                   tabsetPanel(
#                     tabPanel("Aluetaso", plotOutput("plot_reg", height="650px", width="100%")),
#                     tabPanel("Federaatiopiirit", plotOutput("plot_fd", height="650px", width="100%")),
#                     tabPanel("Aluetaso viivat", plotOutput("plot_reg_line", height="650px", width="100%")),
#                     tabPanel("FP viivat", plotOutput("plot_fd_line", height="650px", width="100%"))
#                   ),
                  
                  navbarPage("Venäjän aluedata",
                             tabPanel("Ohjeet",
                                      ("1. valitse yläreunan valikosta tarkastelun taso (federaatiopiirit/alueet)"),
                                      br(),
                                      ("2. valitse viiva- tai karttakuvio"),
                                      br(),
                                      ("3. valitse haluamasi indikaattori"),
                                      br(),
                                      ("halutessasi voit tallentaa kuvan koneelle alareunan painikkeista")),
                             navbarMenu("Federaatiopiirit",
                                        tabPanel("Viivat", plotOutput("plot_fd_line", height="650px", width="100%")),
                                        tabPanel("Kartta", plotOutput("plot_fd", height="650px", width="100%"))),
                             navbarMenu("Alueet",
                                        tabPanel("Viivat", plotOutput("plot_reg_line", height="650px", width="100%")),
                                        tabPanel("Kartta", plotOutput("plot_reg", height="650px", width="100%"))),
                                     hr(),
        fluidRow(
                column(3,
                 h4("Muokkaa kuviota"),
                 selectInput("indicator", "Valitse indikaattori:", 
                             choices = c("keskipalkka","keskitulo","keskimääräinen eläke",
                                         "syntyvyys","bruttokansantuote aluetasolla","imeväiskuolleisuus",
                                         #"eliniänodote",
                                         "eliniänodote miehillä","eliniänodote keskimäärin",
                                         "eliniänodote naisilla","kuolleisuus","teatterikäyntejä per 1000 ihmistä",
                                         "museokäyntejä per 1000 ihmistä","urheilupaikkoja","maaseutuväestön määrä",
                                         "väestömäärä","kaupunkiväestön määrä","sanomalehtiä per 1000 ihmistä",
                                         "urheiluhalleja","urheilustadioneita","uima-altaita")),
                 br(),
                 selectInput("year", "Valitse vuosi (vaikuttaa vain karttoihin):", 
                             choices = c("2010","2011","2010","2009","2008",
                                         "2007","2006","2005","2004",
                                         "2003","2002","2001","2000",
                                         "1995","1990","1989")),
                 hr()
                 ),
          column(6,
                 h4("Tallenna kuvat"),
                 h5("Federaatiopiirit"),
                 downloadButton('downloadPlot_fd', 'Lataa kartta'),
                 downloadButton('downloadPlot_fd_line', 'Lataa viivakuvio'),
                 h5("Alueet"),
                 downloadButton('downloadPlot_reg', 'Lataa kartta'),
                 downloadButton('downloadPlot_reg_line', 'Lataa viivakuvio')
                 ),
                column(3,
                       h4("Lisenssi"),
                       helpText(HTML("<a rel=\"license\" href=\"http://creativecommons.org/licenses/by/4.0/\">
                                           <img alt=\"Creative Commons License\" style=\"border-width:0\" 
                                           src=\"http://i.creativecommons.org/l/by/4.0/80x15.png\" />
                                           </a><br />This work is licensed under a <a rel=\"license\" 
                                           href=\"http://creativecommons.org/licenses/by/4.0/\">
                                           Creative Commons Attribution 4.0 International License</a>.")),
                       h4("Lähdekoodi"),
                       helpText(HTML("<ul>
                                           <li>@ <a href=\"https://github.com/muuankarski/QogCorr\"><strong>GitHub</strong></a></li>
                                           </ul>"))
                )
                 )
        
        ))