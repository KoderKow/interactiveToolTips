#' table UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_table_ui <- function(id){
  ns <- NS(id)
  tabPanel(
    title = "Table",
    tags$p("Below is a table that shows the all clients with some basic demograpihcs and total tickets purchased. Clicking a bar will trigger a 'tooltip' that will show a plot of the selected clients earned points over time."),
    shinyWidgets::dropdownButton(
      inputId = ns("tooltip"),
      width = "300px",
      margin = "25px",
      tags$style(HTML(".btn.btn-circle {display: none;}")),
      plotOutput(ns("tooltip_plot")) %>% 
        shinycssloaders::withSpinner()
    ),
    DT::dataTableOutput(ns("table"))
  )
}

#' table Server Function
#'
#' @noRd 
mod_table_server <- function(input, output, session, r = r){
  ns <- session$ns
  
  output$table <- DT::renderDataTable({
    DT::datatable(
      data = tickets_summarized,
      selection = "single"
    )
  })
  
  observeEvent(input$table_rows_selected, {
    
    selected_row <- input$table_rows_selected
    
    wanted_num_client <-
      tickets_summarized %>% 
      dplyr::slice(selected_row) %>% 
      dplyr::pull(num_client)
    
    d <-
      tickets %>% 
      dplyr::filter(num_client == wanted_num_client)
    # print(selected_row)
    
    output$tooltip_plot <- renderPlot({
      title <- glue::glue("Total point for client {wanted_num_client}")
      
      p <- d %>% 
        ggplot2::ggplot() +
        ggplot2::aes(
          x = timestamp,
          y = total_points
        ) +
        ggplot2::geom_line(
          color = "red",
          size = 1.5,
          alpha = 0.8
        ) +
        ggplot2::geom_smooth(
          method = "lm",
          se = FALSE,
          linetype = 2
        ) +
        ggplot2::labs(
          x = "Date",
          y = "Points",
          title = title
        ) +
        ggplot2::theme_bw()
      
      return(p)
    })
    
    shinyWidgets::toggleDropdownButton("tooltip")
  })
}

## To be copied in the UI
# mod_table_ui("table_ui_1")

## To be copied in the server
# callModule(mod_table_server, "table_ui_1")

