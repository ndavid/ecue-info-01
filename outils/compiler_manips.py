#!/usr/bin/env python3
"""Compile chaque manipulation d'une séance en feuille d'instructions séparée.

Une manipulation est un fichier de `src/cours<n>/diapo/manips/`. Le même
fichier sert deux fois : inclus par `cours<n>.typ`, il est projeté au milieu
du cours ; compilé seul par ce script, il donne un PDF court que l'étudiant
garde sous les yeux pendant qu'il travaille.

    python outils/compiler_manips.py              # les manipulations du cours 1
    python outils/compiler_manips.py --cours 3    # celles d'un autre cours
    python outils/compiler_manips.py --corrige    # + la version avec les réponses
    python outils/compiler_manips.py --lister     # ce qui serait produit, sans compiler

Le PDF est déposé dans le dossier que la manipulation annonce elle-même, par
l'argument `dossier:` de son `#separateur-manip` — celui que l'étudiant a
justement ouvert. Il s'appelle `instructions-<nom>.pdf`, et n'est pas versionné.

Ce script écrit un fichier d'assemblage temporaire à côté de `cours<n>.typ` :
`typst` n'accepte que des chemins littéraux dans `include`, on ne peut donc pas
lui passer la manipulation à inclure en argument.
"""

from __future__ import annotations

import argparse
import re
import shutil
import subprocess
import sys
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent


def dossier_annonce(source: Path) -> Path | None:
    """Le dossier que la manipulation annonce, tel qu'elle l'écrit."""
    trouve = re.search(r'dossier:\s*"([^"]+)"', source.read_text(encoding="utf-8"))
    return RACINE / trouve.group(1) if trouve else None


def reglages(assemblage: Path) -> str:
    """Les arguments de `diapos` du cours, repris tels quels par l'assemblage."""
    texte = assemblage.read_text(encoding="utf-8")
    trouve = re.search(r"#show: diapos\.with\((.*?)\)\n", texte, re.S)
    return trouve.group(1).strip() if trouve else ""


def compiler(manip: Path, assemblage: Path, corrige: bool, captures: bool) -> int:
    destination = dossier_annonce(manip)
    if destination is None:
        print(f"{manip.name} : aucun `dossier:` annoncé, ignorée", file=sys.stderr)
        return 0
    if not destination.is_dir():
        print(f"{manip.name} : {destination} n'existe pas, ignorée", file=sys.stderr)
        return 0

    nom = re.sub(r"^\d+_", "", manip.stem).replace("_", "-")
    sortie = destination / f"instructions-{nom}{'-corrige' if corrige else ''}.pdf"

    temporaire = assemblage.with_name("_manip_en_cours.typ")
    temporaire.write_text(
        "// Assemblage temporaire, écrit par outils/compiler_manips.py.\n"
        f'#import "../../commun/prelude.typ": *\n\n'
        f"#show: diapos.with({reglages(assemblage)})\n\n"
        f'#include "manips/{manip.name}"\n',
        encoding="utf-8",
    )
    commande = ["typst", "compile", "--root", str(RACINE)]
    if captures:
        commande += ["--input", "captures=true"]
    if corrige:
        commande += ["--input", "corrige=true"]
    commande += [str(temporaire), str(sortie)]
    try:
        resultat = subprocess.run(commande, check=False)
    finally:
        temporaire.unlink(missing_ok=True)
    if resultat.returncode == 0:
        print(f"  {sortie.relative_to(RACINE)}")
    return resultat.returncode


def main() -> int:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("--cours", type=int, default=1, help="numéro du cours (défaut : 1)")
    analyseur.add_argument("--corrige", action="store_true", help="+ la version avec les réponses")
    analyseur.add_argument(
        "--sans-captures", action="store_true",
        help="ignorer les captures d'écran, pour vérifier le repli dessiné",
    )
    analyseur.add_argument("--lister", action="store_true", help="dire ce qui serait produit")
    options = analyseur.parse_args()

    diapo = RACINE / f"src/cours{options.cours}/diapo"
    assemblage = diapo / f"cours{options.cours}.typ"
    manips = sorted((diapo / "manips").glob("*.typ"))
    if not manips:
        print(f"{diapo}/manips : aucune manipulation", file=sys.stderr)
        return 1

    if options.lister:
        for manip in manips:
            destination = dossier_annonce(manip)
            nom = re.sub(r"^\d+_", "", manip.stem).replace("_", "-")
            print(f"{manip.name} → {destination}/instructions-{nom}.pdf")
        return 0

    if shutil.which("typst") is None:
        print("typst est introuvable : `conda activate info01` d'abord.", file=sys.stderr)
        return 2

    code = 0
    for manip in manips:
        print(f"{manip.name} :")
        code |= compiler(manip, assemblage, False, not options.sans_captures)
        if options.corrige:
            code |= compiler(manip, assemblage, True, not options.sans_captures)
    return code


if __name__ == "__main__":
    raise SystemExit(main())
