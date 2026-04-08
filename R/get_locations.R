#' Retrieve Financial Institution Locations
#'
#' @description
#' Queries the `/locations` endpoint of the FDIC BankFind Suite API,
#' returning location data for FDIC-insured financial institutions.
#'
#' @inheritParams get_demographics
#'
#' @return A tibble containing location data
#'   for FDIC-insured institutions, with one row per location.
#'
#' @export
get_locations <- function(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE
) {

  endpoint <- "locations"

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