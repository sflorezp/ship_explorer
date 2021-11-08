ui_table_top <- function(id){
  ns <- NS(id)
  semantic_DTOutput(ns("table"))
}

server_table_top <- function(input, output, session, df){
  
  output$table <- DT::renderDataTable({
    df <- head(select(df(), DATETIME, LAT, LON, LAT2, LON2, SPEED, DISTANCE), 3)
    names(df) <- str_to_sentence(names(df))
    semantic_DT(df, extensions = c('Responsive'), options = list(dom = 't', responsive = TRUE))
  })
  
}