setlist.fm scraper
================

For prop bets on which song an act is likely to open their set with,
historical data are useful to compute base rates. The best source of
data on which songs performers have used to open their sets in the past
is published on a wiki called setlist.fm. The functions in this
repository scrape and summarize setlist.fm data so you can more easily
set your expectations about the most likely candidates to open a
Halftime show.

To use the scraper, call `scrape_artist()` with two arguments: a string
that can be anything you want, but that will be used to name the output
of the scrape. I recommend the artist’s name. Use quotes. Spaces are OK.
The resulting .csv is saved in `data/output/` with `_set_lists.csv`
appended to the name you provide. The second argument is the setlist.fm
url for the artist. Pass the url as a string, in quotes as well.

``` r
# do not run
# scrape_artist("jlo", "https://www.setlist.fm/search?query=jennifer+lopez")
# scrape_artist("shakira", "https://www.setlist.fm/search?query=shakira")
```

When the scape completes you’ll want to inspect the data and clean it
where necessary. This step is beyond the scope of this document. However
you can simply summarize the data as-is with the quick helper function
`load_all_openers()` The function accepts the artist’s name, the year of
the Super Bowl performance, and path to the data file created by
`scrape_artist()` as arguments.

``` r
library(purrr)
source("scripts/functions/summarize_data.R") # scraping functions

names <- c("Jennifer Lopez", "Shakira")
years <- c(2020)
paths <- c("data/output/jlo_set_lists.csv", "data/output/shakira_set_lists.csv")

openers <- pmap(list(names, years, paths), load_all_openers) %>% map_df(as_tibble)
```

    ## Parsed with column specification:
    ## cols(
    ##   sets = col_character(),
    ##   artist = col_character(),
    ##   venue = col_character(),
    ##   month = col_character(),
    ##   day = col_double(),
    ##   year = col_double(),
    ##   song_num = col_double()
    ## )

    ## mutate: new variable 'keep' with one unique value and 0% NA

    ## filter: removed 3,748 rows (92%), 337 rows remaining

    ## group_by: one grouping variable (sets)

    ## summarize: now 50 rows and 2 columns, ungrouped

    ## mutate: new variable 'pct' with 8 unique values and 0% NA

    ## Parsed with column specification:
    ## cols(
    ##   sets = col_character(),
    ##   artist = col_character(),
    ##   venue = col_character(),
    ##   month = col_character(),
    ##   day = col_double(),
    ##   year = col_double(),
    ##   song_num = col_double()
    ## )

    ## mutate: new variable 'keep' with one unique value and 0% NA

    ## filter: removed 7,114 rows (92%), 648 rows remaining

    ## group_by: one grouping variable (sets)

    ## summarize: now 59 rows and 2 columns, ungrouped

    ## mutate: new variable 'pct' with 10 unique values and 0% NA

You now have a list containing song openers by artist, with the
frequency and share computed.

``` r
openers %>% filter(artist == "Jennifer Lopez")
```

    ## filter: removed 59 rows (54%), 50 rows remaining

    ## # A tibble: 50 x 4
    ##    songs                       n   pct artist        
    ##    <chr>                   <int> <dbl> <chr>         
    ##  1 Get Right                  96  0.28 Jennifer Lopez
    ##  2 If You Had My Love         76  0.23 Jennifer Lopez
    ##  3 Medicine                   25  0.07 Jennifer Lopez
    ##  4 Do It Well                 24  0.07 Jennifer Lopez
    ##  5 Love Don't Cost a Thing    12  0.04 Jennifer Lopez
    ##  6 Waiting for Tonight        11  0.03 Jennifer Lopez
    ##  7 On the Floor                8  0.02 Jennifer Lopez
    ##  8 Booty                       7  0.02 Jennifer Lopez
    ##  9 Live It Up                  6  0.02 Jennifer Lopez
    ## 10 First Love                  5  0.01 Jennifer Lopez
    ## # … with 40 more rows

``` r
openers %>% filter(artist == "Shakira")
```

    ## filter: removed 50 rows (46%), 59 rows remaining

    ## # A tibble: 59 x 4
    ##    songs                                  n   pct artist 
    ##    <chr>                              <int> <dbl> <chr>  
    ##  1 Estoy aquí                           132  0.2  Shakira
    ##  2 Vuelve                                91  0.14 Shakira
    ##  3 Pienso en ti                          81  0.12 Shakira
    ##  4 Estoy aquí / ¿Dónde estás corazón?    54  0.08 Shakira
    ##  5 Whenever, Wherever                    47  0.07 Shakira
    ##  6 Ojos así                              39  0.06 Shakira
    ##  7 ¿Dónde estás corazón?                 22  0.03 Shakira
    ##  8 Don't Bother                          15  0.02 Shakira
    ##  9 Underneath Your Clothes               15  0.02 Shakira
    ## 10 Objection (Tango)                     12  0.02 Shakira
    ## # … with 49 more rows

``` r
openers_by_year <- load_all_openers_by_year("Jennifer Lopez", 2020, "data/output/jlo_set_lists.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   sets = col_character(),
    ##   artist = col_character(),
    ##   venue = col_character(),
    ##   month = col_character(),
    ##   day = col_double(),
    ##   year = col_double(),
    ##   song_num = col_double()
    ## )

    ## mutate: new variable 'keep' with one unique value and 0% NA

    ## filter: removed 3,748 rows (92%), 337 rows remaining

    ## group_by: 2 grouping variables (year, sets)

    ## summarize: now 79 rows and 3 columns, one group variable remaining (year)

    ## mutate (grouped): new variable 'pct' with 28 unique values and 0% NA

``` r
as_tibble(openers_by_year)
```

    ## # A tibble: 79 x 5
    ##     year songs                             n   pct artist        
    ##    <dbl> <chr>                         <int> <dbl> <chr>         
    ##  1  2019 Medicine                         25  0.83 Jennifer Lopez
    ##  2  2019 Baila conmigo                     1  0.03 Jennifer Lopez
    ##  3  2019 Dancing in the Street             1  0.03 Jennifer Lopez
    ##  4  2019 Dancing Machine                   1  0.03 Jennifer Lopez
    ##  5  2019 Live It Up                        1  0.03 Jennifer Lopez
    ##  6  2019 Santa Claus Is Coming to Town     1  0.03 Jennifer Lopez
    ##  7  2018 Limitless                         3  0.25 Jennifer Lopez
    ##  8  2018 Get Right                         2  0.17 Jennifer Lopez
    ##  9  2018 If You Had My Love                2  0.17 Jennifer Lopez
    ## 10  2018 Waiting for Tonight               2  0.17 Jennifer Lopez
    ## # … with 69 more rows
