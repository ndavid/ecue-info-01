"""Vérifie que la version boucle et la version numpy d'un effet donnent la même image.

    python test_effet.py

À copier dans le dossier du projet, à côté de train.py ; doit afficher `True`
sur chaque ligne.
"""
from pathlib import Path

import numpy as np

import train

# Une image au hasard, de la taille des images de la série
image = np.random.default_rng(0).integers(0, 256, size=(480, 640, 3), dtype=np.uint8)

for numero in [1, 2, 50]:
    print("poteaux", numero, np.array_equal(train.poteaux_boucle(image, numero), train.poteaux_numpy(image, numero)))

# Second temps, la parallaxe : enlever le # devant les trois lignes suivantes.
# train.charger(Path("decor"))
# for numero in [1, 2, 50]:
#     print("parallaxe", numero, np.array_equal(train.parallaxe_boucle(image, numero), train.parallaxe_numpy(image, numero)))
