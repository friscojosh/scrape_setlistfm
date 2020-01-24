setlist.fm scraper
================

For prop bets on which song an act is likely to open their set with,
historical data are useful to compute base rates. The best source of
data on which songs performers have used to open their sets in the past
is published on a wiki called setlist.fm. The functions in the
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

When the scape cpmpletes you’ll want to inspect the data and clean it
where necessary. This step is beyond the scope of this document. However
you can simply summarize the data as-is with the quick helper function
`load_all_openers()` The function accepts the artist’s name, the year of
the Super Bowl performance, and path to the data file created by
`scrape_artist()` as arguments.

``` r
library(purrr)
source("scripts/functions/summarize_data.R") # scraping functions

names <- c("Jennifer Lopez", "Shakira")
years <- c(2020, 2020)
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
openers %>% filter(artist == "Jennifer Lopez") %>% kable()
```

    ## filter: removed 59 rows (54%), 50 rows remaining

| songs                                                                                          |  n |  pct | artist         |
| :--------------------------------------------------------------------------------------------- | -: | ---: | :------------- |
| Get Right                                                                                      | 96 | 0.28 | Jennifer Lopez |
| If You Had My Love                                                                             | 76 | 0.23 | Jennifer Lopez |
| Medicine                                                                                       | 25 | 0.07 | Jennifer Lopez |
| Do It Well                                                                                     | 24 | 0.07 | Jennifer Lopez |
| Love Don’t Cost a Thing                                                                        | 12 | 0.04 | Jennifer Lopez |
| Waiting for Tonight                                                                            | 11 | 0.03 | Jennifer Lopez |
| On the Floor                                                                                   |  8 | 0.02 | Jennifer Lopez |
| Booty                                                                                          |  7 | 0.02 | Jennifer Lopez |
| Live It Up                                                                                     |  6 | 0.02 | Jennifer Lopez |
| First Love                                                                                     |  5 | 0.01 | Jennifer Lopez |
| Ain’t It Funny                                                                                 |  4 | 0.01 | Jennifer Lopez |
| Dance Again                                                                                    |  4 | 0.01 | Jennifer Lopez |
| Jenny From the Block                                                                           |  4 | 0.01 | Jennifer Lopez |
| Louboutins                                                                                     |  4 | 0.01 | Jennifer Lopez |
| ¿Qué hiciste?                                                                                  |  3 | 0.01 | Jennifer Lopez |
| Jenny From the Block / Ain’t It Funny / Waiting for Tonight / Love Don’t Cost a Thing          |  3 | 0.01 | Jennifer Lopez |
| Let’s Get Loud                                                                                 |  3 | 0.01 | Jennifer Lopez |
| Limitless                                                                                      |  3 | 0.01 | Jennifer Lopez |
| No me ames                                                                                     |  3 | 0.01 | Jennifer Lopez |
| Feelin’ So Good                                                                                |  2 | 0.01 | Jennifer Lopez |
| Hold It Don’t Drop It                                                                          |  2 | 0.01 | Jennifer Lopez |
| Love Make the World Go Round                                                                   |  2 | 0.01 | Jennifer Lopez |
| Play                                                                                           |  2 | 0.01 | Jennifer Lopez |
| Until It Beats No More                                                                         |  2 | 0.01 | Jennifer Lopez |
| (What Is) Love?                                                                                |  1 | 0.00 | Jennifer Lopez |
| Ain’t Your Mama                                                                                |  1 | 0.00 | Jennifer Lopez |
| Alive                                                                                          |  1 | 0.00 | Jennifer Lopez |
| Baila conmigo                                                                                  |  1 | 0.00 | Jennifer Lopez |
| Como la flor                                                                                   |  1 | 0.00 | Jennifer Lopez |
| Dancing in the Street                                                                          |  1 | 0.00 | Jennifer Lopez |
| Dancing Machine                                                                                |  1 | 0.00 | Jennifer Lopez |
| Diamonds                                                                                       |  1 | 0.00 | Jennifer Lopez |
| Dinero                                                                                         |  1 | 0.00 | Jennifer Lopez |
| El anillo                                                                                      |  1 | 0.00 | Jennifer Lopez |
| Feel the Light                                                                                 |  1 | 0.00 | Jennifer Lopez |
| Goin’ In                                                                                       |  1 | 0.00 | Jennifer Lopez |
| Heartbreak Hotel                                                                               |  1 | 0.00 | Jennifer Lopez |
| I Luh Ya Papi                                                                                  |  1 | 0.00 | Jennifer Lopez |
| I’m Into You                                                                                   |  1 | 0.00 | Jennifer Lopez |
| I’m Real                                                                                       |  1 | 0.00 | Jennifer Lopez |
| If You Had My Love / Love Don’t Cost a Thing / Jenny From the Block / Get Right / On the Floor |  1 | 0.00 | Jennifer Lopez |
| Llorando se fué                                                                                |  1 | 0.00 | Jennifer Lopez |
| Loving You                                                                                     |  1 | 0.00 | Jennifer Lopez |
| Mírate                                                                                         |  1 | 0.00 | Jennifer Lopez |
| Ni tú ni yo                                                                                    |  1 | 0.00 | Jennifer Lopez |
| Olvídame y pega la vuelta                                                                      |  1 | 0.00 | Jennifer Lopez |
| Por arriesgarnos                                                                               |  1 | 0.00 | Jennifer Lopez |
| Quimbara / Bemba colorá / La vida es un carnaval                                               |  1 | 0.00 | Jennifer Lopez |
| Santa Claus Is Coming to Town                                                                  |  1 | 0.00 | Jennifer Lopez |
| True Colors                                                                                    |  1 | 0.00 | Jennifer Lopez |

