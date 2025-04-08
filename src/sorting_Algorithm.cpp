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
