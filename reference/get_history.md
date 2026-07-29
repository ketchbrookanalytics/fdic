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

A tibble containing structural change events for FDIC-insured
institutions, with one row per structural change event.

## Examples

``` r
# Return the 5 most recent structural change events
get_history(
  sort_by = "PROCDATE",
  descending = TRUE,
  limit = 5
)
#> # A tibble: 5 × 229
#>   ACQDATE         ACQYEAR ACQ_BRANCHES ACQ_BRANCHES_HREF ACQ_CERT ACQ_CHARTAGENT
#>   <chr>             <int>        <int> <chr>                <int> <chr>         
#> 1 "2004-11-13T00…    2004           NA ""                      NA ""            
#> 2 "9999-12-31T00…    9999           NA ""                      NA ""            
#> 3 "9999-12-31T00…    9999           NA ""                      NA ""            
#> 4 ""                   NA            1 "/history?filter…     3337 "OCC"         
#> 5 ""                   NA            1 "/history?filter…     3337 "OCC"         
#> # ℹ 223 more variables: ACQ_CHARTER <int>, ACQ_CLASS <chr>,
#> #   ACQ_CLASS_TYPE <chr>, ACQ_CLASS_TYPE_DESC <chr>, ACQ_CLCODE <int>,
#> #   ACQ_CNTYNAME <chr>, ACQ_CNTYNUM <int>, ACQ_FDICREGION <int>,
#> #   ACQ_FDICREGION_DESC <chr>, ACQ_INSAGENT1 <chr>, ACQ_INSAGENT2 <lgl>,
#> #   ACQ_INSTNAME <chr>, ACQ_LATITUDE <dbl>, ACQ_LONGITUDE <dbl>,
#> #   ACQ_ORGTYPE_NUM <int>, ACQ_ORG_EFF_DTE <chr>, ACQ_PADDR <chr>,
#> #   ACQ_PADDR2 <lgl>, ACQ_PCITY <chr>, ACQ_PSTALP <chr>, ACQ_PSTNUM <int>, …

# Return specific fields only
get_history(
  fields = c("CERT", "CHANGECODE", "CHANGECODE_DESC", "PROCDATE"),
  limit = 5
)
#> # A tibble: 5 × 5
#>    CERT CHANGECODE CHANGECODE_DESC                                ID    PROCDATE
#>   <int>      <int> <chr>                                          <chr> <chr>   
#> 1 18409        721 Branch Closing                                 0000… 2013-08…
#> 2 31746        713 Branch Acquired in Merger/Consolidation/Failu… 0000… 1996-01…
#> 3 24015        722 Branch Sold                                    0000… 1994-06…
#> 4 14533        713 Branch Acquired in Merger/Consolidation/Failu… 0000… 1997-02…
#> 5 17097        713 Branch Acquired in Merger/Consolidation/Failu… 0000… 1997-08…
```