``` r
openers %>% filter(artist == "Shakira") %>% kable()
```

    ## filter: removed 50 rows (46%), 59 rows remaining

| songs                              |   n |  pct | artist  |
| :--------------------------------- | --: | ---: | :------ |
| Estoy aquí                         | 132 | 0.20 | Shakira |
| Vuelve                             |  91 | 0.14 | Shakira |
| Pienso en ti                       |  81 | 0.12 | Shakira |
| Estoy aquí / ¿Dónde estás corazón? |  54 | 0.08 | Shakira |
| Whenever, Wherever                 |  47 | 0.07 | Shakira |
| Ojos así                           |  39 | 0.06 | Shakira |
| ¿Dónde estás corazón?              |  22 | 0.03 | Shakira |
| Don’t Bother                       |  15 | 0.02 | Shakira |
| Underneath Your Clothes            |  15 | 0.02 | Shakira |
| Objection (Tango)                  |  12 | 0.02 | Shakira |
| Ciega, sordomuda                   |  11 | 0.02 | Shakira |
| La tortura                         |  10 | 0.02 | Shakira |
| Años luz                           |   7 | 0.01 | Shakira |
| Hips Don’t Lie                     |   7 | 0.01 | Shakira |
| She Wolf                           |   7 | 0.01 | Shakira |
| Suerte (Whenever, Wherever)        |   7 | 0.01 | Shakira |
| Empire                             |   6 | 0.01 | Shakira |
| Inevitable                         |   6 | 0.01 | Shakira |
| La Tortura                         |   5 | 0.01 | Shakira |
| Can’t Remember to Forget You       |   4 | 0.01 | Shakira |
| Did It Again                       |   4 | 0.01 | Shakira |
| Loca                               |   4 | 0.01 | Shakira |
| Why Wait                           |   4 | 0.01 | Shakira |
| Give It Up to Me                   |   3 | 0.00 | Shakira |
| Hey You                            |   3 | 0.00 | Shakira |
| La pared                           |   3 | 0.00 | Shakira |
| Loba                               |   3 | 0.00 | Shakira |
| Me enamoré                         |   3 | 0.00 | Shakira |
| Waka Waka (This Time for Africa)   |   3 | 0.00 | Shakira |
| 23                                 |   2 | 0.00 | Shakira |
| Antes de las seis                  |   2 | 0.00 | Shakira |
| Día de enero                       |   2 | 0.00 | Shakira |
| Medicine                           |   2 | 0.00 | Shakira |
| No                                 |   2 | 0.00 | Shakira |
| Pies descalzos, sueños blancos     |   2 | 0.00 | Shakira |
| Te aviso, te anuncio (Tango)       |   2 | 0.00 | Shakira |
| Te dejo Madrid                     |   2 | 0.00 | Shakira |
| The Song Remains                   |   2 | 0.00 | Shakira |
| Welcome to the Jungle              |   2 | 0.00 | Shakira |
| Brick Wall Falling                 |   1 | 0.00 | Shakira |
| Dude (Looks Like a Lady)           |   1 | 0.00 | Shakira |
| Eres                               |   1 | 0.00 | Shakira |
| Fool                               |   1 | 0.00 | Shakira |
| Gitana                             |   1 | 0.00 | Shakira |
| Gypsy                              |   1 | 0.00 | Shakira |
| Higher Ground                      |   1 | 0.00 | Shakira |
| I’ll Stand by You                  |   1 | 0.00 | Shakira |
| Illegal                            |   1 | 0.00 | Shakira |
| Imagine                            |   1 | 0.00 | Shakira |
| Je l’aime à mourir                 |   1 | 0.00 | Shakira |
| La La La (Brazil 2014)             |   1 | 0.00 | Shakira |
| Morning Over Morocco               |   1 | 0.00 | Shakira |
| No creo                            |   1 | 0.00 | Shakira |
| Octavo día                         |   1 | 0.00 | Shakira |
| Que me quedes tú                   |   1 | 0.00 | Shakira |
| Será será (Las caderas no mienten) |   1 | 0.00 | Shakira |
| Te olvidé                          |   1 | 0.00 | Shakira |
| Toneladas                          |   1 | 0.00 | Shakira |
| You Were Always on My Mind         |   1 | 0.00 | Shakira |

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
as_tibble(openers_by_year) %>%  kable()
```

| year | songs                                                                                          |  n |  pct | artist         |
| ---: | :--------------------------------------------------------------------------------------------- | -: | ---: | :------------- |
| 2019 | Medicine                                                                                       | 25 | 0.83 | Jennifer Lopez |
| 2019 | Baila conmigo                                                                                  |  1 | 0.03 | Jennifer Lopez |
| 2019 | Dancing in the Street                                                                          |  1 | 0.03 | Jennifer Lopez |
| 2019 | Dancing Machine                                                                                |  1 | 0.03 | Jennifer Lopez |
| 2019 | Live It Up                                                                                     |  1 | 0.03 | Jennifer Lopez |
| 2019 | Santa Claus Is Coming to Town                                                                  |  1 | 0.03 | Jennifer Lopez |
| 2018 | Limitless                                                                                      |  3 | 0.25 | Jennifer Lopez |
| 2018 | Get Right                                                                                      |  2 | 0.17 | Jennifer Lopez |
| 2018 | If You Had My Love                                                                             |  2 | 0.17 | Jennifer Lopez |
| 2018 | Waiting for Tonight                                                                            |  2 | 0.17 | Jennifer Lopez |
| 2018 | Dinero                                                                                         |  1 | 0.08 | Jennifer Lopez |
| 2018 | El anillo                                                                                      |  1 | 0.08 | Jennifer Lopez |
| 2018 | Heartbreak Hotel                                                                               |  1 | 0.08 | Jennifer Lopez |
| 2017 | If You Had My Love                                                                             | 29 | 0.85 | Jennifer Lopez |
| 2017 | I’m Real                                                                                       |  1 | 0.03 | Jennifer Lopez |
| 2017 | Jenny From the Block                                                                           |  1 | 0.03 | Jennifer Lopez |
| 2017 | Mírate                                                                                         |  1 | 0.03 | Jennifer Lopez |
| 2017 | Ni tú ni yo                                                                                    |  1 | 0.03 | Jennifer Lopez |
| 2017 | Waiting for Tonight                                                                            |  1 | 0.03 | Jennifer Lopez |
| 2016 | If You Had My Love                                                                             | 42 | 0.86 | Jennifer Lopez |
| 2016 | Love Make the World Go Round                                                                   |  2 | 0.04 | Jennifer Lopez |
| 2016 | Ain’t Your Mama                                                                                |  1 | 0.02 | Jennifer Lopez |
| 2016 | Love Don’t Cost a Thing                                                                        |  1 | 0.02 | Jennifer Lopez |
| 2016 | No me ames                                                                                     |  1 | 0.02 | Jennifer Lopez |
| 2016 | Olvídame y pega la vuelta                                                                      |  1 | 0.02 | Jennifer Lopez |
| 2016 | Waiting for Tonight                                                                            |  1 | 0.02 | Jennifer Lopez |
| 2015 | Booty                                                                                          |  3 | 0.33 | Jennifer Lopez |
| 2015 | Como la flor                                                                                   |  1 | 0.11 | Jennifer Lopez |
| 2015 | Diamonds                                                                                       |  1 | 0.11 | Jennifer Lopez |
| 2015 | Feel the Light                                                                                 |  1 | 0.11 | Jennifer Lopez |
| 2015 | If You Had My Love / Love Don’t Cost a Thing / Jenny From the Block / Get Right / On the Floor |  1 | 0.11 | Jennifer Lopez |
| 2015 | On the Floor                                                                                   |  1 | 0.11 | Jennifer Lopez |
| 2015 | Waiting for Tonight                                                                            |  1 | 0.11 | Jennifer Lopez |
| 2014 | First Love                                                                                     |  5 | 0.28 | Jennifer Lopez |
| 2014 | Get Right                                                                                      |  5 | 0.28 | Jennifer Lopez |
| 2014 | Booty                                                                                          |  4 | 0.22 | Jennifer Lopez |
| 2014 | I Luh Ya Papi                                                                                  |  1 | 0.06 | Jennifer Lopez |
| 2014 | Jenny From the Block                                                                           |  1 | 0.06 | Jennifer Lopez |
| 2014 | Let’s Get Loud                                                                                 |  1 | 0.06 | Jennifer Lopez |
| 2014 | True Colors                                                                                    |  1 | 0.06 | Jennifer Lopez |
| 2013 | Live It Up                                                                                     |  5 | 0.45 | Jennifer Lopez |
| 2013 | Get Right                                                                                      |  3 | 0.27 | Jennifer Lopez |
| 2013 | Jenny From the Block                                                                           |  1 | 0.09 | Jennifer Lopez |
| 2013 | On the Floor                                                                                   |  1 | 0.09 | Jennifer Lopez |
| 2013 | Quimbara / Bemba colorá / La vida es un carnaval                                               |  1 | 0.09 | Jennifer Lopez |
| 2012 | Get Right                                                                                      | 79 | 0.92 | Jennifer Lopez |
| 2012 | Dance Again                                                                                    |  4 | 0.05 | Jennifer Lopez |
| 2012 | Goin’ In                                                                                       |  1 | 0.01 | Jennifer Lopez |
| 2012 | Hold It Don’t Drop It                                                                          |  1 | 0.01 | Jennifer Lopez |
| 2012 | Llorando se fué                                                                                |  1 | 0.01 | Jennifer Lopez |
| 2011 | On the Floor                                                                                   |  6 | 0.50 | Jennifer Lopez |
| 2011 | Get Right                                                                                      |  2 | 0.17 | Jennifer Lopez |
| 2011 | Waiting for Tonight                                                                            |  2 | 0.17 | Jennifer Lopez |
| 2011 | I’m Into You                                                                                   |  1 | 0.08 | Jennifer Lopez |
| 2011 | Until It Beats No More                                                                         |  1 | 0.08 | Jennifer Lopez |
| 2010 | Get Right                                                                                      |  2 | 0.25 | Jennifer Lopez |
| 2010 | No me ames                                                                                     |  2 | 0.25 | Jennifer Lopez |
| 2010 | (What Is) Love?                                                                                |  1 | 0.12 | Jennifer Lopez |
| 2010 | Hold It Don’t Drop It                                                                          |  1 | 0.12 | Jennifer Lopez |
| 2010 | Por arriesgarnos                                                                               |  1 | 0.12 | Jennifer Lopez |
| 2010 | Until It Beats No More                                                                         |  1 | 0.12 | Jennifer Lopez |
| 2009 | Louboutins                                                                                     |  4 | 1.00 | Jennifer Lopez |
| 2008 | Do It Well                                                                                     |  1 | 0.50 | Jennifer Lopez |
| 2008 | Waiting for Tonight                                                                            |  1 | 0.50 | Jennifer Lopez |
| 2007 | Do It Well                                                                                     | 23 | 0.88 | Jennifer Lopez |
| 2007 | ¿Qué hiciste?                                                                                  |  3 | 0.12 | Jennifer Lopez |
| 2005 | Get Right                                                                                      |  3 | 0.50 | Jennifer Lopez |
| 2005 | Jenny From the Block / Ain’t It Funny / Waiting for Tonight / Love Don’t Cost a Thing          |  3 | 0.50 | Jennifer Lopez |
| 2002 | Alive                                                                                          |  1 | 0.33 | Jennifer Lopez |
| 2002 | Jenny From the Block                                                                           |  1 | 0.33 | Jennifer Lopez |
| 2002 | Loving You                                                                                     |  1 | 0.33 | Jennifer Lopez |
| 2001 | Love Don’t Cost a Thing                                                                        |  5 | 0.38 | Jennifer Lopez |
| 2001 | Ain’t It Funny                                                                                 |  4 | 0.31 | Jennifer Lopez |
| 2001 | Let’s Get Loud                                                                                 |  2 | 0.15 | Jennifer Lopez |
| 2001 | Play                                                                                           |  2 | 0.15 | Jennifer Lopez |
| 2000 | Love Don’t Cost a Thing                                                                        |  6 | 0.75 | Jennifer Lopez |
| 2000 | Feelin’ So Good                                                                                |  2 | 0.25 | Jennifer Lopez |
| 1999 | If You Had My Love                                                                             |  3 | 0.50 | Jennifer Lopez |
| 1999 | Waiting for Tonight                                                                            |  3 | 0.50 | Jennifer Lopez |
