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



##### Merge sort
tri_fusion <- function(vec) {
  if (length(vec) <= 1) {
    return(vec)
  }
  
  mid <- floor(length(vec) / 2)
  
  left <- tri_fusion(vec[1:mid])
  right <- tri_fusion(vec[(mid + 1):length(vec)])
  
  return(merge(left, right))
}

merge <- function(left, right) {
  n_left <- length(left)
  n_right <- length(right)
  
  result <- numeric(n_left + n_right)
  i <- 1
  j <- 1
  k <- 1
  
  while (i <= n_left && j <= n_right) {
    if (left[i] <= right[j]) {
      result[k] <- left[i]
      i <- i + 1
    } else {
      result[k] <- right[j]
      j <- j + 1
    }
    k <- k + 1
  }
  
  
  if (i <= n_left) {
    result[k:(n_left + n_right)] <- left[i:n_left]
  }
  if (j <= n_right) {
    result[k:(n_left + n_right)] <- right[j:n_right]
  }
  
  return(result)
}

