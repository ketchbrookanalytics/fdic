# Retrieve Historical Aggregate Data by Year for FDIC-Insured Institutions

Queries the `/summary` endpoint of the FDIC BankFind Suite API,
returning aggregate data by bank type, state, quarter, and year for
FDIC-insured financial institutions.

## Usage

``` r
get_summary(
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

  (String) Your FDIC API key. Required: the FDIC does not accept
  unauthenticated requests. Defaults to the value of the `FDIC_API_KEY`
  environment variable. Register for a free personal key (1,000 req/hr)
  at <https://api.data.gov/signup/>.

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

A tibble containing historic aggregate financial and structure data
regarding financial institutions, with one row per quarter and year.

## Examples

``` r
# Return summary data for each bank type, state, quarter, and year
suppressMessages(get_summary(
  fields = c("ASSET", "BANKS", "BRANCHES", "CALLYM", "NETINC"),
  limit = 5
))
#> # A tibble: 5 × 6
#>    ASSET BANKS BRANCHES CALLYM ID         NETINC
#>    <int> <int>    <int>  <int> <chr>       <int>
#> 1      0     2        0 193412 CB_1934_AK      0
#> 2 277000   210        0 193412 CB_1934_AL      0
#> 3 148000   213        0 193412 CB_1934_AR      0
#> 4      0     0        0 193412 CB_1934_AS      0
#> 5  55000    15        0 193412 CB_1934_AZ      0

# Return summary data sorted by reporting period descending
suppressMessages(get_summary(
  fields = c("ASSET", "BANKS", "CALLYM", "YEAR"),
  sort_by = "CALLYM",
  descending = TRUE,
  limit = 5
))
#> # A tibble: 5 × 5
#>       ASSET BANKS CALLYM ID          YEAR
#>       <int> <int>  <int> <chr>      <int>
#> 1   9765541     4 202512 CB_2025_AK  2025
#> 2 225230810    92 202512 CB_2025_AL  2025
#> 3 178292908    77 202512 CB_2025_AR  2025
#> 4         0    NA 202512 CB_2025_AS  2025
#> 5  95336832    11 202512 CB_2025_AZ  2025
```
