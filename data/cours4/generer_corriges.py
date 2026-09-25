"""Écrit les corrigés par étape des TD 4a (montre), 4b (tourbillon) et 4c (train).

Le programme de chaque TD grandit par fonctionnalités, une branche git par
fonctionnalité :

    B1  une image          le dessin d'une image, `main` et une première option
    B2  une série d'images une image par valeur du paramètre, dans sortie/images/
    B3  la vidéo           ffmpeg assemble la série ; --nettoyer supprime les images

Le code est écrit ici en morceaux, un par commit, et les trois TD ont les
mêmes morceaux : leurs étapes restent identiques, seules les fonctions de
dessin et les options changent. `version(nom, etat)` assemble le fichier tel
qu'il est après un commit donné ; `generer_guides.py` importe ce module pour
mettre le même code dans les guides.

    python data/cours4/generer_corriges.py

écrit `corriges/<td>/b1/`, `b2/`, `b3/` (le programme final) et `b5/src/`.
Les README et `pyproject.toml` de `b4/` et `b5/` sont écrits à la main.
Modifier le code ici, pas dans `corriges/`, puis relancer `generer_guides.py`.
"""
from pathlib import Path

CORRIGES = Path(__file__).resolve().parent / "corriges"

# Les états successifs du fichier, un par commit de code, dans l'ordre du TD.
ETATS = ["b1-dessin", "b1", "b2-fonctions", "b2", "b3-video", "b3"]

OUTILS = '''
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
'''

LANCER = '''

def lancer(commande):
    """Lance une commande (le programme, puis chaque argument) ; s'arrête si elle échoue."""
    subprocess.run(commande, check=True)
'''

ASSEMBLER = '''

# ---- La vidéo (section 6 du notebook, seconde cellule) ----------------------

def assembler(video, cadence):
    """La vidéo à partir des images img_0001.png, img_0002.png… du dossier IMAGES."""
    lancer([FFMPEG, "-y", "-loglevel", "error",
            "-framerate", str(cadence),
            "-i", str(IMAGES / "img_%04d.png"),
            "-c:v", "mpeg4", "-q:v", "3", "-pix_fmt", "yuv420p",
            str(video)])
'''

APPEL = '''

# Vrai quand le fichier est lancé par `python`, faux quand il est importé par
# un autre fichier : dans ce cas, main() n'est pas appelé.
if __name__ == "__main__":
    main()
'''

# ======================================================================= montre

