# Field definitions for the FDIC BankFind Suite `/locations` endpoint

A data frame describing the fields available when querying the
`/locations` endpoint via
[`get_locations()`](https://ketchbrookanalytics.github.io/fdic/reference/get_locations.md).

## Usage

``` r
fdic_locations
```

## Format

A data frame with 35 rows and 4 columns:

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
[`get_locations()`](https://ketchbrookanalytics.github.io/fdic/reference/get_locations.md)
with `limit = 1` and no `fields` argument.
