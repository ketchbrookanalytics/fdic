test_that("get_sod() returns a tibble", {
  skip_if(no_creds_available())
  result <- get_sod(filters = "STALP:ND")
  expect_s3_class(result, "tbl_df")
  expect_gt(nrow(result), 0)
})

test_that("get_sod() respects the fields argument", {
  skip_if(no_creds_available())
  fields <- c("CERT", "CITY", "ASSET", "YEAR")
  result <- get_sod(filters = "STALP:ND", fields = fields)
  expect_setequal(names(result), c("ID", fields))
})
