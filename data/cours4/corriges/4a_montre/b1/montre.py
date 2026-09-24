"""La montre du Lapin blanc : une image, une série d'images ou une vidéo.

Les aiguilles sont placées par Python, l'image est dessinée par ImageMagick,
la vidéo assemblée par ffmpeg.

    python montre.py --heure 10:05
    python montre.py --heure 10:00 --minutes 120
    python montre.py --heure 10:00 --minutes 120 --video --cadence 12 --nettoyer
    python montre.py --help

À lancer dans l'environnement `animation` ; les fichiers sont écrits dans
`sortie/`, dans le dossier du terminal.
"""

import argparse
import math
import subprocess
from pathlib import Path

# Les programmes, et la police des textes
MAGICK = "magick"
FFMPEG = "ffmpeg"
POLICE = None
for candidate in ["C:/Windows/Fonts/arial.ttf", "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"]:
    if Path(candidate).exists():
        POLICE = candidate

# Les fichiers produits vont dans sortie/, dans le dossier du terminal
SORTIE = Path.cwd() / "sortie"
IMAGES = SORTIE / "images"


# ---- Une image (sections 2 à 5 du notebook) ---------------------------------

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
LAPIN = ("fill #ffffff stroke #666666 stroke-width 3 "
         "ellipse 95,110 16,60 0,360  ellipse 145,110 16,60 0,360 "
         "fill #f4b6c2 stroke none ellipse 95,110 7,42 0,360  ellipse 145,110 7,42 0,360 "
         "fill #ffffff stroke #666666 stroke-width 3 circle 120,205 120,255 "
         "fill #e8607a stroke none circle 103,198 103,206  circle 137,198 137,206 "
         "fill #f4b6c2 stroke none ellipse 120,222 6,4 0,360 "
         "fill none stroke #666666 stroke-width 2 "
         "line 65,226 113,222  line 65,240 113,226  line 127,222 175,226  line 127,226 175,240")
CITATION = "« Ah ! j’arriverai trop tard ! »"


def lancer(commande):
    """Lance une commande (le programme, puis chaque argument) ; s'arrête si elle échoue."""
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


def point(distance, angle_degres):
    """Le point à `distance` du centre du cadran, dans la direction `angle_degres` (0 en haut, 90 à droite)."""
    angle = math.radians(angle_degres)
    x = CX + distance * math.sin(angle)
    y = CY - distance * math.cos(angle)
    return str(round(x)) + "," + str(round(y))


def graduations():
    """Les soixante traits du bord du cadran, un tous les six degrés."""
    dessin = "fill none stroke #333333 stroke-width 2 "
    for k in range(60):
        angle = k * 6
        if k % 5 == 0:
            longueur = 14        # un trait long toutes les cinq minutes
        else:
            longueur = 6
        dessin = dessin + "line " + point(R - 6, angle) + " " + point(R - 6 - longueur, angle) + " "
    return dessin


def aiguilles(heures, minutes):
    """Les deux aiguilles pour cette heure, et l'axe au centre."""
    angle_heures = 30 * heures + 0.5 * minutes
    angle_minutes = 6 * minutes
    centre = str(CX) + "," + str(CY)
    return ("fill none stroke #222222 stroke-linecap round "
            "stroke-width 8 line " + centre + " " + point(80, angle_heures) + " "
            "stroke-width 5 line " + centre + " " + point(120, angle_minutes) + " "
            "fill #222222 stroke none circle " + centre + " " + str(CX) + "," + str(CY + 7))


def texte_heure(heures, minutes):
    """La citation, puis l'heure écrite « 10 h 05 »."""
    return CITATION + "\n" + str(heures) + " h " + str(minutes).zfill(2)


def dessiner(fichier, heures, minutes):
    """L'image de la montre à cette heure : le cadran, les aiguilles, le Lapin et le texte."""
    dessins = [BOITIER, ANNEAU, graduations(), CHIFFRES, aiguilles(heures, minutes), LAPIN]
    image(fichier, dessins, texte_heure(heures, minutes))


def lire_heure(texte):
    """L'heure écrite « 10:05 », en deux nombres : (10, 5). Sert de `type` à argparse."""
    morceaux = texte.split(":")
    if len(morceaux) != 2 or not morceaux[0].isdigit() or not morceaux[1].isdigit():
        raise argparse.ArgumentTypeError("heure attendue sous la forme 10:05 : " + texte)
    heures = int(morceaux[0])
    minutes = int(morceaux[1])
    if heures < 1 or heures > 12 or minutes > 59:
        raise argparse.ArgumentTypeError("heure attendue entre 1:00 et 12:59 : " + texte)
    return heures, minutes


# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La montre du Lapin blanc : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--heure", type=lire_heure, default="10:00", help="l'heure de la montre, sous la forme 10:05 (défaut : 10:00)")
    options = analyseur.parse_args()
    heures, minutes = options.heure
    SORTIE.mkdir(exist_ok=True)

    # Une image
    fichier = SORTIE / ("montre_" + str(heures).zfill(2) + str(minutes).zfill(2) + ".png")
    dessiner(fichier, heures, minutes)
    print(fichier)


# Vrai quand le fichier est lancé par `python`, faux quand il est importé par
# un autre fichier : dans ce cas, main() n'est pas appelé.
if __name__ == "__main__":
    main()
