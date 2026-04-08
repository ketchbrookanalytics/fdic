base_url <- "https://api.fdic.gov/banks/"

api_definitions <- list(
  demographics = paste0(base_url, "docs/demographics_properties.yaml"),
  failures     = paste0(base_url, "docs/failure_properties.yaml"),
  financials   = paste0(base_url, "docs/risview_properties.yaml"),
  history      = paste0(base_url, "docs/history_properties.yaml"),
  institutions = paste0(base_url, "docs/institution_properties.yaml"),
  locations    = paste0(base_url, "docs/location_properties.yaml"),
  sod          = paste0(base_url, "docs/sod_properties.yaml"),
  summary      = paste0(base_url, "docs/summary_properties.yaml")
)

field_definitions <- api_definitions |>
  purrr::map(
    \(x) {

      yaml <- yaml::read_yaml(
        file = url(x),
        readLines.warn = FALSE
      )

      fields <- yaml$properties$data$properties

      purrr::imap(
        .x = fields,
        .f = function(x, idx) {
          tibble::tibble(
            field = idx,
            title = trimws(x$title),
            description = trimws(x$description),
            type = trimws(x$type)
          )
        }
      ) |>
        dplyr::bind_rows()

    }
  )

demographics <- field_definitions$demographics
failures     <- field_definitions$failures
financials   <- field_definitions$financials
history      <- field_definitions$history
institutions <- field_definitions$institutions
locations    <- field_definitions$locations
sod          <- field_definitions$sod
summary      <- field_definitions$summary

usethis::use_data(
  demographics,
  failures,
  financials,
  history,
  institutions,
  locations,
  sod,
  summary,
  overwrite = TRUE
)
