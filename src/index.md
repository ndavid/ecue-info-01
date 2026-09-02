---
title: Introduction à l'informatique
---

Supports exécutables du module (14 h, 1re année géomatique).

Le **syllabus** — vue d'ensemble des 7 séances et déroulé détaillé — vit dans
`syllabus/01_syllabus_v1.md`. Ce dossier-ci contient les
**supports utilisés en séance** :

| Dossier | Contenu |
|---------|---------|
| `src/cours<n>/notebook/` | pages MyST exécutables (cellules Python lancées en direct) |
| `src/cours<n>/diapo/` | sources des diapositives (typst) |

Les jeux de données correspondants sont dans `data/`.

## Construire les supports

Depuis la **racine du dépôt** :

```bash
conda activate info01

sphinx-build -b html src _build/html         # site statique
sphinx-autobuild src _build/html             # aperçu live pendant la rédaction

typst compile src/cours1/diapo/cours1.typ    # diapositives → PDF
```

Le site produit s'ouvre par **double-clic** sur `_build/html/index.html` :
chemins relatifs, aucune ressource externe, aucun serveur nécessaire.

Prérequis, options et pannes connues : `INSTALLATION.md`.

```{toctree}
:maxdepth: 2
:caption: Séances

cours1/notebook/01_logiciel_et_programmation
cours1/notebook/02_formats_de_fichier
cours1/notebook/03_environnement_python
cours2/notebook/cours2
cours3/notebook/cours3
cours4/notebook/cours4
cours5/notebook/cours5
cours6/notebook/cours6
cours7/notebook/cours7
```
