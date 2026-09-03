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

A tibble containing FDIC-insured institution information, with one row
per institution.

## Examples

``` r
# Return active institutions in New York
suppressMessages(get_institutions(
  filters = "STALP:NY AND ACTIVE:1",
  limit = 5
))
#> # A tibble: 5 × 136
#>   ACTIVE ADDRESS         ADDRESS2   ASSET BKCLASS CALLFORM    CB CBSA   CBSA_DIV
#>    <int> <chr>           <chr>      <int> <chr>      <int> <int> <chr>  <lgl>   
#> 1      1 201 Mohawk Ave  ""        719046 N             41     1 Alban… NA      
#> 2      1 212 Dolson Ave  ""       2792253 SM            41     1 Pough… NA      
#> 3      1 857 E Main St   ""        185900 NM            41     1 Alban… NA      
#> 4      1 116 Main St     "# 20"    384681 NM            51     1 Olean… NA      
#> 5      1 1537 Milton Ave ""       1197828 SM            51     1 Syrac… NA      
#> # ℹ 127 more variables: CBSA_DIV_FLG <int>, CBSA_DIV_NO <lgl>,
#> #   CBSA_METRO <int>, CBSA_METRO_FLG <int>, CBSA_METRO_NAME <chr>,
#> #   CBSA_MICRO_FLG <int>, CBSA_NO <int>, CERT <int>, CFPBEFFDTE <chr>,
#> #   CFPBENDDTE <chr>, CFPBFLAG <int>, CHARTER <int>, CHRTAGNT <chr>,
#> #   CITY <chr>, CITYHCR <chr>, CLCODE <int>, CONSERVE <chr>, COUNTY <chr>,
#> #   CSA <chr>, CSA_FLG <int>, CSA_NO <int>, DATEUPDT <chr>, DENOVO <int>,
#> #   DEP <int>, DEPDOM <int>, DOCKET <int>, EFFDATE <chr>, ENDEFYMD <chr>, …

# Return the 5 largest institutions by total assets
suppressMessages(get_institutions(
  fields = c("ASSET", "CERT", "NAME", "STALP"),
  sort_by = "ASSET",
  descending = TRUE,
  limit = 5
))
#> # A tibble: 5 × 5
#>        ASSET  CERT    ID NAME                                      STALP
#>        <dbl> <int> <int> <chr>                                     <chr>
#> 1 4091315000   628   628 JPMorgan Chase Bank, National Association OH   
#> 2 2654645000  3510  3510 Bank of America, National Association     NC   
#> 3 1976180000  7213  7213 Citibank, National Association            SD   
#> 4 1907928000  3511  3511 Wells Fargo Bank, National Association    SD   
#> 5  758788000 33124 33124 Goldman Sachs Bank USA                    NY   
```
