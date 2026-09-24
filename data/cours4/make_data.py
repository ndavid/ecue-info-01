"""Fabrique les fichiers des TD du cours 4 : la montre (4a) et le tourbillon (4b).

Le dépôt versionne ce que chaque TD livre tel quel (`depart/environment.yml`,
`depart/modeles/`) et les corrigés (`corriges/`). `build` remplit le
`produit/` de chaque TD : le dossier `travail/` vide et, pour le tourbillon,
l'image de départ, reprise du cours 3.

    python make_data.py build           # produit/ des deux TD
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
VAGUE = ICI.parent / "cours3" / "2b_images" / "produit" / "depart" / "vague.jpg"
DEPOT = ICI.parent.parent
ILLUSTRATIONS = DEPOT / "illustrations" / "cours4"
SCHEMA = DEPOT / "src" / "cours4" / "diapo" / "schema_programme.typ"

# Les images de la vidéo montrées dans les schémas : cinq par TD, prises dans
# la série d'images du programme final (corrigé de l'étape B3).
VIGNETTES = {
    "montre": (["--heure", "10:00", "--minutes", "120"], [1, 31, 61, 91, 120]),
    "tourbillon": (["vague.jpg", "--maximum", "360"], [1, 7, 13, 19, 25]),
}

CREDITS = (
    "# Image\n\n"
    "- `vague.jpg` : Katsushika Hokusai, *Under the Wave off Kanagawa*, "
    "The Metropolitan Museum of Art, open access (CC0), "
    "<https://www.metmuseum.org/art/collection/search/45434>\n"
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


def illustrations() -> None:
    """Les vignettes des schémas : le programme final lancé une fois par TD, cinq images réduites."""
    ILLUSTRATIONS.mkdir(parents=True, exist_ok=True)
    for nom, (options, numeros) in VIGNETTES.items():
        td = TD_MONTRE if nom == "montre" else TD_TOURBILLON
        programme = ICI / "corriges" / td.name / "b3" / (nom + ".py")
        with tempfile.TemporaryDirectory() as dossier:
            if nom == "tourbillon":
                shutil.copy(VAGUE, Path(dossier) / "vague.jpg")
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
