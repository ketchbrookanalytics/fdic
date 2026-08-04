#' Retrieve Summary of Demographic Data for FDIC-Insured Institutions
#'
#' @description
#' Queries the `/demographics` endpoint of the FDIC BankFind Suite API,
#' returning demographic data for FDIC-insured financial institutions.
#'
#' @param api_key (String) Your FDIC API key. Required: the FDIC does not
#'   accept unauthenticated requests. Defaults to the value of the
#'   `FDIC_API_KEY` environment variable. Register for a free personal key
#'   (1,000 req/hr) at <https://api.data.gov/signup/>.
#' @param filters (String) An optional Elasticsearch query string to filter
#'   results. All field names and values must be uppercase.
#' @param fields (String or Character vector) Fields to include in the response.
#'   An `ID` column is always present, regardless of the fields requested.
#'   To retrieve the most recently published API definition for an endpoint,
#'   replace the `get_` prefix in the function name with `fdic_`
#'   (e.g., `get_{endpoint}()` to `fdic_{endpoint}()`).
#' @param sort_by (String) Field name to sort results by. Defaults to the API
#'   default sort order for this endpoint.
#' @param descending (Logical) Should results be sorted in descending order?
#'   Only applies when `sort_by` is specified. Defaults to `FALSE`.
#' @param limit (Integer) Number of records to return. Must be between 1 and
#'   10,000. Defaults to 10,000.
#'
#' @return A tibble containing demographic data for FDIC-insured
#'   institutions, with one row per institution.
#'
#' @export
#'
#' @examplesIf !no_creds_available()
#' # Return demographic data for a specific institution
#' suppressMessages(get_demographics(filters = "CERT:10002"))
#'
#' # Return specific fields only
#' suppressMessages(get_demographics(
#'   fields = c("CERT", "OFFSTATE", "OFFTOT", "REPDTE"),
#'   limit = 5
#' ))
#'
#' # Sort by report date in descending order
#' suppressMessages(get_demographics(
#'   fields = c("CERT", "OFFTOT", "REPDTE"),
#'   sort_by = "REPDTE",
#'   descending = TRUE,
#'   limit = 5
#' ))
get_demographics <- function(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE,
  limit = 10000
) {
  endpoint <- "demographics"

  df <- get_fdic(
    endpoint = endpoint,
    api_key = api_key,
    filters = filters,
    fields = fields,
    sort_by = sort_by,
    descending = descending,
    limit = limit
  )

  return(df)
}
