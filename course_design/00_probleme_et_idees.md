# Cours d'introduction à l'informatique — Problème & idées directrices

*Document de cadrage — v0 (2026-07-08)*

## Contexte

- **Public** : étudiants ingénieurs en **géomatique**, bac+2 (~20 ans), horizons variés.
- **Volume** : **16 h** au total.
- **Cours parallèle** : introduction à la programmation & algorithmique (Python langage principal).

## Problème observé

Le cours de programmation/algorithmique seul ne suffit pas. Constats récurrents :

- Difficultés sur les **bases** : éditer un fichier texte, s'y retrouver dans une arborescence, utiliser un IDE.
- **Git** : point de blocage majeur (commandes, mental model, panique face aux erreurs).
- Manque de **culture informatique** : ordres de grandeur d'accès aux données, CPU/GPU, client-serveur / cloud.

## Objection à traiter (collègues sceptiques)

> « Les étudiants apprendront les outils en codant ; concentrons-nous sur la programmation et l'algorithmique. »

**Réponse retenue.** La fluidité outillage n'émerge pas de façon fiable « par osmose » : à défaut, les étudiants installent de **mauvaises habitudes** difficiles à corriger (script géant non versionné, `cv_final_v2.py`, échange de fichiers par mail). Références : [MIT Missing Semester](https://missing.csail.mit.edu/), [The Carpentries](https://software-carpentry.org/lessons/).

> **Positionnement clé** : ce module n'est **pas** un concurrent du cours d'algo. C'est une **infrastructure de travail** qui réduit la friction dans *tous* les cours suivants (moins de temps encadrant perdu sur « mon venv est cassé », « j'ai perdu mon fichier », « git dit *detached HEAD* »). À vendre comme un **investissement**, pas comme du contenu CS en plus.

## Principes de conception

1. **Cœur = git + éditeur/IDE + ligne de commande.** Le reste est au service de ce cœur.
2. **Pas de capstone trop complexe.** On abandonne l'idée « forker un vrai projet Python avec env + lint + typing » : trop de complexité simultanée pour des débutants.
3. **Markdown / YAML / JSON = matériel de support**, intégré aux exercices (README, fichier de config), jamais en cours magistral isolé.
4. **Culture info = légère et incarnée** par des exemples géomatique (API géospatiale réelle, temps de chargement gros vs petit fichier).
5. **Artefacts réutilisables** plutôt qu'exercices jetables : ce que l'étudiant produit doit avoir une valeur au-delà du TP (CV, dépôt de notes…).
6. **Ancrage géomatique** systématique : les exemples parlent au métier visé.
7. **Répétition > variété** pour git : réutiliser *le même* workflow branche+PR plusieurs fois vaut mieux que multiplier les workflows.
8. **Un palier « avancé » cohérent** pour les étudiants rapides (outil Python de templating, Typst, MyST/Jupyter Book).

## Idées d'exercices retenues (détail en annexes)

- **CV en Markdown** → PDF via `pandoc` / GitHub Pages : artefact personnel réutilisable.
- **README de profil GitHub** : première victoire rapide « je commit, je push, ça apparaît en ligne ».
- **Dépôt partagé de la classe (liste curatée)** via branche + Pull Request : provoque un **vrai conflit de merge** — meilleur exercice git.
- **Carnet de terrain** en Markdown : ancrage géomatique, motif « commit par sortie ».
- **Prise de notes du cours** dans un dépôt git perso : répétition git à faible enjeu.

## Sécurité (fil transversal, ~1,5 h)

- **SSH & cryptographie clé publique/privée** : rattaché au moment « configurer le push vers GitHub/GitLab ».
- **Protéger les infos privées dans git** : rattaché à l'exercice CV (données perso réelles → `.gitignore`, jamais commitées ; l'historique public est permanent).

## Pont vers le cours d'algorithmique

- **Aparté « algorithme caché dans l'outil »** : hash de commit git → hachage ; `git diff` → algorithme de diff (Myers) ; `sort` en CLI → tris ; Dijkstra → analyse de réseau/itinéraire (QGIS). *Mentionnés, pas enseignés ici.*
- **Convergence MyST** : les algos du cours parallèle sont **documentés et illustrés** (pas ré-implémentés) dans des pages MyST Markdown (texte brut → compatible git), agrégées dans un dépôt commun via PR. Rend visible le retour sur investissement du module outillage.

## Points encore ouverts (décisions à prendre)

- Répartition horaire fine à l'intérieur du bloc git.
- Quels 1-2 projets constituent le **cœur** (vs. optionnel).
- Les extensions (outil Python, Typst, MyST book) sont-elles **notées** ou purement bonus ?
- Degré de **couplage** avec le cours d'algo parallèle (calendrier, dépôt partagé commun).
