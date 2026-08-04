# Retrieve Data on Structural Change Events for FDIC-Insured Institutions

Queries the `/history` endpoint of the FDIC BankFind Suite API,
returning data for structural change events for FDIC-insured financial
institutions.

## Usage

``` r
get_history(
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

A tibble containing structural change events for FDIC-insured
institutions, with one row per structural change event.

## Examples

``` r
# Return the 5 most recent structural change events
suppressMessages(get_history(
  sort_by = "PROCDATE",
  descending = TRUE,
  limit = 5
))
#> # A tibble: 5 × 126
#>   ACQDATE  ACQYEAR ACQ_UNINUM ASSISTED_PAYOUT_FLAG BANK_INSURED  CERT CHANGECODE
#>   <chr>      <int>      <int>                <int> <chr>        <int>      <int>
#> 1 9999-12…    9999          0                    0 Y            11952        711
#> 2 2025-04…    2025          0                    0 Y            30788        721
#> 3 2005-06…    2005          0                    0 Y            12368        520
#> 4 9999-12…    9999          0                    0 Y             8321        711
#> 5 9999-12…    9999          0                    0 Y            28332        721
#> # ℹ 119 more variables: CHANGECODE_DESC <chr>, CHARTAGENT <chr>,
#> #   CHARTER_COM_TO_OTHER_FLAG <int>, CHARTER_COM_TO_OTS_FLAG <int>,
#> #   CHARTER_OTHER_TO_COM_FLAG <int>, CHARTER_OTS_TO_COM_FLAG <int>,
#> #   CLASS <chr>, CLASS_CHANGE_FLAG <int>, CLASS_TYPE <chr>,
#> #   CLASS_TYPE_DESC <chr>, CLCODE <int>, CNTYNAME <chr>, CNTYNUM <int>,
#> #   EFFDATE <chr>, EFFYEAR <int>, ENDDATE <chr>, ENDYEAR <int>, ESTDATE <chr>,
#> #   ESTYEAR <int>, FAILED_COM_TO_COM_FLAG <int>, …

# Return specific fields only
suppressMessages(get_history(
  fields = c("CERT", "CHANGECODE", "CHANGECODE_DESC", "PROCDATE"),
  limit = 5
))
#> # A tibble: 5 × 5
#>    CERT CHANGECODE CHANGECODE_DESC                                ID    PROCDATE
#>   <int>      <int> <chr>                                          <chr> <chr>   
#> 1 18409        721 Branch Closing                                 0000… 2013-08…
#> 2 31746        713 Branch Acquired in Merger/Consolidation/Failu… 0000… 1996-01…
#> 3 24015        722 Branch Sold                                    0000… 1994-06…
#> 4 14533        713 Branch Acquired in Merger/Consolidation/Failu… 0000… 1997-02…
#> 5 17097        713 Branch Acquired in Merger/Consolidation/Failu… 0000… 1997-08…
```
