// sort_algorithms.cpp

#include "sort_algorithms.h"
#include <algorithm>
#include <cmath>

// === Radix Sort ===
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


// === Heap Sort ===

std::vector<double> build_heap(std::vector<double> heap, unsigned int i, unsigned int n) {
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

// === Merge Sort ===
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
