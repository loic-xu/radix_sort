devtools::install_github("loic-xu/radix_sort") # Installation de la librairie radix_sort depuis GitHub
library(testthat); library(RadixSort) # Chargement des packages nécessaires

# Définition des vecteurs de test
simple_vec <- c(3,1,2) # Vecteur simple à trier (3 éléments)
complex_vec <- c(5,3,9,1,4,8,2,7,6) # Vecteur plus complexe à trier (9 éléments)
expected_vec <- sort(complex_vec) # Vecteur trié attendu pour comparaison

# === TESTS DES FONCTIONS R ===
test_that("Radix Sort (R) trie correctement les vecteurs", {
  expect_equal(radix_sort(simple_vec), sort(simple_vec))  # Test de tri avec Radix Sort sur simple_vec
  expect_equal(radix_sort(complex_vec), expected_vec)     # Test de tri avec Radix Sort sur complex_vec
})
test_that("Heap Sort (R) trie correctement les vecteurs", {
  expect_equal(heap_sort(simple_vec), sort(simple_vec)) # Test de tri avec Heap Sort sur simple_vec
  expect_equal(heap_sort(complex_vec), expected_vec)    # Test de tri avec Heap Sort sur complex_vec
})
test_that("Merge Sort (R) trie correctement les vecteurs", {
  expect_equal(merge_sort(simple_vec), sort(simple_vec)) # Test de tri avec Merge Sort sur simple_vec
  expect_equal(merge_sort(complex_vec), expected_vec)    # Test de tri avec Merge Sort sur complex_vec
})

# === TESTS DES FONCTIONS C++ ===
test_that("Radix Sort (C++) trie correctement les vecteurs", {
  expect_equal(radix_sort_Rcpp(simple_vec), sort(simple_vec))  # Test de tri avec Radix Sort (C++) sur simple_vec
  expect_equal(radix_sort_Rcpp(complex_vec), expected_vec)     # Test de tri avec Radix Sort (C++) sur complex_vec
})
test_that("Heap Sort (C++) trie correctement les vecteurs", {
  expect_equal(heap_sort_Rcpp(simple_vec), sort(simple_vec))  # Test de tri avec Heap Sort (C++) sur simple_vec
  expect_equal(heap_sort_Rcpp(complex_vec), expected_vec)     # Test de tri avec Heap Sort (C++) sur complex_vec
})
test_that("Merge Sort (C++) trie correctement les vecteurs", {
  expect_equal(merge_sort_Rcpp(simple_vec), sort(simple_vec))  # Test de tri avec Merge Sort (C++) sur simple_vec
  expect_equal(merge_sort_Rcpp(complex_vec), expected_vec)     # Test de tri avec Merge Sort (C++) sur complex_vec
})