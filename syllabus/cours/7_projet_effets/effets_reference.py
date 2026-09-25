"""Projet 7 — les effets, en boucle et avec numpy : implémentation de référence.

Les quatre effets communs aux TD 4a, 4b et 4c, puis deux effets écrits pour le
TD 4c (la fenêtre du train) : `poteaux`, qui s'applique aussi aux deux autres
TD, et `parallaxe`, qui demande le décor du TD 4c.

Sert à préparer le guide et le corrigé, et à mesurer les temps. Chaque effet
prend une image (tableau numpy de forme (hauteur, largeur, 3), type uint8) et
le numéro de l'image dans la série, et renvoie une nouvelle image de même forme.
Les calculs sont en entiers, pour que la version boucle et la version numpy
donnent exactement les mêmes octets (`np.array_equal`).

    python effets_reference.py            # égalité et temps sur une image 640 × 480
"""

import time

import numpy as np


# ---- Caméra thermique --------------------------------------------------------
# Le niveau de gris, puis une couleur lue dans une table de 256 couleurs.


def table_thermique():
    """256 couleurs : noir, bleu, violet, rouge, orange, jaune, blanc. Fournie aux élèves."""
    points = [(0, (0, 0, 0)), (40, (20, 0, 120)), (90, (120, 0, 160)),
              (140, (220, 30, 60)), (190, (255, 140, 0)), (230, (255, 230, 60)),
              (255, (255, 255, 255))]
    table = np.zeros((256, 3), dtype=np.uint8)
    for (a, couleur_a), (b, couleur_b) in zip(points, points[1:]):
        for valeur in range(a, b + 1):
            t = (valeur - a) / (b - a)
            table[valeur] = [round(couleur_a[k] + t * (couleur_b[k] - couleur_a[k])) for k in range(3)]
    return table


TABLE = table_thermique()


def thermique_boucle(image, numero):
    hauteur, largeur, _ = image.shape
    resultat = np.zeros_like(image)
    for y in range(hauteur):
        for x in range(largeur):
            r, v, b = int(image[y, x, 0]), int(image[y, x, 1]), int(image[y, x, 2])
            gris = (299 * r + 587 * v + 114 * b) // 1000
            resultat[y, x] = TABLE[gris]
    return resultat


def thermique_numpy(image, numero):
    rvb = image.astype(np.int32)
    gris = (299 * rvb[:, :, 0] + 587 * rvb[:, :, 1] + 114 * rvb[:, :, 2]) // 1000
    return TABLE[gris]


# ---- Glitch ------------------------------------------------------------------
# Le canal rouge décalé de k pixels vers la droite, le bleu vers la gauche ;
# k change d'une image à l'autre.


def decalage(numero):
    return 4 + (numero * 7) % 25


def glitch_boucle(image, numero):
    hauteur, largeur, _ = image.shape
    k = decalage(numero)
    resultat = np.zeros_like(image)
    for y in range(hauteur):
        for x in range(largeur):
            resultat[y, x, 0] = image[y, (x - k) % largeur, 0]
            resultat[y, x, 1] = image[y, x, 1]
            resultat[y, x, 2] = image[y, (x + k) % largeur, 2]
    return resultat


def glitch_numpy(image, numero):
    k = decalage(numero)
    resultat = image.copy()
    resultat[:, :, 0] = np.roll(image[:, :, 0], k, axis=1)
    resultat[:, :, 2] = np.roll(image[:, :, 2], -k, axis=1)
    return resultat


# ---- Pixel art ---------------------------------------------------------------
# Des blocs de N × N pixels, qui prennent la couleur de leur premier pixel ;
# quatre valeurs par canal (32, 96, 160, 224).

N = 8


def pixel_boucle(image, numero):
    hauteur, largeur, _ = image.shape
    resultat = np.zeros_like(image)
    for y in range(hauteur):
        for x in range(largeur):
            for c in range(3):
                valeur = int(image[y - y % N, x - x % N, c])
                resultat[y, x, c] = valeur // 64 * 64 + 32
    return resultat


def pixel_numpy(image, numero):
    hauteur, largeur, _ = image.shape
    petite = image[::N, ::N] // 64 * 64 + 32
    grande = np.repeat(np.repeat(petite, N, axis=0), N, axis=1)
    return grande[:hauteur, :largeur]


# ---- Vieux film --------------------------------------------------------------
# Sépia (chaque canal est une combinaison des trois), puis les bords assombris
# selon le carré de la distance au centre (Pythagore, sans racine).

SEPIA = [(393, 769, 189), (349, 686, 168), (272, 534, 131)]


