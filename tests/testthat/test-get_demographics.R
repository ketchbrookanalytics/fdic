test_that("get_demographics() returns a tibble", {
  skip_if(no_creds_available())
  result <- get_demographics(filters = "CERT:10002")
  expect_s3_class(result, "tbl_df")
  expect_gt(nrow(result), 0)
})

test_that("get_demographics() respects the fields argument", {
  skip_if(no_creds_available())
  fields <- c("CERT", "REPDTE", "OFFTOT")
  result <- get_demographics(filters = "CERT:10002", fields = fields)
  expect_setequal(names(result), c("ID", fields))
})
