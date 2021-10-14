
library(shiny)
library(vroom)
library(tidyverse)
library(lubridate)



df <- readr::read_csv("mass_shoting_data.csv")
df <- df %>% mutate(`Incident Date` = mdy(`Incident Date`))


ui <- fluidPage(
  titlePanel("Mass Shooting Data - Presentation Generator"),
  fluidRow(
    column(10,
           selectInput("state_select", label = h3("Select a State"), df$State)
    )
  ),
  fluidRow(
    column(12,
           plotOutput("event_usa"))
  ),
  fluidRow(
    column(12,
           downloadButton("Presentation","Generate Presentation")
    )
  )
  
)









