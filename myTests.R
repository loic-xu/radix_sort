################################################
############# Setup & Données ##################
################################################

n <- 100 # Taille des données
s <- sample(n) # Vecteur aléatoire

# Appels tests
merge_sort(s)
heap_sort(s)
radix_sort(s)
merge_sort_Rcpp(s)
heap_sort_Rcpp(s)
radix_sort_Rcpp(s)

################################################################################################
# Fonction qui mesure le temps d'exécution d'un algorithme de tri
one.simu <- function(n, type = "sample", func = "merge_sort") {
  if (type == "sample") {
    v <- sample(n)
  } else {
    v <- n:1
  }
  if (func == "merge_sort") t <- system.time(merge_sort(v))[[1]]
  if (func == "heap_sort") t <- system.time(heap_sort(v))[[1]]
  if (func == "radix_sort") t <- system.time(radix_sort(v))[[1]]
  if (func == "merge_sort_Rcpp") t <- system.time(merge_sort_Rcpp(v))[[1]]
  if (func == "heap_sort_Rcpp") t <- system.time(heap_sort_Rcpp(v))[[1]]
  if (func == "radix_sort_Rcpp") t <- system.time(radix_sort_Rcpp(v))[[1]]
  return(t)
}
################################################################################################

###########################################################
############# One time complexity test ####################
###########################################################

n <- 10000
one.simu(n, func = "merge_sort")
one.simu(n, func = "heap_sort")
one.simu(n, func = "radix_sort")
one.simu(n, func = "merge_sort_Rcpp")
one.simu(n, func = "heap_sort_Rcpp")
one.simu(n, func = "radix_sort_Rcpp")

#########################################################################
############# Simulation à taille fixe avec médianes ####################
#########################################################################

nbSimus <- 10
time1 <- numeric(nbSimus)
time2 <- numeric(nbSimus)
time3 <- numeric(nbSimus)
time4 <- numeric(nbSimus)
time5 <- numeric(nbSimus)
time6 <- numeric(nbSimus)

for (i in 1:nbSimus) {
  time1[i] <- one.simu(n, func = "merge_sort")
  time2[i] <- one.simu(n, func = "heap_sort")
  time3[i] <- one.simu(n, func = "radix_sort")
  time4[i] <- one.simu(n, func = "merge_sort_Rcpp")
  time5[i] <- one.simu(n, func = "heap_sort_Rcpp")
  time6[i] <- one.simu(n, func = "radix_sort_Rcpp")
}

# Gains avec médianes
median(time1) / median(time4)  # R → Rcpp (merge)
median(time2) / median(time5)  # R → Rcpp (heap)
median(time3) / median(time6)  # R → Rcpp (radix)

#time1 / time2  # merge vs heap
#time4 / time5  # merge Rcpp vs heap Rcpp

#time1 / time3  # merge vs radix
#time4 / time6  # merge Rcpp vs radix Rcpp

#time3 / time2  # radix vs heap
#time6 / time5  # radix Rcpp vs heap Rcpp

##########################################
############# microbenchmark #############
##########################################

library(microbenchmark)
library(ggplot2)

n <- 10000
res <- microbenchmark(
  one.simu(n, func = "merge_sort_Rcpp"),
  one.simu(n, func = "heap_sort_Rcpp"),
  one.simu(n, func = "radix_sort_Rcpp"),
  times = 50
)
autoplot(res) + ggtitle("Microbenchmark des algorithmes de tri (R & Rcpp)")
res

##########################################
############# time complexity ############
##########################################

nbSimus <- 30
vector_n <- seq(from = 5000, to = 50000, length.out = nbSimus)
nbRep <- 10

# merge Rcpp
res_merge <- data.frame(matrix(0, nbSimus, nbRep + 1))
colnames(res_merge) <- c("n", paste0("Rep",1:nbRep))
for (j in 1:nbSimus) {
  n_val <- vector_n[j]
  res_merge[j,] <- c(n_val, replicate(nbRep, one.simu(n_val, func = "merge_sort_Rcpp")))
  print(j)
}
res <- apply(res_merge[,-1], 1, median)
plot(vector_n, res, xlab = "Taille des données", ylab = "Temps (s)", main = "Complexité temporelle : merge_sort_Rcpp")
lm(log(res) ~ log(vector_n))

# Heap Rcpp
res_heap <- data.frame(matrix(0, nbSimus, nbRep + 1))
colnames(res_heap) <- c("n", paste0("Rep",1:nbRep))
for (j in 1:nbSimus) {
  n_val <- vector_n[j]
  res_heap[j,] <- c(n_val, replicate(nbRep, one.simu(n_val, func = "heap_sort_Rcpp")))
  print(j)
}
res <- apply(res_heap[,-1], 1, median)
plot(vector_n, res, xlab = "Taille des données", ylab = "Temps (s)", main = "Complexité temporelle : heap_sort_Rcpp")
lm(log(res) ~ log(vector_n))

