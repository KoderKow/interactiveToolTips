#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    navbarPage(
      title = "Interactive Tooltips",
      mod_about_ui("about_ui_1"),
      mod_plot_ui("plot_ui_1"),
      mod_table_ui("table_ui_1"),
      tabPanel(
        tags$span(
          icon("github-square", class = "fa-3x"),
          title = "My GitHub"
        )
      ),
      tabPanel(
        tags$span(
          icon("globe", class = "fa-3x"),
          title = "My Website"
        )
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'interactiveToolTips'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

