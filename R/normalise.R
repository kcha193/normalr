#' Apply normalisation on a numeric vector using a specific Lambda value
#'
#' @param x a numeric vector to be normalised.
#' @param lambda a numeric vector from the \link[MASS]{boxcox} function
#'
#' @return a numeric vector with lambda, scale and the transformed variable
#' @references {
#' Courtney, M. G. R., and Chang, K. C. (2018) Dealing with non-normality: an introduction and step-by-step guide using R. TEST, doi: 10.1111/test.12154.
#' }
#' @export
#'
#' @examples
#' x <- c(1, 5, 9, 9, 9, 9, 10, 10, 10, 11, 11, 12)
#' normalise(x, lambda = 3)
normalise <- function(x, lambda = 3){
  stopifnot(is.numeric(x) | is.numeric(lambda))

  transX <-
    if(lambda == 0){
      log(x)
    }else if (lambda < 0){
        if(min(x) <= 0){
          temp <- x + (1-min(x)) #anchor
          temp <- -(temp^(lambda)) #applied and reflected
        } else {
          temp <- -(x^(lambda)) #applied and reflected
        }
        temp+(1-min(temp)) #pegged
    }else{
      if(min(x) <= 0){
        temp <- x + (1-min(x)) #anchor
        temp <- (temp^(lambda)) #applied and reflected
      } else {
        temp <- (x^(lambda)) #applied and reflected
      }
      temp+(1-min(temp)) #pegged
    }

  scaled <- ((max(x) - min(x))/(max(transX) - min(transX)))

  return(c(lambda = lambda, scaled = scaled, (transX - min(transX))* scaled + min(x)))
}


