#' Retrieve Data on Structural Change Events for FDIC-Insured Institutions
#'
#' @description
#' Queries the `/history` endpoint of the FDIC BankFind Suite API,
#' returning data for structural change events for FDIC-insured financial
#' institutions.
#'
#' @inheritParams get_demographics
#'
#' @return A tibble containing structural change events
#'   for FDIC-insured institutions, with one row per structural change event.
#'
#' @export
#'
#' @examplesIf !no_creds_available()
#' # Return the 5 most recent structural change events
#' suppressMessages(get_history(
#'   sort_by = "PROCDATE",
#'   descending = TRUE,
#'   limit = 5
#' ))
#'
#' # Return specific fields only
#' suppressMessages(get_history(
#'   fields = c("CERT", "CHANGECODE", "CHANGECODE_DESC", "PROCDATE"),
#'   limit = 5
#' ))
get_history <- function(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE,
  limit = 10000
) {
  endpoint <- "history"

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
