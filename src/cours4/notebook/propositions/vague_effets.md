---
title: La Vague, en mouvement
subtitle: Un panoramique et un tourbillon sur une image existante, par ImageMagick et ffmpeg
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# La Vague, en mouvement

Ce notebook fabrique deux vidéos à partir d'une image existante, *La Grande
Vague* de Hokusai (The Met, CC0), celle du cours 3. Une animation est une
suite d'images qui diffèrent d'un paramètre : ici la position d'une fenêtre
qui glisse sur le tableau, puis l'angle d'un tourbillon. ImageMagick produit
chaque image, ffmpeg les assemble.

1. Les outils et l'image.
2. Un panoramique : une fenêtre qui glisse.
3. Un tourbillon : un angle qui augmente.
4. Aller plus loin.

Ce que le notebook fabrique va dans `produit/vague/`.

## 1 · Les outils et l'image

```{code-cell} ipython3
import shutil
import subprocess
from pathlib import Path

from IPython.display import Image, Video

MAGICK = "magick"        # sur les postes de la salle : le chemin de magick.exe
FFMPEG = "ffmpeg"

VAGUE = Path("../../cours3/2b_images/produit/depart/vague.jpg")   # 2 000 × 1 344 pixels
PRODUIT = Path("produit") / "vague"
IMAGES = PRODUIT / "images"
IMAGES.mkdir(parents=True, exist_ok=True)
print(VAGUE.exists())


def lancer(commande):
    """Lance une commande (le programme, puis chaque argument, en liste) ; s'arrête si elle échoue."""
    subprocess.run(commande, check=True)


CADENCE = 12


def assembler(video):
    """La vidéo à partir des images img_0001.png, img_0002.png… du dossier IMAGES."""
    lancer([FFMPEG, "-y", "-loglevel", "error",
            "-framerate", str(CADENCE),
            "-i", str(IMAGES / "img_%04d.png"),
            "-c:v", "libx264", "-pix_fmt", "yuv420p",
            str(video)])


def vider():
    """Repart d'un dossier d'images vide."""
    for ancien in IMAGES.glob("img_*.png"):
        ancien.unlink()
```

## 2 · Un panoramique : une fenêtre qui glisse

`-crop 800x450+X+Y` découpe une fenêtre de 800 × 450 pixels dont le coin haut
gauche est en (X, Y) ; `+repage` oublie la position d'origine. Une image par
valeur de X, de la gauche du tableau à sa droite : la fenêtre glisse.

```{code-cell} ipython3
lancer([MAGICK, str(VAGUE), "-crop", "800x450+0+300", "+repage", str(PRODUIT / "essai_crop.png")])
Image(str(PRODUIT / "essai_crop.png"))
```

```{code-cell} ipython3
vider()
NOMBRE = 60                            # images : cinq secondes à douze images par seconde
for i in range(NOMBRE):
    x = i * (2000 - 800) // (NOMBRE - 1)   # de 0 à 1 200 : la fenêtre reste dans l'image
    nom = "img_" + str(i + 1).zfill(4) + ".png"
    lancer([MAGICK, str(VAGUE), "-crop", "800x450+" + str(x) + "+300", "+repage", str(IMAGES / nom)])
print(NOMBRE, "images")
assembler(PRODUIT / "panoramique.mp4")
Video(str(PRODUIT / "panoramique.mp4"), embed=True, width=480)
```

## 3 · Un tourbillon : un angle qui augmente

`-swirl angle` tord l'image autour de son centre. Une image par angle, de 0
à 360 degrés, puis retour : le tableau se tord et se détord. L'image est
d'abord réduite à 500 pixels de large, pour que chaque `magick` soit rapide.

```{code-cell} ipython3
PETITE = PRODUIT / "vague_500.png"
lancer([MAGICK, str(VAGUE), "-resize", "500x", str(PETITE)])
lancer([MAGICK, str(PETITE), "-swirl", "180", str(PRODUIT / "essai_swirl.png")])
Image(str(PRODUIT / "essai_swirl.png"))
```

```{code-cell} ipython3
vider()
angles = []
for i in range(0, 361, 15):            # 0, 15, 30 … 360
    angles.append(i)
for i in range(345, -1, -15):          # puis 345, 330 … 0
    angles.append(i)

numero = 0
for angle in angles:
    numero = numero + 1
    nom = "img_" + str(numero).zfill(4) + ".png"
    lancer([MAGICK, str(PETITE), "-swirl", str(angle), str(IMAGES / nom)])
print(numero, "images")
assembler(PRODUIT / "tourbillon.mp4")
Video(str(PRODUIT / "tourbillon.mp4"), embed=True, width=480)
```

```{code-cell} ipython3
# Un GIF réduit, pour l'aperçu
commande = [MAGICK, "-delay", "8", "-loop", "0"]
for fichier in sorted(IMAGES.glob("img_*.png")):
    commande.append(str(fichier))
commande = commande + ["-resize", "60%", str(PRODUIT / "tourbillon.gif")]
lancer(commande)
Image(str(PRODUIT / "tourbillon.gif"))
```

## 4 · Aller plus loin

D'autres opérateurs d'ImageMagick prennent un paramètre et se prêtent au même
schéma, une image par valeur : `-wave 20x200` (une ondulation, amplitude et
longueur d'onde), `-modulate 100,100,H` (une rotation des couleurs, `H` de 0
à 200), `-implode 0.5`, `-blur 0x8`, `-rotate`. `magick a.png b.png -morph
20 img_%04d.png` fabrique en une commande vingt images intermédiaires entre
deux images. Documentation : <https://imagemagick.org/script/command-line-options.php>.

:::{admonition} À faire
Un zoom : une fenêtre `-crop` de plus en plus petite, centrée sur la vague,
puis `-resize 800x450!` pour que toutes les images aient la même taille.
:::
