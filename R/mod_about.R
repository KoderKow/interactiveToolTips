#' about UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_about_ui <- function(id){
  ns <- NS(id)
  tabPanel(
    title = "About",
    tags$h1("Interactive Tooltips"),
    tags$p(shinipsum::random_text(nwords = 100)),
    tags$h2("Data"),
    tags$p("Tickets data from {fakir} https://github.com/ThinkR-open/fakir")
  )
}
    
#' about Server Function
#'
#' @noRd 
mod_about_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_about_ui("about_ui_1")
    
## To be copied in the server
# callModule(mod_about_server, "about_ui_1")
 
