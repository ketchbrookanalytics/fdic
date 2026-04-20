# Field definitions for the FDIC BankFind Suite `/sod` endpoint

A data frame describing the fields available when querying the `/sod`
endpoint via
[`get_sod()`](https://ketchbrookanalytics.github.io/fdic/reference/get_sod.md).

## Usage

``` r
fdic_sod
```

## Format

A data frame with 82 rows and 4 columns:

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

This dataset reflects the API field definitions provided by the FDIC at
the time the package was built. The FDIC API may have added, removed, or
renamed fields since then. To confirm which fields are currently
available, call
[`get_sod()`](https://ketchbrookanalytics.github.io/fdic/reference/get_sod.md)
with `limit = 1` and no `fields` argument.
