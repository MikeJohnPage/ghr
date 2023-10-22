query_gh <- function(endpoint) {
  Sys.sleep(60 / 30)
  response <- gh::gh(
    endpoint = endpoint,
    .limit = 1
  )
  response$total_count
}

monthly_dates <- function(start_date = "2010-01-01", end_date = "today") {
  if (is.na(lubridate::as_date(start_date, format = "%Y-%m-%d"))) {
    stop("Please supply a `start_date` in the format %Y-%m-%d")
  } else {
    start_date <- lubridate::ymd(start_date)
  }

  if (end_date == "today") {
    end_date <- lubridate::today()
  } else if (is.na(lubridate::as_date(end_date, format = "%Y-%m-%d"))) {
    stop("Please supply a `end_date` in the format %Y-%m-%d")
  } else {
    end_date <- lubridate::ymd(end_date)
  }

  if (start_date > end_date) {
    stop("`start_date` must be before `end_date`")
  }

  dates <- tibble::tibble(
    start_dates = seq(
      from = start_date,
      to = lubridate::floor_date(end_date, "month") - 1,
      by = "month"
    ),
    end_dates = lubridate::ceiling_date(start_dates, "month") - 1
  )
}

repos <- function(start_date = "2010-01-01", end_date = "today", ...) {
  dates <- monthly_dates(start_date, end_date)

  params <- paste0(
    "language:R created:",
    dates$start_dates,
    "..",
    dates$end_dates
  )

  endpoint <- paste0(
    "/search/repositories?q=",
    params # encoded by gh::gh()
  )

  count <- purrr::map_int(endpoint, query_gh, .progress = TRUE)

  tibble::tibble(
    date = dates$end_dates,
    repo_count = count
  )
}