def vieux_boucle(image, numero):
    hauteur, largeur, _ = image.shape
    cy, cx = hauteur // 2, largeur // 2
    d2max = cx * cx + cy * cy
    resultat = np.zeros_like(image)
    for y in range(hauteur):
        for x in range(largeur):
            r, v, b = int(image[y, x, 0]), int(image[y, x, 1]), int(image[y, x, 2])
            d2 = (x - cx) ** 2 + (y - cy) ** 2
            facteur = 1000 - 700 * d2 // d2max
            for c in range(3):
                a, bb, cc = SEPIA[c]
                valeur = min(255, (a * r + bb * v + cc * b) // 1000)
                resultat[y, x, c] = valeur * facteur // 1000
    return resultat


def vieux_numpy(image, numero):
    hauteur, largeur, _ = image.shape
    cy, cx = hauteur // 2, largeur // 2
    d2max = cx * cx + cy * cy
    y, x = np.ogrid[:hauteur, :largeur]
    d2 = (x - cx) ** 2 + (y - cy) ** 2
    facteur = 1000 - 700 * d2 // d2max
    rvb = image.astype(np.int32)
    resultat = np.zeros_like(image)
    for c in range(3):
        a, bb, cc = SEPIA[c]
        valeur = np.minimum(255, (a * rvb[:, :, 0] + bb * rvb[:, :, 1] + cc * rvb[:, :, 2]) // 1000)
        resultat[:, :, c] = valeur * facteur // 1000
    return resultat


# ---- Poteaux (TD 4c, mais s'applique aux trois TD) -----------------------------
# Des bandes verticales assombries, qui avancent très vite vers la droite :
# l'ombre des poteaux le long de la voie. La colonne x est dans une bande si
# (x - VITESSE_POTEAUX × numero) modulo ECART_POTEAUX est plus petit que
# LARGEUR_POTEAU ; chaque valeur y est multipliée par 6/10.

ECART_POTEAUX = 400
LARGEUR_POTEAU = 24
VITESSE_POTEAUX = 90


def poteaux_boucle(image, numero):
    hauteur, largeur, _ = image.shape
    resultat = image.copy()
    for y in range(hauteur):
        for x in range(largeur):
            if (x - VITESSE_POTEAUX * numero) % ECART_POTEAUX < LARGEUR_POTEAU:
                for c in range(3):
                    resultat[y, x, c] = int(image[y, x, c]) * 6 // 10
    return resultat


def poteaux_numpy(image, numero):
    largeur = image.shape[1]
    colonnes = (np.arange(largeur) - VITESSE_POTEAUX * numero) % ECART_POTEAUX < LARGEUR_POTEAU
    resultat = image.copy()
    # En uint8, 200 * 6 dépasse 255 et le résultat est faux : calcul en uint16.
    resultat[:, colonnes] = image[:, colonnes].astype(np.uint16) * 6 // 10
    return resultat


# ---- Parallaxe (TD 4c seulement) ----------------------------------------------
# Un second plan, la plage orange (bande RGBA de 1 920 pixels), décalé de
# VITESSE_PLAGE × numero pixels vers la droite, plus vite que le plan du TD 4c.
# Le pixel (y, x) prend la couleur du pixel (y, (x - d) modulo 1 920) de la
# plage si ce pixel est opaque et si (y, x) est dans la vitre de la fenêtre.
# DONNEES["plage"] : la bande (hauteur, 1 920, 4) ; DONNEES["vitre"] : un
# tableau de booléens (hauteur, largeur), vrai dans la vitre.

VITESSE_PLAGE = 16
DONNEES = {}


def parallaxe_boucle(image, numero):
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
    largeur = image.shape[1]
    decalee = np.roll(DONNEES["plage"], VITESSE_PLAGE * numero, axis=1)[:, :largeur]
    masque = DONNEES["vitre"] & (decalee[:, :, 3] > 0)
    resultat = image.copy()
    resultat[masque] = decalee[:, :, :3][masque]
    return resultat


def donnees_parallaxe_essai():
    """Une plage et une vitre au hasard, pour le test : alpha 0 ou 255, vitre à bords droits."""
    hasard = np.random.default_rng(1)
    plage = hasard.integers(0, 256, size=(480, 1920, 4), dtype=np.uint8)
    plage[:, :, 3] = np.where(plage[:, :, 3] > 127, 255, 0)
    vitre = np.zeros((480, 640), dtype=bool)
    vitre[30:450, 40:600] = True
    return plage, vitre


EFFETS = {
    "thermique": (thermique_boucle, thermique_numpy),
    "glitch": (glitch_boucle, glitch_numpy),
    "pixel": (pixel_boucle, pixel_numpy),
    "vieux": (vieux_boucle, vieux_numpy),
    "poteaux": (poteaux_boucle, poteaux_numpy),
    "parallaxe": (parallaxe_boucle, parallaxe_numpy),
}


if __name__ == "__main__":
    image = np.random.default_rng(0).integers(0, 256, size=(480, 640, 3), dtype=np.uint8)
    DONNEES["plage"], DONNEES["vitre"] = donnees_parallaxe_essai()
    for nom, (boucle, avec_numpy) in EFFETS.items():
        # Une petite image pour l'égalité ; pleine largeur pour les poteaux
        # (bandes espacées de 400 pixels), pleine taille pour la parallaxe
        # (la vitre et la plage font 480 pixels de haut).
        if nom == "parallaxe":
            petite = image
        elif nom == "poteaux":
            petite = image[:48].copy()
        else:
            petite = image[:48, :64].copy()
        egal = all(np.array_equal(boucle(petite, n), avec_numpy(petite, n)) for n in (1, 3, 50))
        debut = time.perf_counter()
        boucle(image, 3)
        milieu = time.perf_counter()
        for _ in range(10):
            avec_numpy(image, 3)
        fin = time.perf_counter()
        t_boucle, t_numpy = milieu - debut, (fin - milieu) / 10
        print(f"{nom:10} égalité : {egal}   boucle : {t_boucle:.2f} s   "
              f"numpy : {1000 * t_numpy:.1f} ms   rapport : {t_boucle / t_numpy:.0f}")
