test_that("Get Optimal Lambda value works", {
  expect_equal(getLambda(mtcars, parallel = FALSE),
               c(0.60, 1.23, 0.55, 0.63, 0.28, 0.65,
                 0.03, -1.09, -1.66, -0.99,  0.27))
})
