---
title: Le Hareng saur, en images
subtitle: Un poème dessiné strophe par strophe par ImageMagick, monté en vidéo par ffmpeg
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Le Hareng saur, en images

Ce notebook fabrique une courte vidéo qui illustre *Le Hareng saur* de
Charles Cros (1873, domaine public) : une image par strophe, dessinée par
ImageMagick avec des formes simples, le texte de la strophe écrit dessous ;
puis ffmpeg met les images à la suite. À la dernière strophe, le hareng se
balance.

1. Les outils : ImageMagick, ffmpeg, une police.
2. Une image dessinée par une commande.
3. Le texte sur l'image.
4. Une fonction qui fait les deux.
5. Les sept strophes.
6. Des images à la vidéo.
7. Le hareng se balance.

Ce que le notebook fabrique va dans `produit/hareng/`.

## 1 · Les outils

ImageMagick (`magick`) dessine et écrit du texte dans une image ; ffmpeg met
des images à la suite en vidéo. Ce sont des programmes : Python les lance par
`subprocess.run`, comme pandoc au cours 3. Le texte a besoin d'un fichier de
police : `arial.ttf` sur un poste Windows.

```{code-cell} ipython3
import math
import shutil
import subprocess
from pathlib import Path

from IPython.display import Image, Video

MAGICK = "magick"        # sur les postes de la salle : le chemin de magick.exe
FFMPEG = "ffmpeg"

# La police : un fichier .ttf du poste
POLICES = ["C:/Windows/Fonts/arial.ttf",
           "/usr/share/fonts/truetype/dejavu/DejaVuSerif.ttf"]
POLICE = None
for candidate in POLICES:
    if Path(candidate).exists():
        POLICE = candidate
print("police :", POLICE)

PRODUIT = Path("produit") / "hareng"
IMAGES = PRODUIT / "images"
IMAGES.mkdir(parents=True, exist_ok=True)
```

```{code-cell} ipython3
def lancer(commande):
    """Lance une commande (le programme, puis chaque argument, en liste) ; s'arrête si elle échoue."""
    subprocess.run(commande, check=True)


lancer([MAGICK, "-version"])
lancer([FFMPEG, "-version"])
```

## 2 · Une image dessinée par une commande

`magick -size 640x480 xc:white -draw "…" fichier.png` crée une image blanche
de 640 × 480 pixels et y dessine ce que dit la chaîne après `-draw` : une
couleur de remplissage (`fill`), une couleur de trait (`stroke`), puis une
forme avec ses coordonnées en pixels, l'origine en haut à gauche. Documentation
des formes : <https://imagemagick.org/Usage/draw/>.

```{code-cell} ipython3
MUR = "fill #ece6d4 stroke #555555 stroke-width 3 rectangle 60,30 580,370"

lancer([MAGICK, "-size", "640x480", "xc:white",
        "-draw", MUR,
        str(PRODUIT / "essai_mur.png")])
Image(str(PRODUIT / "essai_mur.png"))
```

Plusieurs `-draw` se suivent : chacun dessine par-dessus les précédents.
Une chaîne peut contenir plusieurs formes.

```{code-cell} ipython3
ECHELLE = ("fill none stroke #8a5a2b stroke-width 6 "
           "line 140,370 190,50  line 220,370 270,50 "          # les deux montants
           "line 150,300 230,300  line 160,240 240,240 "       # les barreaux
           "line 170,180 250,180  line 180,120 260,120")

lancer([MAGICK, "-size", "640x480", "xc:white",
        "-draw", MUR,
        "-draw", ECHELLE,
        str(PRODUIT / "essai_scene.png")])
Image(str(PRODUIT / "essai_scene.png"))
```

Le hareng est un dessin plus fin : un chemin, `path`, écrit avec les mêmes
lettres qu'un fichier SVG (`M` aller à un point, `L` tracer une ligne, `C`
une courbe, `Z` fermer). Il est dessiné la queue à l'origine, la tête vers la
droite, 146 pixels de long ; `translate x,y` le pose où on veut. Documentation
des chemins : <https://developer.mozilla.org/fr/docs/Web/SVG/Tutorial/Paths>.