M = {}
M["doc"] = '''"""La montre du Lapin blanc : une image, une série d'images ou une vidéo.

Les aiguilles sont placées par Python, l'image est dessinée par ImageMagick,
la vidéo assemblée par ffmpeg.

    python montre.py --heure 10:05
    python montre.py --heure 10:00 --minutes 120
    python montre.py --heure 10:00 --minutes 120 --video --cadence 12 --nettoyer
    python montre.py --help

À lancer dans l'environnement `animation` ; les fichiers sont écrits dans
`sortie/`, dans le dossier du terminal.
"""
'''
M["imports"] = '''import argparse
import math
import subprocess
from pathlib import Path
'''
M["dessin"] = '''

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
''' + LANCER + '''

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
    return CITATION + "\\n" + str(heures) + " h " + str(minutes).zfill(2)


def dessiner(fichier, heures, minutes):
    """L'image de la montre à cette heure : le cadran, les aiguilles, le Lapin et le texte."""
    dessins = [BOITIER, ANNEAU, graduations(), CHIFFRES, aiguilles(heures, minutes), LAPIN]
    image(fichier, dessins, texte_heure(heures, minutes))
'''
M["options"] = '''

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
'''
M["serie"] = '''

# ---- Une série d'images (section 6 du notebook, première cellule) -----------

def serie(heures, minutes, nombre):
    """Une image par minute à partir de cette heure, dans IMAGES ; renvoie le nombre d'images."""
    IMAGES.mkdir(parents=True, exist_ok=True)
    for ancienne in IMAGES.glob("img_*.png"):
        ancienne.unlink()
    for t in range(nombre):                     # t : les minutes écoulées depuis la première image
        total = heures * 60 + minutes + t       # les minutes écoulées depuis 0 h 00
        h = (total // 60 - 1) % 12 + 1          # l'heure, de 1 à 12
        m = total % 60
        nom = "img_" + str(t + 1).zfill(4) + ".png"
        dessiner(IMAGES / nom, h, m)
    return nombre
'''
M["nettoyer"] = '''

def nettoyer():
    """Supprime les fichiers intermédiaires : le dossier des images de la série."""
    shutil.rmtree(IMAGES)
'''
M["main-b1"] = '''

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
'''
M["main-b2"] = '''

# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La montre du Lapin blanc : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--heure", type=lire_heure, default="10:00", help="l'heure de la montre, sous la forme 10:05 (défaut : 10:00)")
    analyseur.add_argument("-m", "--minutes", type=int, help="une série : une image par minute, pendant ce nombre de minutes")
    options = analyseur.parse_args()
    heures, minutes = options.heure
    SORTIE.mkdir(exist_ok=True)

    if options.minutes is None:
        # Une image
        fichier = SORTIE / ("montre_" + str(heures).zfill(2) + str(minutes).zfill(2) + ".png")
        dessiner(fichier, heures, minutes)
        print(fichier)
    else:
        # Une série d'images
        nombre = serie(heures, minutes, options.minutes)
        print(nombre, "images dans", IMAGES)
'''
M["main-b3-video"] = '''

# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La montre du Lapin blanc : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--heure", type=lire_heure, default="10:00", help="l'heure de la montre, sous la forme 10:05 (défaut : 10:00)")
    analyseur.add_argument("-m", "--minutes", type=int, help="une série : une image par minute, pendant ce nombre de minutes")
    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --minutes)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    options = analyseur.parse_args()
    heures, minutes = options.heure
    if options.video and options.minutes is None:
        analyseur.error("--video demande une série : ajouter --minutes")
    SORTIE.mkdir(exist_ok=True)

    if options.minutes is None:
        # Une image
        fichier = SORTIE / ("montre_" + str(heures).zfill(2) + str(minutes).zfill(2) + ".png")
        dessiner(fichier, heures, minutes)
        print(fichier)
    else:
        # Une série d'images
        nombre = serie(heures, minutes, options.minutes)
        print(nombre, "images dans", IMAGES)
        # La vidéo
        if options.video:
            video = SORTIE / "montre.mp4"
            assembler(video, options.cadence)
            print(video, ":", nombre, "images à", options.cadence, "images par seconde")
'''
M["main-b3"] = '''

# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La montre du Lapin blanc : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("--heure", type=lire_heure, default="10:00", help="l'heure de la montre, sous la forme 10:05 (défaut : 10:00)")
    analyseur.add_argument("-m", "--minutes", type=int, help="une série : une image par minute, pendant ce nombre de minutes")
    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --minutes)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    analyseur.add_argument("--nettoyer", action="store_true", help="supprime les images de la série une fois la vidéo écrite")
    options = analyseur.parse_args()
    heures, minutes = options.heure
    if options.video and options.minutes is None:
        analyseur.error("--video demande une série : ajouter --minutes")
    SORTIE.mkdir(exist_ok=True)

    if options.minutes is None:
        # Une image
        fichier = SORTIE / ("montre_" + str(heures).zfill(2) + str(minutes).zfill(2) + ".png")
        dessiner(fichier, heures, minutes)
        print(fichier)
    else:
        # Une série d'images
        nombre = serie(heures, minutes, options.minutes)
        print(nombre, "images dans", IMAGES)
        # La vidéo, puis les fichiers intermédiaires supprimés si demandé
        if options.video:
            video = SORTIE / "montre.mp4"
            assembler(video, options.cadence)
            print(video, ":", nombre, "images à", options.cadence, "images par seconde")
            if options.nettoyer:
                nettoyer()
                print("images intermédiaires supprimées")
'''

