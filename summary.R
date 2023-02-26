library("ggplot2")
library("dplyr")
library("styler")
library("plotly")

book_df <- read.csv("https://raw.githubusercontent.com/info-201a-wi23/a3-spl-checkouts-arizo32/main/book_version.csv")
movie_df <- read.csv("https://raw.githubusercontent.com/info-201a-wi23/a3-spl-checkouts-arizo32/main/movie_version.csv")
movie_and_book <- rbind(movie_df, book_df)



# 1. When was the story's peak total checkout and when was the story's base total checkout?

# Puts together total checkouts of the story by each month in every year from July 2009 to January 2023 and sorts it by most to least checkouts
totals_by_month <- movie_and_book %>%
  group_by(CheckoutYear, CheckoutMonth) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  arrange(desc(total_checkouts))

ungrouped_totals_by_month <- totals_by_month %>% ungroup()

# gets the row with the most checkouts from the previous summary / most checkouts in a month
max_row <- ungrouped_totals_by_month %>% slice(1)

# the date
max_date <- paste(max_row$CheckoutYear, "-", max_row$CheckoutMonth)
# checkouts in that month
max_checkouts <- paste(max_row$total_checkouts)


# gets the bottom row(the month with the least checkouts)
min_row <- ungrouped_totals_by_month[nrow(ungrouped_totals_by_month), ]

# the date
min_date <- paste(min_row$CheckoutYear, "-", min_row$CheckoutMonth)
# checkouts in that month
min_checkouts <- paste(min_row$total_checkouts)



# 2. How much more popular is reading the book vs listening to the audiobook vs watching the movie?

# Audiobook dataframe (SOUNDDISC and AUDIOBOOK)
audiobook_df <- book_df %>%
  filter(MaterialType %in% c("SOUNDDISC", "AUDIOBOOK"))

# Reading book dataframe (EBOOK and BOOK)
reading_df <- book_df %>%
  filter(MaterialType %in% c("BOOK", "EBOOK"))


# Total number of reading book checkouts
reading_num <- sum(reading_df$Checkouts)

# Total number of audiobook checkouts
audiobook_num <- sum(audiobook_df$Checkouts)

# Total number of movie checkouts
movie_num <- sum(movie_df$Checkouts)



# 3. What year was the movie the most popular?

# Highest year
max_year <- movie_df %>%
  group_by(CheckoutYear) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  filter(total_checkouts == max(total_checkouts)) %>%
  pull(CheckoutYear)

# Lowest year
min_year <- movie_df %>%
  group_by(CheckoutYear) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  filter(total_checkouts == min(total_checkouts)) %>%
  pull(CheckoutYear)

# 4. What is the average number of checkouts each year of the story?


avg_per_year <- movie_and_book %>%
  group_by(CheckoutYear) %>%
  summarize(avg_checkouts = mean(Checkouts))



# 5. How does each material compare on average?

avg_per_material <- movie_and_book %>%
  group_by(MaterialType) %>%
  summarize(avg_checkouts = mean(Checkouts))

# Average of sound disc checkouts
avg_sounddisc <- avg_per_material %>%
  filter(MaterialType == "SOUNDDISC") %>%
  pull(avg_checkouts)

# Average of audiobook checkouts
avg_audiobook <- avg_per_material %>%
  filter(MaterialType == "AUDIOBOOK") %>%
  pull(avg_checkouts)

# Average of book checkouts
avg_book <- avg_per_material %>%
  filter(MaterialType == "BOOK") %>%
  pull(avg_checkouts)

# Average of ebook checkouts
avg_ebook <- avg_per_material %>%
  filter(MaterialType == "EBOOK") %>%
  pull(avg_checkouts)

# Average of movie checkouts
avg_movie <- avg_per_material %>%
  filter(MaterialType == "VIDEODISC") %>%
  pull(avg_checkouts)
