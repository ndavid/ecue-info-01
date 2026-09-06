---
title: Environnement Python et notebooks
subtitle: Installer une fois, retrouver partout, et savoir où tourne le code
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

:::{note}
Cette partie était prévue en séance 3. Elle a été avancée pour que les autres
cours du programme disposent d'un environnement Python fonctionnel dès la
première semaine. Le bloc « binaire, hexadécimal, PGM » qu'elle remplace a
rejoint le cours 3, où il précède l'introduction de `numpy` et le traitement
d'image.
:::

## L'environnement de développement

Vous allez installer Python, puis `numpy`, puis `ffmpeg`, puis `pandoc`, sur un
poste de laboratoire, sur votre portable, peut-être sous un autre système
d'exploitation. Sans méthode, chaque poste diverge et le travail cesse d'être
reproductible.

Un *environnement* est un dossier isolé contenant une version précise de Python
et les outils choisis. Il se décrit dans un fichier, se recrée à l'identique
ailleurs, et se supprime sans conséquence sur le reste de la machine.

Nous utilisons `conda` avec le canal `conda-forge`, qui installe aussi bien des
bibliothèques Python (`numpy`, `Pillow`) que des programmes complets (`ffmpeg`,
`imagemagick`, `pandoc`, `typst`), sur les trois systèmes. L'objectif est
d'installer des outils de façon reproductible, pas de distribuer un projet.

## Installation

Installez Miniforge, une distribution conda préconfigurée sur conda-forge :
<https://conda-forge.org/download/>. Puis, dans un terminal :

```bash
conda create -n info01 -c conda-forge python=3.12 \
    jupyterlab numpy pillow pandoc typst ffmpeg imagemagick

conda activate info01
```

Le prompt affiche alors `(info01)`. Vérifiez ensuite que les outils répondent :

```bash
python --version
pandoc --version
ffmpeg -version
```

:::{admonition} Manipulation 1 — vérifier quel Python s'exécute
:class: tip

Exécutez la cellule suivante. Elle affiche le chemin de l'interpréteur qui
exécute réellement ce notebook. Ce chemin doit contenir `info01`.
:::

```{code-cell} python
import sys
import platform
from pathlib import Path

print("Python  :", sys.version.split()[0])
print("Exécutable :", sys.executable)
print("Système :", platform.system(), platform.release())
print("Dossier courant :", Path.cwd())
```

:::{warning}
Un message `ModuleNotFoundError: No module named 'numpy'` alors que le paquet
vient d'être installé signifie presque toujours que l'environnement actif n'est
pas celui où l'installation a eu lieu. Vérifiez `sys.executable` avant toute
autre hypothèse.
:::

## Trois façons d'exécuter du Python

```{raw} html
<svg viewBox="0 0 720 182" width="100%" style="max-width:720px;height:auto;display:block;margin:1.2rem auto;font-family:inherit" role="img">
  <defs><marker id="fl" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7"
     markerHeight="7" orient="auto-start-reverse">
     <path d="M0,0 L10,5 L0,10 z" fill="currentColor"/></marker></defs>
  <rect x="255" y="8" width="200" height="46" rx="6" fill="rgba(31,111,139,.10)"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="355.0" y="36" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Du texte Python</text>
  <line x1="355" y1="54" x2="120" y2="96" stroke="currentColor"
     stroke-width="1.5" marker-end="url(#fl)" opacity=".8"/>
  <line x1="355" y1="54" x2="355" y2="96" stroke="currentColor"
     stroke-width="1.5" marker-end="url(#fl)" opacity=".8"/>
  <line x1="355" y1="54" x2="590" y2="96" stroke="currentColor"
     stroke-width="1.5" marker-end="url(#fl)" opacity=".8"/>
  <rect x="10" y="100" width="220" height="70" rx="6" fill="none"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="120.0" y="132" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Interpréteur interactif</text>
  <text x="120.0" y="148" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">tape → réponse immédiate</text>
  <rect x="245" y="100" width="220" height="70" rx="6" fill="none"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="355.0" y="132" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Script .py</text>
  <text x="355.0" y="148" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">python script.py</text>
  <rect x="480" y="100" width="230" height="70" rx="6" fill="none"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="595.0" y="132" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Notebook</text>
  <text x="595.0" y="148" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">cellules + résultats conservés</text>

</svg>
```

```{list-table}
:header-rows: 1

* - Forme
  - Convient pour
  - Limite
* - Interpréteur (`python`)
  - essayer une ligne, faire un calcul
  - rien n'est conservé
* - Script (`.py`)
  - un outil qu'on relance et qu'on versionne
  - les résultats intermédiaires ne sont pas visibles
* - Notebook (`.ipynb`)
  - explorer, documenter, enseigner
  - fichier lourd, difficile à versionner
```

```{code-cell} python
largeur, hauteur = 1920, 1080
pixels = largeur * hauteur
print(f"{pixels:,} pixels".replace(",", " "))
print(f"En couleur, non compressée : {pixels * 3 / 1_000_000:.1f} Mo")
```

Le second chiffre resservira au cours 5, consacré aux ordres de grandeur, et au
TD 7 : une image est un tableau de nombres, et sa taille se calcule.

## Interface et noyau

Un notebook n'exécute rien par lui-même. Deux composants se répartissent le
travail.

