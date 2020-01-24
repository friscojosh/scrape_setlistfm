library(tidyverse)
library(rvest)
library(urltools)
library(purrr)

get_pages <- function(link){

   print("Getting page count...")

   session <- read_html(link)

   links <- session %>%
      html_nodes(".hidden-print li:nth-child(9) a") %>%
      html_text()

   links <- links[[1]]
}

url_expander <- function(link, num) {

   print(paste("Building URL", num, "..."))

   artist_query <- param_get(urls = link,
                             parameter_names = "query")

   build_url <- paste0("https://www.setlist.fm/search?page=", num, "&query=", artist_query)
}

# .hidden-print li:nth-child(9) a
get_links <- function (link) {

   print(paste0("Scraping ", link, "..."))

   session <- read_html(link)

   links <- session %>%
      html_nodes(".setlistPreview h2 a") %>%
      html_attr("href") %>%
      as.tibble()

   links <- links %>%
      mutate(link = paste0("https://www.setlist.fm/", value)) %>%
      select(-value)
}

get_songs <- function(link) {

   session <- read_html(link)

   sets <- session %>%
      html_nodes(".songLabel") %>%
      html_text()

   artist <- session %>%
      html_node("strong span") %>%
      html_text()

   venue <- session %>%
      html_node(".setlistHeadline span span span") %>%
      html_text()

   month <- session %>%
      html_node(".month") %>%
      html_text()

   day <- session %>%
      html_node(".day") %>%
      html_text()

   year <- session %>%
      html_node(".year") %>%
      html_text()

   print(paste("Getting", venue, year, "set lists..."))

   set_list <- list(sets = sets, artist = artist, venue = venue, month = month, day = day, year = year)

}

scrape_artist <- function (artist_name, link) {

   # first get the number of pages we'll need to crawl from setlist.fm
   num <- get_pages(link)
   # make a sequence to pass to map2 to build the URLs to scrape
   nums <- seq(1, num, 1)
   # repeat the base URL num number of times because map2 expectes vectors of equal length
   urls <- rep(link, times = num)
   # pass the 2 vectors to the url_explander function that will give us our list of
   # valid URLs of artist gigs to scrape
   artist_gigs <- map2(urls, nums, url_expander)
   # now that we have the base page URLs we need to get the links to the actual
   # set lists. We use the get_links function for that
   set_list_links <- map(artist_gigs, get_links)
   # I like to covert to a tibble here for ease of troubleshooting
   set_lists_df <- set_list_links %>% map_df(as_tibble)
   # we go right back to a vector now
   set_list_vector <- set_lists_df %>% pull(link)
   # grab set lists songs and map them to a dataframe
   set_lists <- map(set_list_vector, get_songs)
   set_lists_final <- set_lists %>% map_df(as_tibble)
   # clean up the resulting data frame and add song numbers, which is what we're interested in
   set_lists_final <- set_lists_final %>%
      group_by(artist, venue, month, day, year) %>%
      mutate(song_num = row_number())
   ### write the scrape to disk
   write_csv(set_lists_final, paste0("data/output/", artist_name, "_set_lists.csv"))
}
