

library(shiny)
library(vroom)
library(tidyverse)
library(lubridate)



shinyServer(function(input, output, session){
  selected <- reactive(df %>% filter(State == input$state_select))
  
  output$event_usa <- renderPlot({
    df %>% 
      count(Year=year(`Incident Date`)) %>% 
      ggplot(mapping = aes(Year,n))+
      geom_col(fill="White",color="black")+
      geom_text(aes(label=n), position=position_dodge(width=0.9), vjust=-0.25)+
      labs(title="Number of events for the United States of America",
           x="Years",
           y="Number of event")
  })
  
  output$Presentation <- downloadHandler(
    # Selecting output file type
    filename = "Presentation.pptx",
    content = function(file){
      tempReport <- file.path(tempdir(), "Presentation_Template.Rmd")
      file.copy("Presentation_template.Rmd",tempReport, overwrite = TRUE)
      
      # Setting up the parameters
      params <- list(df = selected(), state=input$state_select)
      
      # Knitting the document
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent =globalenv()))
      
    }
  )
  
  
})

