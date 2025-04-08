#include <Rcpp.h> // to use the NumericVector object
using namespace Rcpp;

#include <vector> // to use std::vector



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


// --------- QUICK SORT ----------

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

// [[Rcpp::export]]
NumericVector quick_sort_Rcpp(NumericVector v) {
  std::vector<double> vec = Rcpp::as<std::vector<double>>(v);
  quick_sort_helper(vec, 0, vec.size() - 1);
  return wrap(vec);
}

