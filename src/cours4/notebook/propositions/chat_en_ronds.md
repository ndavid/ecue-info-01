---
title: Un chat en ronds
subtitle: Un dessin construit forme par forme, une ligne de texte par forme, puis la queue qui bouge
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Un chat en ronds

Ce notebook fabrique une vidéo qui dessine un chat forme par forme, comme le
dit un texte de six lignes : à chaque ligne, une forme de plus sur l'image.
À la fin, la queue se balance. ImageMagick dessine, ffmpeg assemble.

1. Les outils.
2. Une forme par ligne de texte.
3. Les six images.
4. La vidéo.
5. La queue qui bouge.

Ce que le notebook fabrique va dans `produit/chat/`.

## 1 · Les outils

Les mêmes que pour le poème : ImageMagick dessine, ffmpeg assemble, une
police du poste écrit le texte, et Python lance les deux programmes par
`subprocess.run`.

```{code-cell} ipython3
import math
import shutil
import subprocess
from pathlib import Path

from IPython.display import Image, Video

MAGICK = "magick"        # sur les postes de la salle : le chemin de magick.exe
FFMPEG = "ffmpeg"

POLICES = ["C:/Windows/Fonts/arial.ttf",
           "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"]
POLICE = None
for candidate in POLICES:
    if Path(candidate).exists():
        POLICE = candidate
print("police :", POLICE)

PRODUIT = Path("produit") / "chat"
IMAGES = PRODUIT / "images"
IMAGES.mkdir(parents=True, exist_ok=True)


def lancer(commande):
    """Lance une commande (le programme, puis chaque argument, en liste) ; s'arrête si elle échoue."""
    subprocess.run(commande, check=True)


def image(fichier, dessins, texte):
    """Une image 480 × 640 : les dessins dans l'ordre, puis le texte en bas."""
    commande = [MAGICK, "-size", "480x640", "xc:#fbf7ee"]
    for dessin in dessins:
        commande.append("-draw")
        commande.append(dessin)
    commande = commande + ["-font", POLICE, "-pointsize", "22", "-fill", "#333333",
                           "-gravity", "South", "-annotate", "+0+22", texte]
    commande.append(str(fichier))
    lancer(commande)
```

## 2 · Une forme par ligne de texte

Le texte dit une forme par ligne. Chaque forme est une chaîne pour `-draw` :
`circle` prend le centre et un point du bord, `ellipse` le centre et les deux
rayons, `polygon` trois sommets, `line` deux points. Les coordonnées sont en
pixels ; la tête est centrée en (240, 200).

```{code-cell} ipython3
TETE = "fill #f2c078 stroke #6b4a1e stroke-width 4 circle 240,200 240,320"
YEUX = ("fill #ffffff stroke #6b4a1e stroke-width 3 circle 195,180 195,206  circle 285,180 285,206 "
        "fill #222222 stroke none circle 195,182 195,194  circle 285,182 285,194")
OREILLES = ("fill #f2c078 stroke #6b4a1e stroke-width 4 "
            "polygon 140,140 150,40 220,100  polygon 340,140 330,40 260,100")
NEZ = "fill #d96d6d stroke #6b4a1e stroke-width 2 circle 240,230 240,242"
MOUSTACHES = ("fill none stroke #6b4a1e stroke-width 3 "
              "line 205,235 110,215  line 205,245 110,245  line 205,255 110,275 "
              "line 275,235 370,215  line 275,245 370,245  line 275,255 370,275")
CORPS = "fill #f2c078 stroke #6b4a1e stroke-width 4 ellipse 240,430 90,110 0,360"
QUEUE = "fill none stroke #6b4a1e stroke-width 8 line 320,470 400,400"

TEXTE = [
    "Un grand rond : la tête.",
    "Deux petits ronds, un point dans chacun :\nles yeux.",
    "Deux triangles au-dessus : les oreilles.",
    "Un petit rond au milieu : le nez.",
    "Trois traits de chaque côté : les moustaches.",
    "Un grand ovale dessous, et un trait :\nle corps et la queue.",
]
FORMES = [TETE, YEUX, OREILLES, NEZ, MOUSTACHES, CORPS + " " + QUEUE]

image(PRODUIT / "essai.png", [TETE], TEXTE[0])
Image(str(PRODUIT / "essai.png"))
```

