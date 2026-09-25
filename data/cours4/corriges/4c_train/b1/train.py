"""La fenêtre du train : une image, une série d'images ou une vidéo.

Le décalage du paysage est calculé par Python, chaque image composée par
ImageMagick, la vidéo assemblée par ffmpeg.

    python train.py --decalage 200
    python train.py --images 120
    python train.py --images 120 --video --cadence 12 --nettoyer
    python train.py --help

À lancer dans l'environnement `animation` ; le décor est lu dans `decor/`,
les fichiers sont écrits dans `sortie/`, dans le dossier du terminal.
"""

import argparse
import subprocess
from pathlib import Path

# Les programmes
MAGICK = "magick"
FFMPEG = "ffmpeg"

# Les fichiers produits vont dans sortie/, dans le dossier du terminal
SORTIE = Path.cwd() / "sortie"
IMAGES = SORTIE / "images"


# ---- Une image (sections 2 à 4 du notebook) ---------------------------------


def lancer(commande):
    """Lance une commande (le programme, puis chaque argument) ; s'arrête si elle échoue."""
    subprocess.run(commande, check=True)


def image(fichier, decor, decalage):
    """Une image 640 × 480 : le fond, le plan décalé de `decalage` pixels vers la droite, puis la fenêtre."""
    commande = [MAGICK, str(decor / "fond.png"),
                "(", str(decor / "plan.png"), "-roll", "+" + str(decalage) + "+0",
                "-crop", "640x480+0+0", "+repage", ")", "-composite",
                str(decor / "fenetre.png"), "-composite"]
    commande.append(str(fichier))
    lancer(commande)


# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La fenêtre du train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("-d", "--decalage", type=int, default=0, help="le décalage du paysage d'une image seule, en pixels (défaut : 0)")
    analyseur.add_argument("--decor", default="decor", help="le dossier des images du décor (défaut : decor)")
    options = analyseur.parse_args()
    decor = Path(options.decor)
    if not (decor / "plan.png").exists():
        analyseur.error("décor introuvable : " + options.decor)
    SORTIE.mkdir(exist_ok=True)

    # Une image
    fichier = SORTIE / ("train_" + str(options.decalage).zfill(4) + ".png")
    image(fichier, decor, options.decalage)
    print(fichier)


# Vrai quand le fichier est lancé par `python`, faux quand il est importé par
# un autre fichier : dans ce cas, main() n'est pas appelé.
if __name__ == "__main__":
    main()