```{code-cell} ipython3
HARENG = ("fill #c28a3c stroke #5a3a1a stroke-width 2 "
          "path 'M 0,0 L 24,-18 L 32,0 L 24,18 Z' "                                  # la queue
          "path 'M 28,0 C 58,-30 112,-30 146,0 C 112,30 58,30 28,0 Z' "                # le corps
          "fill #8a5a24 stroke none path 'M 40,-7 C 65,-24 105,-24 130,-8 C 105,-14 65,-14 40,-7 Z' "  # le dos
          "fill #c28a3c stroke #5a3a1a stroke-width 2 polygon 62,-21 84,-36 98,-22 "    # la nageoire
          "fill none stroke #5a3a1a stroke-width 2 path 'M 118,-14 Q 110,0 118,14' "    # l'ouïe
          "fill #ffffff stroke #5a3a1a stroke-width 1.5 circle 130,-5 130,0 "          # l'œil
          "fill #222222 stroke none circle 131,-5 131,-2.5")
HARENG_PAR_TERRE = "translate 390,334 " + HARENG

lancer([MAGICK, "-size", "640x480", "xc:white",
        "-draw", MUR,
        "-draw", ECHELLE,
        "-draw", HARENG_PAR_TERRE,
        str(PRODUIT / "essai_hareng.png")])
Image(str(PRODUIT / "essai_hareng.png"))
```

## 3 · Le texte sur l'image

`-annotate` écrit du texte. `-gravity South` le place en bas, centré ;
`+0+16` le décale de 16 pixels du bord ; `\n` dans la chaîne passe à la
ligne. La bande blanche en bas de l'image lui est réservée.

```{code-cell} ipython3
BANDE = "fill white stroke none rectangle 0,380 640,480"
STROPHE_1 = ("Il était un grand mur blanc ― nu, nu, nu,\n"
             "Contre le mur une échelle ― haute, haute, haute,\n"
             "Et, par terre, un hareng saur ― sec, sec, sec.")

lancer([MAGICK, "-size", "640x480", "xc:white",
        "-draw", MUR, "-draw", ECHELLE, "-draw", HARENG_PAR_TERRE, "-draw", BANDE,
        "-font", POLICE, "-pointsize", "19", "-fill", "#222222",
        "-gravity", "South", "-annotate", "+0+16", STROPHE_1,
        str(PRODUIT / "essai_texte.png")])
Image(str(PRODUIT / "essai_texte.png"))
```

## 4 · Une fonction qui fait les deux

La même commande, pour n'importe quelle liste de dessins et n'importe quel
texte : une fonction. Elle construit la liste des arguments morceau par
morceau, puis lance la commande.

```{code-cell} ipython3
def image(fichier, dessins, texte):
    """Une image 640 × 480 : les dessins dans l'ordre, la bande blanche, le texte en bas."""
    commande = [MAGICK, "-size", "640x480", "xc:white"]
    for dessin in dessins:
        commande.append("-draw")
        commande.append(dessin)
    commande.append("-draw")
    commande.append(BANDE)
    commande = commande + ["-font", POLICE, "-pointsize", "19", "-fill", "#222222",
                           "-gravity", "South", "-annotate", "+0+16", texte]
    commande.append(str(fichier))
    lancer(commande)


image(PRODUIT / "essai_fonction.png", [MUR, ECHELLE, HARENG_PAR_TERRE], STROPHE_1)
Image(str(PRODUIT / "essai_fonction.png"))
```

Le personnage : un rond et cinq traits, placés par rapport à un point
`(x, y)`, le centre de la tête. La fonction calcule les coordonnées et rend
la chaîne pour `-draw`.

```{code-cell} ipython3
def bonhomme(x, y):
    """Un personnage en traits, la tête centrée en (x, y)."""
    dessin = "fill none stroke #222222 stroke-width 3 "
    dessin = dessin + "circle " + str(x) + "," + str(y) + " " + str(x) + "," + str(y + 16) + " "   # la tête
    dessin = dessin + "line " + str(x) + "," + str(y + 16) + " " + str(x) + "," + str(y + 80) + " "  # le corps
    dessin = dessin + "line " + str(x) + "," + str(y + 30) + " " + str(x - 25) + "," + str(y + 60) + " "  # bras gauche
    dessin = dessin + "line " + str(x) + "," + str(y + 30) + " " + str(x + 25) + "," + str(y + 60) + " "  # bras droit
    dessin = dessin + "line " + str(x) + "," + str(y + 80) + " " + str(x - 18) + "," + str(y + 130) + " "  # jambe gauche
    dessin = dessin + "line " + str(x) + "," + str(y + 80) + " " + str(x + 18) + "," + str(y + 130)        # jambe droite
    return dessin


image(PRODUIT / "essai_bonhomme.png", [MUR, ECHELLE, HARENG_PAR_TERRE, bonhomme(330, 220)], STROPHE_1)
Image(str(PRODUIT / "essai_bonhomme.png"))
```

