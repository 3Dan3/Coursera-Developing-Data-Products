library(shiny)
library(plotly)

shinyUI(fluidPage(
  
  titlePanel("GDP per Capita for \nNAFTA Countries"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider1", "Pick Time (Year) Range", 
                  min = 1952, max = 2007, value = c(1952, 2007), 
                  step = 1),
      h4("Please select at least 1 Country."),
      checkboxInput("box1", "Show country: US", value = TRUE),
      checkboxInput("box2", "Show country: CAN", value = TRUE),
      checkboxInput("box3", "Show stock: MEX", value = TRUE)
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Instructions", br(), htmlOutput("intro")),
                  tabPanel("GDP per Cap Plot", br(), plotlyOutput("plot1"))
      )
    )
  )
))