"""La Vague en tourbillon : une image tordue, une série d'images ou une vidéo.

L'angle de torsion est calculé par Python, l'image tordue par ImageMagick,
la vidéo assemblée par ffmpeg.

    python tourbillon.py vague.jpg --angle 90
    python tourbillon.py vague.jpg --maximum 360
    python tourbillon.py vague.jpg --maximum 360 --video --cadence 12 --nettoyer
    python tourbillon.py --help

À lancer dans l'environnement `animation` ; les fichiers sont écrits dans
`sortie/`, dans le dossier du terminal.
"""

import argparse
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


def lancer(commande):
    """Lance une commande (le programme, puis chaque argument) ; s'arrête si elle échoue."""
    subprocess.run(commande, check=True)


def reduire(source, petite):
    """Une copie de l'image, réduite à 640 pixels de large."""
    lancer([MAGICK, str(source), "-resize", "640x", str(petite)])


def image(fichier, source, angle, texte):
    """Une image 640 × 480 : la source tordue de `angle` degrés, puis le texte en bas."""
    commande = [MAGICK, str(source), "-swirl", str(angle),
                "-background", "#fbf7ee", "-gravity", "North", "-extent", "640x480",
                "-font", POLICE, "-pointsize", "22", "-fill", "#333333",
                "-gravity", "South", "-annotate", "+0+14", texte]
    commande.append(str(fichier))
    lancer(commande)


def texte_angle(nom, angle):
    """Le texte sous l'image : le nom du fichier et l'angle."""
    return nom + " · tourbillon : " + str(angle) + "°"


# ---- Une série d'images (sections 5 et 6 du notebook) -----------------------

PAS = 15              # l'écart entre deux angles, en degrés


def angles(maximum, pas):
    """Les angles de 0 à `maximum`, puis de retour à 0, de `pas` en `pas` degrés."""
    liste = []
    for angle in range(0, maximum + 1, pas):        # 0, 15, 30 … maximum
        liste.append(angle)
    for angle in range(maximum - pas, -1, -pas):    # puis retour à 0
        liste.append(angle)
    return liste


def serie(petite, nom, maximum):
    """Une image par angle, de 0 à `maximum` puis retour, dans IMAGES ; renvoie le nombre d'images."""
    IMAGES.mkdir(parents=True, exist_ok=True)
    for ancienne in IMAGES.glob("img_*.png"):
        ancienne.unlink()
    liste = angles(maximum, PAS)
    numero = 0
    for angle in liste:
        numero = numero + 1
        fichier = IMAGES / ("img_" + str(numero).zfill(4) + ".png")
        image(fichier, petite, angle, texte_angle(nom, angle))
    return len(liste)


# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="Tord une image en tourbillon : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("image", help="l'image à tordre")
    analyseur.add_argument("-a", "--angle", type=int, default=90, help="l'angle de torsion d'une image seule, en degrés (défaut : 90)")
    analyseur.add_argument("-m", "--maximum", type=int, help="une série : de 0 à cet angle, puis retour à 0, de 15 en 15 degrés")
    options = analyseur.parse_args()
    source = Path(options.image)
    if not source.exists():
        analyseur.error("image introuvable : " + options.image)
    SORTIE.mkdir(exist_ok=True)
    petite = SORTIE / "petite.png"
    reduire(source, petite)

    if options.maximum is None:
        # Une image
        fichier = SORTIE / ("tourbillon_" + str(options.angle).zfill(3) + ".png")
        image(fichier, petite, options.angle, texte_angle(source.name, options.angle))
        print(fichier)
    else:
        # Une série d'images
        nombre = serie(petite, source.name, options.maximum)
        print(nombre, "images dans", IMAGES)


# Vrai quand le fichier est lancé par `python`, faux quand il est importé par
# un autre fichier : dans ce cas, main() n'est pas appelé.
if __name__ == "__main__":
    main()
