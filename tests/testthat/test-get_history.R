test_that("get_history() returns a tibble", {
  skip_if_not(nzchar(Sys.getenv("FDIC_API_KEY")))
  result <- get_history(filters = "CERT:10002")
  expect_s3_class(result, "tbl_df")
  expect_gt(nrow(result), 0)
})

test_that("get_history() respects the fields argument", {
  skip_if_not(nzchar(Sys.getenv("FDIC_API_KEY")))
  fields <- c("CERT", "CHANGECODE", "CHANGECODE_DESC", "PROCDATE")
  result <- get_history(filters = "CERT:10002", fields = fields)
  expect_setequal(names(result), c("ID", fields))
})
