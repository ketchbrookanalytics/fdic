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

A tibble containing historic aggregate financial and structure data
regarding financial institutions, with one row per quarter and year.

## Examples

``` r
if (FALSE) { # nzchar(Sys.getenv("FDIC_API_KEY"))
# Return summary data for each bank type, state, quarter, and year
get_summary(
  fields = c("CALLYM", "BANKS", "BRANCHES", "ASSET", "NETINC"),
  limit = 5
)

# Return summary data sorted by reporting period descending
get_summary(
  fields = c("YEAR", "CALLYM", "BANKS", "ASSET"),
  sort_by = "CALLYM",
  descending = TRUE,
  limit = 5
)
}
```
