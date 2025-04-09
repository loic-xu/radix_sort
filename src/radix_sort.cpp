#include <Rcpp.h>

#include "sort_algorithms.h"

using namespace Rcpp; //to use the NumericVector object


 //' Radix Sort Algorithm (C++ Implementation)
 //' 
 //' @description
 //' This function implements the radix sort algorithm, a non-comparative integer sorting algorithm. 
 //' The algorithm processes each digit of the numbers starting from the least significant digit and moving 
 //' to the most significant. The sorting is done by grouping the numbers based on their digits and iteratively 
 //' sorting them until all digits are processed.
 //' 
 //' The function handles both positive and negative numbers by separating them, sorting the absolute values 
 //' and then merging them back together. Negative values are reversed to ensure they maintain their correct 
 //' order in the sorted result.
 //' 
 //' @param v A numeric vector of integers to be sorted. This can include both positive and negative integers.
 //' 
 //' @return A sorted numeric vector with the same elements in ascending order.
 //' 
 //' @details
 //' The radix sort algorithm works by sorting numbers based on their individual digits. The function 
 //' processes each digit of the numbers starting from the least significant digit (units place) and proceeds 
 //' to the more significant digits. It groups numbers into buckets based on each digit and sorts these buckets 
 //' recursively. For negative numbers, the algorithm treats them as their absolute values initially, and then 
 //' reverses them at the end to preserve the negative sign.
 //' 
 //' \itemize{
 //'   \item \bold{Time Complexity:} O(n * d), where `n` is the number of elements and `d` is the number of digits in the largest number.
 //'   \item \bold{Space Complexity:} O(n) for storing the sorted results and temporary bucket arrays.
 //' }
 //' The algorithm is efficient for sorting integers when the number of digits is relatively small.
 //' 
 //' @examples
 //' v <- c(10, 2, 5, -3, 1, 20, -2)
 //' radix_sort_Rcpp(v)
 //' # Returns: c(-3, -2, 1, 2, 5, 10, 20)
 //' @name radix_sort_Rcpp
 //' @export
 // [[Rcpp::export]]
 NumericVector radix_sort_Rcpp(NumericVector v_) {
   if (v_.isNULL()) {
     stop("Input cannot be NULL.");
   }
   NumericVector v(v_);
   if (v.size() == 0) return v;
   
   std::vector<int> vec = Rcpp::as<std::vector<int>>(v);
   
   std::vector<int> positives;
   std::vector<int> negatives;
   
   for (int x : vec) {
     if (x >= 0) {
       positives.push_back(x);
     } else {
       negatives.push_back(-x); // on stocke la valeur absolue
     }
   }
   
   // Fonction pour obtenir l'exposant max
   auto get_max_exp = [](const std::vector<int>& vals) {
     if (vals.empty()) return 0;
     int max_val = *std::max_element(vals.begin(), vals.end());
     int exp = 1;
     while (max_val / exp > 0) exp *= 10;
     return exp / 10;
   };
   
   std::vector<int> sorted_positives = radix_sort(positives, get_max_exp(positives));
   std::vector<int> sorted_negatives = radix_sort(negatives, get_max_exp(negatives));
   
   // Inverser les négatifs et les repasser en négatifs
   std::reverse(sorted_negatives.begin(), sorted_negatives.end());
   for (int& x : sorted_negatives) x = -x;
   
   // Fusionner les deux
   sorted_negatives.insert(sorted_negatives.end(), sorted_positives.begin(), sorted_positives.end());
   
   return wrap(sorted_negatives);
 }