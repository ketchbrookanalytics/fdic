#' Retrieve Financial Data for FDIC-Insured Institutions
#'
#' @description
#' Queries the `/financials` endpoint of the FDIC BankFind Suite API,
#' returning financial data for FDIC-insured financial institutions.
#'
#' @inheritParams get_demographics
#'
#' @return A tibble containing financial data for FDIC-insured
#'   institutions, with one row per institution.
#'
#' @export
get_financials <- function(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE
) {

  endpoint <- "financials"

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