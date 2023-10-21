pkgload::load_all()

library(tidyverse)
library(hrbrthemes)

total_r_repos |>
  ggplot(aes(x = date, y = repo_count)) +
  geom_line(linewidth = 1, colour = "#1d65b7") +
  geom_area(fill = "#1d65b7", alpha = .2) +
  theme_ipsum() +
  labs(
    title = "The number of R repositories on GitHub is steadily climbing",
    x = NULL,
    y = "Number of repos"
  ) +
  scale_x_date(date_breaks = "2 year", date_labels = "%Y")