## 5 · Les sept strophes

Le poème, strophe par strophe, et pour chacune la liste des dessins : les
mêmes éléments, qui apparaissent ou se déplacent. Le clou, la ficelle et le
hareng pendu sont écrits comme le mur.

```{code-cell} ipython3
CLOU = "fill #333333 stroke none circle 420,60 420,66"
FICELLE = "fill none stroke #444444 stroke-width 2 line 420,60 420,180"
# Pendu par la queue : l'origine au bout de la ficelle, tourné de 90 degrés, la tête en bas
HARENG_PENDU = "translate 420,180 rotate 90 " + HARENG
MARTEAU = "fill #777777 stroke #333333 stroke-width 2 rectangle 355,268 385,282 line 370,282 370,320"
PELOTON = "fill #888888 stroke #444444 stroke-width 2 circle 300,300 300,312"

POEME = [
    ("Il était un grand mur blanc ― nu, nu, nu,\n"
     "Contre le mur une échelle ― haute, haute, haute,\n"
     "Et, par terre, un hareng saur ― sec, sec, sec.",
     [MUR, ECHELLE, HARENG_PAR_TERRE]),
    ("Il vient, tenant dans ses mains ― sales, sales, sales,\n"
     "Un marteau lourd, un grand clou ― pointu, pointu, pointu,\n"
     "Un peloton de ficelle ― gros, gros, gros.",
     [MUR, ECHELLE, HARENG_PAR_TERRE, bonhomme(330, 220), MARTEAU, PELOTON]),
    ("Alors il monte à l’échelle ― haute, haute, haute,\n"
     "Et plante le clou pointu ― toc, toc, toc,\n"
     "Tout en haut du grand mur nu ― nu, nu, nu.",
     [MUR, ECHELLE, HARENG_PAR_TERRE, bonhomme(232, 40), CLOU]),
    ("Il laisse aller le marteau ― qui tombe, qui tombe, qui tombe,\n"
     "Attache au clou la ficelle ― longue, longue, longue,\n"
     "Et, au bout, le hareng saur ― sec, sec, sec.",
     [MUR, ECHELLE, bonhomme(232, 40), CLOU, FICELLE, HARENG_PENDU]),
    ("Il redescend de l’échelle ― haute, haute, haute,\n"
     "L’emporte avec le marteau ― lourd, lourd, lourd ;\n"
     "Et puis, il s’en va ailleurs ― loin, loin, loin.",
     [MUR, CLOU, FICELLE, HARENG_PENDU, bonhomme(600, 220)]),
    ("Et, depuis, le hareng saur ― sec, sec, sec,\n"
     "Au bout de cette ficelle ― longue, longue, longue,\n"
     "Très lentement se balance ― toujours, toujours, toujours.",
     [MUR, CLOU, FICELLE, HARENG_PENDU]),
    ("J’ai composé cette histoire ― simple, simple, simple,\n"
     "Pour mettre en fureur les gens ― graves, graves, graves,\n"
     "Et amuser les enfants ― petits, petits, petits.",
     [MUR, CLOU, FICELLE, HARENG_PENDU]),
]
print(len(POEME), "strophes")
```

```{code-cell} ipython3
# Une image par strophe : strophe_1.png … strophe_7.png
numero = 0
for texte, dessins in POEME:
    numero = numero + 1
    image(PRODUIT / ("strophe_" + str(numero) + ".png"), dessins, texte)
    print("strophe", numero, "écrite")
```

```{code-cell} ipython3
Image(str(PRODUIT / "strophe_3.png"))
```

## 6 · Des images à la vidéo

ffmpeg lit une suite d'images numérotées, `img_0001.png`, `img_0002.png`, …,
et en fait une vidéo à une cadence donnée : `-framerate 8` affiche huit
images par seconde. Pour qu'une strophe reste trois secondes à l'écran, son
image est copiée 24 fois. Documentation : <https://ffmpeg.org/ffmpeg.html> ;
`-c:v libx264` et `-pix_fmt yuv420p` donnent un fichier `.mp4` que tous les
lecteurs ouvrent.