# =================================================================== tourbillon

T = {}
T["doc"] = '''"""La Vague en tourbillon : une image tordue, une série d'images ou une vidéo.

L'angle de torsion est calculé par Python, l'image tordue par ImageMagick,
la vidéo assemblée par ffmpeg.

    python tourbillon.py vague.jpg --angle 90
    python tourbillon.py vague.jpg --maximum 360
    python tourbillon.py vague.jpg --maximum 360 --video --cadence 12 --nettoyer
    python tourbillon.py --help

À lancer dans l'environnement `animation` ; les fichiers sont écrits dans
`sortie/`, dans le dossier du terminal.
"""
'''
T["imports"] = '''import argparse
import subprocess
from pathlib import Path
'''
T["dessin"] = '''

# ---- Une image (sections 2 à 5 du notebook) ---------------------------------
''' + LANCER + '''

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
'''
T["options"] = ""
T["serie"] = '''

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
'''
T["nettoyer"] = '''

def nettoyer():
    """Supprime les fichiers intermédiaires : les images de la série et la copie réduite."""
    shutil.rmtree(IMAGES)
    (SORTIE / "petite.png").unlink()
'''
_T_DEBUT_MAIN = '''

# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="Tord une image en tourbillon : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("image", help="l'image à tordre")
    analyseur.add_argument("-a", "--angle", type=int, default=90, help="l'angle de torsion d'une image seule, en degrés (défaut : 90)")
'''
_T_SOURCE = '''    source = Path(options.image)
    if not source.exists():
        analyseur.error("image introuvable : " + options.image)
    SORTIE.mkdir(exist_ok=True)
    petite = SORTIE / "petite.png"
    reduire(source, petite)
'''
_T_UNE_IMAGE = '''fichier = SORTIE / ("tourbillon_" + str(options.angle).zfill(3) + ".png")
image(fichier, petite, options.angle, texte_angle(source.name, options.angle))
print(fichier)
'''


def _indenter(texte, n=1):
    lignes = []
    for ligne in texte.splitlines():
        lignes.append(("    " * n + ligne) if ligne.strip() else "")
    return "\n".join(lignes) + "\n"


T["main-b1"] = (_T_DEBUT_MAIN + '''    options = analyseur.parse_args()
''' + _T_SOURCE + '''
    # Une image
''' + _indenter(_T_UNE_IMAGE))
T["main-b2"] = (_T_DEBUT_MAIN + '''    analyseur.add_argument("-m", "--maximum", type=int, help="une série : de 0 à cet angle, puis retour à 0, de 15 en 15 degrés")
    options = analyseur.parse_args()
''' + _T_SOURCE + '''
    if options.maximum is None:
        # Une image
''' + _indenter(_T_UNE_IMAGE, 2) + '''    else:
        # Une série d'images
        nombre = serie(petite, source.name, options.maximum)
        print(nombre, "images dans", IMAGES)
''')
T["main-b3-video"] = (_T_DEBUT_MAIN + '''    analyseur.add_argument("-m", "--maximum", type=int, help="une série : de 0 à cet angle, puis retour à 0, de 15 en 15 degrés")
    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --maximum)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    options = analyseur.parse_args()
    if options.video and options.maximum is None:
        analyseur.error("--video demande une série : ajouter --maximum")
''' + _T_SOURCE + '''
    if options.maximum is None:
        # Une image
''' + _indenter(_T_UNE_IMAGE, 2) + '''    else:
        # Une série d'images
        nombre = serie(petite, source.name, options.maximum)
        print(nombre, "images dans", IMAGES)
        # La vidéo
        if options.video:
            video = SORTIE / "tourbillon.mp4"
            assembler(video, options.cadence)
            print(video, ":", nombre, "images à", options.cadence, "images par seconde")
''')
T["main-b3"] = (_T_DEBUT_MAIN + '''    analyseur.add_argument("-m", "--maximum", type=int, help="une série : de 0 à cet angle, puis retour à 0, de 15 en 15 degrés")
    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --maximum)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
    analyseur.add_argument("--nettoyer", action="store_true", help="supprime les images de la série une fois la vidéo écrite")
    options = analyseur.parse_args()
    if options.video and options.maximum is None:
        analyseur.error("--video demande une série : ajouter --maximum")
''' + _T_SOURCE + '''
    if options.maximum is None:
        # Une image
''' + _indenter(_T_UNE_IMAGE, 2) + '''    else:
        # Une série d'images
        nombre = serie(petite, source.name, options.maximum)
        print(nombre, "images dans", IMAGES)
        # La vidéo, puis les fichiers intermédiaires supprimés si demandé
        if options.video:
            video = SORTIE / "tourbillon.mp4"
            assembler(video, options.cadence)
            print(video, ":", nombre, "images à", options.cadence, "images par seconde")
            if options.nettoyer:
                nettoyer()
                print("images intermédiaires supprimées")
''')