```{raw} html
<svg viewBox="0 0 720 140" width="100%" style="max-width:720px;height:auto;display:block;margin:1.2rem auto;font-family:inherit" role="img">
  <defs><marker id="fl" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7"
     markerHeight="7" orient="auto-start-reverse">
     <path d="M0,0 L10,5 L0,10 z" fill="currentColor"/></marker></defs>
  <rect x="20" y="34" width="265" height="76" rx="6" fill="none"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="152.5" y="68" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Interface</text>
  <text x="152.5" y="86" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">navigateur ou VSCode</text>
  <line x1="295" y1="58" x2="425" y2="58" stroke="currentColor"
     stroke-width="1.5" marker-end="url(#fl)" opacity=".8"/>
  <text x="360.0" y="51.0" text-anchor="middle"
     fill="currentColor" font-size="12" opacity=".7">code</text>
  <line x1="425" y1="92" x2="295" y2="92" stroke="currentColor"
     stroke-width="1.5" marker-end="url(#fl)" opacity=".8"/>
  <text x="360.0" y="85.0" text-anchor="middle"
     fill="currentColor" font-size="12" opacity=".7">résultats</text>
  <rect x="435" y="34" width="265" height="76" rx="6" fill="rgba(31,111,139,.10)"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="567.5" y="68" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Noyau (kernel)</text>
  <text x="567.5" y="86" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">un processus Python</text>

</svg>
```

L'interface affiche le texte et les résultats. Le *noyau* est un processus
Python : il exécute le code et garde les variables en mémoire. Cette séparation
explique deux comportements qui déroutent souvent.

Redémarrer le noyau efface toutes les variables. Le texte des cellules reste à
l'écran, mais son effet a disparu.

L'ordre d'exécution ne suit pas nécessairement l'ordre d'affichage. Les
compteurs `[1]`, `[2]` indiquent l'ordre réel. Un notebook qui fonctionne chez
vous peut échouer chez quelqu'un d'autre s'il n'a jamais été relancé depuis le
début.

:::{admonition} Manipulation 2 — provoquer puis réparer l'incohérence
:class: tip

1. Lancez `jupyter lab` depuis le terminal, avec `info01` activé.
2. Créez un notebook `essai.ipynb`. Première cellule : `x = 10`. Seconde
   cellule : `print(x * 2)`. Exécutez dans l'ordre, vous obtenez `20`.
3. Remplacez le contenu de la première cellule par `x = 3`, mais n'exécutez que
   la seconde. Elle affiche toujours `20` : le noyau ignore ce que vous n'avez
   pas exécuté.
4. Choisissez *Kernel → Restart Kernel and Run All Cells*. Vous obtenez `6`.

Prenez l'habitude de relancer un notebook depuis le début avant de le partager.
:::

## Deux formats de notebook

```{code-cell} python
# Un .ipynb est un fichier JSON : du texte, mais du texte destiné à un programme.
exemple = {
    "cells": [
        {"cell_type": "code",
         "execution_count": 1,
         "metadata": {},
         "source": ["print('bonjour')"],
         "outputs": [{"output_type": "stream", "name": "stdout",
                      "text": ["bonjour\n"]}]},
    ],
    "metadata": {"kernelspec": {"name": "python3"}},
    "nbformat": 4, "nbformat_minor": 5,
}

import json
print(json.dumps(exemple, indent=1)[:420], "…")
```

Un `.ipynb` réunit dans un même fichier le code, les résultats (y compris les
images, encodées en base64) et des métadonnées. Il s'échange facilement, mais se
relit et se compare mal : deux exécutions du même notebook produisent des
différences considérables.

MyST Markdown est l'autre possibilité. Le contenu est écrit en Markdown, les
cellules de code sont des blocs ` ```{code-cell} `, et les résultats sont
recalculés à la construction plutôt que stockés. Cette page est écrite ainsi.

Sur la page que vous lisez, remplacer `1920` par `3840` produit une différence
de 2 lignes au format MyST, contre 44 lignes au format `.ipynb`, dont les
résultats enregistrés.

```{list-table}
:header-rows: 1

* -
  - `.ipynb`
  - MyST (`.md`)
* - Nature
  - JSON produit par l'outil
  - Markdown écrit par un humain
* - Résultats
  - stockés dans le fichier
  - recalculés à la construction
* - Comparaison de versions
  - difficile
  - ligne à ligne
* - Édition
  - JupyterLab, VSCode
  - n'importe quel éditeur
```

:::{admonition} Manipulation 3 — convertir dans les deux sens
:class: tip

```bash
jupytext --to ipynb 03_environnement_python.md
jupytext --to myst essai.ipynb
```

Ouvrez les deux résultats dans VSCode, comparez leur taille et leur lisibilité,
puis répondez en trois lignes : lequel choisiriez-vous pour rédiger un cours ?
pour envoyer un résultat par courriel ?
:::

## Bilan de la séance

Un logiciel transforme une entrée en sortie, et son traitement part d'un texte
écrit par un humain. Une extension nomme un fichier sans dire ce qu'il contient.
Le contenu et la présentation se séparent, en HTML comme ailleurs. Un
environnement rend l'outillage reproductible d'un poste à l'autre. Un notebook
s'exécute dans un noyau, qui conserve l'état entre les cellules.

Le choix d'un format décide de ce que l'on pourra en faire : le relire, le
comparer, le versionner. C'est le sujet du cours 2, consacré à la ligne de
commande et à git.
