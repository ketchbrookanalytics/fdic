# Non-API unit tests:

test_that("no_creds_available() returns TRUE when api_key is NULL or empty", {
  expect_true(no_creds_available(NULL))
  expect_true(no_creds_available(""))
  expect_true(no_creds_available("   "))
})

test_that("no_creds_available() returns FALSE when api_key is non-empty", {
  expect_false(no_creds_available("my_api_key"))
})

test_that("check_api_key() errors when api_key is NULL or empty", {
  expect_snapshot(error = TRUE, check_api_key(NULL))
  expect_snapshot(error = TRUE, check_api_key(""))
  expect_snapshot(error = TRUE, check_api_key("   "))
})

test_that("check_api_key() is silent when api_key is non-empty", {
  expect_no_error(check_api_key("my_api_key"))
})

test_that("validate_query_params() errors when filters is not a single string", {
  expect_snapshot(
    error = TRUE,
    validate_query_params(
      filters = 123,
      fields = NULL,
      sort_by = NULL,
      descending = FALSE
    )
  )
  expect_snapshot(
    error = TRUE,
    validate_query_params(
      filters = c("STALP:ND", "STALP:SD"),
      fields = NULL,
      sort_by = NULL,
      descending = FALSE
    )
  )
})

test_that("validate_query_params() errors when descending is not logical", {
  expect_snapshot(
    error = TRUE,
    validate_query_params(
      filters = NULL,
      fields = NULL,
      sort_by = NULL,
      descending = "yes"
    )
  )
})

test_that("validate_query_params() errors when descending has length > 1", {
  expect_snapshot(
    error = TRUE,
    validate_query_params(
      filters = NULL,
      fields = NULL,
      sort_by = NULL,
      descending = c(TRUE, FALSE)
    )
  )
})

test_that("validate_query_params() warns when descending=TRUE but sort_by is NULL", {
  expect_snapshot(
    validate_query_params(
      filters = NULL,
      fields = NULL,
      sort_by = NULL,
      descending = TRUE
    )
  )
})

test_that("validate_query_params() uppercases fields and sort_by", {
  result <- validate_query_params(
    filters = NULL,
    fields = "cert",
    sort_by = "cert",
    descending = FALSE
  )
  expect_equal(result$fields, "CERT")
  expect_equal(result$sort_by, "CERT")
})

test_that("validate_query_params() returns ASC sort_order when descending=FALSE", {
  result <- validate_query_params(
    filters = NULL,
    fields = NULL,
    sort_by = "CERT",
    descending = FALSE
  )
  expect_equal(result$sort_order, "ASC")
})

test_that("validate_query_params() returns DESC sort_order when descending=TRUE", {
  result <- validate_query_params(
    filters = NULL,
    fields = NULL,
    sort_by = "CERT",
    descending = TRUE
  )
  expect_equal(result$sort_order, "DESC")
})

test_that("validate_query_params() returns limit as integer", {
  result <- validate_query_params(
    filters = NULL,
    fields = NULL,
    sort_by = NULL,
    descending = FALSE,
    limit = 100
  )
  expect_identical(result$limit, 100L)
})

test_that("validate_query_params() errors on invalid limit", {
  expect_snapshot(
    error = TRUE,
    validate_query_params(
      filters = NULL,
      fields = NULL,
      sort_by = NULL,
      descending = FALSE,
      limit = "100"
    )
  )
  expect_snapshot(
    error = TRUE,
    validate_query_params(
      filters = NULL,
      fields = NULL,
      sort_by = NULL,
      descending = FALSE,
      limit = 100.5
    )
  )
  expect_snapshot(
    error = TRUE,
    validate_query_params(
      filters = NULL,
      fields = NULL,
      sort_by = NULL,
      descending = FALSE,
      limit = 0
    )
  )
  expect_snapshot(
    error = TRUE,
    validate_query_params(
      filters = NULL,
      fields = NULL,
      sort_by = NULL,
      descending = FALSE,
      limit = 10001
    )
  )
  expect_snapshot(
    error = TRUE,
    validate_query_params(
      filters = NULL,
      fields = NULL,
      sort_by = NULL,
      descending = FALSE,
      limit = NA_real_
    )
  )
  expect_snapshot(
    error = TRUE,
    validate_query_params(
      filters = NULL,
      fields = NULL,
      sort_by = NULL,
      descending = FALSE,
      limit = Inf
    )
  )
  expect_snapshot(
    error = TRUE,
    validate_query_params(
      filters = NULL,
      fields = NULL,
      sort_by = NULL,
      descending = FALSE,
      limit = -1
    )
  )
})

# get_fdic() integration tests:

# req_throttle() (see get_fdic()) prints a "Waiting Ns for throttling delay"
# message when a call has to wait for the token bucket to refill. That
# message is a timing side-effect, not part of what these tests assert, and
# whether it appears depends on how quickly preceding calls ran the bucket
# down. suppressMessages() muffles it before expect_snapshot() ever captures
# it, so the snapshots stay stable regardless of throttling.

test_that("get_fdic() errors when API returns an empty response", {
  skip_if(no_creds_available())
  expect_snapshot(
    error = TRUE,
    suppressMessages(get_institutions(filters = "STALP:XX"))
  )
})

test_that("get_fdic() errors when all requested fields are invalid", {
  skip_if(no_creds_available())
  expect_snapshot(
    error = TRUE,
    suppressMessages(get_institutions(
      filters = "STALP:ND",
      fields = c("NONEXISTENT_FIELD_1", "NONEXISTENT_FIELD_2"),
      limit = 5
    ))
  )
})

test_that("get_fdic() warns when some requested fields are invalid", {
  # Mock the HTTP response so this test runs without credentials and is not
  # fragile against live data changing. The mocked response contains only CERT
  # and the always-returned ID column, so the requested NONEXISTENT_FIELD is
  # absent and triggers the "fields not returned" warning inside get_fdic().
  httr2::local_mocked_responses(list(
    httr2::response(
      status_code = 200,
      body = charToRaw(paste0(
        "CERT,ID\n",
        "10231,10231\n10233,10233\n10236,10236\n10238,10238\n10240,10240\n"
      ))
    )
  ))
  expect_snapshot(
    suppressMessages(get_institutions(
      api_key = "test_key",
      filters = "STALP:ND",
      fields = c("CERT", "NONEXISTENT_FIELD"),
      limit = 5
    ))
  )
})

test_that("get_fdic() errors with HTTP 403 for an invalid api_key", {
  skip_if_offline()
  expect_error(
    get_institutions(api_key = "blah", limit = 1),
    class = "httr2_http_403"
  )
})
