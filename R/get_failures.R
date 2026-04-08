#' Retrieve Historic Bank Failure Data
#'
#' @description
#' Queries the `/failures` endpoint of the FDIC BankFind Suite API,
#' returning data for failed financial institutions from 1934 to present.
#'
#' @inheritParams get_demographics
#'
#' @return A [tibble::tibble()] containing bank failure data for FDIC-insured
#'   institutions, with one row per institution.
#'
#' @export
get_failures <- function(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE
) {

  endpoint <- "failures"

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