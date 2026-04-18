# Field definitions for the FDIC BankFind Suite `/institutions` endpoint

A data frame describing the fields available when querying the
`/institutions` endpoint via
[`get_institutions()`](https://ketchbrookanalytics.github.io/fdic/reference/get_institutions.md).

## Usage

``` r
fdic_institutions
```

## Format

A data frame with 151 rows and 4 columns:

- field:

  Field name, as passed to the `fields` or `sort_by` arguments.

- title:

  Human-readable title for the field.

- description:

  Extended description of the field, where available.

- type:

  Data type of the field (`"string"` or `"number"`).

## Source

<https://api.fdic.gov/banks/docs/>

## Note

This dataset reflects the API field definitions at the time the package
was built. The FDIC API may have added, removed, or renamed fields since
then. To confirm which fields are currently available, call
[`get_institutions()`](https://ketchbrookanalytics.github.io/fdic/reference/get_institutions.md)
with `limit = 1` and no `fields` argument.
