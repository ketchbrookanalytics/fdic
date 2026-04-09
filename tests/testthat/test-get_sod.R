test_that("get_sod() returns a tibble", {
  skip_if_not(nzchar(Sys.getenv("FDIC_API_KEY")))
  result <- get_sod(filters = "STALP:ND")
  expect_s3_class(result, "tbl_df")
  expect_gt(nrow(result), 0)
})

test_that("get_sod() respects the fields argument", {
  skip_if_not(nzchar(Sys.getenv("FDIC_API_KEY")))
  fields <- c("CERT", "CITY", "ASSET", "YEAR")
  result <- get_sod(filters = "STALP:ND", fields = fields)
  expect_setequal(names(result), c("ID", fields))
})
