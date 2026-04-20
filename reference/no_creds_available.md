# Handle missing API key without throwing an error for unit testing purposes

Handle missing API key without throwing an error for unit testing
purposes

## Usage

``` r
no_creds_available(api_key = Sys.getenv("FDIC_API_KEY"))
```

## Arguments

- api_key:

  (String) The API key for authenticating against the FDIC API

## Value

(Logical) `FALSE` if a non-empty `api_key` has been supplied; otherwise
`TRUE`.

## Details

Intended for internal use.
