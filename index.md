# fdic

R package for retrieving data from the [FDIC BankFind Suite
API](https://api.fdic.gov/banks/docs/).

The FDIC BankFind Suite API allows you to:

- Search for specific FDIC-insured financial institutions
- Collect branch office location data
- Explore annual branch office deposit data by institution and location
- Review financial reports and other performance metrics for
  institutions
- Get details on failed financial institutions and structural change
  events
- Retrieve historic aggregate financial and structural data
- Obtain demographic data related to financial institutions

## Installation

You can install the development version of {fdic} from GitHub using
{pak} like so:

``` r

# install.packages("pak")
pak::pak("ketchbrookanalytics/fdic")
```

## Authentication

In order to use {fdic}, you will first need to [obtain an API
key](https://api.data.gov/signup/) from the United States Government’s
Open Data Portal. **The API key must be provided to each function in
this R package.**

### Using Your API Key

Once you have obtained your API key, we recommend setting it as the
`FDIC_API_KEY` environment variable. Perhaps the easiest way to do this
is to create an `.Renviron` file at the root of your project like so:

``` .renviron
FDIC_API_KEY=QwPoVb951753
```

*Note: the above API key is an example and will not work – it must be
replaced with a valid API key value.*

If you prefer not to set the API key as an environment variable, you can
pass it directly using the `api_key` argument available in each function
in {fdic}.

## Examples

``` r

library(fdic)

# Search for the five largest active institutions by asset size in New York
# Collect the total asset amount, name of each institution, and the report date
# The `ID` column is included in all responses despite not being in `fields`
# Sort the results by total assets, descending
get_institutions(
  filters = "STALP:NY AND ACTIVE:1",
  fields = c("ASSET", "NAME", "REPDTE"),
  sort_by = "ASSET",
  descending = TRUE,
  limit = 5
)
#> # A tibble: 5 × 4
#>       ASSET    ID NAME                                              REPDTE    
#>       <int> <int> <chr>                                             <chr>     
#> 1 644997000 33124 Goldman Sachs Bank USA                            12/31/2025
#> 2 380997000   639 The Bank of New York Mellon                       12/31/2025
#> 3 254706000 34221 Morgan Stanley Private Bank, National Association 12/31/2025
#> 4 212887157   588 Manufacturers and Traders Trust Company           12/31/2025
#> 5  87511954 32541 Flagstar Bank, National Association               12/31/2025
```

Each function in {fdic} accepts the following arguments:

- `api_key`: Your FDIC API key (see [Authentication](#authentication)
  above)
- `filters`: One or more filters to apply when requesting data using
  [Elasticsearch Query String
  Syntax](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-query-string-query#query-string-syntax)
- `fields`: One or more fields to include in the response
- `sort_by`: A field name to sort the response by
- `descending`: A flag to specify the direction to `sort_by` (if
  `sort_by` is specified)
- `limit`: The number of records to include in the response (up to a
  maximum of 10,000)

While most of the arguments are relatively straightforward, there are
some idiosyncrasies with both the `filters` and `fields` arguments that
are worth discussing.

### Filtering Using Elasticsearch Query String Syntax

The [Elasticsearch Query String
Syntax](https://www.elastic.co/docs/reference/query-languages/query-dsl/query-dsl-query-string-query#query-string-syntax)
is a mini-language that allows for a customized search of the data,
using terms and operators to facilitate the filtering. Pass a valid
Elasticsearch Query String to the `filters` argument of an {fdic}
function to filter the data provided by the FDIC BankFind Suite API.

While it is strongly encouraged to review the Query String Syntax
documentation provided by the FDIC and Elastic, a few examples are
provided below for reference:

``` r

# Search for five active institutions in New York
# Return all available fields
get_institutions(
  filters = "STALP:NY AND ACTIVE:1",
  limit = 5
)
#> # A tibble: 5 × 135
#>   ACTIVE ADDRESS         ADDRESS2   ASSET BKCLASS CALLFORM    CB CBSA   CBSA_DIV
#>    <int> <chr>           <chr>      <int> <chr>      <int> <int> <chr>  <lgl>   
#> 1      1 201 Mohawk Ave  ""        698520 N             41     1 Alban… NA      
#> 2      1 212 Dolson Ave  ""       2650965 SM            41     1 Pough… NA      
#> 3      1 857 E Main St   ""        180561 NM            41     1 Alban… NA      
#> 4      1 116 Main St     "# 20"    375234 NM            51     1 Olean… NA      
#> 5      1 1537 Milton Ave ""       1183807 SM            51     1 Syrac… NA      
#> # ℹ 126 more variables: CBSA_DIV_FLG <int>, CBSA_DIV_NO <lgl>,
#> #   CBSA_METRO <int>, CBSA_METRO_FLG <int>, CBSA_METRO_NAME <chr>,
#> #   CBSA_MICRO_FLG <int>, CBSA_NO <int>, CERT <int>, CFPBEFFDTE <chr>,
#> #   CFPBENDDTE <chr>, CFPBFLAG <int>, CHARTER <int>, CHRTAGNT <chr>,
#> #   CITY <chr>, CITYHCR <chr>, CLCODE <int>, CONSERVE <chr>, COUNTY <chr>,
#> #   CSA <chr>, CSA_FLG <int>, CSA_NO <int>, DATEUPDT <chr>, DENOVO <int>,
#> #   DEP <int>, DEPDOM <int>, DOCKET <int>, EFFDATE <chr>, ENDEFYMD <chr>, …
```

``` r

# Collect location data for five branches of a specific institution
# Return all available fields
get_locations(
  filters = "CERT:33124",
  limit = 5
)
#> # A tibble: 5 × 38
#>   ACQDATE      ADDRESS  ADDRESS2 BKCLASS CBSA  CBSA_DIV CBSA_DIV_FLG CBSA_DIV_NO
#>   <chr>        <chr>    <lgl>    <chr>   <chr> <chr>           <int>       <int>
#> 1 "11/28/2008" 111 S M… NA       SM      Salt… ""                  0          NA
#> 2 ""           200 Wes… NA       SM      New … "New Yo…            1       35614
#> 3 ""           125 Hig… NA       SM      Bost… "Boston…            1       14454
#> 4 ""           30 Huds… NA       SM      New … "New Yo…            1       35614
#> 5 ""           11850 S… NA       SM      Salt… ""                  0          NA
#> # ℹ 30 more variables: CBSA_METRO <int>, CBSA_METRO_FLG <int>,
#> #   CBSA_METRO_NAME <chr>, CBSA_MICRO_FLG <int>, CBSA_NO <int>, CERT <int>,
#> #   CITY <chr>, COUNTY <chr>, CSA <chr>, CSA_FLG <int>, CSA_NO <int>,
#> #   ESTYMD <chr>, FI_UNINUM <int>, ID <int>, LATITUDE <dbl>, LONGITUDE <dbl>,
#> #   MAINOFF <int>, MDI_STATUS_CODE <lgl>, MDI_STATUS_DESC <chr>, NAME <chr>,
#> #   OFFNAME <chr>, OFFNUM <int>, RUNDATE <chr>, SERVTYPE <int>,
#> #   SERVTYPE_DESC <chr>, STALP <chr>, STCNTY <int>, STNAME <chr>, …
```

``` r

# Explore the 2025 Summary of Deposit data for non-community banks in New York
# Collect the coordinates for the top five branch locations by total deposits
get_sod(
  filters = "STALP:NY AND !(CB:1) AND YEAR:2025",
  fields = c("DEPSUM", "NAMEBR", "SIMS_LATITUDE", "SIMS_LONGITUDE", "YEAR"),
  sort_by = "DEPSUM",
  descending = TRUE,
  limit = 5
)
#> # A tibble: 5 × 6
#>      DEPSUM ID           NAMEBR               SIMS_LATITUDE SIMS_LONGITUDE  YEAR
#>       <int> <chr>        <chr>                        <dbl>          <dbl> <int>
#> 1 390220000 2025_33124_0 Goldman Sachs Bank …          40.7          -74.0  2025
#> 2 227667000 2025_639_0   The Bank Of New Yor…          40.7          -74.0  2025
#> 3 212449000 2025_34221_0 Morgan Stanley Priv…          41.0          -73.7  2025
#> 4 168383903 2025_588_0   Manufacturers And T…          42.9          -78.9  2025
#> 5  70246292 2025_32541_0 Flagstar Bank, Nati…          40.8          -73.5  2025

fdic_sod$description[fdic_sod$field == "DEPSUM"]
#> [1] "TOTAL DEPOSITS"
```

### Available API Fields

{fdic} contains eight internal datasets documenting the [current API
endpoint definition files](https://api.fdic.gov/banks/docs/) provided by
the FDIC. Each dataset corresponds to one of the functions contained in
{fdic} and is named by prefixing the endpoint with `fdic_` (e.g.,
`fdic_institutions` for
[`get_institutions()`](https://ketchbrookanalytics.github.io/fdic/reference/get_institutions.md)).
Each dataset can be accessed directly by name, as demonstrated below.

``` r

head(fdic_institutions)
#> # A tibble: 6 × 4
#>   field   title                            description                     type 
#>   <chr>   <chr>                            <chr>                           <chr>
#> 1 ACTIVE  Institution Status               A number indicating the status… numb…
#> 2 ADDRESS Street Address                   The street address in which an… stri…
#> 3 ASSET   Total assets                     The sum of all assets owned by… numb…
#> 4 BKCLASS Institution Class                A classification code assigned… stri…
#> 5 CB      Community Bank                   A flag used to indicate whethe… stri…
#> 6 CBSA    Core Based Statistical Area Name Name of the Core Based Statist… stri…
```

During package development, it was noted that *most* fields returned by
the API are documented in these internal datasets. **However, there are
several instances where fields are either no longer available or new,
undocumented fields have been added.**

{fdic} functions evaluate the values supplied to the `fields` argument
and will raise a warning if a field is not returned in the response.
However, it can be helpful to call an {fdic} function with no `fields`
argument and `limit = 1` to return the current endpoint definition, as
demonstrated below:

``` r

# Review current endpoint definition
get_locations(limit = 1) |>
  names()
#>  [1] "ACQDATE"         "ADDRESS"         "ADDRESS2"        "BKCLASS"        
#>  [5] "CBSA"            "CBSA_DIV"        "CBSA_DIV_FLG"    "CBSA_DIV_NO"    
#>  [9] "CBSA_METRO"      "CBSA_METRO_FLG"  "CBSA_METRO_NAME" "CBSA_MICRO_FLG" 
#> [13] "CBSA_NO"         "CERT"            "CITY"            "COUNTY"         
#> [17] "CSA"             "CSA_FLG"         "CSA_NO"          "ESTYMD"         
#> [21] "FI_UNINUM"       "ID"              "LATITUDE"        "LONGITUDE"      
#> [25] "MAINOFF"         "MDI_STATUS_CODE" "MDI_STATUS_DESC" "NAME"           
#> [29] "OFFNAME"         "OFFNUM"          "RUNDATE"         "SERVTYPE"       
#> [33] "SERVTYPE_DESC"   "STALP"           "STCNTY"          "STNAME"         
#> [37] "UNINUM"          "ZIP"
```

Alternatively, the BankFind Suite offers a [Glossary and Variable
Definition](https://banks.data.fdic.gov/bankfind-suite/help?helpTopic=glossary-and-variable-definitions)
table which may provide more up-to-date information on API fields.

## Need Help?

If you’re in need of assistance working with {fdic}, don’t hesitate to
reach out to our team at <info@ketchbrookanalytics.com>.
