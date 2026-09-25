"""Fabrique les fichiers des TD du cours 4 : la montre (4a), le tourbillon (4b) et le train (4c).

Le dépôt versionne ce que chaque TD livre tel quel (`depart/environment.yml`,
`depart/modeles/`) et les corrigés (`corriges/`). `build` remplit le
`produit/` de chaque TD : le dossier `travail/` vide et, pour le tourbillon,
l'image de départ, reprise du cours 3 ; pour le train, les images du décor,
dessinées ici.

    python make_data.py build           # produit/ des trois TD
    python make_data.py illustrations   # les images des schémas, dans illustrations/cours4/

À lancer après `python make_data.py build` du cours 3, qui fabrique
`vague.jpg`. Le notebook de chaque TD est posé dans `produit/depart/notebook/`
par `outils/construire_notebooks.py`.
"""

from __future__ import annotations

import argparse
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ICI = Path(__file__).parent
TD_MONTRE = ICI / "4a_montre"
TD_TOURBILLON = ICI / "4b_tourbillon"
TD_TRAIN = ICI / "4c_train"
VAGUE = ICI.parent / "cours3" / "2b_images" / "produit" / "depart" / "vague.jpg"
DEPOT = ICI.parent.parent
ILLUSTRATIONS = DEPOT / "illustrations" / "cours4"
SCHEMA = DEPOT / "src" / "cours4" / "diapo" / "schema_programme.typ"

# Les images de la vidéo montrées dans les schémas : cinq par TD, prises dans
# la série d'images du programme final (corrigé de l'étape B3).
VIGNETTES = {
    "montre": (["--heure", "10:00", "--minutes", "120"], [1, 31, 61, 91, 120]),
    "tourbillon": (["vague.jpg", "--maximum", "360"], [1, 7, 13, 19, 25]),
    "train": (["--images", "120"], [1, 31, 61, 91, 120]),
}
DOSSIERS_TD = {"montre": TD_MONTRE, "tourbillon": TD_TOURBILLON, "train": TD_TRAIN}

CREDITS = (
    "# Image\n\n"
    "- `vague.jpg` : Katsushika Hokusai, *Under the Wave off Kanagawa*, "
    "The Metropolitan Museum of Art, open access (CC0), "
    "<https://www.metmuseum.org/art/collection/search/45434>\n"
)

CREDITS_TRAIN = (
    "# Décor\n\n"
    "Les images de `decor/` sont dessinées par `make_data.py` (ImageMagick, "
    "des polygones de couleur unie), d'après la scène de la mer du clip "
    "« Moon » de Kid Francescoli, réalisé par le collectif Cauboyz (2017). "
    "Le clip a été tourné avec des décors en carton posés sur une table "
    "tournante : <https://www.youtube.com/watch?v=fdixQDPA2h0>.\n"
)


def vider(produit: Path) -> None:
    """Repart d'un `produit/` vide : rien de ce qu'un essai y a laissé ne part."""
    if produit.exists():
        for ancien in produit.iterdir():
            if ancien.name != ".gitkeep":
                shutil.rmtree(ancien) if ancien.is_dir() else ancien.unlink()
    produit.mkdir(parents=True, exist_ok=True)


def build() -> None:
    # TD 4a : aucune donnée, le dessin est calculé.
    produit = TD_MONTRE / "produit"
    vider(produit)
    (produit / "travail").mkdir()
    schemas(produit / "depart" / "notebook", "montre")
    print(f"✓ {TD_MONTRE.name}/produit/")

    # TD 4b : l'image de départ, celle du cours 3.
    produit = TD_TOURBILLON / "produit"
    vider(produit)
    (produit / "travail").mkdir()
    depart = produit / "depart"
    depart.mkdir()
    if VAGUE.exists():
        shutil.copy(VAGUE, depart / "vague.jpg")
    else:
        print(f"! {VAGUE} absent — lancer `make_data.py build` du cours 3")
    (depart / "CREDITS.md").write_text(CREDITS, encoding="utf-8")
    schemas(depart / "notebook", "tourbillon")
    print(f"✓ {TD_TOURBILLON.name}/produit/depart/")

    # TD 4c : le décor, dessiné ici.
    produit = TD_TRAIN / "produit"
    vider(produit)
    (produit / "travail").mkdir()
    depart = produit / "depart"
    decor_train(depart / "decor")
    (depart / "CREDITS.md").write_text(CREDITS_TRAIN, encoding="utf-8")
    schemas(depart / "notebook", "train")
    print(f"✓ {TD_TRAIN.name}/produit/depart/")


# ---- TD 4c : le décor de la fenêtre du train -----------------------------------
#
# Quatre images en aplats de couleur, d'après le clip « Moon » de Kid
# Francescoli (Cauboyz, 2017) : la scène de la mer, de jour, vue d'un train.
# Coordonnées écrites à la main, pour que chaque exécution donne les mêmes
# fichiers. Les bandes de 1920 pixels se raccordent d'un bord à l'autre : leur
# premier et leur dernier point sont à la même hauteur.

LARGEUR_BANDE = 1920
HORIZON = 270


def polygone(points: list[tuple[int, int]]) -> str:
    return "polygon " + " ".join(f"{x},{y}" for x, y in points)


