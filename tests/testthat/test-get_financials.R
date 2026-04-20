test_that("get_financials() returns a tibble", {
  skip_if(no_creds_available())
  result <- get_financials(filters = "STALP:ND")
  expect_s3_class(result, "tbl_df")
  expect_gt(nrow(result), 0)
})

test_that("get_financials() respects the fields argument", {
  skip_if(no_creds_available())
  fields <- c("CERT", "REPDTE", "ASSET", "NETINC")
  result <- get_financials(filters = "STALP:ND", fields = fields)
  expect_setequal(names(result), c("ID", fields))
})

test_that("get_financials() errors when limit > 500 and fields > 250", {
  expect_snapshot(
    error = TRUE,
    get_financials(fields = head(fdic_financials$field, 251), limit = 501)
  )
})

test_that("get_financials() allows limit = 500 when fields > 250", {
  withr::local_envvar(FDIC_API_KEY = "")
  expect_error(
    get_financials(fields = head(fdic_financials$field, 251), limit = 500),
    regexp = "api_key"
  )
})

test_that("get_financials() allows limit > 500 when fields <= 250", {
  withr::local_envvar(FDIC_API_KEY = "")
  expect_error(
    get_financials(fields = head(fdic_financials$field, 250), limit = 501),
    regexp = "api_key"
  )
})
