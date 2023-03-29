library("dplyr")
library("ggplot2")
library("stringr")


tolkien_df <- read.csv("~/Documents/UW Documents/UW-Info201/a3-spl-checkouts-sergiov11/Tolkien - Checkouts_by_Title.csv", stringsAsFactors = FALSE)

tolkien_df <- tolkien_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))

tolkien_df$date <- as.Date(tolkien_df$date, format = "%Y-%m-%d")

tolkien_df$Title[str_detect(tolkien_df$Title, "Fellowship")] <- "The Lord of the Rings: The Fellowship of the Ring"
tolkien_df$Title[str_detect(tolkien_df$Title, "Two Towers")] <- "The Lord of the Rings: The Two Towers"
tolkien_df$Title[str_detect(tolkien_df$Title, "Return")] <- "The Lord of the Rings: The Return of the King"


lotr_saga <- tolkien_df %>% filter(Title %in% c("The Lord of the Rings: The Fellowship of the Ring",
                                                "The Lord of the Rings: The Two Towers",
                                                "The Lord of the Rings: The Return of the King"))

most_checkout_per_publisher <- lotr_saga %>% group_by(Publisher, PublicationYear) %>% summarize(checkouts_by_publishers = sum(Checkouts, na.rm = T))

ggplot(most_checkout_per_publisher) +
  geom_point(aes(x = PublicationYear, y = checkouts_by_publishers, color = Publisher)) +
  scale_color_brewer(palette = "Dark2") +
  labs(title = "Number of Books Checked Out by Year Published/Publisher From 2007 to 2022",
       x = "Year Published",
       y = "Total Checkouts",
       fill = "Book Type")
