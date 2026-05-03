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
  `FDIC_API_KEY` environment variable.

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
if (FALSE) { # !no_creds_available()
# Return demographic data for a specific institution
get_demographics(filters = "CERT:10002")

# Return specific fields only
get_demographics(
  fields = c("CERT", "OFFSTATE", "OFFTOT", "REPDTE"),
  limit = 5
)

# Sort by report date in descending order
get_demographics(
  fields = c("CERT", "OFFTOT", "REPDTE"),
  sort_by = "REPDTE",
  descending = TRUE,
  limit = 5
)
}
```
