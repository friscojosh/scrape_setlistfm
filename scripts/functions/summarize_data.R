library(tidyverse)

### Funtion that takes the artist name, SB year, and the artist name from the scraped
### data file as arguments, filters and summarizes the data for set openers.
load_all_openers <- function(artist, sb_year, file_name) {

   data <- read_csv(paste0(file_name))
   `%notin%` <- Negate(`%in%`)
   first_songs <- data %>%
      # tag months after January of the Super Bowl year for removal (since they came after the SB performance)
      mutate(keep = ifelse(year == sb_year & month == "Jan", 1,
                           ifelse(year < sb_year, 0, -1))) %>%
      # first songs in the set only
      filter(song_num == 1,
             # filter to data prior to or equal to the Super Bowl year.
             year <= sb_year,
             keep != -1) %>%
      group_by(sets) %>%
      summarize(n = n()) %>%
      mutate(pct = round(n / sum(n), 2)) %>%
      arrange(-n)
   # extract the values into vectors
   songs = first_songs$sets
   n = first_songs$n
   pct = first_songs$pct
   first_songs <- list(songs = songs, n = n, pct = pct, artist = artist)

}

load_all_openers_by_year <- function(artist, sb_year, file_name) {

   data <- read_csv(paste0(file_name))
   `%notin%` <- Negate(`%in%`)
   first_songs <- data %>%
      # tag months after January of the Super Bowl year for removal (since they came after the SB performance)
      mutate(keep = ifelse(year == sb_year & month == "Jan", 1,
                           ifelse(year < sb_year, 0, -1))) %>%
      # first songs in the set only
      filter(song_num == 1,
             # filter to data prior to or equal to the Super Bowl year.
             year <= sb_year,
             keep != -1) %>%
      group_by(year, sets) %>%
      summarize(n = n()) %>%
      mutate(pct = round(n / sum(n), 2)) %>%
      arrange(-year, -n)
   # extract the values into vectors
   year <- first_songs$year
   songs = first_songs$sets
   n = first_songs$n
   pct = first_songs$pct
   # return a list
   first_songs <- list(year = year, songs = songs, n = n, pct = pct, artist = artist)

}
