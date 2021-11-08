ui_leafleft_chart <- function(id) {
  ns <- NS(id)
  leafletOutput(ns("mapPlot"))
}

server_leafleft_chart <- function(input, output, session, df) {
  output$mapPlot <- renderLeaflet({
    
    withProgress(message = 'Calculation in progress', {
      
      df          <- head(df(), 1)
      width       <- df$WIDTH
      len         <- df$LENGTH
      dwt         <- df$DWT
      destination <- df$DESTINATION
      df          <- data.frame(LON = c(df$LON, df$LON2),
                                LAT = c(df$LAT, df$LAT2),
                                POS = c(1, 2),
                                WIDTH = c(width, width),
                                LENGTH = c(len, len),
                                DWT = c(dwt, dwt),
                                DESTINATION = c(destination, destination)
      )
      
      leaf_icons <- icons(
        iconUrl = ifelse(df$POS == 1,
                         "https://media.giphy.com/media/ffQiLNxctlxLb9UqSf/giphy.gif",
                         "https://media.giphy.com/media/IH0KR5iu19G8Jqc0cW/giphy.gif"
        ),
        iconWidth = 50, iconHeight = 50
      )
      
      leaflet() %>%
        addTiles() %>%
        addMarkers(df$LON, df$LAT,
                   icon = leaf_icons,
                   popup = paste("Lon: ", df$LON, "<br>",
                                 "Lat: ", df$LAT, "<br>",
                                 "Width: ", df$WIDTH, "<br>",
                                 "Length: ", df$LENGTH, "<br>",
                                 "Deadweight: ", df$DWT, "<br>",
                                 "Destination: ", df$DESTINATION)
        )
    })
    
  })
}

ui_highchart_chart <- function(id) {
  ns <- NS(id)
  highchartOutput(ns("speed_last_days"), height = "200px")
}

server_highchart_chart <- function(input, output, session, df) {
  
  output$speed_last_days <- renderHighchart({
    
    df <- df() %>% group_by(date) %>%
      summarize("minSpeed" = min(SPEED), "maxSpeed" = max(SPEED), "meanSpeed" = mean(SPEED)) %>%
      gather(tipo, speed, -date)
    
    hchart(df, "line", hcaes(x = date, y = speed, group = tipo)) %>%
      hc_add_theme(hc_theme_google()) %>%
      hc_xAxis(title=list(text=NULL)) %>%
      hc_title(
        text = "Speed over time",
        margin = 20,
        align = "left",
        style = list(color = "#636363", useHTML = TRUE)
      )
    
  })
}



