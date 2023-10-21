pkgload::load_all()
total_r_repos <- repos_monthly()
usethis::use_data(total_r_repos, overwrite = TRUE)
