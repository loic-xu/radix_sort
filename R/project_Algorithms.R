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
  
  # Trouver la valeur maximale dans le vecteur pour déterminer le nombre de passes nécessaires
  max_val <- max(vec)
  exp <- 1  # L'exposant pour extraire chaque chiffre
  
  # Tant que l'exposant est inférieur ou égal à la valeur maximale
  while (max_val / exp >= 1) {
    # Appliquer le tri par comptage sur les chiffres à l'exposant actuel
    vec <- counting_sort(vec, exp)
    # Passer à l'exposant suivant (ex : 1, 10, 100, etc.)
    exp <- exp * 10
  }
  
  # Retourner le vecteur trié
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
  for (i in seq(n, 1)) {
    index <- (vec[i] %/% exp) %% 10
    output[count[index + 1]] <- vec[i]
    count[index + 1] <- count[index + 1] - 1
  }
  
  # Retourner le vecteur trié
  return(output)
}

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

#' Heap Sort Algorithm
#'
#' This function sorts a numeric vector using the Heap Sort algorithm.
#' It can either use an iterative or recursive approach.
#'
#' @param v A numeric vector to be sorted.
#' @param type Type of heap sort ('notRecursive' or 'recursive').
#' @return A sorted numeric vector.
#' @export
heap_sort <- function(v, type = "notRecursive") {
  n <- length(v)
  
  # Construire un tas (heap) en utilisant l'itération ou la récursion
  if (type == "notRecursive") {
    # Construire un tas non récursif
    for(i in (n %/% 2):1) {
      v <- build_heap(v, i, n)
    }
    # Trier les éléments en déplaçant l'élément racine (le plus grand) à la fin
    for(i in n:2) {
      temp <- v[i]
      v[i] <- v[1]
      v[1] <- temp
      v <- build_heap(v, 1, i - 1)
    }
  } else {
    # Construire un tas récursif
    for(i in (n %/% 2):1) {
      v <- build_heap_recursive(v, i, n)
    }
    for(i in n:2) {
      temp <- v[i]
      v[i] <- v[1]
      v[1] <- temp
      v <- build_heap_recursive(v, 1, i - 1)
    }
  }
  
  # Retourner le vecteur trié
  return(v)
}

#' Build Heap for Heap Sort
#'
#' This function builds a max heap from a vector. It is used as a helper function in heap_sort.
#'
#' @param heap The heap to be built.
#' @param i The current index to start the heapification.
#' @param n The size of the heap.
#' @return The heap after heapification.
build_heap <- function(heap, i, n) {
  k <- i
  l <- 2 * k  # Index du fils gauche
  while(l <= n) {
    # Vérifier si le fils droit existe et est plus grand que le gauche
    if((l < n) && (heap[l] < heap[l + 1])) { l <- l + 1 }
    
    # Si le père est plus petit que l'un de ses fils, les échanger
    if(heap[k] < heap[l]) {
      temp <- heap[k]
      heap[k] <- heap[l]
      heap[l] <- temp
      k <- l
      l <- 2 * k  # Vérifier les prochains fils
    } else {
      l <- n + 1  # Terminer si aucun échange n'est nécessaire
    }
  }
  return(heap)
}

#' Build Heap Recursively for Heap Sort
#'
#' This function builds a max heap recursively.
#'
#' @param heap The heap to be built.
#' @param i The current index to start the heapification.
#' @param n The size of the heap.
#' @return The heap after heapification.
build_heap_recursive <- function(heap, i, n) {
  l <- 2 * i  # Index du fils gauche
  if(l <= n) {
    # Vérifier si le fils droit existe et est plus grand que le gauche
    if((l < n) && (heap[l] < heap[l + 1])) { l <- l + 1 }
    
    # Si le père est plus petit que l'un de ses fils, les échanger
    if(heap[i] < heap[l]) {
      temp <- heap[i]
      heap[i] <- heap[l]
      heap[l] <- temp
      # Appliquer récursivement à l'enfant
      heap <- build_heap_recursive(heap, l, n)
    }
  }
  return(heap)
}

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
