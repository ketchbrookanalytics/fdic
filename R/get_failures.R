#' Retrieve Historic Bank Failure Data
#'
#' @description
#' Queries the `/failures` endpoint of the FDIC BankFind Suite API,
#' returning data for failed financial institutions from 1934 to present.
#'
#' @inheritParams get_demographics
#'
#' @return A tibble containing bank failure data for FDIC-insured
#'   institutions, with one row per failure event.
#'
#' @export
#'
#' @examplesIf !no_creds_available()
#' # Return the 5 most recent bank failures
#' get_failures(
#'   sort_by = "FAILDATE",
#'   descending = TRUE,
#'   limit = 5
#' )
#'
#' # Filter to failures in a single state
#' get_failures(
#'   filters = "PSTALP:NY",
#'   limit = 5
#' )
#'
#' # Return specific fields only
#' get_failures(
#'   fields = c("NAME", "CERT", "FAILDATE", "PSTALP"),
#'   limit = 5
#' )
get_failures <- function(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE,
  limit = 10000
) {
  endpoint <- "failures"

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
