#' Apply normalisation on a data frame using specific Lambda value
#'
#' @param dat a data frame containing the variables.
#' @param lambdas a numeric vector from the \link[MASS]{boxcox} function
#'
#' @return a list of three elements, the first element, lambdas, is a numeric vector
#'         containing lambdas, the second element, scaled, is a numeric vector containing
#'         scale adjustment, the last element, transDat, is a data frame comprising the
#'         transformed variables.
#' @references {
#' Courtney, M. G. R., and Chang, K. C. (2018) Dealing with non-normality: an introduction and step-by-step guide using R. TEST, doi: 10.1111/test.12154.
#' }
#' @export
#'
#' @examples
#' \dontrun{normaliseDataInfo(mtcars, getLambda(mtcars, parallel = FALSE))}
#' normaliseDataInfo(mtcars, getLambda(mtcars, parallel = FALSE))
normaliseDataInfo <-
  function(dat, lambdas){
    stopifnot(is.data.frame(dat) | is.numeric(lambdas))

    res <- apply(rbind(lambdas, dat), 2, function(x) normalise(x[-1], x[1]))

    list(lambdas =  res[1,],
         scaled = res[2,],
         transDat = as.data.frame(res[-c(1:2), ]))
  }
