# Non-API unit tests:

test_that("no_creds_available() returns TRUE when api_key is NULL or empty", {
  expect_true(no_creds_available(NULL))
  expect_true(no_creds_available(""))
  expect_true(no_creds_available("   "))
})

test_that("no_creds_available() returns FALSE when api_key is non-empty", {
  expect_false(no_creds_available("my_api_key"))
})

test_that("check_empty_creds() errors when api_key is NULL or empty", {
  expect_snapshot(error = TRUE, check_empty_creds(NULL))
  expect_snapshot(error = TRUE, check_empty_creds(""))
  expect_snapshot(error = TRUE, check_empty_creds("   "))
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
})

# get_fdic() integration tests:

test_that("get_fdic() errors when API returns an empty response", {
  skip_if(no_creds_available())
  expect_snapshot(
    error = TRUE,
    get_institutions(filters = "STALP:XX")
  )
})

test_that("get_fdic() errors when all requested fields are invalid", {
  skip_if(no_creds_available())
  expect_snapshot(
    error = TRUE,
    get_institutions(
      filters = "STALP:ND",
      fields = c("NONEXISTENT_FIELD_1", "NONEXISTENT_FIELD_2"),
      limit = 5
    )
  )
})

test_that("get_fdic() warns when some requested fields are invalid", {
  skip_if(no_creds_available())
  expect_snapshot(
    get_institutions(
      filters = "STALP:ND",
      fields = c("CERT", "NONEXISTENT_FIELD"),
      limit = 5
    )
  )
})