Le corps est dessiné en dernier dans le texte, mais il passe derrière la
tête sur l'image : l'ordre des `-draw` est l'ordre d'empilement. La fonction
suivante met le corps et la queue en premier quand ils sont là.

```{code-cell} ipython3
def dessins_jusqua(n):
    """Les formes des n premières lignes, le corps et la queue d'abord s'ils en font partie."""
    formes = FORMES[:n]
    if n == 6:
        formes = [CORPS, QUEUE] + FORMES[:5]
    return formes


image(PRODUIT / "essai_complet.png", dessins_jusqua(6), TEXTE[5])
Image(str(PRODUIT / "essai_complet.png"))
```

## 3 · Les six images

Une image par ligne : les formes des lignes précédentes, plus celle de la
ligne, et la ligne écrite dessous.

```{code-cell} ipython3
for n in range(1, 7):
    image(PRODUIT / ("etape_" + str(n) + ".png"), dessins_jusqua(n), TEXTE[n - 1])
    print("étape", n, "écrite")
Image(str(PRODUIT / "etape_3.png"))
```

## 4 · La vidéo

Comme pour le poème : les images copiées sous des noms numérotés, chacune
répétée pour durer deux secondes à huit images par seconde, puis ffmpeg.

```{code-cell} ipython3
CADENCE = 8
compteur = 0


def ajouter_image(source):
    """Copie une image comme prochaine image de la vidéo : img_0001.png, img_0002.png…"""
    global compteur
    compteur = compteur + 1
    shutil.copy(source, IMAGES / ("img_" + str(compteur).zfill(4) + ".png"))


def assembler(video):
    """La vidéo à partir des images img_0001.png, img_0002.png… du dossier IMAGES."""
    lancer([FFMPEG, "-y", "-loglevel", "error",
            "-framerate", str(CADENCE),
            "-i", str(IMAGES / "img_%04d.png"),
            "-c:v", "libx264", "-pix_fmt", "yuv420p",
            str(video)])


for ancien in IMAGES.glob("img_*.png"):
    ancien.unlink()
compteur = 0
for n in range(1, 7):
    for repetition in range(2 * CADENCE):
        ajouter_image(PRODUIT / ("etape_" + str(n) + ".png"))
assembler(PRODUIT / "chat_fixe.mp4")
Video(str(PRODUIT / "chat_fixe.mp4"), embed=True, width=360)
```

## 5 · La queue qui bouge

La queue est un trait qui part du corps ; elle tourne autour de son point
d'attache d'un angle qui va et vient. `translate` met l'origine sur le point
d'attache, `rotate` tourne, et le trait est écrit depuis l'origine.

```{code-cell} ipython3
def queue(angle):
    """La queue, tournée de `angle` degrés autour de son attache au corps."""
    return ("translate 320,470 rotate " + str(angle) + " "
            "fill none stroke #6b4a1e stroke-width 8 line 0,0 80,-70")


PERIODE = 24
for i in range(3 * PERIODE):
    angle = 20 * math.sin(2 * math.pi * i / PERIODE)
    fichier = PRODUIT / "queue.png"
    image(fichier, [CORPS, queue(angle)] + FORMES[:5], "Et le chat remue la queue.")
    ajouter_image(fichier)
assembler(PRODUIT / "chat.mp4")
Video(str(PRODUIT / "chat.mp4"), embed=True, width=360)
```

```{code-cell} ipython3
# Un GIF de la fin, réduit de moitié, pour l'aperçu
dernieres = sorted(IMAGES.glob("img_*.png"))[-PERIODE:]
commande = [MAGICK, "-delay", "12", "-loop", "0"]
for fichier in dernieres:
    commande.append(str(fichier))
commande = commande + ["-resize", "50%", str(PRODUIT / "chat_fin.gif")]
lancer(commande)
Image(str(PRODUIT / "chat_fin.gif"))
```

:::{admonition} À faire
Changer les couleurs, ajouter une bouche (`ellipse` ou `line`), faire cligner
les yeux (une image sur huit avec les yeux en traits), ou écrire son propre
texte et les formes qui vont avec.
:::
