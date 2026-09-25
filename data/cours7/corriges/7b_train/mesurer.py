"""Chronomètre la version boucle et la version numpy d'un effet, sur une image puis sur la série.

    python train.py --images 120      # d'abord : la série, sans effet
    python mesurer.py poteaux

À lancer dans le dossier du projet.
"""
import sys
import time
from pathlib import Path

import train

nom = sys.argv[1]
boucle = getattr(train, nom + "_boucle")
avec_numpy = getattr(train, nom + "_numpy")
if nom == "parallaxe":
    train.charger(Path("decor"))

fichiers = sorted(train.IMAGES.glob("img_*.png"))
images = [train.lire(fichier) for fichier in fichiers]

for version, effet in [("boucle", boucle), ("numpy", avec_numpy)]:
    debut = time.perf_counter()
    effet(images[0], 1)
    une = time.perf_counter() - debut
    debut = time.perf_counter()
    for numero, image in enumerate(images, start=1):
        effet(image, numero)
    serie = time.perf_counter() - debut
    print(f"{version:7} une image : {une:.4f} s   la série ({len(images)} images) : {serie:.2f} s")
