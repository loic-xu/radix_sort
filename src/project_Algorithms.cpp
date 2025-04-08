#include <Rcpp.h> // to use the NumericVector object

#include <vector> // to use std::vector
#include <algorithm> // for std::max_element

using namespace Rcpp;

// ------------------------------
// RADIX SORT
// ------------------------------

/**
 * @brief Internal recursive radix sort helper.
 *
 * This function recursively sorts a given vector of integers by a specific digit exponent.
 *
 * @param v Integer vector to sort.
 * @param exp Current digit exponent to sort by.
 * @return A sorted vector of integers.
 */
std::vector<int> radix_sort(std::vector<int> v, int exp) {
  if (exp == 0 || v.size() <= 1) {
    return v;
  }
  
  std::vector<int> buckets[10];
  
  // Place numbers into buckets based on current digit
  for (size_t i = 0; i < v.size(); i++) {
    int index = (v[i] / exp) % 10;
    buckets[index].push_back(v[i]);
  }
  
  // Concatenate sorted buckets
  std::vector<int> sorted_v;
  for (int i = 0; i < 10; i++) {
    std::vector<int> sorted_bucket = radix_sort(buckets[i], exp / 10);
    sorted_v.insert(sorted_v.end(), sorted_bucket.begin(), sorted_bucket.end());
  }
  
  return sorted_v;
}

 //' Radix Sort Algorithm (C++ Implementation)
 //' 
 //' This function sorts an integer vector using the radix sort algorithm,
 //' which is non-comparative and works well for integers.
 //' 
 //' @param v An integer vector to sort.
 //' @return A sorted integer vector.
 //' @examples 
 //' radix_sort_Rcpp(c(3, 2, 1))
 //' # Returns: c(1, 2, 3)
 //' @export
 // [[Rcpp::export]]
 NumericVector radix_sort_Rcpp(NumericVector v) {
   if (v.size() == 0) return v;
   
   // Convert NumericVector to std::vector<int>
   std::vector<int> vec = Rcpp::as<std::vector<int>>(v);
   
   int max_val = *std::max_element(vec.begin(), vec.end());
   int exp = 1;
   
   // Determine the highest digit position
   while (max_val / exp > 0) {
     exp *= 10;
   }
   exp /= 10; // Back to the last significant digit
   
   std::vector<int> sorted_vec = radix_sort(vec, exp);
   
   return wrap(sorted_vec); // Convert std::vector back to NumericVector
 }


// --------- QUICK SORT ----------

/**
 * @brief Internal helper function for quick sort.
 *
 * This function partitions the array around a pivot and recursively sorts the partitions.
 *
 * @param arr The array to sort.
 * @param left The left index of the partition.
 * @param right The right index of the partition.
 */
void quick_sort_helper(std::vector<double>& arr, int left, int right) {
  int i = left, j = right;
  double pivot = arr[(left + right) / 2];
  
  while (i <= j) {
    while (arr[i] < pivot) i++;
    while (arr[j] > pivot) j--;
    
    if (i <= j) {
      std::swap(arr[i], arr[j]);
      i++;
      j--;
    }
  }
  
  if (left < j) quick_sort_helper(arr, left, j);
  if (i < right) quick_sort_helper(arr, i, right);
}

 //' Quick Sort Algorithm (C++ Implementation)
 //' 
 //' This function sorts a numeric vector using the quick sort algorithm,
 //' which is a comparison-based sorting algorithm with average-case O(n log n) complexity.
 //' 
 //' @param v A numeric vector to sort.
 //' @return A sorted numeric vector.
 //' @examples 
 //' quick_sort_Rcpp(c(3, 2, 1))
 //' # Returns: c(1, 2, 3)
 //' @export
 // [[Rcpp::export]]
 NumericVector quick_sort_Rcpp(NumericVector v) {
   std::vector<double> vec = Rcpp::as<std::vector<double>>(v);
   quick_sort_helper(vec, 0, vec.size() - 1);
   return wrap(vec);
 }


// --------- HEAP SORT ----------

