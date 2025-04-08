


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


