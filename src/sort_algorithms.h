// sort_algorithms.h

#ifndef SORT_ALGORITHMS_H
#define SORT_ALGORITHMS_H

#include <vector>

// Radix Sort
std::vector<int> radix_sort(std::vector<int> v, int exp);

// Heap Sort
std::vector<double> build_heap(std::vector<double> heap, unsigned int i, unsigned int n);

// Merge Sort
std::vector<double> merge_sort(std::vector<double> v);

#endif
