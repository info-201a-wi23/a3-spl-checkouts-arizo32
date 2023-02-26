library("ggplot2")
library("dplyr")
library("styler")
library("plotly")

book_df <- read.csv("https://raw.githubusercontent.com/info-201a-wi23/a3-spl-checkouts-arizo32/main/book_version.csv")
movie_df <- read.csv("https://raw.githubusercontent.com/info-201a-wi23/a3-spl-checkouts-arizo32/main/movie_version.csv")
movie_and_book <- rbind(movie_df, book_df)

totals_by_month <- movie_and_book %>%
  group_by(CheckoutYear, CheckoutMonth, MaterialType) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  arrange(desc(total_checkouts))

ungrouped_totals_by_month <- totals_by_month %>% ungroup()

ungrouped_totals_by_month$date <- as.Date(paste(ungrouped_totals_by_month$CheckoutYear, ungrouped_totals_by_month$CheckoutMonth, "1", sep = "-"), format = "%Y-%m-%d")

ggplot(ungrouped_totals_by_month, aes(x = date, y = total_checkouts, color = MaterialType)) +
  geom_line() + scale_color_discrete(labels = c("Audiobook", "Book", "EBook", "Sound Disc", "Movie")) + 
  labs(x = "Date", y = "Total Checkouts", title = "Checkouts Over Time for 'The Accidental Billionaires'", color = "Medium")
