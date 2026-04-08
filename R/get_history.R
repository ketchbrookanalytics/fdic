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
#'   for FDIC-insured institutions, with one row per institution.
#'
#' @export
get_history <- function(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE
) {

  endpoint <- "history"

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