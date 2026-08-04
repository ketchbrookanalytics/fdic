# check_api_key() errors when api_key is NULL or empty

    Code
      check_api_key(NULL)
    Condition
      Error in `check_api_key()`:
      ! No `api_key` provided.
      i The FDIC requires an API key for all requests.
      i Register for a free personal key (1,000 req/hr) at <https://api.data.gov/signup/>.

---

    Code
      check_api_key("")
    Condition
      Error in `check_api_key()`:
      ! No `api_key` provided.
      i The FDIC requires an API key for all requests.
      i Register for a free personal key (1,000 req/hr) at <https://api.data.gov/signup/>.

---

    Code
      check_api_key("   ")
    Condition
      Error in `check_api_key()`:
      ! No `api_key` provided.
      i The FDIC requires an API key for all requests.
      i Register for a free personal key (1,000 req/hr) at <https://api.data.gov/signup/>.

# validate_query_params() errors when filters is not a single string

    Code
      validate_query_params(filters = 123, fields = NULL, sort_by = NULL, descending = FALSE)
    Condition
      Error in `validate_query_params()`:
      ! `filters` must be a single character string.

---

    Code
      validate_query_params(filters = c("STALP:ND", "STALP:SD"), fields = NULL,
      sort_by = NULL, descending = FALSE)
    Condition
      Error in `validate_query_params()`:
      ! `filters` must be a single character string.

# validate_query_params() errors when descending is not logical

    Code
      validate_query_params(filters = NULL, fields = NULL, sort_by = NULL,
        descending = "yes")
    Condition
      Error in `validate_query_params()`:
      ! `descending` must be TRUE or FALSE.

# validate_query_params() errors when descending has length > 1

    Code
      validate_query_params(filters = NULL, fields = NULL, sort_by = NULL,
        descending = c(TRUE, FALSE))
    Condition
      Error in `validate_query_params()`:
      ! `descending` must be TRUE or FALSE.

# validate_query_params() warns when descending=TRUE but sort_by is NULL

    Code
      validate_query_params(filters = NULL, fields = NULL, sort_by = NULL,
        descending = TRUE)
    Condition
      Warning:
      `descending` is ignored when `sort_by` is not specified.
    Output
      $filters
      NULL
      
      $fields
      NULL
      
      $sort_by
      NULL
      
      $sort_order
      [1] "DESC"
      
      $limit
      [1] 10000
      

# validate_query_params() errors on invalid limit

    Code
      validate_query_params(filters = NULL, fields = NULL, sort_by = NULL,
        descending = FALSE, limit = "100")
    Condition
      Error in `validate_query_params()`:
      ! `limit` must be an integer between 1 and 10,000.

---

    Code
      validate_query_params(filters = NULL, fields = NULL, sort_by = NULL,
        descending = FALSE, limit = 100.5)
    Condition
      Error in `validate_query_params()`:
      ! `limit` must be an integer between 1 and 10,000.

---

    Code
      validate_query_params(filters = NULL, fields = NULL, sort_by = NULL,
        descending = FALSE, limit = 0)
    Condition
      Error in `validate_query_params()`:
      ! `limit` must be an integer between 1 and 10,000.

---

    Code
      validate_query_params(filters = NULL, fields = NULL, sort_by = NULL,
        descending = FALSE, limit = 10001)
    Condition
      Error in `validate_query_params()`:
      ! `limit` must be an integer between 1 and 10,000.

---

    Code
      validate_query_params(filters = NULL, fields = NULL, sort_by = NULL,
        descending = FALSE, limit = NA_real_)
    Condition
      Error in `validate_query_params()`:
      ! `limit` must be an integer between 1 and 10,000.

---

    Code
      validate_query_params(filters = NULL, fields = NULL, sort_by = NULL,
        descending = FALSE, limit = Inf)
    Condition
      Warning in `validate_query_params()`:
      NAs introduced by coercion to integer range
      Error in `validate_query_params()`:
      ! `limit` must be an integer between 1 and 10,000.

---

    Code
      validate_query_params(filters = NULL, fields = NULL, sort_by = NULL,
        descending = FALSE, limit = -1)
    Condition
      Error in `validate_query_params()`:
      ! `limit` must be an integer between 1 and 10,000.

# get_fdic() errors when API returns an empty response

    Code
      suppressMessages(get_institutions(filters = "STALP:XX"))
    Condition
      Error in `get_fdic()`:
      ! The response from the API is empty.
      Query `filters` of `STALP:XX` passed to API.
      Please check `filters` for possible issues.
      Refer to <https://api.fdic.gov/banks/docs/> for additional information.

# get_fdic() errors when all requested fields are invalid

    Code
      suppressMessages(get_institutions(filters = "STALP:ND", fields = c(
        "NONEXISTENT_FIELD_1", "NONEXISTENT_FIELD_2"), limit = 5))
    Condition
      Error in `get_fdic()`:
      ! None of the requested `fields` were returned by the API:
      * `NONEXISTENT_FIELD_1` and `NONEXISTENT_FIELD_2`
      i These fields may not exist or may have been renamed. To see currently available fields, call this function with `limit = 1` and no `fields` argument.

# get_fdic() warns when some requested fields are invalid

    Code
      suppressMessages(get_institutions(api_key = "test_key", filters = "STALP:ND",
        fields = c("CERT", "NONEXISTENT_FIELD"), limit = 5))
    Condition
      Warning:
      The following `fields` were not returned by the API:
      * `NONEXISTENT_FIELD`
      i These fields may not exist or may have been renamed. To see currently available fields, call this function with `limit = 1` and no `fields` argument.
    Output
      # A tibble: 5 x 2
         CERT    ID
        <int> <int>
      1 10231 10231
      2 10233 10233
      3 10236 10236
      4 10238 10238
      5 10240 10240

