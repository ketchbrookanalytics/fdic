#' Field definitions for the FDIC BankFind Suite `/demographics` endpoint
#'
#' A data frame describing the fields available when querying the
#' `/demographics` endpoint via [get_demographics()].
#'
#' @format A data frame with 54 rows and 4 columns:
#' \describe{
#'   \item{field}{Field name, as passed to the `fields` or `sort_by` arguments.}
#'   \item{title}{Human-readable title for the field.}
#'   \item{description}{Extended description of the field, where available.}
#'   \item{type}{Data type of the field (`"string"` or `"number"`).}
#' }
#' @note This dataset reflects the API field definitions provided by the FDIC at
#'   the time the package was built. The FDIC API may have added, removed, or
#'   renamed fields since then. To confirm which fields are currently available,
#'   call [get_demographics()] with `limit = 1` and no `fields` argument.
#' @source <https://api.fdic.gov/banks/docs/>
"fdic_demographics"

#' Field definitions for the FDIC BankFind Suite `/failures` endpoint
#'
#' A data frame describing the fields available when querying the
#' `/failures` endpoint via [get_failures()].
#'
#' @format A data frame with 21 rows and 4 columns:
#' \describe{
#'   \item{field}{Field name, as passed to the `fields` or `sort_by` arguments.}
#'   \item{title}{Human-readable title for the field.}
#'   \item{description}{Extended description of the field, where available.}
#'   \item{type}{Data type of the field (`"string"` or `"number"`).}
#' }
#' @note This dataset reflects the API field definitions provided by the FDIC at
#'   the time the package was built. The FDIC API may have added, removed, or
#'   renamed fields since then. To confirm which fields are currently available,
#'   call [get_failures()] with `limit = 1` and no `fields` argument.
#' @source <https://api.fdic.gov/banks/docs/>
"fdic_failures"

#' Field definitions for the FDIC BankFind Suite `/financials` endpoint
#'
#' A data frame describing the fields available when querying the
#' `/financials` endpoint via [get_financials()].
#'
#' @format A data frame with 2,377 rows and 4 columns:
#' \describe{
#'   \item{field}{Field name, as passed to the `fields` or `sort_by` arguments.}
#'   \item{title}{Human-readable title for the field.}
#'   \item{description}{Extended description of the field, where available.}
#'   \item{type}{Data type of the field (`"string"` or `"number"`).}
#' }
#' @note This dataset reflects the API field definitions provided by the FDIC at
#'   the time the package was built. The FDIC API may have added, removed, or
#'   renamed fields since then. To confirm which fields are currently available,
#'   call [get_financials()] with `limit = 1` and no `fields` argument.
#' @source <https://api.fdic.gov/banks/docs/>
"fdic_financials"

#' Field definitions for the FDIC BankFind Suite `/history` endpoint
#'
#' A data frame describing the fields available when querying the
#' `/history` endpoint via [get_history()].
#'
#' @format A data frame with 176 rows and 4 columns:
#' \describe{
#'   \item{field}{Field name, as passed to the `fields` or `sort_by` arguments.}
#'   \item{title}{Human-readable title for the field.}
#'   \item{description}{Extended description of the field, where available.}
#'   \item{type}{Data type of the field (`"string"` or `"number"`).}
#' }
#' @note This dataset reflects the API field definitions provided by the FDIC at
#'   the time the package was built. The FDIC API may have added, removed, or
#'   renamed fields since then. To confirm which fields are currently available,
#'   call [get_history()] with `limit = 1` and no `fields` argument.
#' @source <https://api.fdic.gov/banks/docs/>
"fdic_history"

#' Field definitions for the FDIC BankFind Suite `/institutions` endpoint
#'
#' A data frame describing the fields available when querying the
#' `/institutions` endpoint via [get_institutions()].
#'
#' @format A data frame with 151 rows and 4 columns:
#' \describe{
#'   \item{field}{Field name, as passed to the `fields` or `sort_by` arguments.}
#'   \item{title}{Human-readable title for the field.}
#'   \item{description}{Extended description of the field, where available.}
#'   \item{type}{Data type of the field (`"string"` or `"number"`).}
#' }
#' @note This dataset reflects the API field definitions provided by the FDIC at
#'   the time the package was built. The FDIC API may have added, removed, or
#'   renamed fields since then. To confirm which fields are currently available,
#'   call [get_institutions()] with `limit = 1` and no `fields` argument.
#' @source <https://api.fdic.gov/banks/docs/>
"fdic_institutions"

#' Field definitions for the FDIC BankFind Suite `/locations` endpoint
#'
#' A data frame describing the fields available when querying the
#' `/locations` endpoint via [get_locations()].
#'
#' @format A data frame with 35 rows and 4 columns:
#' \describe{
#'   \item{field}{Field name, as passed to the `fields` or `sort_by` arguments.}
#'   \item{title}{Human-readable title for the field.}
#'   \item{description}{Extended description of the field, where available.}
#'   \item{type}{Data type of the field (`"string"` or `"number"`).}
#' }
#' @note This dataset reflects the API field definitions provided by the FDIC at
#'   the time the package was built. The FDIC API may have added, removed, or
#'   renamed fields since then. To confirm which fields are currently available,
#'   call [get_locations()] with `limit = 1` and no `fields` argument.
#' @source <https://api.fdic.gov/banks/docs/>
"fdic_locations"

#' Field definitions for the FDIC BankFind Suite `/sod` endpoint
#'
#' A data frame describing the fields available when querying the
#' `/sod` endpoint via [get_sod()].
#'
#' @format A data frame with 82 rows and 4 columns:
#' \describe{
#'   \item{field}{Field name, as passed to the `fields` or `sort_by` arguments.}
#'   \item{title}{Human-readable title for the field.}
#'   \item{description}{Extended description of the field, where available.}
#'   \item{type}{Data type of the field (`"string"` or `"number"`).}
#' }
#' @note This dataset reflects the API field definitions provided by the FDIC at
#'   the time the package was built. The FDIC API may have added, removed, or
#'   renamed fields since then. To confirm which fields are currently available,
#'   call [get_sod()] with `limit = 1` and no `fields` argument.
#' @source <https://api.fdic.gov/banks/docs/>
"fdic_sod"

#' Field definitions for the FDIC BankFind Suite `/summary` endpoint
#'
#' A data frame describing the fields available when querying the
#' `/summary` endpoint via [get_summary()].
#'
#' @format A data frame with 203 rows and 4 columns:
#' \describe{
#'   \item{field}{Field name, as passed to the `fields` or `sort_by` arguments.}
#'   \item{title}{Human-readable title for the field.}
#'   \item{description}{Extended description of the field, where available.}
#'   \item{type}{Data type of the field (`"string"` or `"number"`).}
#' }
#' @note This dataset reflects the API field definitions provided by the FDIC at
#'   the time the package was built. The FDIC API may have added, removed, or
#'   renamed fields since then. To confirm which fields are currently available,
#'   call [get_summary()] with `limit = 1` and no `fields` argument.
#' @source <https://api.fdic.gov/banks/docs/>
"fdic_summary"