```{code-cell} ipython3
CADENCE = 8                  # images par seconde
DUREE_STROPHE = 3            # secondes

compteur = 0                 # le numéro de la prochaine image de la vidéo


def ajouter_image(source):
    """Copie une image comme prochaine image de la vidéo, sous le nom img_0001.png, img_0002.png…"""
    global compteur
    compteur = compteur + 1
    nom = "img_" + str(compteur).zfill(4) + ".png"   # zfill : le numéro sur quatre chiffres
    shutil.copy(source, IMAGES / nom)
```

```{code-cell} ipython3
# On repart d'un dossier d'images vide
for ancien in IMAGES.glob("img_*.png"):
    ancien.unlink()
compteur = 0

for numero in range(1, 8):
    for repetition in range(CADENCE * DUREE_STROPHE):
        ajouter_image(PRODUIT / ("strophe_" + str(numero) + ".png"))
print(compteur, "images, soit", compteur / CADENCE, "secondes")
```

```{code-cell} ipython3
def assembler(video):
    """La vidéo à partir des images img_0001.png, img_0002.png… du dossier IMAGES."""
    lancer([FFMPEG, "-y", "-loglevel", "error",
            "-framerate", str(CADENCE),
            "-i", str(IMAGES / "img_%04d.png"),
            "-c:v", "libx264", "-pix_fmt", "yuv420p",
            str(video)])


assembler(PRODUIT / "hareng_fixe.mp4")
Video(str(PRODUIT / "hareng_fixe.mp4"), embed=True, width=480)
```

## 7 · Le hareng se balance

Une animation est une suite d'images qui diffèrent un peu. La ficelle et le
hareng tournent autour du clou d'un angle qui va et vient : `angle = 12 ×
sin(…)`. ImageMagick tourne un dessin par `translate` (déplacer l'origine sur
le clou) puis `rotate` ; la ficelle et le hareng sont alors dessinés par
rapport au clou. Les déplacements et rotations s'ajoutent : après la ficelle,
`translate 0,120 rotate 90` met l'origine à son bout et tourne le hareng,
tête en bas.

```{code-cell} ipython3
def hareng_qui_pend(angle):
    """La ficelle et le hareng, tournés de `angle` degrés autour du clou."""
    return ("translate 420,60 rotate " + str(angle) + " "
            "fill none stroke #444444 stroke-width 2 line 0,0 0,120 "
            "translate 0,120 rotate 90 " + HARENG)


image(PRODUIT / "essai_angle.png", [MUR, CLOU, hareng_qui_pend(12)], POEME[5][0])
Image(str(PRODUIT / "essai_angle.png"))
```

```{code-cell} ipython3
# Les cinq premières strophes fixes, puis les deux dernières avec le hareng qui se balance
for ancien in IMAGES.glob("img_*.png"):
    ancien.unlink()
compteur = 0

for numero in range(1, 6):
    for repetition in range(CADENCE * DUREE_STROPHE):
        ajouter_image(PRODUIT / ("strophe_" + str(numero) + ".png"))

PERIODE = 32                 # images pour un aller-retour : quatre secondes à huit images par seconde
for numero in (6, 7):
    texte = POEME[numero - 1][0]
    for i in range(2 * PERIODE):
        angle = 12 * math.sin(2 * math.pi * i / PERIODE)
        fichier = PRODUIT / "balance.png"
        image(fichier, [MUR, CLOU, hareng_qui_pend(angle)], texte)
        ajouter_image(fichier)
print(compteur, "images, soit", compteur / CADENCE, "secondes")
```

```{code-cell} ipython3
assembler(PRODUIT / "hareng.mp4")
Video(str(PRODUIT / "hareng.mp4"), embed=True, width=480)
```

Un GIF de la fin, pour l'aperçu : ImageMagick sait aussi assembler des
images, en GIF animé ; `-delay 12` est le temps entre deux images en
centièmes de seconde, `-resize 50%` réduit le fichier.

```{code-cell} ipython3
dernieres = sorted(IMAGES.glob("img_*.png"))[-PERIODE:]
commande = [MAGICK, "-delay", "12", "-loop", "0"]
for fichier in dernieres:
    commande.append(str(fichier))
commande = commande + ["-resize", "50%", str(PRODUIT / "hareng_fin.gif")]
lancer(commande)
Image(str(PRODUIT / "hareng_fin.gif"))
```

:::{admonition} À faire
Changer les couleurs du mur ou du hareng, faire tomber le marteau à la
quatrième strophe (une image par position, `y` qui augmente), ou faire sortir
le personnage du cadre pas à pas à la cinquième.
:::
