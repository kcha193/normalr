
#'Get Optimal Lambda value
#'
#'Computes optimal lambda value using \link[MASS]{boxcox} function from the provided data.
#'
#' @param data a data frame containing the variables of numeric or integer vectors.
#' @param lambda a vector of values of lambda – default (-10, 10) in steps of 0.01.
#' @param parallel perform the computation in parallel, default setting is TRUE.
#'
#' @return a numeric vector
#' @importFrom purrr keep map map_dbl
#' @importFrom magrittr %>%
#' @importFrom stats as.formula
#' @importFrom ddR dlapply collect
#' @importFrom parallel detectCores
#' @export
#'
#' @examples
#' \dontrun{ getLambda(mtcars)}
#' getLambda(mtcars, parallel = FALSE)
getLambda <-
  function(data, lambda = seq(-10, 10, 1/100), parallel = TRUE){
    stopifnot(is.data.frame(data))

    data <- purrr::keep(data, purrr::is_numeric)

    data <- data.frame(apply(rbind(1 - apply(data, 2, min), data), 2, function(x) x[1] + x[-1]))

    formulaList <-
      names(data) %>%
      purrr::map(function(x)
        as.formula(paste(x, paste(names(data)[!names(data) %in% x], collapse = "+"), sep = "~")))

    lambdasList <-
      if(parallel){
        formulaList %>% ddR::dlapply(function(x)
          MASS::boxcox(x, data = data, lambda = lambda, plotit = FALSE),
                nparts = parallel::detectCores()) %>%
          ddR::collect()
      } else {
        formulaList %>% purrr::map(function(x)
          MASS::boxcox(x, data = data, lambda = lambda, plotit = FALSE))
      }

    lambdas <-
      lambdasList %>%
      purrr::map_dbl(function(k) k$x[ which(k$y == max(k$y))])

    return(lambdas)
  }



