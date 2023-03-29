library("dplyr")
library("stringr")

tolkien_df <- read.csv("~/Documents/UW Documents/UW-Info201/a3-spl-checkouts-sergiov11/Tolkien - Checkouts_by_Title.csv", stringsAsFactors = FALSE)

tolkien_df <- tolkien_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))

tolkien_df$date <- as.Date(tolkien_df$date, format = "%Y-%m-%d")

tolkien_df$Title[str_detect(tolkien_df$Title, "Fellowship")] <- "The Lord of the Rings: The Fellowship of the Ring"
tolkien_df$Title[str_detect(tolkien_df$Title, "Two Towers")] <- "The Lord of the Rings: The Two Towers"
tolkien_df$Title[str_detect(tolkien_df$Title, "Return")] <- "The Lord of the Rings: The Return of the King"

book_max_checkouts <- tolkien_df %>% filter(Checkouts == max(Checkouts, na.rm = T)) %>% pull(Title)

year_max_checkouts <- tolkien_df %>% filter(Checkouts == max(Checkouts, na.rm = T)) %>% pull(CheckoutYear)

mean_checkout_2022 <- tolkien_df %>% filter(CheckoutYear == "2022") %>% group_by(Title) %>% summarize(Checkouts = mean(Checkouts, na.rm = T)) %>% filter(Checkouts == max(Checkouts, na.rm = T)) %>%  pull(Checkouts)

most_popular_material <- tolkien_df %>% mutate(MaterialType = tolower(MaterialType)) %>% filter(Checkouts == max(Checkouts, na.rm = T)) %>% pull(MaterialType)

year_min_checkouts_ebook <- tolkien_df %>% filter(CheckoutYear == max(CheckoutYear, na.rm = T)) %>% group_by(MaterialType) %>% filter(MaterialType == "EBOOK") %>% filter(Checkouts == min(Checkouts, na.rm = T)) %>% 
  pull(CheckoutYear)



