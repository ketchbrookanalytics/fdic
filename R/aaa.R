#' Define the base URL for all FDIC API endpoints
#' @noRd
base_url <- "https://api.fdic.gov/banks/"

#' Create a small error handler to return error messages from API
#' @noRd
fdic_error_message <- function(resp) {
  httr2::resp_body_json(resp)$Message
}

#' Handle missing API key without throwing an error for unit testing purposes
#'
#' @param api_key (String) The API key for authenticating against the FDIC API

#' @return (Logical) `FALSE` if a non-empty `api_key` has been supplied;
#'   otherwise `TRUE`.
#'
#' @details Intended for internal use.
#'
#' @export
no_creds_available <- function(
  api_key = Sys.getenv("FDIC_API_KEY")
) {
  if (is.null(api_key) || trimws(api_key) == "") {
    TRUE
  } else {
    FALSE
  }
}

#' Handle missing API Key value
#' @noRd
check_empty_creds <- function(api_key) {
  if (is.null(api_key) || trimws(api_key) == "") {
    cli::cli_abort(
      c(
        "{.arg api_key} is missing.",
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
    cli::cli_abort("{.arg filters} must be a single character string.")
  }

  # The `fields` param can be a character vector to specify the fields to return
  # Values must be formatted as uppercase when creating the API request
  if (!is.null(fields)) {
    fields <- toupper(fields)
  }

  # The `sort_by` param can be a `field` to sort the returned data by
  # Values must be formatted as uppercase when creating the API request
  if (!is.null(sort_by)) {
    sort_by <- toupper(sort_by)
  }

  if (!is.logical(descending) || length(descending) != 1) {
    cli::cli_abort("{.arg descending} must be TRUE or FALSE.")
  }

  if (
    !is.numeric(limit) ||
      length(limit) != 1 ||
      is.na(limit) ||
      limit != as.integer(limit) ||
      limit < 1 ||
      limit > 10000
  ) {
    cli::cli_abort("{.arg limit} must be an integer between 1 and 10,000.")
  }

  # The `descending` param does not affect the return data
  # when the `sort_by` param is not specified
  if (is.null(sort_by) && descending) {
    cli::cli_warn(
      "{.arg descending} is ignored when {.arg sort_by} is not specified."
    )
  }

  validated_params <- list(
    filters = filters,
    fields = fields,
    sort_by = sort_by,
    sort_order = if (descending) "DESC" else "ASC",
    limit = as.integer(limit)
  )

  return(validated_params)
}

#' Factory function to build request and extract response body to tibble
#' @importFrom utils read.delim
#' @noRd
get_fdic <- function(
  endpoint,
  api_key,
  filters,
  fields,
  sort_by,
  descending,
  limit
) {
  # Check for FDIC_API_KEY
  check_empty_creds(api_key = api_key)

  # Evaluate and prepare query params for request
  params <- validate_query_params(
    filters = filters,
    fields = fields,
    sort_by = sort_by,
    descending = descending,
    limit = limit
  )

  # Build API request per specification
  # https://api.fdic.gov/banks/docs/
  req <- httr2::request(base_url = base_url) |>
    httr2::req_url_path_append(endpoint) |>
    httr2::req_url_query(
      !!!params,
      .multi = "comma"
    ) |>
    httr2::req_url_query(format = "CSV") |>
    httr2::req_error(body = fdic_error_message) |>
    httr2::req_user_agent(
      "fdic R package (https://ketchbrookanalytics.github.io/fdic/)"
    )

  # Perform request
  resp <- httr2::req_perform(req)

  # Protect against error if response body is empty
  # This may indicate a malformed `filter` expression
  if (!httr2::resp_has_body(resp)) {
    cli::cli_abort(
      c(
        "The response from the API is empty.",
        "Query {.arg filters} of {.code {params$filters}} passed to API.",
        "Please check {.arg filters} for possible issues.",
        "Refer to {.url https://api.fdic.gov/banks/docs/} for additional information."
      )
    )
  }

  # If response body is not empty, extract data to tibble
  resp <- httr2::resp_body_string(resp)

  df <- read.delim(
    file = textConnection(resp),
    sep = ","
  ) |>
    tibble::as_tibble()

  # If all supplied `fields` are not in response, only ID field will be returned
  # Instead of returning a tibble with just the ID, abort and notify user
  if (!is.null(params$fields)) {
    missing_fields <- setdiff(params$fields, toupper(names(df)))
    if (length(missing_fields) == length(params$fields)) {
      cli::cli_abort(
        c(
          "None of the requested {.arg fields} were returned by the API:",
          "*" = "{.code {missing_fields}}",
          "i" = paste(
            "These fields may not exist or may have been renamed. To see",
            "currently available fields, call this function with",
            "{.code limit = 1} and no {.arg fields} argument."
          )
        )
      )
    } else if (length(missing_fields) > 0) {
      # If some supplied `fields` are not in response, warn user
      cli::cli_warn(
        c(
          "The following {.arg fields} were not returned by the API:",
          "*" = "{.code {missing_fields}}",
          "i" = paste(
            "These fields may not exist or may have been renamed. To see",
            "currently available fields, call this function with",
            "{.code limit = 1} and no {.arg fields} argument."
          )
        )
      )
    }
  }

  return(df)
}
