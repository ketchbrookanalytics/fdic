# Retrieve Financial Institutions

Queries the `/institutions` endpoint of the FDIC BankFind Suite API,
returning FDIC-insured financial institution data.

## Usage

``` r
get_institutions(
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

A tibble containing FDIC-insured institution information, with one row
per institution.

## Examples

``` r
if (FALSE) { # !no_creds_available()
# Return active institutions in New York
get_institutions(
  filters = "STALP:NY AND ACTIVE:1",
  limit = 5
)

# Return the 5 largest institutions by total assets
get_institutions(
  fields = c("ASSET", "CERT", "NAME", "STALP"),
  sort_by = "ASSET",
  descending = TRUE,
  limit = 5
)
}
```
