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
  
  # Si le vecteur est vide, renvoyer directement le vecteur
  if (n == 0) {
    return(v)
  }
  
  # Si le vecteur a une seule valeur, il est déjà trié
  if (n == 1) {
    return(v)
  }
  
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
