"""La fenêtre du train : une image, une série d'images ou une vidéo, avec des effets.

Le décalage du paysage est calculé par Python, chaque image composée par
ImageMagick, la vidéo assemblée par ffmpeg. Les effets (projet 7) modifient
les images de la série avant la vidéo, avec numpy.

    python train.py --decalage 200
    python train.py --images 120
    python train.py --images 120 --video --cadence 12 --nettoyer
    python train.py --images 120 --effet parallaxe --effet poteaux --video
    python train.py --help

À lancer dans l'environnement `animation` ; le décor est lu dans `decor/`,
les fichiers sont écrits dans `sortie/`, dans le dossier du terminal.
"""

import argparse
import shutil
import subprocess
from pathlib import Path

import numpy as np
from PIL import Image

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


# ---- Une série d'images (sections 5 et 6 du notebook) -----------------------

VITESSE = 8           # le décalage de plus à chaque image, en pixels


def decalages(nombre, vitesse):
    """Le décalage de chaque image : 0, puis `vitesse` pixels de plus à chaque image."""
    liste = []
    for numero in range(nombre):
        liste.append(numero * vitesse)
    return liste


def serie(decor, nombre):
    """`nombre` images, le plan un peu plus décalé à chaque image, dans IMAGES ; renvoie le nombre d'images."""
    IMAGES.mkdir(parents=True, exist_ok=True)
    for ancienne in IMAGES.glob("img_*.png"):
        ancienne.unlink()
    liste = decalages(nombre, VITESSE)
    numero = 0
    for decalage in liste:
        numero = numero + 1
        fichier = IMAGES / ("img_" + str(numero).zfill(4) + ".png")
        image(fichier, decor, decalage)
    return len(liste)


# ---- La vidéo (section 6 du notebook, seconde cellule) ----------------------

def assembler(video, cadence):
    """La vidéo à partir des images img_0001.png, img_0002.png… du dossier IMAGES."""
    lancer([FFMPEG, "-y", "-loglevel", "error",
            "-framerate", str(cadence),
            "-i", str(IMAGES / "img_%04d.png"),
            "-c:v", "mpeg4", "-q:v", "3", "-pix_fmt", "yuv420p",
            str(video)])


def nettoyer():
    """Supprime les fichiers intermédiaires : le dossier des images de la série."""
    shutil.rmtree(IMAGES)


# ---- Les effets (projet 7) ---------------------------------------------------

def lire(fichier):
    """L'image du fichier, en tableau numpy (hauteur, largeur, 3) d'entiers de 0 à 255."""
    return np.asarray(Image.open(fichier).convert("RGB"))


def lire_rgba(fichier):
    """L'image du fichier avec sa transparence : un tableau (hauteur, largeur, 4)."""
    return np.asarray(Image.open(fichier).convert("RGBA"))


def ecrire(tableau, fichier):
    """Enregistre le tableau comme image ; le format suit l'extension du fichier."""
    Image.fromarray(tableau).save(fichier)


def appliquer(effet):
    """Applique l'effet à chaque image de la série, en remplaçant le fichier ; renvoie le nombre d'images."""
    fichiers = sorted(IMAGES.glob("img_*.png"))
    for numero, fichier in enumerate(fichiers, start=1):
        ecrire(effet(lire(fichier), numero), fichier)
    return len(fichiers)


# Les poteaux : des bandes sombres qui passent très vite vers la droite.
ECART_POTEAUX = 400       # pixels entre deux bandes
LARGEUR_POTEAU = 24       # largeur d'une bande, en pixels
VITESSE_POTEAUX = 90      # pixels par image


def poteaux_boucle(image, numero):
    """Les bandes des poteaux, pixel par pixel : chaque valeur multipliée par 6/10."""
    hauteur, largeur, _ = image.shape
    resultat = image.copy()
    for y in range(hauteur):
        for x in range(largeur):
            if (x - VITESSE_POTEAUX * numero) % ECART_POTEAUX < LARGEUR_POTEAU:
                for c in range(3):
                    resultat[y, x, c] = int(image[y, x, c]) * 6 // 10
    return resultat


