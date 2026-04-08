#' Retrieve Summary of Demographic Data for FDIC-Insured Institutions
#'
#' @description
#' Queries the `/demographics` endpoint of the FDIC BankFind Suite API,
#' returning demographic data for FDIC-insured financial institutions.
#'
#' @inheritParams no_creds_available
#' @param filters (String) An optional Elasticsearch query string to filter
#'   results. All field names and values must be uppercase. See the examples
#'   below and refer to <https://api.fdic.gov/banks/docs/> for full syntax
#'   details. Run `demographics$field` to see available field names.
#' @param fields (String or Character vector) Fields to include in the response.
#'   Defaults to all available fields if not specified. Run `demographics$field`
#'   for valid values.
#' @param sort_by (String) Field name to sort results by. Defaults to the API
#'   default sort order for this endpoint. Run `demographics$field` to see
#'   valid values.
#' @param descending (Logical) Should results be sorted in descending order?
#'   Only applies when `sort_by` is specified. Defaults to `FALSE`.
#'
#' @return A [tibble::tibble()] containing demographic data for FDIC-insured
#'   institutions, with one row per institution.
#'
#' @export
#'
#' @examples
#' if (!no_creds_available()) {
#'   # Assumiming you have set the FDIC_API_KEY environment variable
#'
#'   # Return all demographic data (subject to 10,000 maximum record limit)
#'   get_demographics()
#'
#'   # Filter to a single state
#'   get_demographics(filters = "STALP:ND")
#'
#'   # Filter to multiple states
#'   get_demographics(filters = "STALP:(ND OR SD)")
#'
#'   # Return specific fields only
#'   get_demographics(fields = c("CERT", "STALP", "REPDTE"))
#'
#'   # Sort by certificate number in descending order
#'   get_demographics(sort_by = "CERT", descending = TRUE)
#' }
get_demographics <- function(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE
) {

  endpoint <- "demographics"

  df <- get_fdic(
    endpoint = endpoint,
    api_key = api_key,
    filters = filters,
    fields = fields,
    sort_by = sort_by,
    descending = descending
  )

  return(df)

}