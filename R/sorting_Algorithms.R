#########################################################
#########################################################

#' Heap sort algorithm
#'
#' @description Sorting by insertion with a heap structure.
#' @param v An unsorted vector of numeric data.
#' @param type There are two versions for the heap building: a recursive one and a direct one.
#' @return The sorted vector.
#' @export
heap_sort <- function(v, type = "notRecursive")
{
  n <- length(v)
  if(type == "notRecursive")
  {
    for(i in (n %/% 2):1)
    {
      v <- build_heap(v, i, n)
    }
    for(i in n:2)
    {
      temp <- v[i]
      v[i] <- v[1]
      v[1] <- temp
      v <- build_heap(v, 1, i - 1)
    }
  }
  else
  {
    for(i in (n %/% 2):1)
    {
      v <- build_heap_recursive(v, i, n)
    }
    for(i in n:2)
    {
      temp <- v[i]
      v[i] <- v[1]
      v[1] <- temp
      v <- build_heap_recursive(v, 1, i - 1)
    }
  }
  return(v)
}

#' Build a heap (non-recursive)
#'
#' @param heap The vector representing the heap.
#' @param i The index to heapify from.
#' @param n The total number of elements in the heap.
#' @return The updated heap.
build_heap <- function(heap, i, n)
{
  k <- i
  l <- 2 * k
  while(l <= n)
  {
    if((l < n) && (heap[l] < heap[l + 1])){ l <- l + 1 } # choose the right child
    if(heap[k] < heap[l]) # swap values
    {
      temp <- heap[k]
      heap[k] <- heap[l]
      heap[l] <- temp
      k <- l
      l <- 2 * k
    }
    else
    {
      l <- n + 1
    }
  }
  return(heap)
}

#' Build a heap (recursive)
#'
#' @param heap The vector representing the heap.
#' @param i The index to heapify from.
#' @param n The total number of elements in the heap.
#' @return The updated heap.
build_heap_recursive <- function(heap, i, n)
{
  l <- 2 * i
  if(l <= n)
  {
    if((l < n) && (heap[l] < heap[l + 1])){ l <- l + 1 } # choose the right child
    if(heap[i] < heap[l]) # swap values
    {
      temp <- heap[i]
      heap[i] <- heap[l]
      heap[l] <- temp
      heap <- build_heap_recursive(heap, l, n)
    }
  }
  return(heap)
}

#########################################################
#########################################################

#' Quick sort algorithm
#'
#' @description Sorting using the divide-and-conquer strategy of quick sort.
#' This is a simple and elegant recursive implementation.
#'
#' @param v An unsorted numeric vector.
#' @return The sorted vector.
#' @examples
#' quick_sort(c(4.2, 1.1, 3.9, 2.5))
#' @export
quick_sort <- function(v) {
  if (length(v) <= 1) {
    return(v)
  }
  
  pivot <- v[1]
  left <- v[v < pivot]
  middle <- v[v == pivot]
  right <- v[v > pivot]
  
  c(quick_sort(left), middle, quick_sort(right))
}
