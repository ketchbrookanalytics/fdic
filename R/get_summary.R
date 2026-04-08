#' Retrieve Historical Aggregate Data by Year for FDIC-Insured Institutions
#'
#' @description
#' Queries the `/summary` endpoint of the FDIC BankFind Suite API,
#' returning aggregate data by year for FDIC-insured financial institutions.
#'
#' @inheritParams get_demographics
#'
#' @return A tibble containing historic aggregate financial
#'   and structure data regarding financial institutions, with one row per year.
#'
#' @export
get_summary <- function(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE
) {

  endpoint <- "summary"

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