# radix Rcpp
res_radix_rcpp <- data.frame(matrix(0, nbSimus, nbRep + 1))
colnames(res_radix_rcpp) <- c("n", paste0("Rep",1:nbRep))
for (j in 1:nbSimus) {
  n_val <- vector_n[j]
  res_radix_rcpp[j,] <- c(n_val, replicate(nbRep, one.simu(n_val, func = "radix_sort_Rcpp")))
  print(j)
}
res <- apply(res_radix_rcpp[,-1], 1, median)
plot(vector_n, res, xlab = "Taille des données", ylab = "Temps (s)", main = "Complexité temporelle : radix_sort_Rcpp")
lm(log(res) ~ log(vector_n))

##########################################
####### Comparaison R vs Rcpp (plot) #####
##########################################

# Init
res_merge_R <- data.frame(matrix(0, nbSimus, nbRep + 1))
res_heap_R   <- data.frame(matrix(0, nbSimus, nbRep + 1))
res_radix_R   <- data.frame(matrix(0, nbSimus, nbRep + 1))
colnames(res_merge_R) <- colnames(res_heap_R) <- colnames(res_radix_R) <- c("n", paste0("Rep",1:nbRep))

# Boucle pour R
for (j in 1:nbSimus) {
  n_val <- vector_n[j]
  res_merge_R[j,] <- c(n_val, replicate(nbRep, one.simu(n_val, func = "merge_sort")))
  res_heap_R[j,]   <- c(n_val, replicate(nbRep, one.simu(n_val, func = "heap_sort")))
  res_radix_R[j,]   <- c(n_val, replicate(nbRep, one.simu(n_val, func = "radix_sort")))
  print(paste("R:", j))
}

# Médianes
df_compar <- data.frame(
  n = vector_n,
  merge_R = apply(res_merge_R[,-1], 1, median),
  merge_Rcpp = apply(res_merge[,-1], 1, median),
  heap_R = apply(res_heap_R[,-1], 1, median),
  heap_Rcpp = apply(res_heap[,-1], 1, median),
  radix_R = apply(res_radix_R[,-1], 1, median),
  radix_Rcpp = apply(res_radix_rcpp[,-1], 1, median)
)

# ggplot
library(tidyr)
df_long <- pivot_longer(df_compar, cols = -n, names_to = "algo", values_to = "temps")
ggplot(df_long, aes(x = n, y = temps, color = algo)) +
  geom_line(size = 1) +
  labs(title = "Comparaison R vs Rcpp par algorithme",
       x = "Taille des données", y = "Temps (s)") +
  theme_minimal()



# ggplot pour chaque algorithme séparément
library(tidyr)
library(ggplot2)

# Comparaison pour l'algorithme de merge
df_merge <- data.frame(
  n = vector_n,
  merge_R = apply(res_merge_R[,-1], 1, median),
  merge_Rcpp = apply(res_merge[,-1], 1, median)
)
df_merge_long <- pivot_longer(df_merge, cols = -n, names_to = "algo", values_to = "temps")

ggplot(df_merge_long, aes(x = n, y = temps, color = algo)) +
  geom_line(size = 1) +
  labs(title = "Comparaison R vs Rcpp - Tri merge",
       x = "Taille des données", y = "Temps (s)") +
  theme_minimal()

# Comparaison pour l'algorithme de heap
df_heap <- data.frame(
  n = vector_n,
  heap_R = apply(res_heap_R[,-1], 1, median),
  heap_Rcpp = apply(res_heap[,-1], 1, median)
)
df_heap_long <- pivot_longer(df_heap, cols = -n, names_to = "algo", values_to = "temps")

ggplot(df_heap_long, aes(x = n, y = temps, color = algo)) +
  geom_line(size = 1) +
  labs(title = "Comparaison R vs Rcpp - Tri Heap",
       x = "Taille des données", y = "Temps (s)") +
  theme_minimal()

# Comparaison pour l'algorithme de radix
df_radix <- data.frame(
  n = vector_n,
  radix_R = apply(res_radix_R[,-1], 1, median),
  radix_Rcpp = apply(res_radix_rcpp[,-1], 1, median)
)
df_radix_long <- pivot_longer(df_radix, cols = -n, names_to = "algo", values_to = "temps")

ggplot(df_radix_long, aes(x = n, y = temps, color = algo)) +
  geom_line(size = 1) +
  labs(title = "Comparaison R vs Rcpp - Tri radix",
       x = "Taille des données", y = "Temps (s)") +
  theme_minimal()