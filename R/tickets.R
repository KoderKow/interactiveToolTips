#' Ticket data from {fakir}
#'
#' This is randomly generated data using the `{fakir}` package. Two columns addition columns were created from the original data; `points_earned` and `total_points`. `points_earned` is derived from `fidelity_points` by multiplying it by a random value. `total_points` is derived by doing a cumulative sum over each `num_client`. This is for the plots in the tooltip to give the appearance of a client earning and spending points.
#'
#' @format A data frame with 5000 rows and 27 variables
#' @source \url{https://github.com/ThinkR-open/fakir}
"tickets"