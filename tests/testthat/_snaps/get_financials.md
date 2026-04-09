# get_financials() errors when limit > 500 and fields > 250

    Code
      get_financials(fields = head(fdic_financials$field, 251), limit = 501)
    Condition
      Error in `get_financials()`:
      ! `limit` must be 500 or fewer when more than 250 fields are requested.

