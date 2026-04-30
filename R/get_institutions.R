#' Retrieve Financial Institutions
#'
#' @description
#' Queries the `/institutions` endpoint of the FDIC BankFind Suite API,
#' returning FDIC-insured financial institution data.
#'
#' @inheritParams get_demographics
#'
#' @return A tibble containing FDIC-insured institution information,
#'   with one row per institution.
#'
#' @export
#'
#' @examplesIf !no_creds_available()
#' # Return active institutions in New York
#' get_institutions(
#'   filters = "STALP:NY AND ACTIVE:1",
#'   limit = 5
#' )
#'
#' # Return the 5 largest institutions by total assets
#' get_institutions(
#'   fields = c("ASSET", "CERT", "NAME", "STALP"),
#'   sort_by = "ASSET",
#'   descending = TRUE,
#'   limit = 5
#' )
get_institutions <- function(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE,
  limit = 10000
) {
  endpoint <- "institutions"

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
