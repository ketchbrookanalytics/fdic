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
  `fdic_financials$field` for valid values.

- sort_by:

  (String) Field name to sort results by. Defaults to the API default
  sort order for this endpoint. Run `fdic_demographics$field` for
  reference.

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
if (FALSE) { # !no_creds_available()
# Return key financial fields for institutions in New York
get_financials(
  filters = "STALP:NY",
  fields = c("ASSET", "CERT", "NETINC", "REPDTE"),
  limit = 5
)

# Sort by total assets descending
get_financials(
  fields = c("ASSET", "CERT"),
  sort_by = "ASSET",
  descending = TRUE,
  limit = 5
)
}
```
