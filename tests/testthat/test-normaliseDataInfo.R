test_that("multiplication works", {


  res <-  normaliseDataInfo(mtcars, getLambda(mtcars, parallel = FALSE))


  expect_equal(length(res), 3)

  lambdas <-
    getLambda(mtcars, parallel = FALSE)

  names(lambdas) <- names(mtcars)

  expect_equal(res$lambdas, lambdas)

  expect_equal(round(sum(res$scaled)), 638)


  expect_equal(round(sum(res$transDat)), 15327)

  expect_equal(
    res$transDat,
    as.data.frame(apply(rbind(lambdas, mtcars), 2,
                        function(x) normalise(x[-1], x[1])[-c(1:2)])))


  res <-  normaliseDataInfo(mtcars, getLambda(mtcars, parallel = TRUE))


  expect_equal(length(res), 3)

  lambdas <-
    getLambda(mtcars, parallel = FALSE)

  names(lambdas) <- names(mtcars)

  expect_equal(res$lambdas, lambdas)

  expect_equal(round(sum(res$scaled)), 638)


  expect_equal(round(sum(res$transDat)), 15327)

  expect_equal(
    res$transDat,
    as.data.frame(apply(rbind(lambdas, mtcars), 2,
                        function(x) normalise(x[-1], x[1])[-c(1:2)])))




})
