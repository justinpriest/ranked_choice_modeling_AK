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
    
    rright <- rbeta(1000 * props[1], 3, 10) # the right
    rmid <- rbeta(1000 * props[2], 4.8, 5)  # the middle (skewing slightly right)
    rleft <- rbeta(1000 * props[3], 17, 10) # the left
    
    hist(rbeta(1000, 400, 15))
    
    allgroups <- c(rright, rmid, rleft)

    
    output$currentdemography <- renderPlot({
      t <- hist(allgroups)
      print(t)
    })


    
    voters <- reactive({
      tibble(profile = allgroups)
    })
    
    
    percdemoc <- reactive({
      length(allgroups[allgroups >= 0.5])
    })
    
    
    
    
    cumulativedata <- reactive({
      if(input$maturitysel != "All") {testdata %>% 
          filter(Species == input$sppchoice, Maturity == input$maturitysel) %>%
          group_by(Year) %>%
          mutate(cummsum = cumsum(Count))
      } else {testdata %>% 
          filter(Species == input$sppchoice) %>%
          group_by(Year, Species, std_date) %>%
          summarise(Count = sum(Count, na.rm = TRUE)) %>%
          group_by(Year) %>%
          mutate(cummsum = cumsum(Count))}
      
    })
    
    
    
    output$annualcountplot <- renderPlot({
      
      t <- ggplot(dataset.new(), aes(x=std_date, y=Count)) + 
        geom_line(color = "deepskyblue1", size = 1.5) + labs(title = paste0(input$sppchoice,", ", input$year)) 
      
      print(t)
    })

    

    


  }
)


