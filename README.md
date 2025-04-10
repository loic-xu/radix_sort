# Package RadixSort

## Aperçu

Le package `RadixSort` est conçu pour comparer les performances de différents algorithmes de tri, avec un accent particulier sur l'algorithme **Radix Sort**. Ce package fournit des implémentations de Radix Sort, Merge Sort et Heap Sort à la fois en R et en C++ optimisé (via Rcpp). L'objectif est d'évaluer l'efficacité de ces algorithmes dans diverses conditions et tailles de données.

## Installation

Pour installer le package `RadixSort`, utilisez la commande suivante dans R :

```{r}
devtools::install_github("loic-xu/radix_sort")
```
## Utilisation
Après avoir installé le package, vous pouvez le charger dans votre session R en utilisant :

```{r}

library(RadixSort)

```

## Exemple

```{r}

# Générer un vecteur aléatoire de taille 100
n <- 100
v <- sample(n)

# Trier le vecteur en utilisant différents algorithmes
cat("Vecteur original :\n")
print(v)
cat("\n")

cat("Trié avec Merge Sort :\n")
print(merge_sort(v))
cat("\n")

cat("Trié avec Heap Sort :\n")
print(heap_sort(v))
cat("\n")

cat("Trié avec Radix Sort :\n")
print(radix_sort(v))
cat("\n")

cat("Trié avec Merge Sort (Rcpp) :\n")
print(merge_sort_Rcpp(v))
cat("\n")

cat("Trié avec Heap Sort (Rcpp) :\n")
print(heap_sort_Rcpp(v))
cat("\n")

cat("Trié avec Radix Sort (Rcpp) :\n")
print(radix_sort_Rcpp(v))
cat("\n")

```


## Fonctionnalités

# Tri Algorithmique et Benchmarking

- **Algorithmes de tri multiples** : Implémentations de plusieurs algorithmes de tri, y compris Merge Sort, Heap Sort et Radix Sort.
- **Performances optimisées** : Les algorithmes sont implémentés en C++ via Rcpp pour des performances accrues.
- **Outils de benchmarking** : Fournit des fonctions pour mesurer et comparer le temps d'exécution des différents algorithmes de tri.
- **Visualisation** : Outils pour visualiser les performances des algorithmes de tri en utilisant `ggplot2`.

## Résultats Clés

### Comparaison des Performances

- **Radix Sort** : Affiche une complexité proche de la linéaire, le rendant particulièrement efficace pour des ensembles de données de taille modérée ou avec des distributions spécifiques.
- **Merge Sort et Heap Sort** : Ces algorithmes ont une complexité de \( O(n \log n) \), ce qui les rend adaptés aux grands ensembles de données.
- **Implémentations en C++** : Les versions en C++ sont significativement plus rapides que leurs homologues en R, soulignant l'importance de l'optimisation pour les tâches computationnelles intensives.

### Points de Croisement

- Théoriquement, les courbes de performance de Radix Sort et Merge Sort devraient se croiser lorsque \( k = \log(n) \). Cependant, les tests pratiques montrent que les points d'intersection sont plus complexes et dépendent des caractéristiques spécifiques des données.

### Analyse de la Complexité

- **Radix Sort** : Présente une complexité proche de la linéaire, avec une pente plus raide dans les courbes de performance.
- **Merge Sort** : Affiche une complexité log-linéaire, avec une pente plus douce, indiquant une croissance plus lente du temps d'exécution.

## Travaux Futurs

- **Algorithmes supplémentaires** : Ajouter et tester d'autres algorithmes de tri, comme Quick Sort.
- **Données réelles** : Analyser les performances des algorithmes sur des jeux de données réels pour mieux comprendre leur comportement en pratique.
- **MSD Radix Sort** : Explorer la variante Most Significant Digit (MSD) de Radix Sort pour d'éventuelles améliorations des performances.

## Conclusion

Ce package RadixSort offre un ensemble complet d'outils pour comparer et analyser les algorithmes de tri. Il met en évidence l'importance de l'optimisation et de la sélection des algorithmes en fonction des cas d'utilisation spécifiques et des caractéristiques des données.
