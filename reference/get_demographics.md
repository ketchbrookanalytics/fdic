# Retrieve Summary of Demographic Data for FDIC-Insured Institutions

Queries the `/demographics` endpoint of the FDIC BankFind Suite API,
returning demographic data for FDIC-insured financial institutions.

## Usage

``` r
get_demographics(
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

A tibble containing demographic data for FDIC-insured institutions, with
one row per institution.

## Examples

``` r
# Return demographic data for a specific institution
get_demographics(filters = "CERT:10002")
#> # A tibble: 137 × 55
#>    ACTEVT BRANCH CALLYM  CALLYMD CBSANAME  CERT CLCODE CNTRYALP CNTRYNUM CNTYNUM
#>     <int>  <int>  <int>    <int> <chr>    <int>  <int> <chr>       <int>   <int>
#>  1     NA      1 198403 19840331 WHEELIN… 10002      3 US           1007      69
#>  2    810      1 198406 19840630 WHEELIN… 10002      3 US           1007      69
#>  3    810      1 198409 19840930 WHEELIN… 10002      3 US           1007      69
#>  4    810      1 198412 19841231 WHEELIN… 10002      3 US           1007      69
#>  5    810      1 198503 19850331 WHEELIN… 10002      3 US           1007      69
#>  6    810      1 198506 19850630 WHEELIN… 10002      3 US           1007      69
#>  7    810      1 198509 19850930 WHEELIN… 10002      3 US           1007      69
#>  8    810      1 198512 19851231 WHEELIN… 10002      3 US           1007      69
#>  9    810      1 198603 19860331 WHEELIN… 10002      3 US           1007      69
#> 10    810      1 198606 19860630 WHEELIN… 10002      3 US           1007      69
#> # ℹ 127 more rows
#> # ℹ 45 more variables: CSA <lgl>, DIVISION <int>, DOCKET <int>, FDICAREA <int>,
#> #   FDICTERR <chr>, FLDOFDCA <chr>, HCTNONE <lgl>, ID <chr>, INSAGNT2 <lgl>,
#> #   METRO <int>, MICRO <int>, MNRTYCDE <lgl>, MNRTYDTE <int>, OAKAR <int>,
#> #   OFFDMULT <int>, OFFNDOM <int>, OFFOTH <int>, OFFSOD <int>, OFFSTATE <int>,
#> #   OFFTOT <int>, OFFUSOA <int>, QTRNO <int>, REPDTE <int>, REPDTE_INT <lgl>,
#> #   RISKTERR <chr>, SASSER <int>, SIMS_LAT <dbl>, SIMS_LONG <dbl>, …

# Return specific fields only
get_demographics(
  fields = c("CERT", "OFFSTATE", "OFFTOT", "REPDTE"),
  limit = 5
)
#> # A tibble: 5 × 5
#>    CERT ID             OFFSTATE OFFTOT   REPDTE
#>   <int> <chr>             <int>  <int>    <int>
#> 1 10002 10002_19840331        1      2 19840331
#> 2 10002 10002_19840630        1      3 19840630
#> 3 10002 10002_19840930        1      3 19840930
#> 4 10002 10002_19841231        1      3 19841231
#> 5 10002 10002_19850331        1      3 19850331

# Sort by report date in descending order
get_demographics(
  fields = c("CERT", "OFFTOT", "REPDTE"),
  sort_by = "REPDTE",
  descending = TRUE,
  limit = 5
)
#> # A tibble: 5 × 4
#>    CERT ID             OFFTOT   REPDTE
#>   <int> <chr>           <int>    <int>
#> 1 10004 10004_20250630      5 20250630
#> 2 10011 10011_20250630      6 20250630
#> 3 10012 10012_20250630      4 20250630
#> 4 10015 10015_20250630      4 20250630
#> 5 10044 10044_20250630     34 20250630
```
