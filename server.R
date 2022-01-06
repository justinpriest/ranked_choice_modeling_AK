# Modified off the "shiny skeleton" template I made



shinyServer(
  # Function takes input from ui.R and returns output objects.
  function(input, output, session) {
    
    # Code to switch tabs
    observeEvent(input$switchtab, {
      newtab <- switch(input$tabs, "Set Up Demographics" = "Show Outcome!","Show Outcome!" = "Set Up Demographics")
      updateTabItems(session, "tabs", newtab)
    })
    
    
    
    
    # DEFINE THE ELECTORATE
    
    # Simulate proportions among groups
    props <- c(0.35, 0.4, 0.25) # right, middle, left

    rright <- rbeta(10000 * props[1], 3, 10) # the right
    rmid <- rbeta(10000 * props[2], 4.8, 5)  # the middle (skewing slightly right)
    rleft <- rbeta(10000 * props[3], 17, 10) # the left

    hist(rbeta(1000, 400, 15))

    allgroups <- c(rright, rmid, rleft)

    
    output$currentdemography <- renderPlot({
      t <- hist(allgroups, xlim = c(0, 1)) 
      lines(x = density(rright)$x, y = density(rright)$y * length(rright) * diff(hist(rright, plot=FALSE)$breaks)[1], lwd = 2, col = "darkred") 
      lines(x = density(rmid)$x, y = density(rmid)$y * length(rmid) * diff(hist(rmid, plot=FALSE)$breaks)[1], lwd = 2, col = "magenta4") 
      lines(x = density(rleft)$x, y = density(rleft)$y * length(rleft) * diff(hist(rleft, plot=FALSE)$breaks)[1], lwd = 2, col = "darkblue") 
      
      print(t)
    })


    
    voters <- reactive({
      tibble(profile = allgroups)
    })




    
    
    
    
    # cumulativedata <- reactive({
    #   if(input$maturitysel != "All") {testdata %>% 
    #       filter(Species == input$sppchoice, Maturity == input$maturitysel) %>%
    #       group_by(Year) %>%
    #       mutate(cummsum = cumsum(Count))
    #   } else {testdata %>% 
    #       filter(Species == input$sppchoice) %>%
    #       group_by(Year, Species, std_date) %>%
    #       summarise(Count = sum(Count, na.rm = TRUE)) %>%
    #       group_by(Year) %>%
    #       mutate(cummsum = cumsum(Count))}
    #   
    # })
    
    
   # sumcheck <- (input$cons+input$indp+input$libs)
    
    
    output$sumcheck <- renderText({ 
      paste("Your totals: ", (input$cons+input$indp+input$libs))
    })
    
    output$percdemoc <- renderText({
      paste0("As a check, according to your demographics, in the last election, ", 
             round(length(allgroups[allgroups >= 0.5]) / length(allgroups) * 100,1), "%",
             " of Alaskans would have voted Democratic.")
    })


  }
)