def nuage(x: int, y: int, longueur: int, epaisseur: int) -> str:
    """Un nuage en lanière : pointu à gauche, coupé net à droite."""
    return polygone([(x, y), (x + longueur, y - epaisseur // 2), (x + longueur, y + epaisseur // 2)])


def voile(x: int, haut: int, bas: int, largeur: int) -> str:
    """Une voile : un triangle, le côté gauche presque vertical."""
    return polygone([(x, haut), (x + 2, bas), (x + largeur, bas)])


def colline(crete: list[tuple[int, int]]) -> str:
    """Une bande de terre : la ligne de crête, fermée par le bas de l'image."""
    return polygone(crete + [(LARGEUR_BANDE, 480), (0, 480)])


def dessiner(cible: Path, taille: str, fond: str, formes: list[tuple[str, str]], net: bool = False) -> None:
    """Une image : le fond, puis chaque forme (couleur, primitive -draw). `net` : sans lissage des bords."""
    commande = ["magick", "-size", taille, "xc:" + fond]
    if net:
        commande.append("+antialias")
    for couleur, primitive in formes:
        commande += ["-fill", couleur, "-draw", primitive]
    commande.append("PNG32:" + str(cible))
    subprocess.run(commande, check=True)


def decor_train(dossier: Path) -> None:
    """fond.png (fixe), plan.png (défile), fenetre.png (fixe, par-dessus) ; plage.png, le second plan du TD 7."""
    dossier.mkdir(parents=True, exist_ok=True)
    dessiner(dossier / "fond.png", "640x480", "#a9ddd3", [
        ("#cfe7b9", nuage(270, 150, 370, 12)),
        ("#cfe7b9", nuage(60, 196, 300, 18)),
        ("#cfe7b9", nuage(440, 222, 200, 10)),
        ("#4b5bcc", f"rectangle 0,{HORIZON} 640,480"),
        ("#5b6bd8", f"rectangle 0,{HORIZON + 30} 640,{HORIZON + 31}"),
    ])
    dessiner(dossier / "plan.png", f"{LARGEUR_BANDE}x480", "none", [
        ("#f3cfc9", voile(180, 286, 352, 26)),
        ("#f3cfc9", voile(470, 268, 318, 16)),
        ("#f3cfc9", voile(1010, 280, 350, 26)),
        ("#f3cfc9", voile(1380, 266, 316, 15)),
        ("#f3cfc9", voile(1650, 272, 322, 17)),
        ("#f6c23f", colline([(0, 382), (420, 330), (900, 405), (1300, 345), (1650, 398), (1920, 382)])),
    ])
    crete = [(0, 432), (520, 396), (1000, 458), (1480, 408), (1920, 432)]
    dessiner(dossier / "plage.png", f"{LARGEUR_BANDE}x480", "none", [
        ("#f6dcb0", colline([(x, y - 2) for x, y in crete])),
        ("#e8801d", colline(crete)),
    ], net=True)
    # La fenêtre : opaque partout, sauf la vitre, transparente. Le masque est
    # dessiné sans lissage : chaque pixel est soit opaque, soit transparent.
    subprocess.run(["magick", "-size", "640x480", "xc:#0b0b0b",
                    "(", "-size", "640x480", "xc:white", "+antialias", "-fill", "black",
                    "-draw", "roundrectangle 40,30 599,449 56,56", ")",
                    "-alpha", "off", "-compose", "CopyOpacity", "-composite",
                    "PNG32:" + str(dossier / "fenetre.png")], check=True)


def illustrations() -> None:
    """Les vignettes des schémas : le programme final lancé une fois par TD, cinq images réduites."""
    ILLUSTRATIONS.mkdir(parents=True, exist_ok=True)
    for nom, (options, numeros) in VIGNETTES.items():
        td = DOSSIERS_TD[nom]
        programme = ICI / "corriges" / td.name / "b3" / (nom + ".py")
        with tempfile.TemporaryDirectory() as dossier:
            if nom == "tourbillon":
                shutil.copy(VAGUE, Path(dossier) / "vague.jpg")
            if nom == "train":
                decor_train(Path(dossier) / "decor")
            subprocess.run([sys.executable, str(programme), *options], cwd=dossier, check=True)
            images = Path(dossier) / "sortie" / "images"
            for rang, numero in enumerate(numeros, start=1):
                source = images / ("img_" + str(numero).zfill(4) + ".png")
                cible = ILLUSTRATIONS / (nom + "_" + str(rang) + ".jpg")
                subprocess.run(["magick", str(source), "-resize", "320x", "-quality", "85", str(cible)], check=True)
        print(f"✓ {ILLUSTRATIONS.relative_to(DEPOT)}/{nom}_1.jpg … {nom}_{len(numeros)}.jpg")


def schemas(depart_notebook: Path, nom: str) -> None:
    """Le schéma des étapes du programme, en PNG, à côté du notebook livré."""
    cible = depart_notebook.parent / "illustrations" / ("programme_" + nom + ".png")
    cible.parent.mkdir(parents=True, exist_ok=True)
    subprocess.run(["typst", "compile", "--root", str(DEPOT), "--input", "td=" + nom,
                    "--format", "png", "--ppi", "110", str(SCHEMA), str(cible)], check=True)


def main() -> None:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("commande", choices=("build", "illustrations"))
    options = analyseur.parse_args()
    illustrations() if options.commande == "illustrations" else build()


if __name__ == "__main__":
    main()
