library("ggplot2")
library("dplyr")
library("styler")
library("plotly")

book_df <- read.csv("https://raw.githubusercontent.com/info-201a-wi23/a3-spl-checkouts-arizo32/main/book_version.csv")
movie_df <- read.csv("https://raw.githubusercontent.com/info-201a-wi23/a3-spl-checkouts-arizo32/main/movie_version.csv")
movie_and_book <- rbind(movie_df, book_df)

total_materials <- movie_and_book %>%
  group_by(MaterialType) %>%
  summarize(total_checkouts = sum(Checkouts))

ggplot(total_materials, aes(x = MaterialType, y = total_checkouts, fill = MaterialType)) +
  geom_bar(stat = "identity") +
  labs(title = "Checkouts of The Accidental Billionaires by Material Type",
       x = "Material Type",
       y = "Total Checkouts")

