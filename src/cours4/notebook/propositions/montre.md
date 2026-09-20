---
title: La montre du Lapin blanc
subtitle: Un cadran dessiné par ImageMagick, des aiguilles placées par Python, une vidéo par ffmpeg
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# La montre du Lapin blanc

Ce notebook fabrique une vidéo d'une montre de gousset dont les aiguilles
tournent, à côté du Lapin blanc d'*Alice au pays des merveilles* (Lewis
Carroll, 1865 ; traduction d'Henri Bué, 1869, domaine public) : « Ah !
j'arriverai trop tard ! ». Python calcule où vont les aiguilles pour chaque
heure ; ImageMagick dessine ; ffmpeg assemble.

1. Les outils.
2. Le cadran : les graduations, calculées par Python.
3. Les aiguilles : un angle qui dépend de l'heure.
4. Le Lapin.
5. La vidéo : une image par minute.

Ce que le notebook fabrique va dans `produit/montre/`.

## 1 · Les outils

```{code-cell} ipython3
import math
import shutil
import subprocess
from pathlib import Path

from IPython.display import Image, Video

MAGICK = "magick"        # sur les postes de la salle : le chemin de magick.exe
FFMPEG = "ffmpeg"

POLICES = ["C:/Windows/Fonts/arial.ttf",
           "/usr/share/fonts/truetype/dejavu/DejaVuSerif.ttf"]
POLICE = None
for candidate in POLICES:
    if Path(candidate).exists():
        POLICE = candidate
print("police :", POLICE)

PRODUIT = Path("produit") / "montre"
IMAGES = PRODUIT / "images"
IMAGES.mkdir(parents=True, exist_ok=True)


def lancer(commande):
    """Lance une commande (le programme, puis chaque argument, en liste) ; s'arrête si elle échoue."""
    subprocess.run(commande, check=True)


def image(fichier, dessins, texte):
    """Une image 640 × 480 : les dessins dans l'ordre, puis le texte en bas."""
    commande = [MAGICK, "-size", "640x480", "xc:#fbf7ee", "-font", POLICE, "-pointsize", "26"]
    for dessin in dessins:
        commande.append("-draw")
        commande.append(dessin)
    commande = commande + ["-pointsize", "22", "-fill", "#333333",
                           "-gravity", "South", "-annotate", "+0+18", texte]
    commande.append(str(fichier))
    lancer(commande)
```

## 2 · Le cadran

Le centre du cadran est en (CX, CY), son rayon vaut R. Le boîtier est un
cercle, l'anneau un petit cercle et un rectangle au-dessus, les chiffres du
texte placé par `text x,y '12'`.

```{code-cell} ipython3
CX = 380
CY = 240
R = 150

BOITIER = ("fill #f7f1df stroke #7a5a1e stroke-width 8 "
           "circle " + str(CX) + "," + str(CY) + " " + str(CX) + "," + str(CY + R))
ANNEAU = ("fill #c9a227 stroke #7a5a1e stroke-width 3 "
          "circle " + str(CX) + "," + str(CY - R - 22) + " " + str(CX) + "," + str(CY - R - 8) + " "
          "rectangle " + str(CX - 10) + "," + str(CY - R - 12) + " " + str(CX + 10) + "," + str(CY - R + 4))
CHIFFRES = ("fill #333333 stroke none "
            "text " + str(CX - 14) + "," + str(CY - R + 42) + " '12' "
            "text " + str(CX + R - 44) + "," + str(CY + 9) + " '3' "
            "text " + str(CX - 8) + "," + str(CY + R - 26) + " '6' "
            "text " + str(CX - R + 30) + "," + str(CY + 9) + " '9'")

image(PRODUIT / "essai_cadran.png", [BOITIER, ANNEAU, CHIFFRES], "")
Image(str(PRODUIT / "essai_cadran.png"))
```

Les soixante graduations sont des traits sur le bord du cadran, un tous les
six degrés. Un point à la distance `d` du centre, dans la direction `angle`
(mesuré depuis le haut, dans le sens des aiguilles), est en
`(CX + d × sin(angle), CY − d × cos(angle))` ; Python fait ce calcul pour
chaque trait, et la chaîne pour `-draw` grandit à chaque tour de boucle.

```{code-cell} ipython3
def point(distance, angle_degres):
    """Le point à `distance` du centre du cadran, dans la direction `angle_degres` (0 en haut, 90 à droite)."""
    angle = math.radians(angle_degres)
    x = CX + distance * math.sin(angle)
    y = CY - distance * math.cos(angle)
    return str(round(x)) + "," + str(round(y))


graduations = "fill none stroke #333333 stroke-width 2 "
for k in range(60):
    angle = k * 6
    if k % 5 == 0:
        longueur = 14        # un trait long toutes les cinq minutes
    else:
        longueur = 6
    graduations = graduations + "line " + point(R - 6, angle) + " " + point(R - 6 - longueur, angle) + " "
GRADUATIONS = graduations

image(PRODUIT / "essai_graduations.png", [BOITIER, ANNEAU, GRADUATIONS, CHIFFRES], "")
Image(str(PRODUIT / "essai_graduations.png"))
```

