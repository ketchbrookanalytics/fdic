# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working
with code in this repository.

## Overview

[fdic](https://github.com/ketchbrookanalytics/fdic) is an R package
providing a tibble-returning interface to the [FDIC BankFind Suite
API](https://api.fdic.gov/banks/docs/). It exposes eight `get_*()`
functions, one per API endpoint (demographics, failures, financials,
history, institutions, locations, sod, summary), plus the internal
helper
[`no_creds_available()`](https://ketchbrookanalytics.github.io/fdic/reference/no_creds_available.md).

## Architecture

The package is deliberately thin. Understanding it requires reading
[R/aaa.R](https://ketchbrookanalytics.github.io/fdic/R/aaa.R) and any
one `get_*()` file together:

- **`get_fdic()` in
  [R/aaa.R](https://ketchbrookanalytics.github.io/fdic/R/aaa.R) is the
  single engine.** Every public `get_*()` function is a thin wrapper
  that sets `endpoint <- "<name>"` and forwards all arguments to
  `get_fdic()`. `get_fdic()` builds the `httr2` request, performs it,
  requests CSV format, parses the response into a tibble, and handles
  all error/warning cases. To change request-building, parsing, or error
  handling, edit `get_fdic()`, not the individual wrappers.
- **All public functions share the same six arguments**: `api_key`,
  `filters`, `fields`, `sort_by`, `descending`, `limit`. Roxygen docs
  use `@inheritParams get_demographics` to inherit these —
  `get_demographics` is the canonical source of parameter documentation,
  so edit its roxygen block to change shared docs.
- **[`get_financials()`](https://ketchbrookanalytics.github.io/fdic/reference/get_financials.md)
  is the only wrapper with extra logic**: when more than 250 `fields`
  are requested, `limit` is capped at 500 (it aborts otherwise). This
  check runs in the wrapper *before* `get_fdic()` is called.
- **`filters` uses Elasticsearch Query String Syntax**
  (e.g. `"STALP:NY AND ACTIVE:1"`), passed through verbatim to the API.
  `fields` and `sort_by` are upcased before sending. Validation lives in
  `validate_query_params()`.
- **Field-definition datasets.** The eight `fdic_*` data objects in
  [data/](https://ketchbrookanalytics.github.io/fdic/data/)
  (e.g. `fdic_financials`) document valid `field` names per endpoint.
  They are *built artifacts*, regenerated from the live FDIC YAML specs
  by
  [data-raw/fdic_api_definitions.R](https://ketchbrookanalytics.github.io/fdic/data-raw/fdic_api_definitions.R)
  (requires `purrr`, `yaml`, `dplyr`, `usethis` — Suggests/dev-only).
  Their roxygen docs live in
  [R/data.R](https://ketchbrookanalytics.github.io/fdic/R/data.R).

### Authentication

Functions read the API key from the `FDIC_API_KEY` environment variable
by default (`Sys.getenv("FDIC_API_KEY")`), overridable via the `api_key`
argument. With no key, the API allows only 50 requests/day; `"DEMO_KEY"`
allows 30/hr. `check_empty_creds()` warns once per session (state
tracked in the `.fdic_env` environment in
[R/aaa.R](https://ketchbrookanalytics.github.io/fdic/R/aaa.R)).
[`no_creds_available()`](https://ketchbrookanalytics.github.io/fdic/reference/no_creds_available.md)
is exported purely so tests can `skip_if()` when no key is present.

## Common Commands

This is a standard R package — most development uses
[devtools](https://devtools.r-lib.org/) from an R session at the repo
root:

``` r

devtools::load_all()      # load package for interactive use
devtools::test()          # run all tests
devtools::check()         # full R CMD check (what CI runs)
devtools::document()      # regenerate NAMESPACE and man/*.Rd from roxygen
```

Run a single test file:

``` r

testthat::test_file("tests/testthat/test-get_financials.R")
```

Regenerate the README (it is generated from
[README.Rmd](https://ketchbrookanalytics.github.io/fdic/README.Rmd) —
**never edit README.md directly**):

``` r

devtools::build_readme()
```

Rebuild the bundled `fdic_*` datasets after an API spec change:

``` r

source("data-raw/fdic_api_definitions.R")
```

## Testing notes

- Tests use [testthat](https://testthat.r-lib.org) edition 3. Live-API
  tests call `skip_if(no_creds_available())`, so they are silently
  skipped without an `FDIC_API_KEY`. CI supplies the key via the
  `FDIC_API_KEY` secret.
- To exercise wrapper logic (e.g. the
  [`get_financials()`](https://ketchbrookanalytics.github.io/fdic/reference/get_financials.md)
  field/limit constraint) without a network call, tests use
  `testthat::local_mocked_bindings(get_fdic = function(...) tibble::tibble())`.
  Follow this pattern for new offline tests.
- Some tests use snapshots (`expect_snapshot()`); snapshot baselines
  live in
  [tests/testthat/\_snaps/](https://ketchbrookanalytics.github.io/fdic/tests/testthat/_snaps/).
  Update with
  [`testthat::snapshot_accept()`](https://testthat.r-lib.org/reference/snapshot_accept.html)
  when an intentional change alters output.

## Conventions

- Code is formatted with [air](https://posit-dev.github.io/air/) (config
  in [air.toml](https://ketchbrookanalytics.github.io/fdic/air.toml)).
- Documentation is roxygen2-based; `NAMESPACE` and `man/*.Rd` are
  generated — edit the roxygen comments above each function and run
  `devtools::document()`, never edit those files by hand.

## Tooling available to Claude Code

Claude Code has the `git` and `gh` (GitHub CLI) command-line tools
available in this environment. Use them for inspecting history, managing
branches, and interacting with the GitHub repository (PRs, issues, CI
runs). The repository’s GitHub remote is `ketchbrookanalytics/fdic`; the
default branch is `main` and active development happens on `dev`.
