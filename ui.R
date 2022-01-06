# Shiny Demo
# This is a relatively simple Shiny app designed to demonstrate how to use Shiny


# Still in progress





# https://stackoverflow.com/questions/20952333/constrain-multiple-sliderinput-in-shiny-to-sum-to-100
# https://stackoverflow.com/questions/38372906/constrain-two-sliderinput-in-shiny-to-sum-to-100

library(tidyverse)
library(shinythemes)
library(shinydashboard)

shinyUI(fluidPage(theme = shinytheme("sandstone"),
                  navbarPage("Modeling Alaska RCV Outcomes", 
                             tabPanel("Modeling",
                                      sidebarLayout(
                                        sidebarPanel(
                                          tags$head(tags$style(HTML("hr {border-top: 1px solid #b3b3b3;}"))), # optional. sets color/width of horiz line in hr()  
                                          h2("Set up some options:"),
                                          hr(), # we defined this style up above in tags$head
                                          
                                          conditionalPanel(condition = "input.tabs == 'Show Outcome!'",
                                                           checkboxInput("showoutliers", "Highlight outliers?", value = FALSE) ),
                                          conditionalPanel(condition = "input.tabs == 'Set Up Demographics'",
                                                           p("Define Alaska's electorate"),
                                                           numericInput("cons", "% Firmly Conservative:", value=35, min = 20, max = 45),
                                                           numericInput("indp", "% True Independents:", value=40, min = 10, max = 50),
                                                           numericInput("libs", "% Firmly Progressive:", value=25, min = 15, max = 40),
                                                           textOutput("sumcheck")),
                                          hr(),
                                          conditionalPanel(condition = "input.tabs == 'Set Up Demographics'",
                                                           p("Define Alaska's electorate"),
                                                           sliderInput("spreadcons", "spread", value=35, min = 20, max = 45)),
                                          hr()
                                        ), # end sidebar panel

                                        
                                        mainPanel(
                                          tabsetPanel(
                                            tabPanel("Set Up Demographics",
                                                     h2("Make some choices about Alaska's demographics"),
                                                     plotOutput("currentdemography"),
                                                     textOutput("percdemoc"),
                                                     actionButton('switchtab', 'Show Results')),
                                            tabPanel("Define Candidates", plotOutput("____")),
                                            tabPanel("Show Outcome!", plotOutput("outlierplot")),
                                            id="tabs"
                                          )
                                        ) # end main panel of charts tab
                                        
                                      )
                             ),#end modeling tab
                             
                             tabPanel("RCV Background", h1("Summary of Results"),
                                      h2("Background info on RCV")), #end summary tabpanel
            
                             tabPanel("About", h3("About this application:"),
                                      h4("Enter some interesting info here."), br(),
                                      p("If you have questions or comments, contact Justin Priest,
                             @justintpriest on Twitter"),
                                      br(),
                                      p("Application version 0.1")) #end about tabpanel
                             )
                  )
        )