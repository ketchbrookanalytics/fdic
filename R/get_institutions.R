#' Retrieve Financial Institutions
#'
#' @description
#' Queries the `/institutions` endpoint of the FDIC BankFind Suite API,
#' returning FDIC-insured financial institution data.
#'
#' @inheritParams get_demographics
#'
#' @return A [tibble::tibble()] containing FDIC-insured institution information,
#'   with one row per institution.
#'
#' @export
get_institutions <- function(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE
) {

  endpoint <- "institutions"

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