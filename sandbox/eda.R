pkgload::load_all()

library(tidyverse)
library(hrbrthemes)

# - Facet plot -
data_science_repos |>
  ggplot(aes(x = date, y = repo_count)) +
  geom_line(linewidth = 1, colour = "#1d65b7") +
  geom_area(fill = "#1d65b7", alpha = .2) +
  facet_wrap(vars(language), scales = "free") +
  theme_ipsum() +
  labs(
    title = "The number of R repositories on GitHub is steadily climbing",
    x = NULL,
    y = "Number of repos"
  ) +
  scale_x_date(date_breaks = "2 year", date_labels = "%Y") +
  scale_y_continuous(labels = scales::comma)

# - Combined -
data_science_repos |>
  mutate(label = if_else(date == max(date), language, NA)) |> 
  ggplot(aes(x = date, y = repo_count, colour = language)) +
  geom_line(linewidth = 1) +
  scale_color_manual(values=c("#9558b2", "#ffd539", "#2165b8")) +
  geom_text(aes(label = label), hjust = -0.1) +
  scale_y_log10(labels = scales::comma) +
  theme_ipsum() +
   labs(
    title = "Python continues to show growth while R and Julia lag behind",
    subtitle = "Note: repositories are on a log (10) scale",
    x = NULL,
    y = "Number of repos"
  ) +
  scale_x_date(date_breaks = "2 year", date_labels = "%Y") +
  theme(legend.position = 'none') +
  coord_cartesian(clip = 'off') # Prevent labels being chopped
