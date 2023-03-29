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


material_type <- lotr_saga %>% group_by(MaterialType, date) %>% summarize(total_checkouts = sum(Checkouts, na.rm = T))



ggplot(material_type) +
  geom_col(aes(x = date, y = total_checkouts, fill = MaterialType)) +
  labs(title = "Number of Books Checked Out by Type From 2007 to 2023",
       x = "Year",
       y = "Total Checkouts",
       fill = "Book Type")

?palette()
