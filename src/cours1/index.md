---
title: "Séance 1 — Logiciel, programmation et formats de fichier"
---

## Contenu de la séance

Cinq parties, des notions les plus générales jusqu'à l'installation de
l'environnement de programmation. Chacune alterne une explication courte et une
manipulation faite sur votre machine.

```{list-table}
:header-rows: 1

* - Partie
  - Ce qu'on y voit
  - Durée
* - Logiciels et formats de fichier
  - ce qu'un logiciel manipule, et ce qu'une extension nomme
  - 25 min
* - Programmation et éditeur de code
  - d'où vient un programme, et avec quel outil on l'écrit
  - 25 min
* - Édition de texte et contenu des fichiers
  - ce qu'un fichier texte contient, et Markdown
  - 30 min
* - Environnement de programmation
  - le code qu'un programme emprunte, et l'outil qui l'installe
  - 25 min
* - Notebooks
  - l'interface, le noyau, et deux formats de fichier
  - 10 min
```

## Avant la séance

Les fichiers manipulés sont produits à partir de textes du domaine public. À
lancer une fois, depuis la racine du dépôt :

```bash
cd data/cours1
python make_data.py fetch
python make_data.py build
```

L'environnement `info01` doit être en place, par la consigne d'installation
envoyée avant la rentrée. La bibliothèque `markdown`, elle, ne l'est pas : elle
s'installe pendant la séance, et c'est le sujet de la manipulation de la
quatrième partie.

```{toctree}
:maxdepth: 1

notebook/01_programmes_et_outils
notebook/02_formats_de_fichier
notebook/03_environnement_python
notebook/04_premiers_octets
```
