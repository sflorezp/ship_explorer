ui_select_ship_type <- function(id){
  ns <- NS(id)
  shiny.semantic::selectInput(ns("ship_type_id"), "Select ship type", choices = character(0))
}

server_select_ship_type <- function(input, output, session, ship_types){
  updateSelectInput(session, inputId = "ship_type_id", choices = ship_types)
  reactive({input$ship_type_id})
}

ui_select_ship_name <- function(id){
  ns <- NS(id)
  shiny.semantic::selectInput(ns("ship_name_id"), "Select ship name", choices = character(0))
}

server_select_ship_name <- function(input, output, session, ship_type_df){
  ship_names <- sort(distinct(select(ship_type_df(), SHIPNAME))$SHIPNAME)
  updateSelectInput(session, inputId = "ship_name_id", choices = ship_names)
  reactive({input$ship_name_id})
}