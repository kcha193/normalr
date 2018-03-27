
#'Get Optimal Lambda value
#'
#'Computes optimal lambda value using \link[MASS]{boxcox} function from the provided data.
#'
#' @param dat a data frame containing the variables of numeric or integer vectors.
#' @param lambda a vector of values of lambda – default (-10, 10) in steps of 0.01.
#' @param parallel perform the computation in parallel, default setting is TRUE.
#'
#' @return a numeric vector
#' @importFrom purrr keep map map_dbl
#' @importFrom rlang is_bare_numeric
#' @importFrom magrittr %>%
#' @importFrom stats as.formula
#' @importFrom parallel detectCores makeCluster parLapply stopCluster
#' @export
#'
#' @examples
#' \dontrun{ getLambda(mtcars)}
#' getLambda(mtcars, parallel = FALSE)
getLambda <-
  function(dat, lambda = seq(-10, 10, 1/100), parallel = TRUE){
    stopifnot(is.data.frame(dat))

    dat <- purrr::keep(dat, rlang::is_bare_numeric)

    dat <- data.frame(apply(rbind(1 - apply(dat, 2, min), dat), 2, function(x) x[1] + x[-1])) #anchor at 1

    formulaList <-
      if(ncol(dat) == 1){
        as.formula(paste(names(dat), 1, sep = "~"))
      }else{
        names(dat) %>%
          purrr::map(function(x)
            as.formula(paste(x, paste(names(dat)[!names(dat) %in% x], collapse = "+"), sep = "~")))
      }
browser()

    lambdasList <-
      if(ncol(dat) == 1){
        MASS::boxcox(formulaList, data = dat, lambda = lambda, plotit = FALSE)
      } else if(parallel){

        cl <- parallel::makeCluster(min(parallel::detectCores(), ncol(dat)))

        res <-
        parallel::parLapply(cl, formulaList, function(x)
          MASS::boxcox(x, data = dat, lambda = lambda, plotit = FALSE))

        parallel::stopCluster(cl)

        res
      } else {
        formulaList %>% purrr::map(function(x)
          MASS::boxcox(x, data = dat, lambda = lambda, plotit = FALSE))
      }

    lambdas <-
      if(ncol(dat) == 1){
        lambdasList$x[ which(lambdasList$y == max(lambdasList$y))]
      } else {
        lambdasList %>%
          purrr::map_dbl(function(k) k$x[ which(k$y == max(k$y))])
      }
    return(lambdas)
  }



