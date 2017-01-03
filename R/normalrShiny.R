#' Shiny application of the normalr
#'
#' @param example name of the shiny apps
#'
#' @import shiny
#' @export
#'
#' @examples
#' \dontrun{normalrShiny()}
normalrShiny <-
  function(example = "normalr"){

    validExamples <- list.files(system.file("shiny-examples", package = "normalr"))

    validExamplesMsg <-
      paste0(
        "Valid examples are: '",
        paste(validExamples, collapse = "', '"),
        "'")

    # if an invalid example is given, throw an error
    if (missing(example) || !nzchar(example) ||
        !example %in% validExamples) {
      stop(
        'Please run `normalrShiny()` with a valid example app as an argument.n',
        validExamplesMsg,
        call. = FALSE)
    }

    # find and launch the app
    appDir <- system.file("shiny-examples", example, package = "normalr")

    shiny::runApp(appDir, display.mode = "normal")
}
