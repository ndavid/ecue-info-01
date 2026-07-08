# Annexe G — Pont MyST / algorithmique

**Durée** : variable (cœur du scénario C ; sinon extension avancée). · **Prérequis** : Markdown (D), git+PR (C).

## Idée

Les algorithmes vus dans le **cours parallèle** ne sont **pas ré-implémentés** ici : ils sont **documentés et illustrés** dans des pages **MyST Markdown**, agrégées dans un dépôt commun via PR. C'est le moment où le ROI du module outillage devient **visible**.

## Pourquoi MyST (et pas `.ipynb` brut)

- MyST Markdown = **texte brut** → diffs lisibles, merges gérables dans git. Le `.ipynb` est du JSON avec sorties embarquées → diffs bruités, conflits illisibles, ce qui **saboterait** les compétences git du cours 1.
- Extension naturelle du Markdown déjà connu : + maths, admonitions, figures, références croisées, cellules exécutables.

## Déroulé type

1. Dépôt **amorcé** avec 2–3 exemples déjà écrits (ex. recherche binaire, tri à bulles, BFS sur petit graphe) : chaque page = explication + court bloc de code + une figure + une ligne de complexité.
2. Chaque étudiant **choisit un algo différent** (tri par insertion, récursivité/Fibonacci, PGCD/Euclide, crible d'Ératosthène, DFS…) parmi la liste standard.
3. Il **écrit/débogue d'abord le `.py`** (ça, c'est l'exercice algorithmique — cours parallèle), **puis** la page MyST documente/illustre un code déjà fonctionnel. La page est une **couche de communication**, pas un substitut au code.
4. **PR** vers le dépôt commun + mise à jour de l'index → rejoue exactement le workflow branche+PR+conflit-sur-index de l'exercice « liste curatée ».

## La figure doit porter du sens (pas décorative)

- Version forte : tracer **nb d'opérations/comparaisons vs taille d'entrée** → argument visuel pour O(n) vs O(n log n) vs O(n²). Fournir un squelette matplotlib (enseigner matplotlib n'est pas l'objectif).

## Algorithmes standards d'un cours d'intro (référence)

Recherche (linéaire, binaire) ; tris (bulle/sélection/insertion → fusion/rapide) ; récursivité (factorielle, Fibonacci, Hanoï) ; structures (pile, file, liste chaînée) ; graphes (BFS/DFS, Dijkstra — **très géomatique**) ; théorie des nombres (Euclide, crible) ; hachage.

## Scoping (décision explicite)

- **Baseline** : pages MyST `.md` individuelles, rendu simple (aperçu VSCode ou rendu GitHub), agrégées dans un dépôt.
- **Avancé/optionnel** : *build* d'un vrai **Jupyter Book / site MyST** navigable (install + commande de build + hébergement = overhead réel).

## Livrable

Une page MyST par étudiant, fusionnée par PR dans le dépôt commun, avec au moins une figure de complexité.
