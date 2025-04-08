################################################
############# Setup & Données ##################
################################################

n <- 100 # Taille des données
s <- sample(n) # Vecteur aléatoire

# Appels tests
tri_fusion(s)
heap_sort(s)
tri_base(s)
tri_fusion_Rcpp(s)
heap_sort_Rcpp(s)
tri_base_Rcpp(s)

################################################################################################
# Fonction qui mesure le temps d'exécution d'un algorithme de tri
one.simu <- function(n, type = "sample", func = "tri_fusion") {
  if (type == "sample") {
    v <- sample(n)
  } else {
    v <- n:1
  }
  if (func == "tri_fusion") t <- system.time(tri_fusion(v))[[1]]
  if (func == "heap_sort") t <- system.time(heap_sort(v))[[1]]
  if (func == "tri_base") t <- system.time(tri_base(v))[[1]]
  if (func == "tri_fusion_Rcpp") t <- system.time(tri_fusion_Rcpp(v))[[1]]
  if (func == "heap_sort_Rcpp") t <- system.time(heap_sort_Rcpp(v))[[1]]
  if (func == "tri_base_Rcpp") t <- system.time(tri_base_Rcpp(v))[[1]]
  return(t)
}
################################################################################################

###########################################################
############# One time complexity test ####################
###########################################################

n <- 10000
one.simu(n, func = "tri_fusion")
one.simu(n, func = "heap_sort")
one.simu(n, func = "tri_base")
one.simu(n, func = "tri_fusion_Rcpp")
one.simu(n, func = "heap_sort_Rcpp")
one.simu(n, func = "tri_base_Rcpp")

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
  time1[i] <- one.simu(n, func = "tri_fusion")
  time2[i] <- one.simu(n, func = "heap_sort")
  time3[i] <- one.simu(n, func = "tri_base")
  time4[i] <- one.simu(n, func = "tri_fusion_Rcpp")
  time5[i] <- one.simu(n, func = "heap_sort_Rcpp")
  time6[i] <- one.simu(n, func = "tri_base_Rcpp")
}

# Gains avec médianes
median(time1) / median(time4)  # R → Rcpp (fusion)
median(time2) / median(time5)  # R → Rcpp (heap)
median(time3) / median(time6)  # R → Rcpp (base)

#time1 / time2  # fusion vs heap
#time4 / time5  # fusion Rcpp vs heap Rcpp

#time1 / time3  # fusion vs base
#time4 / time6  # fusion Rcpp vs base Rcpp

#time3 / time2  # base vs heap
#time6 / time5  # base Rcpp vs heap Rcpp

##########################################
############# microbenchmark #############
##########################################

library(microbenchmark)
library(ggplot2)

n <- 10000
res <- microbenchmark(
  one.simu(n, func = "tri_fusion_Rcpp"),
  one.simu(n, func = "heap_sort_Rcpp"),
  one.simu(n, func = "tri_base_Rcpp"),
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

# Fusion Rcpp
res_fusion <- data.frame(matrix(0, nbSimus, nbRep + 1))
colnames(res_fusion) <- c("n", paste0("Rep",1:nbRep))
for (j in 1:nbSimus) {
  n_val <- vector_n[j]
  res_fusion[j,] <- c(n_val, replicate(nbRep, one.simu(n_val, func = "tri_fusion_Rcpp")))
  print(j)
}
res <- apply(res_fusion[,-1], 1, median)
plot(vector_n, res, xlab = "Taille des données", ylab = "Temps (s)", main = "Complexité temporelle : tri_fusion_Rcpp")
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

# Base Rcpp
res_base_rcpp <- data.frame(matrix(0, nbSimus, nbRep + 1))
colnames(res_base_rcpp) <- c("n", paste0("Rep",1:nbRep))
for (j in 1:nbSimus) {
  n_val <- vector_n[j]
  res_base_rcpp[j,] <- c(n_val, replicate(nbRep, one.simu(n_val, func = "tri_base_Rcpp")))
  print(j)
}
res <- apply(res_base_rcpp[,-1], 1, median)
plot(vector_n, res, xlab = "Taille des données", ylab = "Temps (s)", main = "Complexité temporelle : tri_base_Rcpp")
lm(log(res) ~ log(vector_n))

##########################################
####### Comparaison R vs Rcpp (plot) #####
##########################################

# Init
res_fusion_R <- data.frame(matrix(0, nbSimus, nbRep + 1))
res_heap_R   <- data.frame(matrix(0, nbSimus, nbRep + 1))
res_base_R   <- data.frame(matrix(0, nbSimus, nbRep + 1))
colnames(res_fusion_R) <- colnames(res_heap_R) <- colnames(res_base_R) <- c("n", paste0("Rep",1:nbRep))

# Boucle pour R
for (j in 1:nbSimus) {
  n_val <- vector_n[j]
  res_fusion_R[j,] <- c(n_val, replicate(nbRep, one.simu(n_val, func = "tri_fusion")))
  res_heap_R[j,]   <- c(n_val, replicate(nbRep, one.simu(n_val, func = "heap_sort")))
  res_base_R[j,]   <- c(n_val, replicate(nbRep, one.simu(n_val, func = "tri_base")))
  print(paste("R:", j))
}

# Médianes
df_compar <- data.frame(
  n = vector_n,
  fusion_R = apply(res_fusion_R[,-1], 1, median),
  fusion_Rcpp = apply(res_fusion[,-1], 1, median),
  heap_R = apply(res_heap_R[,-1], 1, median),
  heap_Rcpp = apply(res_heap[,-1], 1, median),
  base_R = apply(res_base_R[,-1], 1, median),
  base_Rcpp = apply(res_base_rcpp[,-1], 1, median)
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

# Comparaison pour l'algorithme de fusion
df_fusion <- data.frame(
  n = vector_n,
  fusion_R = apply(res_fusion_R[,-1], 1, median),
  fusion_Rcpp = apply(res_fusion[,-1], 1, median)
)
df_fusion_long <- pivot_longer(df_fusion, cols = -n, names_to = "algo", values_to = "temps")

ggplot(df_fusion_long, aes(x = n, y = temps, color = algo)) +
  geom_line(size = 1) +
  labs(title = "Comparaison R vs Rcpp - Tri Fusion",
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

# Comparaison pour l'algorithme de base
df_base <- data.frame(
  n = vector_n,
  base_R = apply(res_base_R[,-1], 1, median),
  base_Rcpp = apply(res_base_rcpp[,-1], 1, median)
)
df_base_long <- pivot_longer(df_base, cols = -n, names_to = "algo", values_to = "temps")

ggplot(df_base_long, aes(x = n, y = temps, color = algo)) +
  geom_line(size = 1) +
  labs(title = "Comparaison R vs Rcpp - Tri Base",
       x = "Taille des données", y = "Temps (s)") +
  theme_minimal()