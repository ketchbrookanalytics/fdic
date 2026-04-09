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
            title = trimws(purrr::pluck(x, "title", .default = NA_character_)),
            description = trimws(purrr::pluck(x, "description", .default = NA_character_)),
            type = trimws(purrr::pluck(x, "type", .default = NA_character_))
          )
        }
      ) |>
        dplyr::bind_rows()

    }
  )

fdic_demographics <- field_definitions$demographics
fdic_failures     <- field_definitions$failures
fdic_financials   <- field_definitions$financials
fdic_history      <- field_definitions$history
fdic_institutions <- field_definitions$institutions
fdic_locations    <- field_definitions$locations
fdic_sod          <- field_definitions$sod
fdic_summary      <- field_definitions$summary

usethis::use_data(
  fdic_demographics,
  fdic_failures,
  fdic_financials,
  fdic_history,
  fdic_institutions,
  fdic_locations,
  fdic_sod,
  fdic_summary,
  overwrite = TRUE
)
