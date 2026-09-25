---
title: La fenêtre du train
subtitle: Un paysage décalé par ImageMagick, un décalage calculé par Python, une vidéo par ffmpeg
execution: ../../travail
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# La fenêtre du train

Ce notebook fabrique une vidéo de dix secondes : la mer vue de la fenêtre
d'un train, les voiles et la plage qui défilent derrière la vitre. Le décor
est dessiné d'après la scène de la mer du clip « Moon » de Kid Francescoli
(collectif Cauboyz, 2017), tourné avec des décors en carton posés sur une
table tournante.

Chaque image de la vidéo superpose trois images : le fond (le ciel, les
nuages, la mer), qui ne bouge pas ; le plan (les voiles et la plage), décalé
de quelques pixels de plus à chaque image ; la fenêtre, par-dessus.

La fonction Python `decalages` calcule le décalage de chaque image ; pour
chaque décalage, la fonction `image` construit la commande qui compose
l'image. Deux programmes en ligne de commande, comme git (cours 2) et pandoc
(cours 3), font le reste :

- ImageMagick (`magick`) décale le plan et superpose les trois images ;
- ffmpeg assemble les images en une vidéo.

Python lance ces deux programmes avec `subprocess.run` : il automatise
l'ensemble des étapes. Dans la partie B du TD, le code de ce notebook
devient un script `train.py`, appelable en ligne de commande. Le schéma
suivant montre les étapes de ce script final, avec des images de la vidéo
produite :

![Les étapes du script train.py](../depart/illustrations/programme_train.png)

Le notebook a six parties :

1. Les outils : vérifier que `magick` et `ffmpeg` sont trouvés.
2. Le décor : les trois images.
3. Superposer les images.
4. Décaler le plan.
5. Les décalages.
6. La vidéo.

Dans la partie B du TD, le programme `train.py` reprend ces sections
fonctionnalité par fonctionnalité : les sections 2 à 4 pour composer une
image (étape B1), la fonction `decalages` de la section 5 et la première
cellule de la section 6 pour la série d'images (B2), la seconde cellule de
la section 6 pour la vidéo (B3).

Le notebook est livré dans `depart/notebook/`. Le copier dans `travail/`
avant de l'ouvrir. Les fichiers qu'il crée sont écrits dans
`travail/produit/`.

## 1 · Les outils

`magick` et `ffmpeg` sont des programmes, installés dans l'environnement
`animation`. `shutil.which` renvoie le chemin du programme trouvé, ou `None`
si le programme n'est pas trouvé (cours 3, notebook `recette`, section 4.3).

```{code-cell} ipython3
import shutil
import subprocess
import sys
from pathlib import Path

from IPython.display import Image, Video

print("Python :", sys.executable)
print("magick :", shutil.which("magick"))
print("ffmpeg :", shutil.which("ffmpeg"))
```

Les trois chemins doivent être dans le dossier de l'environnement
`animation`. Si `magick` ou `ffmpeg` vaut `None`, JupyterLab n'a pas été
lancé depuis l'environnement `animation` : voir l'étape A4 du guide.

```{code-cell} ipython3
MAGICK = "magick"
FFMPEG = "ffmpeg"

PRODUIT = Path.cwd() / "produit"
IMAGES = PRODUIT / "images"
IMAGES.mkdir(parents=True, exist_ok=True)
print(PRODUIT)
```

## 2 · Le décor

Les images du décor sont dans `depart/decor/`, un dossier au-dessus de
`travail/`. Ce sont des fichiers PNG, qui gardent la transparence : un
pixel transparent laisse voir l'image placée dessous.

- `fond.png`, 640 × 480 pixels : le ciel, les nuages et la mer. Aucun pixel
  n'est transparent.
- `plan.png`, 1 920 × 480 pixels : les voiles et la plage, sur une bande
  trois fois plus large que l'image. Tout le reste est transparent. Le bord
  droit de la bande se raccorde à son bord gauche.
- `fenetre.png`, 640 × 480 pixels : la fenêtre du train, noire, et la vitre,
  transparente.

Le quatrième fichier, `plage.png`, sert au TD 7.

```{code-cell} ipython3
DECOR = Path.cwd().parent / "depart" / "decor"
for nom in ["fond.png", "plan.png", "fenetre.png"]:
    print(DECOR / nom, (DECOR / nom).exists())

Image(str(DECOR / "plan.png"), width=720)
```

Dans l'aperçu, les pixels transparents de `plan.png` prennent la couleur du
fond de la page.

## 3 · Superposer les images

`lancer` exécute une commande donnée sous forme de liste : le programme,
puis chaque argument. `check=True` arrête le notebook si la commande échoue.

`magick` lit les images dans l'ordre de la commande. `-composite` pose la
dernière image lue sur celle d'avant : ses pixels transparents laissent voir
l'image du dessous.

