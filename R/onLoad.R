#' Adds the content of www to shinyWidgets/
#'
#' @importFrom shiny addResourcePath registerInputHandler
#'
#' @noRd
#'
.onLoad <- function(...) {
  shiny::addResourcePath('shinyWidgets', system.file("assets", package = "shinyWidgets"))
  shiny::registerInputHandler("sw.numericRange", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      data[vapply(data, is.null, logical(1))] <- NA
      result <- as.numeric(unlist(data))
      if (all(is.na(result))) {
        return(NULL)
      } else {
        return(result)
      }
    }
  }, force = TRUE)
  shiny::registerInputHandler("air.date", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      res <- try(as.Date(unlist(data)), silent = TRUE)
      if ("try-error" %in% class(res)) {
        warning("Failed to parse dates!")
        # as.Date(NA)
        data
      } else {
        res
      }
    }
  }, force = TRUE)
  shiny::registerInputHandler("air.datetime", function(data, ...) {
    parse_datetime <- function(x) {
      as.POSIXct(x = x/1000, origin = "1970-01-01")
    }
    if (is.null(data)) {
      NULL
    } else {
      res <- try(parse_datetime(unlist(data)), silent = TRUE)
      if ("try-error" %in% class(res)) {
        warning("Failed to parse dates!")
        # as.Date(NA)
        data
      } else {
        res
      }
    }
  }, force = TRUE)
}
