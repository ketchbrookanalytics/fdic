#' Retrieve Summary of Deposit (SOD) Data for FDIC-Insured Institutions
#'
#' @description
#' Queries the `/sod` endpoint of the FDIC BankFind Suite API,
#' returning summary of deposit data for FDIC-insured financial institutions.
#'
#' @inheritParams get_demographics
#'
#' @return A tibble containing summary of deposits data
#'   for FDIC-insured institutions, with one row per institution location.
#'
#' @export
#'
#' @examplesIf nzchar(Sys.getenv("FDIC_API_KEY"))
#' # Return Summary of Deposit data for institutions in North York
#' get_sod(
#'   filters = "STALP:NY",
#'   limit = 5
#' )
#'
#' # Return specific fields, sorted by total assets descending
#' get_sod(
#'   filters = "STALP:NY",
#'   fields = c("CERT", "CITY", "ASSET", "YEAR"),
#'   sort_by = "ASSET",
#'   descending = TRUE,
#'   limit = 5
#' )
get_sod <- function(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE,
  limit = 10000
) {
  endpoint <- "sod"

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
