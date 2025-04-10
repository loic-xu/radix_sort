#' Radix Sort Algorithm (Positives Only)
#' 
#' This function sorts a numeric vector containing only positive numbers using the Radix Sort algorithm.
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
  
  # Déterminer le nombre maximal d'itérations en fonction du nombre de chiffres
  max_val <- max(vec)  # Juste pour les nombres positifs
  exp <- 1  # L'exposant de départ, représentant les unités
  
  # Appliquer counting_sort sur chaque chiffre (de l'unité aux plus grandes puissances de 10)
  while (max_val %/% exp > 0) {
    vec <- counting_sort(vec, exp)
    exp <- exp * 10  # Passer à l'exposant suivant
  }
  
  return(vec)
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
  for (i in rev(seq_len(n))) {  # Traverse de droite à gauche pour maintenir la stabilité
    index <- (vec[i] %/% exp) %% 10
    output[count[index + 1]] <- vec[i]
    count[index + 1] <- count[index + 1] - 1
  }
  
  # Retourner le vecteur trié
  return(output)
}
