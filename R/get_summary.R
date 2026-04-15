#' Retrieve Historical Aggregate Data by Year for FDIC-Insured Institutions
#'
#' @description
#' Queries the `/summary` endpoint of the FDIC BankFind Suite API,
#' returning aggregate data by bank type, state, quarter, and year
#' for FDIC-insured financial institutions.
#'
#' @inheritParams get_demographics
#'
#' @return A tibble containing historic aggregate financial
#'   and structure data regarding financial institutions, with one row per
#'   quarter and year.
#'
#' @export
#'
#' @examplesIf nzchar(Sys.getenv("FDIC_API_KEY"))
#' # Return summary data for each bank type, state, quarter, and year
#' get_summary(
#'   fields = c("CALLYM", "BANKS", "BRANCHES", "ASSET", "NETINC"),
#'   limit = 5
#' )
#'
#' # Return summary data sorted by reporting period descending
#' get_summary(
#'   fields = c("YEAR", "CALLYM", "BANKS", "ASSET"),
#'   sort_by = "CALLYM",
#'   descending = TRUE,
#'   limit = 5
#' )
get_summary <- function(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE,
  limit = 10000
) {
  endpoint <- "summary"

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
