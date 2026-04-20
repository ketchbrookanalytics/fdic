test_that("get_summary() returns a tibble", {
  skip_if(no_creds_available())
  result <- get_summary(filters = "YEAR:2025")
  expect_s3_class(result, "tbl_df")
  expect_gt(nrow(result), 0)
})

test_that("get_summary() respects the fields argument", {
  skip_if(no_creds_available())
  fields <- c("YEAR", "BANKS", "ASSET")
  result <- get_summary(filters = "YEAR:2025", fields = fields)
  expect_setequal(names(result), c("ID", fields))
})