Le plan fait 1 920 pixels de large : avant de le poser, `-crop 640x480+0+0`
en garde un morceau de 640 × 480 pixels à partir du coin en haut à gauche,
et `+repage` oublie la position de ce morceau dans la bande. Les
parenthèses `(` et `)` isolent ces réglages : ils ne s'appliquent qu'au
plan, pas au fond.

```{code-cell} ipython3
def lancer(commande):
    """Lance une commande (le programme, puis chaque argument) ; s'arrête si elle échoue."""
    subprocess.run(commande, check=True)


lancer([MAGICK, str(DECOR / "fond.png"),
        "(", str(DECOR / "plan.png"), "-crop", "640x480+0+0", "+repage", ")", "-composite",
        str(DECOR / "fenetre.png"), "-composite",
        str(PRODUIT / "essai.png")])
Image(str(PRODUIT / "essai.png"))
```

## 4 · Décaler le plan

`-roll +200+0` fait tourner la bande de 200 pixels vers la droite : les
200 pixels qui sortent à droite reviennent à gauche. Un décalage plus grand
que la bande fait plus d'un tour : 2 120 pixels donnent la même image que
200, car 2 120 = 1 920 + 200.

`image` construit la commande complète d'une image : le fond, le plan décalé
de `decalage` pixels puis coupé à 640 pixels, la fenêtre.

```{code-cell} ipython3
def image(fichier, decor, decalage):
    """Une image 640 × 480 : le fond, le plan décalé de `decalage` pixels vers la droite, puis la fenêtre."""
    commande = [MAGICK, str(decor / "fond.png"),
                "(", str(decor / "plan.png"), "-roll", "+" + str(decalage) + "+0",
                "-crop", "640x480+0+0", "+repage", ")", "-composite",
                str(decor / "fenetre.png"), "-composite"]
    commande.append(str(fichier))
    lancer(commande)


image(PRODUIT / "essai_200.png", DECOR, 200)
Image(str(PRODUIT / "essai_200.png"))
```

Les voiles et la plage ont avancé de 200 pixels vers la droite ; le ciel,
les nuages et la mer n'ont pas bougé.

## 5 · Les décalages

La fonction `decalages` renvoie le décalage de chaque image de la vidéo :
0 pour la première, puis `vitesse` pixels de plus à chaque image.

```{code-cell} ipython3
def decalages(nombre, vitesse):
    """Le décalage de chaque image : 0, puis `vitesse` pixels de plus à chaque image."""
    liste = []
    for numero in range(nombre):
        liste.append(numero * vitesse)
    return liste


print(decalages(6, 8))
```

## 6 · La vidéo

Une image par décalage : avec `NOMBRE = 120` et `VITESSE = 8`, 120 images,
nommées `img_0001.png`, `img_0002.png`… La dernière est décalée de
119 × 8 = 952 pixels, la moitié de la bande. Les images d'une exécution
précédente sont d'abord supprimées.

```{code-cell} ipython3
NOMBRE = 120        # le nombre d'images
VITESSE = 8         # le décalage de plus à chaque image, en pixels

for ancienne in IMAGES.glob("img_*.png"):
    ancienne.unlink()

liste = decalages(NOMBRE, VITESSE)
numero = 0
for decalage in liste:
    numero = numero + 1
    nom = "img_" + str(numero).zfill(4) + ".png"
    image(IMAGES / nom, DECOR, decalage)
print(len(liste), "images dans", IMAGES)
```

ffmpeg lit les images `img_0001.png`, `img_0002.png`… (`img_%04d.png` : quatre
chiffres) et écrit la vidéo. `-framerate 12` : douze images par seconde, la
vidéo dure 120 / 12 = 10 secondes.

```{code-cell} ipython3
CADENCE = 12

lancer([FFMPEG, "-y", "-loglevel", "error",
        "-framerate", str(CADENCE),
        "-i", str(IMAGES / "img_%04d.png"),
        "-c:v", "mpeg4", "-q:v", "3", "-pix_fmt", "yuv420p",
        str(PRODUIT / "train.mp4")])
Video(str(PRODUIT / "train.mp4"), embed=True, width=480)
```

La vidéo est le fichier `travail/produit/train.mp4` : elle s'ouvre aussi par
un double-clic dans l'explorateur.

:::{admonition} À essayer
Changer `VITESSE` (par exemple 2, puis 40) ou `CADENCE`, puis relancer les
deux dernières cellules. Dans le clip, une voile met une quarantaine de
secondes à traverser la vitre. Ici, la vitre fait 560 pixels de large :
`VITESSE = 1`, à 12 images par seconde, donne à peu près la même durée.
`NOMBRE` et `CADENCE` sont les valeurs que la partie B passera sur la ligne
de commande.
:::
