# check_empty_creds() warns once per session when api_key is NULL or empty

    Code
      check_empty_creds(NULL)
    Condition
      Warning:
      No `api_key` provided.
      i Use `api_key = "DEMO_KEY"` for exploration (30 req/hr, 50 req/day).
      i Register for a free personal key (1,000 req/hr) at <https://api.data.gov/signup/>.
      This message is shown once per session.

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

