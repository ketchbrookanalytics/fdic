# Field definitions for the FDIC BankFind Suite `/failures` endpoint

A data frame describing the fields available when querying the
`/failures` endpoint via
[`get_failures()`](https://ketchbrookanalytics.github.io/fdic/reference/get_failures.md).

## Usage

``` r
fdic_failures
```

## Format

A data frame with 21 rows and 4 columns:

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
[`get_failures()`](https://ketchbrookanalytics.github.io/fdic/reference/get_failures.md)
with `limit = 1` and no `fields` argument.
