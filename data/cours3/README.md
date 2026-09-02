# Données — Cours 3 : Binaire, données & construction d'une CLI (CM)

_(vide pour l'instant)_

Modèle : [`data/cours1/`](../cours1/) — le dépôt versionne un `make_data.py`
qui **génère** les fichiers de l'exercice, pas les fichiers eux-mêmes
(cf. `.gitignore` à la racine).

Besoins pressentis, d'après le [syllabus](../../syllabus/01_syllabus_v1.md) :

Objectif : voir ce qu'il y a *vraiment* dans un fichier binaire, puis écrire un petit outil Python qui **orchestre des commandes**.

> **Changement v2** : reçoit le bloc **binaire / hexadécimal / PGM** venu du cours 1 (il prépare directement `numpy` et le TD image) ; l'installation de l'environnement conda est désormais faite en séance 1 — ici, simple **rappel d'activation** et ajout de dépendances.

- **🎓 15′ · Binaire vs texte** : encodage, bit et puissances de 2, hexadécimal (code couleur), ASCII/Unicode ; nom des symboles de programmation (`| { [ #` …).
- **⌨️ 20′ · Voir un fichier binaire** : ouvrir une petite image **PGM/PPM** (Netpbm) en **hexadécimal** — en-tête lisible + octets de pixels ; ASCII (`P2`/`P3`) vs binaire (`P5`/`P6`), *même image, deux encodages*. Rappel du cours 1 (« l'extension ne dit pas le contenu ») et préparation du TD7 (une image = un tableau de pixels).
- **🎓 12′ · Fichiers en Python avec `pathlib`** : chemins portables (Windows inclus), lecture / écriture — c'est *ici* qu'on manipule les fichiers, pas au shell.
- **🎓 13′ · Appel de commandes externes** : `subprocess.run([...], check=True)` (forme liste, codes de retour) ; enchaîner des étapes = automatisation. *(`data/cours1/make_data.py`, déjà utilisé en séance 1, en est un exemple à relire.)*
- **🎓 15′ · Construire une CLI** : `argparse`, sous-commandes, options `--verbose`/`--help` ; point sur `args`/`kwargs` (relation list/dict).
- **⌨️ 40′ · Manipulation guidée — mini-pipeline** : construire ensemble un script qui (1) génère quelques frames (ex. 5 images d'un disque qui se déplace) en appelant ImageMagick via `subprocess` (Python calcule les coordonnées, `magick -draw` dessine), (2) les assemble en un court clip avec ffmpeg, (3) expose 1–2 options `argparse` (`--frames N`, `--out`).
- **But** : *voir* concrètement l'automatisation d'un enchaînement d'outils. Sème le **TD séance 4**, qui en fait la version créative complète.
