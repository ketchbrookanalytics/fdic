test_that("get_summary() returns a tibble", {
  skip_if_not(nzchar(Sys.getenv("FDIC_API_KEY")))
  result <- get_summary(filters = "YEAR:2025")
  expect_s3_class(result, "tbl_df")
  expect_gt(nrow(result), 0)
})

test_that("get_summary() respects the fields argument", {
  skip_if_not(nzchar(Sys.getenv("FDIC_API_KEY")))
  fields <- c("YEAR", "BANKS", "ASSET")
  result <- get_summary(filters = "YEAR:2025", fields = fields)
  expect_setequal(names(result), c("ID", fields))
})
