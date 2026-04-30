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
  `FDIC_API_KEY` environment variable. Register for a key at
  <https://api.data.gov/signup/>.

- filters:

  (String) An optional Elasticsearch query string to filter results. All
  field names and values must be uppercase. See the examples below and
  refer to <https://api.fdic.gov/banks/docs/> for full syntax details.
  Run `fdic_demographics$field` to see available field names.

- fields:

  (String or Character vector) Fields to include in the response.
  Defaults to all available fields if not specified. Run
  `fdic_demographics$field` for reference. An `ID` column is always
  included in the response regardless of the fields requested.

- sort_by:

  (String) Field name to sort results by. Defaults to the API default
  sort order for this endpoint. Run `fdic_demographics$field` for
  reference.

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
if (FALSE) { # !no_creds_available()
# Return the 5 most recent bank failures
get_failures(
  sort_by = "FAILDATE",
  descending = TRUE,
  limit = 5
)

# Filter to failures in a single state
get_failures(
  filters = "PSTALP:NY",
  limit = 5
)

# Return specific fields only
get_failures(
  fields = c("CERT", "FAILDATE", "NAME", "PSTALP"),
  limit = 5
)
}
```
