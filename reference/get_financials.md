# Retrieve Financial Data for FDIC-Insured Institutions

Queries the `/financials` endpoint of the FDIC BankFind Suite API,
returning financial data for FDIC-insured financial institutions.

## Usage

``` r
get_financials(
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

  (String or Character vector) Fields to include in the response.
  Defaults to all available fields if not specified. Run
  `fdic_financials$field` for valid values.

- sort_by:

  (String) Field name to sort results by. Defaults to the API default
  sort order for this endpoint.

- descending:

  (Logical) Should results be sorted in descending order? Only applies
  when `sort_by` is specified. Defaults to `FALSE`.

- limit:

  (Integer) Number of records to return. Must be between 1 and 10,000.
  Defaults to 10,000. **Note:** when more than 250 fields are requested,
  the maximum is 500.

## Value

A tibble containing financial data for FDIC-insured institutions, with
one row per institution per reporting period.

## Details

The `/financials` endpoint returns one row per institution per reporting
period (quarter). Requesting more than 250 fields reduces the maximum
allowed `limit` to 500 records; exceeding this will raise an error.

## Examples

``` r
# Return key financial fields for institutions in New York
suppressMessages(get_financials(
  filters = "STALP:NY",
  fields = c("ASSET", "CERT", "NETINC", "REPDTE"),
  limit = 5
))
#> # A tibble: 5 × 5
#>   ASSET  CERT ID             NETINC   REPDTE
#>   <int> <int> <chr>           <int>    <int>
#> 1 62523 11051 11051_19840331    185 19840331
#> 2 66602 11051 11051_19840630    393 19840630
#> 3 65740 11051 11051_19840930    649 19840930
#> 4 40016 11496 11496_19840331    -21 19840331
#> 5 50504 11501 11501_19840331     67 19840331

# Sort by total assets descending
suppressMessages(get_financials(
  fields = c("ASSET", "CERT"),
  sort_by = "ASSET",
  descending = TRUE,
  limit = 5
))
#> # A tibble: 5 × 3
#>        ASSET  CERT ID          
#>        <dbl> <int> <chr>       
#> 1 4016571000   628 628_20260331
#> 2 3813431000   628 628_20250930
#> 3 3788551000   628 628_20250630
#> 4 3752662000   628 628_20251231
#> 5 3643099000   628 628_20250331
```
