
library(tidyverse)
library(ggthemes)
library(shiny)
library(plotly)
library(gapminder)


shinyServer(function(input, output) {
  
  box_US <- reactive({input$box1})
  box_CAN <- reactive({input$box2})
  box_MEX <- reactive({input$box3})
  time_range <- reactive({input$slider1})
  
  output$plot1 <-  renderPlotly({
    ucm <- as.data.frame(gapminder)  %>%
    mutate(country = factor(country,
                            levels = c("United States", "Canada", 
                                       "Mexico"))) %>%
    filter(country %in% c("United States", "Canada","Mexico")) %>%
    select(year, country, gdpPercap)
  
    nafta_df <- data.frame()
    
    if(box_US()) {
      nafta_df <- rbind(nafta_df,subset(ucm, ucm$country == "United States"))
    }
    if(box_CAN()) {
      nafta_df <- rbind(nafta_df, subset(ucm, ucm$country == "Canada"))
    }
    if(box_MEX()) {
      nafta_df <- rbind(nafta_df, subset(ucm, ucm$country == "Mexico"))
    }
    
    nafta_df <- subset(nafta_df, nafta_df$year >= time_range()[1] & nafta_df$year <= time_range()[2])
    
    if(nrow(nafta_df) > 0) {
       plot_ly(nafta_df, x = nafta_df$year, y = nafta_df$gdpPercap, color = nafta_df$country,
               type = 'scatter', mode = 'lines') %>%
        layout(title = "GDP per Capita for NAFTA Countries", 
               yaxis = list(title = "USD"), 
               xaxis = list(title = "Year"))
    }
  })
  
  output$intro <- renderText({
    paste(
      "<h3>", "Introduction", "</h3>",
      "<br>",
      "<h5>", "This Application enables the user to interactively view 
                   the GDP per Capita for the three countries that signed the North American Free Trade Agreement: US, Canada and Mexico", 
      "</h5>",
      "</br>",
      
      "<h3>", "How to Navigate", "</h3>",
      "<br>",
      "<h5>", "In the right tab ('GDP per Cap Plot') there's an interactive plot for our data",
      "<b>", "from the gapminder dataset. ", "</b>",
      "The interactive plot can select up to 3 different countries for any time interval between 1952 and 2007: ",
      "<br>","</br>",
      "<ul>",
      "<li>", "US - United States of America", "</li>",
      "<li>", "CAN - Canada", "</li>",
      "<li>", "MEX - Mexico", "</li>",
      "</ul>",
      "<br>","</br>",
      "The slider on the left can be used to select the required time interval and 
             the boxes below can be used to select the country to display",
      "</h5>",
      "</br>"
      
    )
    
  })
  
})
