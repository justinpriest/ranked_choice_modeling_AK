# Shiny Demo
# This is a relatively simple Shiny app designed to demonstrate how to use Shiny


# Still in progress





# https://stackoverflow.com/questions/20952333/constrain-multiple-sliderinput-in-shiny-to-sum-to-100
# https://stackoverflow.com/questions/38372906/constrain-two-sliderinput-in-shiny-to-sum-to-100

library(tidyverse)
library(shinythemes)
library(shinydashboard)

shinyUI(fluidPage(theme = shinytheme("sandstone"),
                  navbarPage("This is my project's title", 
                             tabPanel("Modeling",
                                      sidebarLayout(
                                        sidebarPanel(
                                          tags$head(tags$style(HTML("hr {border-top: 1px solid #b3b3b3;}"))), # optional. sets color/width of horiz line in hr()  
                                          h2("Set up some options:"),
                                          hr(), # we defined this style up above in tags$head
                                          # I use conditional panels here in the sidebar
                                          conditionalPanel(condition = "input.tabs == 'Set Up Demographics' ",
                                                           selectInput("sppchoice", label = h3("Select species"), 
                                                                       choices = list("Sockeye Salmon" = "Sockeye",  "Coho Salmon" = "Coho", 
                                                                                      selected = "Coho")),
                                                           selectInput("maturitysel", "Choose maturity:", 
                                                                       choices = list("All" = "All", "Jack only" = "Jack", "Adult only" = "Adult"), 
                                                                       selected = c("All")),
                                                           hr(), # we defined this style up above in tags$head
                                                           p("this is text")),
                                          
                                          conditionalPanel(condition = "input.tabs == 'Show Outcome!'",
                                                           checkboxInput("showoutliers", "Highlight outliers?", value = FALSE) ),
                                        ), # end sidebar panel
                                        
                                        
                                        
                                        mainPanel(
                                          tabsetPanel(
                                            tabPanel("Set Up Demographics",
                                                     h2("Make some choices about Alaska's demographics"),
                                                     plotOutput("currentdemography"),
                                                     actionButton('switchtab', 'Switch tab')),
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