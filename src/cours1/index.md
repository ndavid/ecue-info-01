---
title: "Séance 1 — Logiciel, programmation et formats de fichier"
---

Cette première séance répond à quatre questions qui s'enchaînent.

```{list-table}
:header-rows: 1

* - Question
  - Réponse courte
  - Durée
* - À quoi sert un programme ?
  - à faire faire à la machine ce qu'on ferait à la main
  - 12 min
* - De quoi un programme est-il fait ?
  - de fichiers texte, écrits dans un éditeur
  - 10 min
* - Que contient un fichier ?
  - des octets, que l'extension ne décrit pas
  - 40 min
* - Avec quels outils travaille-t-on ?
  - un éditeur, un environnement, un notebook
  - 43 min
```

Les deux dernières lignes sont des manipulations faites sur votre machine.

## Avant la séance

Les fichiers manipulés sont produits à partir de textes du domaine public. À
lancer une fois, depuis la racine du dépôt :

```bash
cd data/cours1
python make_data.py fetch
python make_data.py build
```

```{toctree}
:maxdepth: 1

notebook/01_programmes_et_outils
notebook/02_formats_de_fichier
notebook/03_environnement_python
```
