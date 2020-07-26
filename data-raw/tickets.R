## code to prepare `tickets` dataset goes here
library(fakir)

set.seed(1991)

tickets <-
  fake_ticket_client(vol = 5000) %>% 
  dplyr::ungroup() %>% 
  dplyr::rowwise() %>% 
  dplyr::mutate(
    points_earned = round(fidelity_points * rnorm(1, sd = .5))
    ) %>% 
  dplyr::group_by(num_client) %>% 
  dplyr::arrange(timestamp) %>% 
  dplyr::mutate(total_points = cumsum(points_earned))

tickets_summarized <-
  tickets %>% 
  dplyr::group_by(num_client, first, last, job, age) %>% 
  dplyr::summarise(
    priority = unique(priority),
    ticket_count = dplyr::n()
  ) %>% 
  dplyr::ungroup() %>% 
  dplyr::arrange(dplyr::desc(ticket_count)) %>% 
  dplyr::mutate(
    num_client = forcats::fct_reorder(
      .f = num_client,
      .x = ticket_count,
      .desc = TRUE
    )
  )

usethis::use_data(tickets, overwrite = TRUE)
usethis::use_data(tickets_summarized, overwrite = TRUE)
