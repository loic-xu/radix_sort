
#' Quick Sort Algorithm
#'
#' This function sorts a numeric vector using the Quick Sort algorithm.
#' It recursively divides the vector into sub-vectors and sorts each.
#'
#' @param v A numeric vector to be sorted.
#' @return A sorted numeric vector.
#' @export
quick_sort <- function(v) {
  # Si la longueur du vecteur est 1 ou moins, il est déjà trié
  if (length(v) <= 1) {
    return(v)
  }
  
  # Choisir le premier élément comme pivot
  pivot <- v[1]
  left <- v[v < pivot]    # Éléments inférieurs au pivot
  middle <- v[v == pivot]  # Éléments égaux au pivot
  right <- v[v > pivot]    # Éléments supérieurs au pivot
  
  # Appliquer récursivement quick_sort sur les sous-vecteurs
  c(quick_sort(left), middle, quick_sort(right))
}
