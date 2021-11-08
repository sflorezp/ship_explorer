ui_cards <- function(id){
  ns <- NS(id)
  uiOutput(ns("cards"))
}

server_cards <- function(input, output, session, df){
  
  output$cards <- renderUI({
    
    df <- df() %>% filter(is_parked == 0)
    
    speed    <- round(mean(df$SPEED, na.rm = TRUE), 2)
    if(is.nan(speed)) speed <- NULL
    
    df_1     <- head(df, 1)
    distance <- head(df_1, 1)$DISTANCE
    
    cards(
      class = "three",
      card(
        style = "border-radius: 0; background: #efefef",
        div(class = "content",
            div(class = "header", style = "color : #636363; margin-bottom: 10px; font-family: 'Source Sans Pro'; font-size: 25px",
                tags$img(src = "images/info.gif", style="width: 40px; height: 40px;"),
                HTML("&nbsp &nbsp Important!"),
            ),
            div(class = "meta", style ="font-size: 15x", img(src="images/ship_1.gif", style="width: 20px; height: 20px;"), "Beginning of the movement"),
            div(class = "meta", style ="font-size: 15px", img(src="images/ship_2.gif", style="width: 20px; height: 20px;"), "Enf of the movement")
        )),
      card(
        style = "border-radius: 0; background: #efefef",
        div(class = "content",
            div(class = "header", style = "color : #636363; margin-bottom: 10px; font-family: 'Source Sans Pro'; font-size: 25px",
                tags$img(src = "images/distance.gif", style="width: 40px; height: 40px;"),
                HTML(paste0("&nbsp &nbsp", distance)),
            ),
            div(class = "meta", style ="font-size: 15px", "Longest distance[meters] between two observations")
        )),
      card(
        style = "border-radius: 0; background: #efefef",
        div(class = "content",
            div(class = "header", style = "color : #636363; margin-bottom: 10px; font-family: 'Source Sans Pro'; font-size: 25px",
                tags$img(src = "images/speed.gif", style="width: 40px; height: 40px;"),
                HTML(paste0("&nbsp &nbsp", speed)),
            ),
            div(class = "meta", style ="font-size: 15px", "Mean speed[km] when it's not parked")
        ))
    )
    
  })
  
}