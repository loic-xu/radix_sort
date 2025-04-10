library(testthat)
library(M2algorithmique)

library(testthat)
library(M2algorithmique)

#Tests fonctions R

test_that("Tri Radix R fonctionne correctement", {
  expect_equal(radix_sort(c(3, 1, 2)), c(1, 2, 3))
  expect_equal(radix_sort(numeric()), numeric())  # Cas vide
  expect_equal(radix_sort(c(1)), c(1))  # Cas avec un seul élément
  expect_equal(radix_sort(c(1, 2, 3)), c(1, 2, 3))  # Vecteur déjà trié
  expect_equal(radix_sort(c(3, 3, 3)), c(3, 3, 3))  # Vecteur avec doublons
  expect_equal(radix_sort(c(-3, -1, -2)), c(-3, -2, -1))  # Valeurs négatives
})


test_that("Tri par Tas R fonctionne correctement", {
  expect_equal(heap_sort(c(3, 1, 2)), c(1, 2, 3))
  expect_equal(heap_sort(numeric()), numeric())
  expect_equal(heap_sort(c(1)), c(1))  # Cas avec un seul élément
  expect_equal(heap_sort(c(1, 2, 3)), c(1, 2, 3))  # Vecteur déjà trié
  expect_equal(heap_sort(c(3, 3, 3)), c(3, 3, 3))  # Vecteur avec doublons
  expect_equal(heap_sort(c(-3, -1, -2)), c(-3, -2, -1))  # Valeurs négatives
})

test_that("Tri Fusion R fonctionne correctement", {
  expect_equal(merge_sort(c(3, 1, 2)), c(1, 2, 3))
  expect_equal(merge_sort(numeric()), numeric())
  expect_equal(merge_sort(c(1)), c(1))  # Cas avec un seul élément
  expect_equal(merge_sort(c(1, 2, 3)), c(1, 2, 3))  # Vecteur déjà trié
  expect_equal(merge_sort(c(3, 3, 3)), c(3, 3, 3))  # Vecteur avec doublons
  expect_equal(merge_sort(c(-3, -1, -2)), c(-3, -2, -1))  # Valeurs négatives
})


#Tests fonctions C++

test_that("Tri Radix C++ fonctionne correctement", {
  expect_equal(radix_sort_Rcpp(c(3, 1, 2)), c(1, 2, 3))
  expect_equal(radix_sort_Rcpp(numeric()), numeric())  # Cas vide
  expect_equal(radix_sort_Rcpp(c(1)), c(1))  # Cas avec un seul élément
  expect_equal(radix_sort_Rcpp(c(1, 2, 3)), c(1, 2, 3))  # Vecteur déjà trié
  expect_equal(radix_sort_Rcpp(c(3, 3, 3)), c(3, 3, 3))  # Vecteur avec doublons
#  expect_equal(radix_sort_Rcpp(c(-3, -1, -2)), c(-3, -2, -1))  # Valeurs négatives
})


test_that("Tri par Tas C++ fonctionne correctement", {
  expect_equal(heap_sort_Rcpp(c(3, 1, 2)), c(1, 2, 3))
  expect_equal(heap_sort_Rcpp(numeric()), numeric())
  expect_equal(heap_sort_Rcpp(c(1)), c(1))  # Cas avec un seul élément
  expect_equal(heap_sort_Rcpp(c(1, 2, 3)), c(1, 2, 3))  # Vecteur déjà trié
  expect_equal(heap_sort_Rcpp(c(3, 3, 3)), c(3, 3, 3))  # Vecteur avec doublons
  expect_equal(heap_sort_Rcpp(c(-3, -1, -2)), c(-3, -2, -1))  # Valeurs négatives
})

test_that("Tri Fusion C++ fonctionne correctement", {
  expect_equal(merge_sort_Rcpp(c(3, 1, 2)), c(1, 2, 3))
  expect_equal(merge_sort_Rcpp(numeric()), numeric())
  expect_equal(merge_sort_Rcpp(c(1)), c(1))  # Cas avec un seul élément
  expect_equal(merge_sort_Rcpp(c(1, 2, 3)), c(1, 2, 3))  # Vecteur déjà trié
  expect_equal(merge_sort_Rcpp(c(3, 3, 3)), c(3, 3, 3))  # Vecteur avec doublons
  expect_equal(merge_sort_Rcpp(c(-3, -1, -2)), c(-3, -2, -1))  # Valeurs négatives
})
