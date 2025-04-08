library(testthat)
library(M2algorithmique)

test_that("Tri Radix fonctionne correctement", {
  expect_equal(radix_sort_Rcpp(c(3, 1, 2)), c(1, 2, 3))
})

test_that("Tri Quick fonctionne correctement", {
  expect_equal(quick_sort_Rcpp(c(3, 1, 2)), c(1, 2, 3))
})

test_that("Tri par Tas fonctionne correctement", {
  expect_equal(heap_sort_Rcpp(c(3, 1, 2)), c(1, 2, 3))
})

test_that("Tri Fusion fonctionne correctement", {
  expect_equal(merge_sort_Rcpp(c(3, 1, 2)), c(1, 2, 3))
})
