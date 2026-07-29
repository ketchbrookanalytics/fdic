# Retrieve Historic Bank Failure Data

Queries the `/failures` endpoint of the FDIC BankFind Suite API,
returning data for failed financial institutions from 1934 to present.

## Usage

``` r
get_failures(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE,
  limit = 10000
)
```

## Arguments

- api_key:

  (String) Your FDIC API key. Defaults to the value of the
  `FDIC_API_KEY` environment variable. A key is strongly recommended:
  use `"DEMO_KEY"` for exploration (30 req/hr, 50 req/day), or register
  for a free personal key (1,000 req/hr) at
  <https://api.data.gov/signup/>.

- filters:

  (String) An optional Elasticsearch query string to filter results. All
  field names and values must be uppercase.

- fields:

  (String or Character vector) Fields to include in the response. An
  `ID` column is always present, regardless of the fields requested. To
  retrieve the most recently published API definition for an endpoint,
  replace the `get_` prefix in the function name with `fdic_` (e.g.,
  `get_{endpoint}()` to `fdic_{endpoint}()`).

- sort_by:

  (String) Field name to sort results by. Defaults to the API default
  sort order for this endpoint.

- descending:

  (Logical) Should results be sorted in descending order? Only applies
  when `sort_by` is specified. Defaults to `FALSE`.

- limit:

  (Integer) Number of records to return. Must be between 1 and 10,000.
  Defaults to 10,000.

## Value

A tibble containing bank failure data for FDIC-insured institutions,
with one row per failure event.

## Examples

``` r
# Return the 5 most recent bank failures
get_failures(
  sort_by = "FAILDATE",
  descending = TRUE,
  limit = 5
)
#> # A tibble: 5 × 33
#>   BANKNO BIDCITY    BIDNAME BIDSTATE BRDATE BSTATUS  CERT CHCLASS CHCLASS1 CITY 
#>   <lgl>  <chr>      <chr>   <chr>    <lgl>  <chr>   <int> <chr>   <chr>    <chr>
#> 1 NA     PALM BEAC… ANCHOR… FL       NA     ""      25796 NM      NM       LAGR…
#> 2 NA     DETROIT    FIRST … MI       NA     "A"     57488 NM      NM       CHIC…
#> 3 NA     COLEMAN    COLEMA… TX       NA     "A"      5520 N       N        SANT…
#> 4 NA     DES PLAIN… MILLEN… IL       NA     "A"     28611 SI      SI       CHIC…
#> 5 NA     DUNCAN     FIRST … OK       NA     "A"      4134 N       N        LIND…
#> # ℹ 23 more variables: CITYST <chr>, CLOSCD <chr>, COMMENTS <lgl>, COST <int>,
#> #   COSTMOSTRECENTASOF <chr>, FAILDATE <chr>, FAILYR <int>, FIN <int>,
#> #   FSL_PROG <lgl>, FUND <int>, ID <int>, NAME <chr>, PSTALP <chr>,
#> #   PTRDATE <int>, QBFASSET <int>, QBFDEP <int>, RESDATE <chr>, RESTYPE <chr>,
#> #   RESTYPE1 <chr>, SAVR <chr>, TERMI <lgl>, UNINSDEP <lgl>, URL <lgl>

# Filter to failures in a single state
get_failures(
  filters = "PSTALP:NY",
  limit = 5
)
#> # A tibble: 5 × 33
#>   BANKNO BIDCITY    BIDNAME BIDSTATE BRDATE BSTATUS  CERT CHCLASS CHCLASS1 CITY 
#>   <lgl>  <chr>      <chr>   <chr>    <chr>  <chr>   <int> <chr>   <chr>    <chr>
#> 1 NA     0          HONGKO… 0        ""     "I"     22452 N       N        NEW …
#> 2 NA     SYOSSET    LONG I… NY       "85-0… ""      28504 SL      SL       FLUS…
#> 3 NA     HIGHLAND   FIRST … NY       ""     "I"     21562 N       N        RAMA…
#> 4 NA     NEW YORK   BOWERY… NY       ""     ""      15919 SI      SI       NEW …
#> 5 NA     WHITE PLA… HOME S… NY       ""     ""      16074 SI      SI       WHIT…
#> # ℹ 23 more variables: CITYST <chr>, CLOSCD <chr>, COMMENTS <lgl>, COST <int>,
#> #   COSTMOSTRECENTASOF <chr>, FAILDATE <chr>, FAILYR <int>, FIN <int>,
#> #   FSL_PROG <chr>, FUND <int>, ID <int>, NAME <chr>, PSTALP <chr>,
#> #   PTRDATE <int>, QBFASSET <int>, QBFDEP <int>, RESDATE <chr>, RESTYPE <chr>,
#> #   RESTYPE1 <chr>, SAVR <chr>, TERMI <lgl>, UNINSDEP <lgl>, URL <chr>

# Return specific fields only
get_failures(
  fields = c("CERT", "FAILDATE", "NAME", "PSTALP"),
  limit = 5
)
#> # A tibble: 5 × 5
#>    CERT FAILDATE      ID NAME                                       PSTALP
#>   <int> <chr>      <int> <chr>                                      <chr> 
#> 1    NA 5/28/1934      1 FON DU LAC STATE BANK                      IL    
#> 2    NA 1/3/1935      10 CLIFFSIDE PARK TITLE GUARANTEE & TRUST CO. NJ    
#> 3    NA 12/21/1936   100 THE CUMMINGS STATE BANK                    ND    
#> 4 30965 5/31/1985   1000 CENTRAL S&LA                               CA    
#> 5 18388 5/31/1985   1001 FAIRFIELD STATE BANK                       NE    
```
