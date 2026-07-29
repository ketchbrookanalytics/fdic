# Retrieve Summary of Deposit (SOD) Data for FDIC-Insured Institutions

Queries the `/sod` endpoint of the FDIC BankFind Suite API, returning
summary of deposit data for FDIC-insured financial institutions.

## Usage

``` r
get_sod(
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

A tibble containing summary of deposits data for FDIC-insured
institutions, with one row per institution location.

## Examples

``` r
# Return Summary of Deposit data for institutions in North York
get_sod(
  filters = "STALP:NY",
  limit = 5
)
#> # A tibble: 5 × 81
#>   ADDRESBR        ADDRESS  ASSET BKCLASS  BKMO BRCENM BRNUM BRSERTYP CALL  CB   
#>   <chr>           <chr>    <int> <chr>   <int> <chr>  <int>    <int> <chr> <lgl>
#> 1 201 Mohawk Ave… 201 Mo… 143810 N           1 "M"        0       11 CALL  NA   
#> 2 1705 Central A… 201 Mo… 143810 N           0 ""         1       11 CALL  NA   
#> 3 1476 Balltown … 201 Mo… 143810 N           0 ""         2       11 CALL  NA   
#> 4 8 Karner Road   201 Mo… 143810 N           0 ""         3       11 CALL  NA   
#> 5 240 Saratoga R… 201 Mo… 143810 N           0 ""         4       11 CALL  NA   
#> # ℹ 71 more variables: CBSA_DIV_NAMB <lgl>, CERT <int>, CHARTER <chr>,
#> #   CHRTAGNN <chr>, CHRTAGNT <chr>, CITY <chr>, CITY2BR <chr>, CITYBR <chr>,
#> #   CITYHCR <lgl>, CLCODE <int>, CNTRYNA <chr>, CNTRYNAB <chr>, CNTYNAMB <chr>,
#> #   CNTYNUMB <int>, CONSOLD <lgl>, CSABR <int>, CSANAMBR <chr>, DENOVO <int>,
#> #   DEPDOM <int>, DEPSUM <int>, DEPSUMBR <int>, DIVISIONB <int>, DOCKET <int>,
#> #   ESCROW <lgl>, FDICDBS <int>, FDICNAME <chr>, FED <int>, FEDNAME <chr>,
#> #   HCTMULT <chr>, ID <chr>, INSAGNT1 <chr>, INSBRDD <int>, INSBRTS <int>, …

# Return specific fields, sorted by total assets descending
get_sod(
  filters = "STALP:NY",
  fields = c("ASSET", "CERT", "CITY", "YEAR"),
  sort_by = "ASSET",
  descending = TRUE,
  limit = 5
)
#> # A tibble: 5 × 5
#>       ASSET  CERT CITY          ID             YEAR
#>       <int> <int> <chr>         <chr>         <int>
#> 1 777345000  7213 New York City 2006_7213_0    2006
#> 2 777345000  7213 New York City 2006_7213_10   2006
#> 3 777345000  7213 New York City 2006_7213_100  2006
#> 4 777345000  7213 New York City 2006_7213_101  2006
#> 5 777345000  7213 New York City 2006_7213_102  2006
```
