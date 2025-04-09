#include <Rcpp.h>

#include "sort_algorithms.h"

using namespace Rcpp; //to use the NumericVector object



 //' Quick Sort Algorithm (C++ Implementation)
 //' 
 //' @description
 //' This function implements the quick sort algorithm, which is a comparison-based sorting algorithm 
 //' with an average-case time complexity of O(n log n). It works by selecting a "pivot" element and partitioning 
 //' the input vector into two sub-vectors: one containing elements less than the pivot, and the other containing 
 //' elements greater than the pivot. These sub-vectors are then recursively sorted.
 //' 
 //' The function uses the Lomuto partition scheme to organize the elements around the pivot, ensuring that all 
 //' elements on the left are smaller and all elements on the right are larger than the pivot.
 //' 
 //' @param v A numeric vector to be sorted. The function will return the vector sorted in ascending order.
 //' 
 //' @return A sorted numeric vector with the elements of `v` arranged in ascending order.
 //' 
 //' @details
 //' The quick sort algorithm is based on the divide-and-conquer paradigm. It divides the problem into smaller 
 //' sub-problems, sorting each sub-array recursively, and then combines the solutions to form the final sorted array. 
 //' This algorithm is very efficient on average, but its worst-case time complexity is O(n²), which can occur if the 
 //' pivot selection is poor (e.g., always selecting the smallest or largest element as the pivot).
 //' 
 //' \itemize{
 //'   \item \bold{Time Complexity:} O(n log n) on average, O(n²) in the worst case (for example, if the array is already sorted).
 //'   \item \bold{Space Complexity:} O(log n) for recursive stack space.
 //' }
 //' Quick sort is generally faster than other O(n log n) algorithms like merge sort, but it is sensitive to the choice of pivot.
 //' 
 //' @examples
 //' v <- c(3, 2, 1)
 //' quick_sort_Rcpp(v)
 //' # Returns: c(1, 2, 3)
 //' @name quick_sort_Rcpp
 //' @export
 // [[Rcpp::export]]
 NumericVector quick_sort_Rcpp(Nullable<NumericVector> v_) {
   if (v_.isNull()) {
     stop("Input cannot be NULL.");
   }
   NumericVector v(v_);
   if (v.size() == 0) return v;
   
   std::vector<double> vec = Rcpp::as<std::vector<double>>(v);
   quick_sort_helper(vec, 0, vec.size() - 1);
   return wrap(vec);
 }
 