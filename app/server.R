# READING MAIN DF
df <- read.fst("data/dataset.fst", as.data.table = TRUE)

# SHIP_TYPES
ship_types <- sort(distinct(select(df, ship_type))$ship_type)

server <- function(input, output, session) {
  
  # SELECTED SHIP TYPE
  ship_type <- callModule(server_select_ship_type, 'ship_type_id', ship_types)

  ship_type_df <- reactive({
    df[ship_type==ship_type()]
  })

  # MAIN DF
  ship_selected_df <- reactive({
    
    ship_name <- callModule(server_select_ship_name, 'ship_name_id', ship_type_df)

    df <- df[SHIPNAME==ship_name()]
    df <- df[order(df$DATETIME, ),]

    df$LAT2 <- lead(df$LAT)
    df$LON2 <- lead(df$LON)

    select(df, LAT, LON, LAT2, LON2, date, DATETIME, is_parked, SPEED, WIDTH, LENGTH, DWT, DESTINATION)%>%
    rowwise() %>%
    mutate('DISTANCE' = round(distm(c(LON, LAT), c(LON2, LAT2), fun = distHaversine), 2)[1]) %>%
    arrange(desc(DISTANCE), DATETIME) %>%
    mutate_at(vars(LAT, LON, LAT2, LON2), funs(round(., 4)))

  })
  
  # MAP TWO OBSERVATIONS
  callModule(server_leafleft_chart, "mapPlot", ship_selected_df)
  
  # TOP 3 DISTANCE
  callModule(server_table_top, "table", ship_selected_df)
  
  # SPEED OVER TIME
  callModule(server_highchart_chart, "speed_last_days", ship_selected_df)
  
  # INFO CARDS
  callModule(server_cards, "cards", ship_selected_df)

}