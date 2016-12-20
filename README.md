# normalr
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/normalr)](http://cran.r-project.org/package=normalr)
[![Build Status](https://travis-ci.org/kcha193/normalr.png?branch=master)](https://travis-ci.org/kcha193/normalr)
[![Coverage Status](https://img.shields.io/codecov/c/github/kcha193/normalr/master.svg)](https://codecov.io/github/kcha193/normalr?branch=master)


The normalr allows you to perform normalisation on multiple variables in large-scale datasets. 

## Installation

normalr is available from CRAN. Install it with:

``` r
install.packages("normalr")
```

You can install normalr from github with:

``` r
# install.packages("devtools")
devtools::install_github("kcha193/normalr")
```
## Examples

The following example uses normalr to normalise 11 continous variables in mtcars dataset.

```R
library(normalr)

normaliseData(mtcars, getLambda(mtcars))
```
