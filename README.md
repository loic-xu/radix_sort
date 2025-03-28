# Projet : Radix Sort

## Tâches à réaliser

### Rapport (5 points)
Un rapport au format Rmd, avec une sortie en PDF ou HTML.

### Présentation (15 points)
Une présentation au format Beamer (Rmd) ou PowerPoint qui explique clairement la démarche et les résultats du projet.

Le rapport doit démontrer que la démarche a été suivie de manière rigoureuse, tandis que la présentation doit prouver votre capacité à expliquer les concepts de manière claire et concise.

Le rapport et le script R doivent être partagés avec la promotion entière.

### Package Fonctionnel (Obligatoire)
Le projet doit inclure un package fonctionnel (par exemple, M2algorithmique) avec les éléments suivants :
1. Solution naïve en R et C++
2. Solution améliorée en R et C++
3. Évaluation des simulations de la complexité
4. Un package bien documenté sur GitHub

---

## Démarche

### A) Présentation du problème

- **Objectif** : Définir ce que nous cherchons à résoudre avec l'algorithme de tri Radix.
  
### B) Explication de la difficulté algorithmique

1. **Problème combinatoire** : Expliquer la nature combinatoire du problème de tri.
2. **Solution naïve** : Présenter la solution naïve en R et C++.
3. **Limite de la solution naïve** : Analyser la performance de la solution naïve sur des tailles de problème croissantes (notamment quand `n` devient trop grand, et le temps d'exécution dépasse un seuil comme 5 minutes).

### C) Solution améliorée moderne

1. **Stratégie algorithmique** : Présenter la solution améliorée du Radix Sort.
2. **Simulations comparatives** :
   - Comparer les temps d'exécution entre la solution naïve et la solution améliorée.
   - Comparer les temps d'exécution du code en R et en C++.
3. **Complexité attendue** : Effectuer des simulations qui montrent que la complexité attendue de l'algorithme est bien respectée (effectuer une régression linéaire pour analyser la complexité).
4. **Comparaison avec un autre algorithme de tri** : Comparer les performances du Radix Sort avec un tri ayant une complexité en `n log(n)` de votre choix.
   - Identifier les cas favorables pour chaque algorithme.
   - Déterminer la taille à partir de laquelle les courbes de temps d'exécution se croisent entre les algorithmes.
   - Distinction entre la complexité linéaire et log-linéaire via des simulations.

---

## Structure du package

- **R Code** : Le code source en R pour la solution naïve et améliorée.
- **C++ Code** : Le code source en C++ pour la solution naïve et améliorée.
- **Documentation** : Documentation complète pour le package sur GitHub.

---

