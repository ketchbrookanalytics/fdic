#' Retrieve Summary of Demographic Data for FDIC-Insured Institutions
#'
#' @description
#' Queries the `/demographics` endpoint of the FDIC BankFind Suite API,
#' returning demographic data for FDIC-insured financial institutions.
#'
#' @param api_key (String) Your FDIC API key. Defaults to the value of the
#'   `FDIC_API_KEY` environment variable. Register for a key at
#'   <https://api.data.gov/signup/>.
#' @param filters (String) An optional Elasticsearch query string to filter
#'   results. All field names and values must be uppercase. See the examples
#'   below and refer to <https://api.fdic.gov/banks/docs/> for full syntax
#'   details. Run `fdic_demographics$field` to see available field names.
#' @param fields (String or Character vector) Fields to include in the response.
#'   Defaults to all available fields if not specified. Run `fdic_demographics$field`
#'   for reference. An `ID` column is always included in the response regardless
#'   of the fields requested.
#' @param sort_by (String) Field name to sort results by. Defaults to the API
#'   default sort order for this endpoint. Run `fdic_demographics$field` for
#'   reference.
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
#' get_demographics(filters = "CERT:10002")
#'
#' # Return specific fields only
#' get_demographics(
#'   fields = c("CERT", "OFFSTATE", "OFFTOT", "REPDTE"),
#'   limit = 5
#' )
#'
#' # Sort by report date in descending order
#' get_demographics(
#'   fields = c("CERT", "OFFTOT", "REPDTE"),
#'   sort_by = "REPDTE",
#'   descending = TRUE,
#'   limit = 5
#' )
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
