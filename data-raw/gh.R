# Docs: https://docs.github.com/en/rest/search/search?apiVersion=2022-11-28
start_dates <- seq(
  from = lubridate::ymd("2010-01-01"),
  to = lubridate::floor_date(lubridate::today(), "month") - 1,
  by = "month"
)

end_dates <- lubridate::ceiling_date(start_dates, "month") - 1

# List of possible parameters: 
# https://docs.github.com/en/search-github/searching-on-github/searching-for-repositories
params <- paste0("language:R created:", start_dates, "..", end_dates)

endpoint <- paste0(
  "/search/repositories?q=",
  params # URL encoded by gh::gh()
)

query_gh <- function(endpoint) {
  Sys.sleep(60/30)

  response <- gh::gh(
    endpoint = endpoint,
    .limit = 1
  )

  response$total_count
}

r_repos_count <- purrr::map_int(endpoint, query_gh, .progress = TRUE)

r_repos <- tibble::tibble(
  date = end_dates,
  r_repos = r_repos_count
)

usethis::use_data(r_repos, overwrite = TRUE)
