test_that("get_failures() returns a tibble", {
  skip_if(no_creds_available())
  result <- get_failures(filters = "PSTALP:ND")
  expect_s3_class(result, "tbl_df")
  expect_gt(nrow(result), 0)
})

test_that("get_failures() respects the fields argument", {
  skip_if(no_creds_available())
  fields <- c("NAME", "CERT", "FAILDATE", "PSTALP")
  result <- get_failures(filters = "PSTALP:ND", fields = fields)
  expect_setequal(names(result), c("ID", fields))
})
