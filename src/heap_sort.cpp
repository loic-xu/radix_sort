#include <Rcpp.h>

#include "sort_algorithms.h"

using namespace Rcpp; //to use the NumericVector object

 //' Heap Sort Algorithm (C++ Implementation)
 //' 
 //' @description
 //' This function implements the heap sort algorithm, a comparison-based sorting algorithm with a worst-case 
 //' time complexity of O(n log n). It works by first building a max-heap from the input vector, which ensures that 
 //' the largest element is at the root. Then, the root element is swapped with the last element in the vector, 
 //' and the heap is restructured to maintain the heap property. This process is repeated until all elements are sorted.
 //' 
 //' The heap sort algorithm does not require additional memory for recursion, as it sorts the vector in place.
 //' 
 //' @param v A numeric vector to be sorted. The function returns the sorted vector in ascending order.
 //' 
 //' @return A sorted numeric vector with the elements arranged in ascending order.
 //' 
 //' @details
 //' Heap sort first builds a binary heap from the input vector. Then, it repeatedly swaps the root element (the 
 //' largest) with the last unsorted element in the heap and reduces the size of the heap by one. The heap property 
 //' is then restored by a process called "heapify". This sorting algorithm is efficient and works in-place, 
 //' without requiring additional memory for recursion, as merge sort does.
 //' 
 //' \itemize{
 //'   \item \bold{Time Complexity:} O(n log n) in all cases.
 //'   \item \bold{Space Complexity:} O(1) as the sorting is done in-place.
 //' }
 //' Heap sort is often used when memory efficiency is critical, as it does not require additional storage for 
 //' sorting like merge sort does.
 //' 
 //' @examples
 //' v <- c(3, 2, 1)
 //' heap_sort_Rcpp(v)
 //' # Returns: c(1, 2, 3)
 //' @name heap_sort_Rcpp
 //' @export
 // [[Rcpp::export]]
 NumericVector heap_sort_Rcpp(NumericVector v_) {
   if (v_.isNULL()) stop("Input cannot be NULL.");
   if (v_.size() == 0) return v_;
   
   std::vector<double> heap = as<std::vector<double>>(v_);
   unsigned int n = heap.size();
   
   for (int i = n / 2; i >= 1; i--) {
     heap = build_heap(heap, i, n);
   }
   
   for (unsigned int i = n; i > 1; i--) {
     std::swap(heap[0], heap[i - 1]);
     heap = build_heap(heap, 1, i - 1);
   }
   
   return wrap(heap);
 }
 