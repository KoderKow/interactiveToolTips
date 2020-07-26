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
    tags$p(HTML("This demo is to show how it is possible to generate something that looks like tooltips when interactive with a plot or table. The tooltip can have any shiny inputs and outputs that a developer would normally have access to. At the moment this is using <code>shinyWidgets::dropdownButton</code> with some CSS to hide the button. Eventually, I would like to take the idea of the <code>shinyWidgets::dropdownButton</code> and make a widget that would accomplish this task without having to manipulate the CSS. All code is on my GitHub, click the icon on the top right.")),
    tags$h2("Data"),
    tags$p(HTML("The data is generated using <code>fake_ticket_client(vol = 5000)</code> from the <a href='https://github.com/ThinkR-open/fakir'>{fakir}</a> package. Two columns addition columns were created from the original data; <code>points_earned</code> and <code>total_points</code>. <code>points_earned</code> is derived from <code>fidelity_points</code> by multiplying it by a random value. <code>total_points</code> is derived by doing a cumulative sum over each <code>num_client</code>. This is for the plots in the tooltip to give the appearance of a client earning and spending points. This is purely for demonstration purposes."))
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
 
