#include <Rcpp.h> //to use the NumericVector object
using namespace Rcpp; //to use the NumericVector object

#include<vector> //to use std::vector<double>


//' Insertion sort algorithm using C++
//'
//' @param v an unsorted vector of numeric data
//' @return a sorted vector
//' @export
// [[Rcpp::export]] //mandatory to export the function
std::vector<double> insertion_sort_Rcpp(std::vector<double> v)
{
  double key;
  int i;
  for(unsigned int j = 1; j < v.size(); j++)
  {
    key = v[j];
    i = j - 1;
    while(i >= 0 && v[i] > key)
    {
      v[i + 1] = v[i];
      i = i - 1;
    }
    v[i + 1] = key;
  }
  return v;
}



// [[Rcpp::export]]
NumericVector build_heap_Rcpp(NumericVector heap, unsigned int i, unsigned int n)
{
  unsigned int k = i;
  unsigned int l = 2*k;
  double temp;
  while(l <= n)
  {
    if((l < n) && (heap[l-1] < heap[l])){l = l + 1;}
    if(heap[k-1] < heap[l-1])
    {
      temp = heap[k-1];
      heap[k-1] = heap[l-1];
      heap[l-1] = temp;
      k = l;
      l = 2*k;
    }
    else
    {
      l = n + 1;
    }
  }
  return(heap);
}


//' Heap sort algorithm using C++
//'
//' @param v an unsorted vector of numeric data
//' @return a sorted vector
//' @export
// [[Rcpp::export]]
NumericVector heap_sort_Rcpp(NumericVector v)
{
  unsigned int n = v.size();
  double temp;
    for(unsigned int i = (n/2); i > 0; i--)
    {
      build_heap_Rcpp(v, i, n);
    }
    for(unsigned int i = n; i > 1; i--)
    {
      temp = v[i-1];
      v[i-1] = v[0];
      v[0] = temp;
      build_heap_Rcpp(v, 1, i-1);
    }

  return v;
}

// [[Rcpp::export]]
std::vector<double> tri_bulle_Rcpp(std::vector<double> v) {
  bool swapped;
  for (unsigned int i = 0; i < v.size() - 1; i++) {
    swapped = false;
    for (unsigned int j = 0; j < v.size() - i - 1; j++) {
      if (v[j] > v[j + 1]) {
        std::swap(v[j], v[j + 1]);
        swapped = true;
      }
    }
    if (!swapped) break; // Optimisation : si aucun échange, le tableau est trié
  }
  return v;
}

/// TRI FUSION
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
  
  // Fusionner les deux parties triées
  while (i < left.size() && j < right.size()) {
    if (left[i] <= right[j]) {
      result.push_back(left[i]);
      i++;
    } else {
      result.push_back(right[j]);
      j++;
    }
  }
  
  // Ajouter les éléments restants
  result.insert(result.end(), left.begin() + i, left.end());
  result.insert(result.end(), right.begin() + j, right.end());
  
  return result;
}

// [[Rcpp::export]]
std::vector<double> tri_fusion_Rcpp(std::vector<double> v) {
  return tri_fusion(v);
}



//// RADIX SORT
std::vector<int> radix_sort(std::vector<int> v, int exp) {
  if (exp == 0 || v.size() <= 1) {
    return v;
  }
  
  std::vector<int> buckets[10];
  
  // Placer les nombres dans les bons "buckets" selon le chiffre courant
  for (size_t i = 0; i < v.size(); i++) {
    int index = (v[i] / exp) % 10;
    buckets[index].push_back(v[i]);
  }
  
  // Concaténer les buckets triés récursivement
  std::vector<int> sorted_v;
  for (int i = 0; i < 10; i++) {
    std::vector<int> sorted_bucket = radix_sort(buckets[i], exp / 10);
    sorted_v.insert(sorted_v.end(), sorted_bucket.begin(), sorted_bucket.end());
  }
  
  return sorted_v;
}

// Interface Rcpp
// [[Rcpp::export]]
std::vector<int> tri_base_Rcpp(std::vector<int> v) {
  if (v.empty()) return v;
  
  int max_val = *std::max_element(v.begin(), v.end());
  int exp = 1;
  
  // Trouver la puissance de 10 maximale
    while (max_val / exp > 0) {
    exp *= 10;
  }
  exp /= 10; // On revient à la plus grande puissance de 10 utile
  
  return radix_sort(v, exp);
}