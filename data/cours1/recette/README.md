# Un projet Python : la recette à l'échelle — Cours 1

La partie 3 explique ce qu'un projet Python contient en plus de son code : sa
documentation, les bibliothèques dont il dépend, et les fichiers qui déclarent
les unes et les autres. Ce dossier en est un, petit mais complet, et la
manipulation consiste à l'installer, à s'en servir, puis à compléter sa
documentation.

Le programme lit une recette écrite en Markdown et un tableau d'ingrédients
donné **pour une personne, en unités SI**. Il multiplie les quantités par le
nombre de convives, les convertit si on le lui demande, insère le tableau à
l'endroit où la recette annonce ses ingrédients, et écrit une page HTML.

```
recette/
├── pyproject.toml      ce qu'est le projet, et ce dont il dépend
├── environment.yml     l'environnement conda dans lequel il tourne
├── README.md           ce fichier
├── ingredients.csv     les quantités pour une personne, en unités SI
├── recette.md          la recette, sans son tableau d'ingrédients
├── style.css           la présentation de la page produite
├── recette_a_la_main.py     le programme, sans autre bibliothèque que markdown
├── recette_avec_tabulate.py le même, avec la bibliothèque tabulate
└── recette/
    ├── __init__.py          les deux conversions, et le gabarit de la page
    └── __main__.py          le même programme, en ligne de commande
```

La page `recette.html` n'est pas versionnée, non plus que le `recette.egg-info/`
que dépose une installation en mode éditable : ce sont des artefacts.

## Installation

```bash
conda env create -f environment.yml
conda activate recette
python -m pip install -e .
```

L'environnement décrit par `environment.yml` ne contient que Python :
`markdown`, dont le code a besoin, s'installe pendant la manipulation. C'est
`pip install -e .` qui lit `pyproject.toml`, installe la dépendance manquante
et met à disposition la commande `recette`.

## Deux façons de s'en servir

| | Ce qu'on tape | Comment on change les valeurs |
|---|---|---|
| Le programme | `python recette_a_la_main.py` | en ouvrant le fichier et en modifiant `PERSONNES` et `UNITES` |
| Le même, avec `tabulate` | `python recette_avec_tabulate.py` | de même |
| La ligne de commande | `python -m recette --personnes 12` | en les donnant au lancement |

Les deux premiers ne diffèrent que par une ligne : l'un écrit sa fonction
`tabulate` en cinq lignes, l'autre l'importe d'une bibliothèque. Même nom,
même appel, même sortie — c'est le plus court exemple de ce qu'on gagne et de
ce qu'on paie à installer une dépendance.

Une fois le projet installé, `python -m recette` s'écrit aussi `recette`.
`recette --help` dit ce que la commande accepte.

## Ce que le code fait, fonction par fonction

Les étapes sont séparées pour qu'on puisse les lire, les essayer une par une
dans l'interpréteur, et en changer une sans toucher aux autres.

Un ingrédient est un triplet — son nom, sa quantité, son unité — et une
recette est la liste de ses ingrédients. Ce qui touche aux ingrédients est
dans `recette/__init__.py` :

| Fonction | Ce qu'elle fait |
|---|---|
| `lire_ingredients` | lit le CSV et rend des nombres, pas du texte |
| `adapter` | met à l'échelle et convertit, en une passe |
| `convertir` | une quantité et son unité, en onces ou en cups |
| `en_table` | rend les lignes du tableau, quantités écrites |

Les trois programmes appellent ces fonctions dans cet ordre, puis posent le
tableau sous le titre « Ingrédients » et convertissent le tout en HTML. Leur
corps tient en une dizaine de lignes, qui se lisent de haut en bas.

Les unités qui se comptent — les œufs — n'ont pas d'équivalent américain :
elles traversent la conversion inchangées, faute d'entrée dans la table.

## Ce qui est demandé

Le `README` d'un projet dit ce que le projet fait et comment s'en servir.
Celui-ci dit le premier et pas le second : **ajoutez-y une section
« Exemples »** avec au moins trois lignes de commande et ce qu'elles
produisent. Par exemple une recette pour deux, une pour douze en unités
américaines, et une page écrite ailleurs que dans le dossier du projet.

Les commandes que vous écrivez doivent avoir été lancées : un exemple qui ne
marche pas est pire que pas d'exemple.

## Pourquoi ces conversions sont écrites à la main

Des bibliothèques savent convertir des unités — `pint` est la plus employée —
et quelques paquets visent la cuisine en particulier, sans être maintenus.
Deux facteurs et un dictionnaire suffisent ici, et le sujet de la séance est
justement de savoir quand une bibliothèque vaut la peine d'être installée :
elle le vaut pour convertir du Markdown en HTML, huit mille lignes, pas pour
diviser par 28,3495.
