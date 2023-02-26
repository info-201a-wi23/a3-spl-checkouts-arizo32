library("ggplot2")
library("dplyr")
library("styler")
library("plotly")

setwd("C:\\Users\\andre\\OneDrive\\Desktop\\info201\\a3-spl-checkouts-arizo32")

book_df <- read.csv("book_version.csv")
movie_df <- read.csv("movie_version.csv")
movie_and_book <- rbind(movie_df, book_df)

book_and_audio<- book_df %>% filter(MaterialType %in% c("BOOK", "AUDIOBOOK")) %>%
  group_by(CheckoutMonth, CheckoutYear, MaterialType) %>%
  summarize(total_checkouts = sum(Checkouts))

ungrouped_book_and_audio <- book_and_audio %>% ungroup()

ungrouped_book_and_audio$date <- as.Date(paste(ungrouped_book_and_audio$CheckoutYear, ungrouped_book_and_audio$CheckoutMonth, "1", sep = "-"), format = "%Y-%m-%d")

ggplot(ungrouped_book_and_audio, aes(x = date, y = total_checkouts, color = MaterialType)) +
  geom_line() + scale_color_discrete(labels = c("Audiobook", "Book")) + 
  labs(x = "Date", y = "Total Checkouts", title = "Checkouts Over Time for Audiobook and Book \n for 'The Accidental Billionaires'", color = "Medium")
