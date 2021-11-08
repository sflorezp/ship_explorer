semanticPage(
  useShinyjs(),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@900&display=swap"),
    includeCSS("./www/css/styles.css")
  ),
  grid(
    grid_template = grid_template(
      default = list(
        areas = rbind(
          c("header", "header", "header"),
          c("sidebar", "card", "card"),
          c("sidebar", "map", "map"),
          c("user", "map", "map")
        ),
        rows_height = c("20px", "130px", "auto", "170px"),
        cols_width = c("45%", "1fr", "1fr")
      )
    ),
    area_styles = list(header = "margin-left: 20px;", card = "margin: 20px;", sidebar = "margin: 20px;", user = "margin: 20px;", map = "margin: 20px;"),
    header = h2(class = "ui header", img(src="images/steering-wheel.png", style="width: 35px; height: 35px;"), div(class = "content", style = "color : #15354A; font-family: 'Source Sans Pro', sans-serif;", "SHIP EXPLORER")),
    card = ui_cards("cards"),
    sidebar = cards(
      card(
      style = "border-radius: 0; width: 100%; background: #efefef",
      div(class="content",
          div(class = "description", style = "", 
              ui_select_ship_type("ship_type_id"),
              ui_select_ship_name("ship_name_id")
          )
      )),
    card(
      style = "border-radius: 0; width: 100%; background: #efefef",
      div(class="content",
          div(class = "header", style = "margin-bottom: 10px; color : #636363; margin-bottom: 10px; font-family: 'Source Sans Pro'", "Top 3 largest sailed distances"),
          div(class = "description", style = "margin-top: 10px", ui_table_top("table"), br(), ui_highchart_chart("speed_last_days"))
      ))
    ),
    map = ui_leafleft_chart("mapPlot"),
    user = card(
      style = "border-radius: 0; width: 100%; margin-top: -20px; background: #efefef",
      div(class = "content", 
          div(class = "header", style = "color : #15354A; margin-bottom: 10px; font-family: 'Source Sans Pro'", 
              tags$img(src = "images/Sebas2.gif", 
                       style="width: 50px; height: 50px;",
                       class = "ui avatar image"), 
              "Sebastián Flórez Parra ", 
              tags$span(style = "color: #0099f9; font-size: 13px;", 
                        icon("linkedin"), 
                        tags$a(href = "https://www.linkedin.com/in/sflorezp/", style = "text-decoration: underline", "sflorezp"))),
          div(class = "meta", img(src="images/mail.gif", style="width: 20px; height: 20px;"), "sebasspicke@gmail.com"),
          div(class = "meta", img(src="images/location.gif", style="width: 20px; height: 20px;"), "Medellín, Colombia")
      ))
  )
)