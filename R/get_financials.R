#' Retrieve Financial Data for FDIC-Insured Institutions
#'
#' @description
#' Queries the `/financials` endpoint of the FDIC BankFind Suite API,
#' returning financial data for FDIC-insured financial institutions.
#'
#' @details
#' The `/financials` endpoint returns one row per institution per reporting
#' period (quarter). Requesting more than 250 fields reduces the maximum
#' allowed `limit` to 500 records; exceeding this will raise an error.
#'
#' @inheritParams get_demographics
#' @param fields (String or Character vector) Fields to include in the response.
#'   Defaults to all available fields if not specified. Run `fdic_financials$field`
#'   for valid values.
#' @param limit (Integer) Number of records to return. Must be between 1 and
#'   10,000. Defaults to 10,000. **Note:** when more than 250 fields are
#'   requested, the maximum is 500.
#'
#' @return A tibble containing financial data for FDIC-insured institutions,
#'   with one row per institution per reporting period.
#'
#' @export
#'
#' @examplesIf !no_creds_available()
#' # Return key financial fields for institutions in New York
#' get_financials(
#'   filters = "STALP:NY",
#'   fields = c("CERT", "REPDTE", "ASSET", "NETINC"),
#'   limit = 5
#' )
#'
#' # Sort by total assets descending
#' get_financials(
#'   fields = c("CERT", "ASSET"),
#'   sort_by = "ASSET",
#'   descending = TRUE,
#'   limit = 5
#' )
get_financials <- function(
  api_key = Sys.getenv("FDIC_API_KEY"),
  filters = NULL,
  fields = NULL,
  sort_by = NULL,
  descending = FALSE,
  limit = 10000
) {
  endpoint <- "financials"

  if (!is.null(fields) && length(fields) > 250 && limit > 500) {
    cli::cli_abort(
      "{.var limit} must be 500 or fewer when more than 250 fields are requested."
    )
  }

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
