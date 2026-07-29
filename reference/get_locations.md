# Retrieve Financial Institution Locations

Queries the `/locations` endpoint of the FDIC BankFind Suite API,
returning location data for FDIC-insured financial institutions.

## Usage

``` r
get_locations(
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

A tibble containing location data for FDIC-insured institutions, with
one row per institution location.

## Examples

``` r
# Return branch locations in New York
get_locations(
  filters = "STALP:NY",
  limit = 5
)
#> # A tibble: 5 × 38
#>   ACQDATE    ADDRESS    ADDRESS2 BKCLASS CBSA  CBSA_DIV CBSA_DIV_FLG CBSA_DIV_NO
#>   <chr>      <chr>      <lgl>    <chr>   <chr> <chr>           <int>       <int>
#> 1 07/01/1992 6 State S… NA       SM      Roch… ""                  0          NA
#> 2 10/08/2016 11 Divisi… NA       N       Amst… ""                  0          NA
#> 3 11/30/2007 68 Exchan… NA       SM      Bing… ""                  0          NA
#> 4 01/01/1987 12 Westch… NA       SI      New … "New Yo…            1       35614
#> 5 05/31/1991 1 Fountai… NA       SM      Buff… ""                  0          NA
#> # ℹ 30 more variables: CBSA_METRO <int>, CBSA_METRO_FLG <int>,
#> #   CBSA_METRO_NAME <chr>, CBSA_MICRO_FLG <int>, CBSA_NO <int>, CERT <int>,
#> #   CITY <chr>, COUNTY <chr>, CSA <chr>, CSA_FLG <int>, CSA_NO <int>,
#> #   ESTYMD <chr>, FI_UNINUM <int>, ID <int>, LATITUDE <dbl>, LONGITUDE <dbl>,
#> #   MAINOFF <int>, MDI_STATUS_CODE <lgl>, MDI_STATUS_DESC <chr>, NAME <chr>,
#> #   OFFNAME <chr>, OFFNUM <int>, RUNDATE <chr>, SERVTYPE <int>,
#> #   SERVTYPE_DESC <chr>, STALP <chr>, STCNTY <int>, STNAME <chr>, …

# Return specific fields only
get_locations(
  filters = "STALP:ND",
  fields = c("ADDRESS", "CERT", "CITY", "STALP"),
  limit = 5
)
#> # A tibble: 5 × 5
#>   ADDRESS          CERT CITY          ID STALP
#>   <chr>           <int> <chr>      <int> <chr>
#> 1 205 Main Ave    15472 Aneta      10023 ND   
#> 2 210 Sheyenne St  9423 West Fargo 10124 ND   
#> 3 Main Street      8387 Buffalo    10147 ND   
#> 4 509 Parke Ave   15539 Portland   10302 ND   
#> 5 210 8th Ave      9423 Langdon    10373 ND   
```
