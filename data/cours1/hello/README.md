# Deux « hello world » — Cours 1

Le même programme, en Python et en C++ : il affiche une phrase, rien de plus.
Ce qui compte n'est pas ce qu'ils font, mais ce qu'il faut faire pour les
lancer, et ce que chacun laisse sur le disque.

Ces fichiers sont versionnés, contrairement au reste de `data/` : ce sont des
sources de quelques lignes, pas des données dérivées.

## Ce que la manipulation montre

| | `python/bonjour.py` | `cpp/bonjour.cpp` |
|---|---|---|
| Ce qu'on tape | `python python/bonjour.py` | `g++ cpp/bonjour.cpp -o cpp/bonjour`, puis `cpp/bonjour` |
| Nombre d'étapes | une | deux : compiler, puis exécuter |
| Ce qui apparaît sur le disque | rien | `cpp/bonjour`, un exécutable |
| Taille du fichier source | 230 octets | 230 octets |
| Taille du fichier produit | aucun fichier | 23 624 octets |

Tailles relevées avec `g++` 13 sous Linux ; elles varient d'un compilateur à
l'autre, mais l'ordre de grandeur, cent fois le fichier de départ, ne varie
pas. L'exécutable embarque de quoi tourner sans le compilateur.

## Déroulé

```bash
conda activate info01
cd data/cours1/hello

python python/bonjour.py            # une étape

g++ cpp/bonjour.cpp -o cpp/bonjour  # compiler
cpp/bonjour                         # exécuter
```

Dans l'éditeur de code, ouvrir le dossier `hello/` puis Terminal → Nouveau
terminal : le terminal s'ouvre déjà dans le bon dossier, ce qui évite l'erreur
de chemin la plus fréquente de la séance.

## Sous Windows

`python` vient de l'environnement conda. `g++`, en revanche, n'est pas fourni
avec Windows : il s'obtient avec MinGW-w64, MSYS2 ou le sous-système Windows
pour Linux. L'exécutable produit s'appelle alors `bonjour.exe` et se lance par
`.\cpp\bonjour`.

Prévoir un poste de démonstration si personne dans la salle n'a de
compilateur : la comparaison vaut d'être vue même par ceux qui ne peuvent pas
la refaire.

## Ce qui est laissé de côté

Le fichier `cpp/bonjour` produit par la compilation n'est pas versionné : c'est
un artefact, comme les PDF et les vidéos du reste du dépôt. Le supprimer avant
la séance suivante pour que la manipulation reparte de zéro.
