# Branches et fusions — TD 4a, cours 2

Questions 6 à 17 du TP. On ouvre les branches du projet, on écrit le code à
deux endroits comme si deux personnes travaillaient en parallèle, puis on
ramène tout dans `develop`.

| Dossier | Ce qu'il contient |
|---|---|
| `depart/` | `main_base.py`, à copier à la question 11 |

On travaille dans le projet créé au TD 3a,
`../3a_premier_depot/travail/projet_2`.

## Les branches, dans l'ordre

| Branche | Ouverte depuis | Ce qu'on y met |
|---|---|---|
| `develop` | `master` | rien directement |
| `documentation` | `develop` | la description du projet dans `README.md` |
| `main_code` | `develop` | `src/main.py`, l'affichage du titre |
| `operations` | `develop` | `src/operations.py`, les quatre fonctions |

Les quatre fonctions de `operations.py` : `add(a,b)` rend la somme,
`mult(a,b)` le produit, `neg(a)` l'opposé, `inv(a)` l'inverse.

## Deux fusions qui ne se ressemblent pas

À la question 17, le premier `merge` est un **avance-rapide** : `develop`
n'a pas bougé depuis que `main_code` en est partie, git se contente donc de
faire avancer l'étiquette, et aucun commit n'est créé.

Le second crée un **commit de fusion**, parce que `develop` a entre-temps
reçu le premier merge. Un éditeur s'ouvre alors dans le terminal pour le
message : c'est souvent `vim`, dont on sort par `:wq`. Ne fermez pas le
terminal.

Afficher `git llog` après chacun des deux : c'est là que la différence se
voit.