# ======================================================================== train

F = {}
F["doc"] = '''"""La fenêtre du train : une image, une série d'images ou une vidéo.

Le décalage du paysage est calculé par Python, chaque image composée par
ImageMagick, la vidéo assemblée par ffmpeg.

    python train.py --decalage 200
    python train.py --images 120
    python train.py --images 120 --video --cadence 12 --nettoyer
    python train.py --help

À lancer dans l'environnement `animation` ; le décor est lu dans `decor/`,
les fichiers sont écrits dans `sortie/`, dans le dossier du terminal.
"""
'''
F["imports"] = '''import argparse
import subprocess
from pathlib import Path
'''
# Pas de texte sur les images : pas de police.
F["outils"] = '''
# Les programmes
MAGICK = "magick"
FFMPEG = "ffmpeg"

# Les fichiers produits vont dans sortie/, dans le dossier du terminal
SORTIE = Path.cwd() / "sortie"
IMAGES = SORTIE / "images"
'''
F["dessin"] = '''

# ---- Une image (sections 2 à 4 du notebook) ---------------------------------
''' + LANCER + '''

def image(fichier, decor, decalage):
    """Une image 640 × 480 : le fond, le plan décalé de `decalage` pixels vers la droite, puis la fenêtre."""
    commande = [MAGICK, str(decor / "fond.png"),
                "(", str(decor / "plan.png"), "-roll", "+" + str(decalage) + "+0",
                "-crop", "640x480+0+0", "+repage", ")", "-composite",
                str(decor / "fenetre.png"), "-composite"]
    commande.append(str(fichier))
    lancer(commande)
'''
F["options"] = ""
F["serie"] = '''

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
'''
F["nettoyer"] = '''

def nettoyer():
    """Supprime les fichiers intermédiaires : le dossier des images de la série."""
    shutil.rmtree(IMAGES)
'''
_F_DEBUT_MAIN = '''

# ---- Le programme ------------------------------------------------------------

def main():
    analyseur = argparse.ArgumentParser(description="La fenêtre du train : une image, une série d'images ou une vidéo.")
    analyseur.add_argument("-d", "--decalage", type=int, default=0, help="le décalage du paysage d'une image seule, en pixels (défaut : 0)")
    analyseur.add_argument("--decor", default="decor", help="le dossier des images du décor (défaut : decor)")
'''
_F_SERIE = '''    analyseur.add_argument("-n", "--images", type=int, help="une série : ce nombre d'images, le paysage décalé de 8 pixels de plus à chaque image")
'''
_F_DECOR = '''    decor = Path(options.decor)
    if not (decor / "plan.png").exists():
        analyseur.error("décor introuvable : " + options.decor)
    SORTIE.mkdir(exist_ok=True)
'''
_F_UNE_IMAGE = '''fichier = SORTIE / ("train_" + str(options.decalage).zfill(4) + ".png")
image(fichier, decor, options.decalage)
print(fichier)
'''
_F_VIDEO_OPTIONS = '''    analyseur.add_argument("--video", action="store_true", help="assemble la série en vidéo (avec --images)")
    analyseur.add_argument("-c", "--cadence", type=int, default=12, help="images par seconde de la vidéo (défaut : 12)")
'''
_F_VIDEO_ERREUR = '''    if options.video and options.images is None:
        analyseur.error("--video demande une série : ajouter --images")
'''
_F_SI_SERIE = '''
    if options.images is None:
        # Une image
''' + _indenter(_F_UNE_IMAGE, 2) + '''    else:
        # Une série d'images
        nombre = serie(decor, options.images)
        print(nombre, "images dans", IMAGES)
'''