def poteaux_numpy(image, numero):
    """Les bandes des poteaux, sur les colonnes entières."""
    largeur = image.shape[1]
    colonnes = (np.arange(largeur) - VITESSE_POTEAUX * numero) % ECART_POTEAUX < LARGEUR_POTEAU
    resultat = image.copy()
    resultat[:, colonnes] = image[:, colonnes].astype(np.uint16) * 6 // 10
    return resultat


# La parallaxe : la plage du premier plan, deux fois plus rapide que le plan.
VITESSE_PLAGE = 16        # pixels par image
DONNEES = {}              # rempli par charger : la plage et la vitre


def charger(decor):
    """Lit la plage (une bande RGBA) et la vitre (vrai là où la fenêtre est transparente)."""
    DONNEES["plage"] = lire_rgba(decor / "plage.png")
    DONNEES["vitre"] = lire_rgba(decor / "fenetre.png")[:, :, 3] == 0


def parallaxe_boucle(image, numero):
    """La plage décalée, pixel par pixel, dans la vitre seulement."""
    hauteur, largeur, _ = image.shape
    plage = DONNEES["plage"]
    vitre = DONNEES["vitre"]
    largeur_plage = plage.shape[1]
    d = VITESSE_PLAGE * numero
    resultat = image.copy()
    for y in range(hauteur):
        for x in range(largeur):
            xp = (x - d) % largeur_plage
            if vitre[y, x] and plage[y, xp, 3] > 0:
                resultat[y, x] = plage[y, xp, :3]
    return resultat


def parallaxe_numpy(image, numero):
    """La plage décalée par np.roll, posée avec un masque."""
    largeur = image.shape[1]
    decalee = np.roll(DONNEES["plage"], VITESSE_PLAGE * numero, axis=1)[:, :largeur]
    masque = DONNEES["vitre"] & (decalee[:, :, 3] > 0)
    resultat = image.copy()
    resultat[masque] = decalee[:, :, :3][masque]
    return resultat


EFFETS = {"poteaux": poteaux_numpy, "parallaxe": parallaxe_numpy}


# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La fenêtre du train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("-d", "--decalage", type=int, default=0, help="le décalage du paysage d'une image seule, en pixels (défaut : 0)")
    analyseur.add_argument("--decor", default="decor", help="le dossier des images du décor (défaut : decor)")
    analyseur.add_argument("-n", "--images", type=int, help="une série : ce nombre d'images, le paysage décalé de 8 pixels de plus à chaque image")
    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --images)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    analyseur.add_argument("--nettoyer", action="store_true", help="supprime les images de la série une fois la vidéo écrite")
    analyseur.add_argument("--effet", action="append", choices=sorted(EFFETS), help="un effet appliqué à chaque image de la série (option répétable)")
    options = analyseur.parse_args()
    if options.video and options.images is None:
        analyseur.error("--video demande une série : ajouter --images")
    decor = Path(options.decor)
    if not (decor / "plan.png").exists():
        analyseur.error("décor introuvable : " + options.decor)
    SORTIE.mkdir(exist_ok=True)

    if options.images is None:
        # Une image
        fichier = SORTIE / ("train_" + str(options.decalage).zfill(4) + ".png")
        image(fichier, decor, options.decalage)
        print(fichier)
    else:
        # Une série d'images
        nombre = serie(decor, options.images)
        print(nombre, "images dans", IMAGES)
        # Les effets, dans l'ordre de la ligne de commande
        if options.effet:
            if "parallaxe" in options.effet:
                charger(decor)
            for nom in options.effet:
                appliquer(EFFETS[nom])
                print("effet", nom, "appliqué")
        # La vidéo, puis les fichiers intermédiaires supprimés si demandé
        if options.video:
            video = SORTIE / "train.mp4"
            assembler(video, options.cadence)
            print(video, ":", nombre, "images à", options.cadence, "images par seconde")
            if options.nettoyer:
                nettoyer()
                print("images intermédiaires supprimées")


# Vrai quand le fichier est lancé par `python`, faux quand il est importé par
# un autre fichier : dans ce cas, main() n'est pas appelé.
if __name__ == "__main__":
    main()