## 3 · Les aiguilles

L'aiguille des minutes fait un tour en soixante minutes : six degrés par
minute. Celle des heures fait un tour en douze heures : trente degrés par
heure, plus un demi-degré par minute. Les deux partent du centre ; `point`
donne l'autre bout.

```{code-cell} ipython3
def aiguilles(heures, minutes):
    """Les deux aiguilles pour cette heure, et l'axe au centre."""
    angle_heures = 30 * heures + 0.5 * minutes
    angle_minutes = 6 * minutes
    centre = str(CX) + "," + str(CY)
    return ("fill none stroke #222222 stroke-linecap round "
            "stroke-width 8 line " + centre + " " + point(80, angle_heures) + " "
            "stroke-width 5 line " + centre + " " + point(120, angle_minutes) + " "
            "fill #222222 stroke none circle " + centre + " " + str(CX) + "," + str(CY + 7))


image(PRODUIT / "essai_aiguilles.png", [BOITIER, ANNEAU, GRADUATIONS, CHIFFRES, aiguilles(10, 5)], "10 h 05")
Image(str(PRODUIT / "essai_aiguilles.png"))
```

## 4 · Le Lapin

Un lapin blanc aux yeux roses, en formes simples : deux ellipses pour les
oreilles, un cercle pour la tête, deux petits cercles pour les yeux, des
traits pour les moustaches.

```{code-cell} ipython3
LAPIN = ("fill #ffffff stroke #666666 stroke-width 3 "
         "ellipse 95,110 16,60 0,360  ellipse 145,110 16,60 0,360 "          # les oreilles
         "fill #f4b6c2 stroke none ellipse 95,110 7,42 0,360  ellipse 145,110 7,42 0,360 "
         "fill #ffffff stroke #666666 stroke-width 3 circle 120,205 120,255 "  # la tête
         "fill #e8607a stroke none circle 103,198 103,206  circle 137,198 137,206 "  # les yeux roses
         "fill #f4b6c2 stroke none ellipse 120,222 6,4 0,360 "                 # le nez
         "fill none stroke #666666 stroke-width 2 "
         "line 65,226 113,222  line 65,240 113,226  line 127,222 175,226  line 127,226 175,240")

CITATION = "« Ah ! j’arriverai trop tard ! »"

image(PRODUIT / "essai_lapin.png", [BOITIER, ANNEAU, GRADUATIONS, CHIFFRES, aiguilles(10, 5), LAPIN], CITATION + "\n10 h 05")
Image(str(PRODUIT / "essai_lapin.png"))
```

## 5 · La vidéo : une image par minute

Une image par minute, de 10 h 00 à 12 h 00 : cent vingt images. À douze
images par seconde, la vidéo dure dix secondes, et la montre avance d'une
heure toutes les cinq secondes. L'heure est écrite sous la citation.

```{code-cell} ipython3
CADENCE = 12

for ancien in IMAGES.glob("img_*.png"):
    ancien.unlink()

compteur = 0
for t in range(120):                 # t : les minutes écoulées depuis 10 h 00
    heures = 10 + t // 60
    minutes = t % 60
    texte = CITATION + "\n" + str(heures) + " h " + str(minutes).zfill(2)
    compteur = compteur + 1
    nom = "img_" + str(compteur).zfill(4) + ".png"
    image(IMAGES / nom, [BOITIER, ANNEAU, GRADUATIONS, CHIFFRES, aiguilles(heures, minutes), LAPIN], texte)
print(compteur, "images")
```

```{code-cell} ipython3
lancer([FFMPEG, "-y", "-loglevel", "error",
        "-framerate", str(CADENCE),
        "-i", str(IMAGES / "img_%04d.png"),
        "-c:v", "libx264", "-pix_fmt", "yuv420p",
        str(PRODUIT / "montre.mp4")])
Video(str(PRODUIT / "montre.mp4"), embed=True, width=480)
```

```{code-cell} ipython3
# Un GIF de la première heure, réduit, pour l'aperçu
commande = [MAGICK, "-delay", "8", "-loop", "0"]
for fichier in sorted(IMAGES.glob("img_*.png"))[:60]:
    commande.append(str(fichier))
commande = commande + ["-resize", "50%", str(PRODUIT / "montre.gif")]
lancer(commande)
Image(str(PRODUIT / "montre.gif"))
```

:::{admonition} À faire
Ajouter une trotteuse (une image par seconde, une aiguille fine qui fait un
tour par minute) ; faire courir le Lapin : sa position `x` augmente d'une
image à l'autre, jusqu'à sortir du cadre.
:::