F["main-b1"] = (_F_DEBUT_MAIN + '''    options = analyseur.parse_args()
''' + _F_DECOR + '''
    # Une image
''' + _indenter(_F_UNE_IMAGE))
F["main-b2"] = (_F_DEBUT_MAIN + _F_SERIE + '''    options = analyseur.parse_args()
''' + _F_DECOR + _F_SI_SERIE)
F["main-b3-video"] = (_F_DEBUT_MAIN + _F_SERIE + _F_VIDEO_OPTIONS + '''    options = analyseur.parse_args()
''' + _F_VIDEO_ERREUR + _F_DECOR + _F_SI_SERIE + '''        # La vidéo
        if options.video:
            video = SORTIE / "train.mp4"
            assembler(video, options.cadence)
            print(video, ":", nombre, "images à", options.cadence, "images par seconde")
''')
F["main-b3"] = (_F_DEBUT_MAIN + _F_SERIE + _F_VIDEO_OPTIONS + '''    analyseur.add_argument("--nettoyer", action="store_true", help="supprime les images de la série une fois la vidéo écrite")
    options = analyseur.parse_args()
''' + _F_VIDEO_ERREUR + _F_DECOR + _F_SI_SERIE + '''        # La vidéo, puis les fichiers intermédiaires supprimés si demandé
        if options.video:
            video = SORTIE / "train.mp4"
            assembler(video, options.cadence)
            print(video, ":", nombre, "images à", options.cadence, "images par seconde")
            if options.nettoyer:
                nettoyer()
                print("images intermédiaires supprimées")
''')

PIECES = {"montre": M, "tourbillon": T, "train": F}
TD = {"montre": "4a_montre", "tourbillon": "4b_tourbillon", "train": "4c_train"}


def version(nom, etat):
    """Le fichier `<nom>.py` tel qu'il est après le commit `etat` (voir ETATS)."""
    p = PIECES[nom]
    rang = ETATS.index(etat)
    imports = p["imports"]
    if rang >= ETATS.index("b3"):
        imports = imports.replace("import subprocess\n", "import shutil\nimport subprocess\n")
    texte = p["doc"] + "\n" + imports + p.get("outils", OUTILS) + p["dessin"]
    if rang >= ETATS.index("b1"):
        texte += p["options"]
    if rang >= ETATS.index("b2-fonctions"):
        texte += p["serie"]
    if rang >= ETATS.index("b3-video"):
        texte += ASSEMBLER
    if rang >= ETATS.index("b3"):
        texte += p["nettoyer"]
    if etat == "b1-dessin":
        return texte
    main = {"b1": "main-b1", "b2-fonctions": "main-b1", "b2": "main-b2",
            "b3-video": "main-b3-video", "b3": "main-b3"}[etat]
    return texte + p[main] + APPEL


def ecrire(chemin, texte):
    chemin.parent.mkdir(parents=True, exist_ok=True)
    chemin.write_text(texte, encoding="utf-8")


def main():
    for nom, td in TD.items():
        base = CORRIGES / td
        for etat in ("b1", "b2", "b3"):
            ecrire(base / etat / (nom + ".py"), version(nom, etat))
        ecrire(base / "b5" / "src" / (nom + ".py"), version(nom, "b3"))
        print("ok", td)


if __name__ == "__main__":
    main()
