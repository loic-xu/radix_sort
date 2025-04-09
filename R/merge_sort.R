
#' Merge Sort Algorithm
#'
#' This function sorts a numeric vector using the Merge Sort algorithm.
#' It recursively divides the vector into sub-vectors and merges them back together.
#'
#' @param vec A numeric vector to be sorted.
#' @return A sorted numeric vector.
#' @export
merge_sort <- function(vec) {
  # Si le vecteur a une longueur de 1 ou moins, il est déjà trié
  if (length(vec) <= 1) {
    return(vec)
  }
  
  # Trouver l'indice du milieu pour diviser le vecteur en deux
  mid <- floor(length(vec) / 2)
  
  # Appliquer merge_sort sur les sous-vecteurs gauche et droit
  left <- merge_sort(vec[1:mid])
  right <- merge_sort(vec[(mid + 1):length(vec)])
  
  # Fusionner les sous-vecteurs triés
  return(merge(left, right))
}

#' Merge Two Sorted Vectors
#'
#' This function merges two sorted vectors into a single sorted vector.
#'
#' @param left A sorted numeric vector.
#' @param right A sorted numeric vector.
#' @return A merged and sorted numeric vector.
merge <- function(left, right) {
  n_left <- length(left)
  n_right <- length(right)
  
  result <- numeric(n_left + n_right)  # Vecteur pour stocker le résultat fusionné
  i <- 1
  j <- 1
  k <- 1
  
  # Fusionner les deux vecteurs
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
  
  # Ajouter les éléments restants de 'left' ou 'right'
  if (i <= n_left) {
    result[k:(n_left + n_right)] <- left[i:n_left]
  }
  if (j <= n_right) {
    result[k:(n_left + n_right)] <- right[j:n_right]
  }
  
  # Retourner le vecteur fusionné
  return(result)
}
