BC Election Turnout: EDA Aanalysis
================

## Introduction

In this data analysis project, our research question is that if the
closer election correlated with the higher turnout in BC. We have used
two publicaly available data set
[provincial\_voter\_participation\_by\_age\_group](https://catalogue.data.gov.bc.ca/dataset/6d9db663-8c30-43ec-922b-d541d22e634f/resource/646530d4-078c-4815-8452-c75639962bb4/download/provincial_voter_participation_by_age_group.csv)
and
[provincial\_voting\_results](https://catalogue.data.gov.bc.ca/dataset/44914a35-de9a-4830-ac48-870001ef8935/resource/fb40239e-b718-4a79-b18f-7a62139d9792/download/provincial_voting_results.csv).

## EDA analysis

In the first step, we load the library need for our EDA analysis.

### Loading the packages

    ## -- Attaching packages ---------------------------------------------------------- tidyverse 1.3.0 --

    ## v ggplot2 3.3.2     v purrr   0.3.4
    ## v tibble  3.0.3     v dplyr   1.0.2
    ## v tidyr   1.1.2     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.5.0

    ## -- Conflicts ------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

    ## Warning: package 'here' was built under R version 4.0.3

    ## here() starts at C:/Users/smoravejjahr/MDS_2020/dsci_522/project

    ## 
    ## Attaching package: 'janitor'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     chisq.test, fisher.test

### Loading the data

In the next step, we load our data set.

``` r
file_path1 <- here::here("data", "raw", "provincial_voting_results.csv")
voting_resukts =read_csv(file_path1)
```

    ## Parsed with column specification:
    ## cols(
    ##   EVENT_NAME = col_character(),
    ##   EVENT_YEAR = col_double(),
    ##   ED_ABBREVIATION = col_character(),
    ##   ED_NAME = col_character(),
    ##   VA_CODE = col_character(),
    ##   EDVA_CODE = col_character(),
    ##   ADVANCE_VOTING_LOCATION = col_character(),
    ##   ADDRESS_STANDARD_ID = col_double(),
    ##   VOTING_OPPORTUNITY = col_character(),
    ##   CANDIDATE = col_character(),
    ##   ELECTED = col_character(),
    ##   AFFILIATION = col_character(),
    ##   VOTES_CONSIDERED = col_double(),
    ##   VOTE_CATEGORY = col_character(),
    ##   COMBINED_INDICATOR = col_character(),
    ##   RESULTS_REPORTED_UNDER = col_character()
    ## )

``` r
file_path2 <- here::here("data", "raw", "participation_by_age_group.csv")
participation = read_csv(file_path2)
```

    ## Parsed with column specification:
    ## cols(
    ##   EVENT_NAME = col_character(),
    ##   EVENT_YEAR = col_double(),
    ##   ED_ABBREVIATION = col_character(),
    ##   ED_NAME = col_character(),
    ##   AGE_GROUP = col_character(),
    ##   PARTICIPATION = col_number(),
    ##   REGISTERED_VOTERS = col_number(),
    ##   EVENT_DATE_TEXT = col_character()
    ## )

lets look at the data set first to get more familiar with the data and
its features. First, we’ll take a look at the `voting_results` data set.

``` r
str(voting_resukts)
```

    ## tibble [221,082 x 16] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ EVENT_NAME             : chr [1:221082] "General Election 2005" "General Election 2005" "General Election 2005" "General Election 2005" ...
    ##  $ EVENT_YEAR             : num [1:221082] 2005 2005 2005 2005 2005 ...
    ##  $ ED_ABBREVIATION        : chr [1:221082] "ABC" "ABC" "ABC" "ABC" ...
    ##  $ ED_NAME                : chr [1:221082] "Abbotsford-Clayburn" "Abbotsford-Clayburn" "Abbotsford-Clayburn" "Abbotsford-Clayburn" ...
    ##  $ VA_CODE                : chr [1:221082] NA NA NA NA ...
    ##  $ EDVA_CODE              : chr [1:221082] NA NA NA NA ...
    ##  $ ADVANCE_VOTING_LOCATION: chr [1:221082] "St Ann's Parish Hall" "St Ann's Parish Hall" "St Ann's Parish Hall" "St Ann's Parish Hall" ...
    ##  $ ADDRESS_STANDARD_ID    : num [1:221082] NA NA NA NA NA NA NA NA NA NA ...
    ##  $ VOTING_OPPORTUNITY     : chr [1:221082] "Advance voting" "Advance voting" "Advance voting" "Advance voting" ...
    ##  $ CANDIDATE              : chr [1:221082] "Gilfillan, Iain" "Keillor, Kenneth Montgomery" "Nenn, Michael" "Pizzariello, Lance Anthony Richmond" ...
    ##  $ ELECTED                : chr [1:221082] "N" "N" "N" "N" ...
    ##  $ AFFILIATION            : chr [1:221082] "BC Marijuana Party" "The Freedom Party" "BC NDP" "BC Green Party" ...
    ##  $ VOTES_CONSIDERED       : num [1:221082] 9 15 603 109 1161 ...
    ##  $ VOTE_CATEGORY          : chr [1:221082] "Valid" "Valid" "Valid" "Valid" ...
    ##  $ COMBINED_INDICATOR     : chr [1:221082] "N" "N" "N" "N" ...
    ##  $ RESULTS_REPORTED_UNDER : chr [1:221082] NA NA NA NA ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   EVENT_NAME = col_character(),
    ##   ..   EVENT_YEAR = col_double(),
    ##   ..   ED_ABBREVIATION = col_character(),
    ##   ..   ED_NAME = col_character(),
    ##   ..   VA_CODE = col_character(),
    ##   ..   EDVA_CODE = col_character(),
    ##   ..   ADVANCE_VOTING_LOCATION = col_character(),
    ##   ..   ADDRESS_STANDARD_ID = col_double(),
    ##   ..   VOTING_OPPORTUNITY = col_character(),
    ##   ..   CANDIDATE = col_character(),
    ##   ..   ELECTED = col_character(),
    ##   ..   AFFILIATION = col_character(),
    ##   ..   VOTES_CONSIDERED = col_double(),
    ##   ..   VOTE_CATEGORY = col_character(),
    ##   ..   COMBINED_INDICATOR = col_character(),
    ##   ..   RESULTS_REPORTED_UNDER = col_character()
    ##   .. )

The column names need to be processed. We then look at the head and tail
of our data set.

``` r
voting_resukts <-clean_names(voting_resukts)
head(voting_resukts)
```

    ## # A tibble: 6 x 16
    ##   event_name event_year ed_abbreviation ed_name va_code edva_code
    ##   <chr>           <dbl> <chr>           <chr>   <chr>   <chr>    
    ## 1 General E~       2005 ABC             Abbots~ <NA>    <NA>     
    ## 2 General E~       2005 ABC             Abbots~ <NA>    <NA>     
    ## 3 General E~       2005 ABC             Abbots~ <NA>    <NA>     
    ## 4 General E~       2005 ABC             Abbots~ <NA>    <NA>     
    ## 5 General E~       2005 ABC             Abbots~ <NA>    <NA>     
    ## 6 General E~       2005 ABC             Abbots~ <NA>    <NA>     
    ## # ... with 10 more variables: advance_voting_location <chr>,
    ## #   address_standard_id <dbl>, voting_opportunity <chr>, candidate <chr>,
    ## #   elected <chr>, affiliation <chr>, votes_considered <dbl>,
    ## #   vote_category <chr>, combined_indicator <chr>, results_reported_under <chr>

``` r
tail(voting_resukts)
```

    ## # A tibble: 6 x 16
    ##   event_name event_year ed_abbreviation ed_name va_code edva_code
    ##   <chr>           <dbl> <chr>           <chr>   <chr>   <chr>    
    ## 1 2018 Kelo~       2018 KLW             Kelown~ <NA>    <NA>     
    ## 2 2018 Kelo~       2018 KLW             Kelown~ <NA>    <NA>     
    ## 3 2018 Kelo~       2018 KLW             Kelown~ <NA>    <NA>     
    ## 4 2018 Kelo~       2018 KLW             Kelown~ <NA>    <NA>     
    ## 5 2018 Kelo~       2018 KLW             Kelown~ <NA>    <NA>     
    ## 6 2018 Kelo~       2018 KLW             Kelown~ <NA>    <NA>     
    ## # ... with 10 more variables: advance_voting_location <chr>,
    ## #   address_standard_id <dbl>, voting_opportunity <chr>, candidate <chr>,
    ## #   elected <chr>, affiliation <chr>, votes_considered <dbl>,
    ## #   vote_category <chr>, combined_indicator <chr>, results_reported_under <chr>

After getting familiar with the voting results, we would take a look at
the `participation data` set.

``` r
str(participation)
```

    ## tibble [2,352 x 8] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ EVENT_NAME       : chr [1:2352] "General Election 2005" "General Election 2005" "General Election 2005" "General Election 2005" ...
    ##  $ EVENT_YEAR       : num [1:2352] 2005 2005 2005 2005 2005 ...
    ##  $ ED_ABBREVIATION  : chr [1:2352] "ABC" "ABC" "ABC" "ABC" ...
    ##  $ ED_NAME          : chr [1:2352] "Abbotsford-Clayburn" "Abbotsford-Clayburn" "Abbotsford-Clayburn" "Abbotsford-Clayburn" ...
    ##  $ AGE_GROUP        : chr [1:2352] "18-24" "25-34" "35-44" "45-54" ...
    ##  $ PARTICIPATION    : num [1:2352] 1433 2157 3376 3739 2838 ...
    ##  $ REGISTERED_VOTERS: num [1:2352] 2788 5055 6273 5932 4071 ...
    ##  $ EVENT_DATE_TEXT  : chr [1:2352] "05/17/2005" "05/17/2005" "05/17/2005" "05/17/2005" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   EVENT_NAME = col_character(),
    ##   ..   EVENT_YEAR = col_double(),
    ##   ..   ED_ABBREVIATION = col_character(),
    ##   ..   ED_NAME = col_character(),
    ##   ..   AGE_GROUP = col_character(),
    ##   ..   PARTICIPATION = col_number(),
    ##   ..   REGISTERED_VOTERS = col_number(),
    ##   ..   EVENT_DATE_TEXT = col_character()
    ##   .. )

The column name needs to be processed and then we can take a look at the
first and last few rows of data.

``` r
participation <-clean_names(participation)
head(participation)
```

    ## # A tibble: 6 x 8
    ##   event_name event_year ed_abbreviation ed_name age_group participation
    ##   <chr>           <dbl> <chr>           <chr>   <chr>             <dbl>
    ## 1 General E~       2005 ABC             Abbots~ 18-24              1433
    ## 2 General E~       2005 ABC             Abbots~ 25-34              2157
    ## 3 General E~       2005 ABC             Abbots~ 35-44              3376
    ## 4 General E~       2005 ABC             Abbots~ 45-54              3739
    ## 5 General E~       2005 ABC             Abbots~ 55-64              2838
    ## 6 General E~       2005 ABC             Abbots~ 65-74              2363
    ## # ... with 2 more variables: registered_voters <dbl>, event_date_text <chr>

``` r
tail(participation)
```

    ## # A tibble: 6 x 8
    ##   event_name event_year ed_abbreviation ed_name age_group participation
    ##   <chr>           <dbl> <chr>           <chr>   <chr>             <dbl>
    ## 1 General E~       2017 WVS             West V~ 25-34              2881
    ## 2 General E~       2017 WVS             West V~ 35-44              4660
    ## 3 General E~       2017 WVS             West V~ 45-54              4890
    ## 4 General E~       2017 WVS             West V~ 55-64              4927
    ## 5 General E~       2017 WVS             West V~ 65-74              3683
    ## 6 General E~       2017 WVS             West V~ 75+                1916
    ## # ... with 2 more variables: registered_voters <dbl>, event_date_text <chr>

## Data Wrangling

We need to have access to the turnout for each ED to be able to answer
our question.

``` r
participation <- participation %>%
    group_by(event_name, ed_name) %>%
    summarise(participation = sum(participation), 
              registered_voters = sum (registered_voters)) %>%
    mutate(turnout = participation / registered_voters)
```

    ## `summarise()` regrouping output by 'event_name' (override with `.groups` argument)

``` r
participation
```

    ## # A tibble: 336 x 5
    ## # Groups:   event_name [4]
    ##    event_name         ed_name             participation registered_vote~ turnout
    ##    <chr>              <chr>                       <dbl>            <dbl>   <dbl>
    ##  1 General Election ~ Abbotsford-Clayburn         18631            31312   0.595
    ##  2 General Election ~ Abbotsford-Mount L~         19841            34226   0.580
    ##  3 General Election ~ Alberni-Qualicum            26735            38735   0.690
    ##  4 General Election ~ Bulkley Valley-Sti~         13060            18988   0.688
    ##  5 General Election ~ Burnaby-Edmonds             22283            38617   0.577
    ##  6 General Election ~ Burnaby-Willingdon          20051            34958   0.574
    ##  7 General Election ~ Burnaby North               23011            38505   0.598
    ##  8 General Election ~ Burquitlam                  21817            36089   0.605
    ##  9 General Election ~ Cariboo North               15679            24399   0.643
    ## 10 General Election ~ Cariboo South               15916            23604   0.674
    ## # ... with 326 more rows