/**
 * @brief Builds a heap from a given numeric vector.
 *
 * This function reorganizes the elements of the vector to satisfy the 
 * max-heap property. It is used as part of the heap sort algorithm.
 *
 * @param heap A numeric vector representing the heap.
 * @param i The index of the node to start building the heap.
 * @param n The size of the heap.
 * @return A heapified numeric vector.
 */
NumericVector build_heap_Rcpp(NumericVector heap, unsigned int i, unsigned int n) {
  unsigned int k = i;
  unsigned int l = 2 * k;
  double temp;
  while (l <= n) {
    if ((l < n) && (heap[l - 1] < heap[l])) {
      l = l + 1;
    }
    if (heap[k - 1] < heap[l - 1]) {
      temp = heap[k - 1];
      heap[k - 1] = heap[l - 1];
      heap[l - 1] = temp;
      k = l;
      l = 2 * k;
    } else {
      l = n + 1;
    }
  }
  return heap;
}

 //' Heap Sort Algorithm (C++ Implementation)
 //' 
 //' This function sorts a numeric vector using the heap sort algorithm,
 //' which has a worst-case time complexity of O(n log n).
 //'
 //' @param v A numeric vector to sort.
 //' @return A sorted numeric vector.
 //' @examples 
 //' heap_sort_Rcpp(c(3, 2, 1))
 //' # Returns: c(1, 2, 3)
 //' @export
 // [[Rcpp::export]]
 NumericVector heap_sort_Rcpp(NumericVector v) {
   unsigned int n = v.size();
   double temp;
   
   // Construction du tas
   for (unsigned int i = (n / 2); i >= 1; i--) { // Itération ajustée
     v = build_heap_Rcpp(v, i, n);  // Construire le tas
   }
   
   // Tri du tas
   for (unsigned int i = n; i > 1; i--) {
     temp = v[i - 1];
     v[i - 1] = v[0];
     v[0] = temp;
     v = build_heap_Rcpp(v, 1, i - 1);  // Réorganiser le tas
   }
   
   return v;
 }


// ------------------------------
// TRI MERGE SORT
// ------------------------------

/**
 * @brief Internal recursive function that implements the merge sort algorithm.
 *
 * This function splits the input vector into two halves, recursively sorts each half,
 * and then merges the sorted halves into a single sorted vector.
 *
 * @param v A numeric vector to sort.
 * @return A sorted numeric vector.
 */
std::vector<double> merge_sort(std::vector<double> v) {
  if (v.size() <= 1) {
    return v;
  }
  
  size_t mid = v.size() / 2;
  std::vector<double> left(v.begin(), v.begin() + mid);
  std::vector<double> right(v.begin() + mid, v.end());
  
  left = merge_sort(left);
  right = merge_sort(right);
  
  std::vector<double> result;
  size_t i = 0, j = 0;
  
  // Merge the two sorted halves
  while (i < left.size() && j < right.size()) {
    if (left[i] <= right[j]) {
      result.push_back(left[i]);
      i++;
    } else {
      result.push_back(right[j]);
      j++;
    }
  }
  
  // Append remaining elements
  result.insert(result.end(), left.begin() + i, left.end());
  result.insert(result.end(), right.begin() + j, right.end());
  
  return result;
}

 //' Merge Sort Algorithm (C++ Implementation)
 //' 
 //' This function sorts a numeric vector using the merge sort algorithm,
 //' which is a divide-and-conquer algorithm with O(n log n) time complexity.
 //' The input vector is recursively split into two halves, and then each half is sorted
 //' and merged back together.
 //'
 //' @param v A numeric vector to sort.
 //' @return A sorted numeric vector.
 //' @examples 
 //' merge_sort_Rcpp(c(3, 2, 1))
 //' # Returns: c(1, 2, 3)
 //' @export
 // [[Rcpp::export]]
 NumericVector merge_sort_Rcpp(NumericVector v) {
   std::vector<double> vec(v.begin(), v.end()); // Convert NumericVector to std::vector<double>
   std::vector<double> sorted_vec = merge_sort(vec); // Perform merge sort
   return wrap(sorted_vec); // Convert std::vector back to NumericVector
 }
