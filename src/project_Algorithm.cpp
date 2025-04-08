#include <Rcpp.h> // to use the NumericVector object
using namespace Rcpp;

#include <vector> // to use std::vector


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


// ------------------------------
// RADIX SORT
// ------------------------------

/**
 * @brief Internal recursive radix sort helper.
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


//' Radix Sort Algorithm (C++)
 //'
 //' This function sorts an integer vector using the radix sort algorithm,
 //' which is non-comparative and works well for integers.
 //'
 //' @param v An integer vector to sort.
 //' @return A sorted integer vector.
 //' @examples
 //' tri_base_Rcpp(c(329, 457, 657, 839, 436, 720, 355))
 //' @export
 // [[Rcpp::export]]
 std::vector<int> tri_base_Rcpp(std::vector<int> v) {
   if (v.empty()) return v;
   
   int max_val = *std::max_element(v.begin(), v.end());
   int exp = 1;
   
   // Determine the highest digit position
   while (max_val / exp > 0) {
     exp *= 10;
   }
   exp /= 10; // Back to the last significant digit
   
   return radix_sort(v, exp);
 }
