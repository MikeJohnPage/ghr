pkgload::load_all()

r_repos <- repos(language = "R") |> 
  dplyr::mutate(language = "R")

python_repos <- repos(language = "Python") |> 
  dplyr::mutate(language = "Python")

julia_repos <- repos(language = "Julia") |> 
  dplyr::mutate(language = "Julia")

data_science_repos <- dplyr::bind_rows(
  r_repos,
  python_repos,
  julia_repos
)

usethis::use_data(data_science_repos, overwrite = TRUE)
