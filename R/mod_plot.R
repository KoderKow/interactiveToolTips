#' plot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_plot_ui <- function(id){
  ns <- NS(id)
  tabPanel(
    title = "Bar Charts",
    tags$p("Below is a chart that shows the top 10 clients in terms of amount of tickets purchased. Clicking a bar will trigger a 'tooltip' that will show a plot of the selected clients earned points over time."),
    shinyWidgets::dropdownButton(
      inputId = ns("tooltip"),
      width = "300px",
      margin = "25px",
      tags$style(HTML(".btn.btn-circle {display: none;}")),
      plotOutput(ns("tooltip_plot")) %>% 
        shinycssloaders::withSpinner()
    ),
    plotly::plotlyOutput(ns("plot")) %>% 
      shinycssloaders::withSpinner()
  )
}

#' plot Server Function
#'
#' @noRd 
mod_plot_server <- function(input, output, session){
  ns <- session$ns
  
  output$plot <- plotly::renderPlotly({
    p <- tickets_summarized %>%
      dplyr::slice_max(ticket_count, n = 15) %>% 
      ggplot2::ggplot() +
      ggplot2::aes(x = num_client, y = ticket_count) +
      ggplot2::geom_col(fill = "#778899", color = "black", alpha = 0.8) +
      ggplot2::theme_bw()
    
    gp <- plotly::ggplotly(p)
    
    plotly::event_register(gp)
    
    return(gp)
  })
  
  observeEvent(plotly::event_data("plotly_click"), {
    
    click_data <- plotly::event_data("plotly_click")
    
    print(click_data)
    
    x <- click_data$x
    
    wanted_num_client <-
      tickets_summarized %>% 
      dplyr::slice(x) %>% 
      dplyr::pull(num_client)
    
    d <-
      tickets %>% 
      dplyr::filter(num_client == wanted_num_client)
    
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
# mod_plot_ui("plot_ui_1")

## To be copied in the server
# callModule(mod_plot_server, "plot_ui_1")

