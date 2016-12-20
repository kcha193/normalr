# normalr


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
