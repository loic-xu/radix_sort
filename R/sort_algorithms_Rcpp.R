#' Tri par tas en C++
#'
#' Trie un vecteur numérique en utilisant l'algorithme de tri par tas (heap sort).
#'
#' Heap Sort Algorithm (C++ Implementation)
#'
#' @description
#' This function implements the heap sort algorithm, a comparison-based sorting algorithm with a worst-case 
#' time complexity of O(n log n). It works by first building a max-heap from the input vector, which ensures that 
#' the largest element is at the root. Then, the root element is swapped with the last element in the vector, 
#' and the heap is restructured to maintain the heap property. This process is repeated until all elements are sorted.
#'
#' The heap sort algorithm does not require additional memory for recursion, as it sorts the vector in place.
#'
#' @param v A numeric vector to be sorted. The function returns the sorted vector in ascending order.
#'
#' @return A sorted numeric vector with the elements arranged in ascending order.
#'
#' @details
#' Heap sort first builds a binary heap from the input vector. Then, it repeatedly swaps the root element (the 
#' largest) with the last unsorted element in the heap and reduces the size of the heap by one. The heap property 
#' is then restored by a process called "heapify". This sorting algorithm is efficient and works in-place, 
#' without requiring additional memory for recursion, as merge sort does.
#'
#' \itemize{
#'   \item \strong{Time Complexity:} O(n log n) in all cases.
#'   \item \strong{Space Complexity:} O(1) as the sorting is done in-place.
#' }
#' Heap sort is often used when memory efficiency is critical, as it does not require additional storage for 
#' sorting like merge sort does.
#'
#' @examples
#' v <- c(3, 2, 1)
#' heap_sort_Rcpp(v)
#' # Returns: c(1, 2, 3)
#'
#' @name heap_sort_Rcpp
#' @export
heap_sort_Rcpp


#' Merge Sort Algorithm (C++ Implementation)
#' 
#' @description
#' This function implements the merge sort algorithm, a comparison-based divide-and-conquer sorting algorithm 
#' with O(n log n) time complexity. It recursively splits the input vector into two halves, sorts each half, and 
#' then merges the two sorted halves together.
#' 
#' Merge sort is stable, meaning it maintains the relative order of elements with equal values.
#' 
#' @param v A numeric vector to be sorted. The function returns the vector sorted in ascending order.
#' 
#' @return A sorted numeric vector with the elements arranged in ascending order.
#' 
#' @details
#' Merge sort is a divide-and-conquer algorithm. It splits the input vector into two halves, recursively 
#' sorts each half, and then merges the sorted halves back together. The merging step ensures that the 
#' final result is a fully sorted vector. It is stable, meaning that the order of equal elements is preserved.
#' 
#' \itemize{
#'   \item \strong{Time Complexity:} O(n log n) in all cases.
#'   \item \strong{Space Complexity:} O(n) for temporary storage used during the merging process.
#' }
#' Merge sort is efficient and predictable, and its worst-case performance is always O(n log n). It is widely 
#' used in applications requiring stable sorting or sorting large datasets that don't fit in memory.
#' 
#' @examples
#' v <- c(3, 2, 1)
#' merge_sort_Rcpp(v)
#' # Returns: c(1, 2, 3)
#' 
#' @name merge_sort_Rcpp
#' @export
merge_sort_Rcpp




#' Quick Sort Algorithm (C++ Implementation)
#' 
#' @description
#' This function implements the quick sort algorithm, which is a comparison-based sorting algorithm 
#' with an average-case time complexity of O(n log n). It works by selecting a "pivot" element and partitioning 
#' the input vector into two sub-vectors: one containing elements less than the pivot, and the other containing 
#' elements greater than the pivot. These sub-vectors are then recursively sorted.
#' 
#' The function uses the Lomuto partition scheme to organize the elements around the pivot, ensuring that all 
#' elements on the left are smaller and all elements on the right are larger than the pivot.
#' 
#' @param v A numeric vector to be sorted. The function will return the vector sorted in ascending order.
#' 
#' @return A sorted numeric vector with the elements of `v` arranged in ascending order.
#' 
#' @details
#' The quick sort algorithm is based on the divide-and-conquer paradigm. It divides the problem into smaller 
#' sub-problems, sorting each sub-array recursively, and then combines the solutions to form the final sorted array. 
#' This algorithm is very efficient on average, but its worst-case time complexity is O(n²), which can occur if the 
#' pivot selection is poor (e.g., always selecting the smallest or largest element as the pivot).
#' 
#' \itemize{
#'   \item \strong{Time Complexity:} O(n log n) on average, O(n²) in the worst case (for example, if the array is already sorted).
#'   \item \strong{Space Complexity:} O(log n) for recursive stack space.
#' }
#' Quick sort is generally faster than other O(n log n) algorithms like merge sort, but it is sensitive to the choice of pivot.
#' 
#' @examples
#' v <- c(3, 2, 1)
#' quick_sort_Rcpp(v)
#' # Returns: c(1, 2, 3)
#' 
#' @name quick_sort_Rcpp
#' @export
quick_sort_Rcpp


#' Radix Sort Algorithm (C++ Implementation)
#' 
#' @description
#' This function implements the radix sort algorithm, a non-comparative integer sorting algorithm. 
#' The algorithm processes each digit of the numbers starting from the least significant digit and moving 
#' to the most significant. The sorting is done by grouping the numbers based on their digits and iteratively 
#' sorting them until all digits are processed.
#' 
#' The function handles both positive and negative numbers by separating them, sorting the absolute values 
#' and then merging them back together. Negative values are reversed to ensure they maintain their correct 
#' order in the sorted result.
#' 
#' @param v A numeric vector of integers to be sorted. This can include both positive and negative integers.
#' 
#' @return A sorted numeric vector with the same elements in ascending order.
#' 
#' @details
#' The radix sort algorithm works by sorting numbers based on their individual digits. The function 
#' processes each digit of the numbers starting from the least significant digit (units place) and proceeds 
#' to the more significant digits. It groups numbers into buckets based on each digit and sorts these buckets 
#' recursively. For negative numbers, the algorithm treats them as their absolute values initially, and then 
#' reverses them at the end to preserve the negative sign.
#' 
#' \itemize{
#'   \item \strong{Time Complexity:} O(n * d), where `n` is the number of elements and `d` is the number of digits in the largest number.
#'   \item \strong{Space Complexity:} O(n) for storing the sorted results and temporary bucket arrays.
#' }
#' The algorithm is efficient for sorting integers when the number of digits is relatively small.
#' 
#' @examples
#' v <- c(10, 2, 5, -3, 1, 20, -2)
#' radix_sort_Rcpp(v)
#' # Returns: c(-3, -2, 1, 2, 5, 10, 20)
#' 
#' @name radix_sort_Rcpp
#' @export
radix_sort_Rcpp
