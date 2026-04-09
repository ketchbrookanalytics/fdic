#' Define the base URL for all FDIC API endpoints
#' @noRd
base_url <- "https://api.fdic.gov/banks/"

#' Create a small error handler to return error messages from API
#' @noRd
fdic_error_message <- function(resp) {
  httr2::resp_body_json(resp)$Message
}

#' Handle missing API Key value
#' @noRd
check_empty_creds <- function(api_key) {

  if (is.null(api_key) || trimws(api_key) == "") {
    cli::cli_abort(
      c(
        "{.var api_key} is missing.",
        "If you do not have an FDIC API Key, you can register for one at {.url https://api.data.gov/signup/}."
      )
    )
  }
}

#' Validate API query parameters
#' @noRd
validate_query_params <- function(
  filters,
  fields,
  sort_by,
  descending,
  limit = 10000
) {
  # The `filters` param is a string that uses Elastic Search query string syntax
  # While the content is challenging to validate, the value can still be checked
  if (!is.null(filters) && (!is.character(filters) || length(filters) != 1)) {
    cli::cli_abort("{.var filters} must be a single character string.")
  }

  # The `fields` param can be a character vector to specify the fields to return
  # Values must be formatted as uppercase when creating the API request
  # Additionally, `fields` must be available for the applicable endpoint
  if (!is.null(fields)) {
    fields <- toupper(fields)
    invalid <- setdiff(fields, endpoint$field)
    if (length(invalid) > 0) {
      cli::cli_abort("Invalid {.var fields}: {.val {invalid}}")
    }
  }

  # The `sort_by` param can be a `field` to sort the returned data by
  # The `sort_by` param must be a `field` available for the applicable endpoint
  if (!is.null(sort_by)) {
    sort_by <- toupper(sort_by)
    if (!sort_by %in% endpoint$field) {
      cli::cli_abort(
        "{.var sort_by} {.val {sort_by}} is not a valid field name."
      )
    }
  }

  if (!is.logical(descending) || length(descending) != 1) {
    cli::cli_abort("{.var descending} must be TRUE or FALSE.")
  }

  # The `descending` param does not affect the return data
  # when the `sort_by` param is not specified
  if (is.null(sort_by) && descending) {
    cli::cli_warn(
      "{.var descending} is ignored when {.var sort_by} is not specified."
    )
  }

  validated_params <- list(
    filters = filters,
    fields = fields,
    sort_by = sort_by,
    sort_order = if (descending) "DESC" else "ASC"
  )

  return(validated_params)

}



get_fdic <- function(endpoint, api_key, filters, fields, sort_by, descending) {

  # Evaluate whether FDIC_API_KEY is environment variable
  check_empty_creds(api_key = api_key)

  # Clean and transform query parameters
  # Source
  params <- validate_query_params(
    filters = filters,
    fields = fields,
    sort_by = sort_by,
    descending = descending,
    endpoint = get(endpoint)
  )

  # Splice params into request
  # `field` param may contain multiple values, separate via comma
  # Max records that can be retrieved is 10,000 per API documentation
  req <- httr2::request(base_url = base_url) |>
    httr2::req_url_path_append(endpoint) |>
    httr2::req_url_query(
      !!!params,
      .multi = "comma"
    ) |>
    httr2::req_url_query(limit = 10000L) |>
    httr2::req_url_query(format = "CSV") |>
    httr2::req_error(body = fdic_error_message) |>
    httr2::req_user_agent(
      "fdic R package (https://ketchbrookanalytics.github.io/fdic/)"
    )

  resp <- httr2::req_perform(req)

  # Responses with empty body will contain the "content-length" header set to 0
  # If the header is present, abort before extracting body to avoid error
  if (
    httr2::resp_header_exists(
      resp = resp,
      header = "content-length"
    )
  ) {
    cli::cli_abort(
      c(
        "The response from the API is empty.",
        "Query {.field filters} of {.code {params$filters}} passed to API.",
        "Please check {.field filters} for possible issues.",
        "Refer to {.url https://api.fdic.gov/banks/docs/} for additional information."
      )
    )
  }

  # If "content-length" header is not present, extract body and create tibble
  resp <- httr2::resp_body_string(resp)

  df <- read.delim(
    file = textConnection(resp),
    sep = ","
  ) |>
    tibble::as_tibble()

  return(df)

}