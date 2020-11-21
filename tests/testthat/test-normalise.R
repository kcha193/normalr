test_that("Apply normalisation works", {

  x <- c(1, 5, 9)

  expect_equal(
    c("lambda" = 3.00000000,
      "scaled" = 0.01098901,
      1.00000000,2.36263736,9.00000000) ,
    normalise(x, lambda = 3))

})
