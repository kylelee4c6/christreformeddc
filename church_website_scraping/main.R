#' Process raw tags from Squarespace
#' 
#' @author Kyle Lee

# Load packages
library(rvest)
library(stringr)

# Get website text
website_text <- c(read.csv("website_text.txt", header=FALSE, sep=";"))[[1]]

# Get titles of series
formatted_tags <- website_text %>%
  read_html() %>%
  html_nodes(xpath = "//div[@title]") %>%
  html_text()

# Format to markdown for Squarespace accordion menu
top_tags <- paste("[", formatted_tags,"][", seq(length(formatted_tags)),"]", sep = "" )
for(i in 1:length(top_tags)){
  line <- top_tags[i]
  # Write initial line
  write(line, file = "series_final.txt",
        append = TRUE, sep = "\n")
  # Add new line
  line <- " "
  write(line, file = "series_final.txt",
        append = TRUE, sep = "\n")
}

# Add hyperlinks with formatted htmls
bottom_tags <- paste("[",seq(length(formatted_tags)),"]: /sermons/tag/",
                     str_replace_all(
                       str_replace_all(
                         str_replace_all(
                           str_replace_all(formatted_tags,"\\:", "%3A"),"\\'","%27"),"\\?", "%3F"), " ", "+"), sep = "")

for(i in 1:length(bottom_tags)){
  line <- bottom_tags[i]
  write(line, file = "series_final.txt",
        append = TRUE, sep = "\n")
  line <- " "
  write(line, file = "series_final.txt",
        append = TRUE, sep = "\n")
}

# Get authors
categories_text <- c(read.csv("categories_raw.txt", header=FALSE, sep=";"))[[1]]

formatted_categories <- categories_text %>%
  read_html() %>%
  html_nodes(xpath = "//p[@title]") %>% 
  html_text()
formatted_categories


top_categories <- paste("[", formatted_categories,"][", length(formatted_tags)+ seq(length(formatted_categories)),"]", sep = "" )
for(i in 1:length(top_categories)){
  line <- top_categories[i]
  write(line, file = "authors_final.txt",
        append = TRUE, sep = "\n")
  line <- " "
  write(line, file = "authors_final.txt",
        append = TRUE, sep = "\n")
}

# Get hyperlinks
bottom_categories<- paste("[", length(formatted_tags)+ seq(length(formatted_categories)),"]: /sermons/category/",
                     str_replace_all(
                       str_replace_all(
                         str_replace_all(
                           str_replace_all(formatted_categories,"\\:", "%3A"),"\\'","%27"),"\\?", "%3F"), " ", "+"), sep = "")

for(i in 1:length(bottom_categories)){
  line <- bottom_categories[i]
  write(line, file = "authors_final.txt",
        append = TRUE, sep = "\n")
  line <- " "
  write(line, file = "authors_final.txt",
        append = TRUE, sep = "\n")
}
