
### Radix sort
tri_base <- function(vec) {
  if (length(vec) <= 1) {
    return(vec)
  }
  
  max_val <- max(vec)
  exp <- 1
  
  while (max_val / exp >= 1) {
    vec <- counting_sort(vec, exp)
    exp <- exp * 10
  }
  
  return(vec)
}

counting_sort <- function(vec, exp) {
  n <- length(vec)
  output <- numeric(n)
  count <- numeric(10)
  
  # Compter le nombre d'occurrences des chiffres à la position donnée
  for (i in seq_len(n)) {
    index <- (vec[i] %/% exp) %% 10
    count[index + 1] <- count[index + 1] + 1
  }
  
  # Transformer count en index de position finale
  for (i in 2:10) {
    count[i] <- count[i] + count[i - 1]
  }
  
  # Construire le tableau trié
  for (i in seq(n, 1)) {
    index <- (vec[i] %/% exp) %% 10
    output[count[index + 1]] <- vec[i]
    count[index + 1] <- count[index + 1] - 1
  }
  
  return(output)
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

