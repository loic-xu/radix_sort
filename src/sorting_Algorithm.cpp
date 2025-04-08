#include <Rcpp.h>
using namespace Rcpp;

// --------- HEAP SORT ----------

// [[Rcpp::export]]
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

// [[Rcpp::export]]
NumericVector heap_sort_Rcpp(NumericVector v) {
  unsigned int n = v.size();
  double temp;
  for (unsigned int i = (n / 2); i > 0; i--) {
    build_heap_Rcpp(v, i, n);
  }
  for (unsigned int i = n; i > 1; i--) {
    temp = v[i - 1];
    v[i - 1] = v[0];
    v[0] = temp;
    build_heap_Rcpp(v, 1, i - 1);
  }
  return v;
}


// ------------------------------
// TRI FUSION (MERGE SORT)
// ------------------------------

/**
 * @brief Internal function that implements the merge sort algorithm.
 *
 * This function recursively splits a vector into halves, sorts each half,
 * and merges them in sorted order.
 *
 * @param v A numeric vector to sort.
 * @return A sorted numeric vector.
 */
std::vector<double> tri_fusion(std::vector<double> v) {
  if (v.size() <= 1) {
    return v;
  }
  
  size_t mid = v.size() / 2;
  std::vector<double> left(v.begin(), v.begin() + mid);
  std::vector<double> right(v.begin() + mid, v.end());
  
  left = tri_fusion(left);
  right = tri_fusion(right);
  
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


//' Merge Sort Algorithm (C++)
 //'
 //' This function sorts a numeric vector using the merge sort algorithm,
 //' a classic divide-and-conquer algorithm with O(n log n) complexity.
 //'
 //' @param v A numeric vector to sort.
 //' @return A sorted numeric vector.
 //' @examples
 //' tri_fusion_Rcpp(c(3.4, 1.2, 5.6, 0.9))
 //' @export
 // [[Rcpp::export]]
 std::vector<double> tri_fusion_Rcpp(std::vector<double> v) {
   return tri_fusion(v);
 }