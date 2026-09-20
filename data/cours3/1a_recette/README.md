# Amélioration d'un code de génération de recette — TD 1a, cours 3

Deux notebooks, exécutés pendant l'exposé, une section à la fois. Les
cellules qui ne contiennent qu'un commentaire sont à compléter avec ce que la
diapositive montre.

| Fichier | Ce qu'il contient |
|---|---|
| `depart/notebook/recette.ipynb` | le code de génération de recette : chemins en dur, puis `pathlib`, puis pandoc |
| `depart/notebook/fichiers.ipynb` | comment ce code ouvre, lit et écrit ses fichiers : `open`, `with`, les modes, `csv` |
| `depart/recettes/` | quatre recettes, une par dossier : `recette.md` et `ingredients.csv` |
| `depart/style.css` | la feuille de style des pages produites |
| `travail/` | vide : la copie des notebooks, et ce qu'ils écrivent |

Copier `depart/notebook/recette.ipynb` dans `travail/`. Ouvrir JupyterLab
depuis Anaconda Navigator, ou, dans Anaconda Prompt, taper `jupyter lab` ;
puis naviguer jusqu'à `travail/` dans le panneau de gauche et double-cliquer
sur la copie. `depart/` ne se modifie pas ; les notebooks y lisent les
recettes par le chemin `../depart/`, qui suppose qu'ils sont dans `travail/`.
