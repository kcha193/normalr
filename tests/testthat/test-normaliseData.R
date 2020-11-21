test_that("normalisation on a data frame works", {

  res <-
    normaliseData(mtcars, getLambda(mtcars, parallel = FALSE))


  expect_equal(dim(res), c(32, 11))

  expect_equal(round(sum(res)), 15327)

})
