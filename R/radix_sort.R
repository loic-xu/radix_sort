#' Radix Sort Algorithm
#' 
#' This function sorts a numeric vector using the Radix Sort algorithm.
#' The function iterates over each digit of the numbers and uses counting sort as a subroutine.
#'
#' @param vec A numeric vector to be sorted.
#' @return A sorted numeric vector.
#' @export
radix_sort <- function(vec) {
  # Si le vecteur a une longueur de 1 ou moins, il est déjà trié
  if (length(vec) <= 1) {
    return(vec)
  }
  
  # Séparer les valeurs négatives et positives
  negative_vals <- vec[vec < 0]
  positive_vals <- vec[vec >= 0]
  
  # Trier d'abord les valeurs absolues
  sorted_positive <- counting_sort(abs(positive_vals), 1)
  sorted_negative <- counting_sort(abs(negative_vals), 1)
  
  # Réorganiser les résultats pour avoir les négatifs avant les positifs
  sorted_negative <- rev(sorted_negative)  # Les valeurs négatives doivent être triées dans l'ordre décroissant
  
  # Combiner les résultats avec les négatifs en premier
  return(c(-sorted_negative, sorted_positive))
}

#' Counting Sort as a Subroutine for Radix Sort
#'
#' This function performs counting sort on a specific digit (specified by 'exp').
#'
#' @param vec A numeric vector to be sorted.
#' @param exp The current digit place (1s, 10s, 100s, etc.).
#' @return A vector sorted by the current digit.
counting_sort <- function(vec, exp) {
  n <- length(vec)
  output <- numeric(n)  # Vecteur de sortie trié
  count <- numeric(10)  # Vecteur de comptage pour chaque chiffre (0-9)
  
  # Remplir le tableau de comptage en fonction du chiffre actuel
  for (i in seq_len(n)) {
    index <- (vec[i] %/% exp) %% 10  # Extraire le chiffre de l'exposant actuel
    count[index + 1] <- count[index + 1] + 1
  }
  
  # Modifier le tableau de comptage pour qu'il contienne les indices de position
  for (i in 2:10) {
    count[i] <- count[i] + count[i - 1]
  }
  
  # Construire le vecteur de sortie avec les éléments triés par le chiffre actuel
  for (i in seq(n, 1)) {
    index <- (vec[i] %/% exp) %% 10
    output[count[index + 1]] <- vec[i]
    count[index + 1] <- count[index + 1] - 1
  }
  
  # Retourner le vecteur trié
  return(output)
}
