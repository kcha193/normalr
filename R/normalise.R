

#' Apply normalisation on a numeirc vector using specific Lambda value
#'
#' @param x a numeric vector to be normalised.
#' @param lambda  a numeric vector from the \link[MASS]{boxcox} function
#'
#' @return a numeric vector
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
      if(min(x) <=0 )
        x <- x + (1-min(x)) #anchor

      temp <- -(x^(lambda))

      temp+(1-min(temp))
    }else{
      x^lambda
    }
  scaled <- ((max(x) - min(x))/(max(transX) - min(transX)))

  return((transX - min(transX))* scaled + min(x))
}


