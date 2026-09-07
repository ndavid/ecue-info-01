#!/usr/bin/env python3
"""Compile un jeu de diapositives avec les bonnes options, sans les retenir.

`typst compile` demande ici trois choses faciles à oublier : `--root` sur la
racine du dépôt, faute de quoi un `.typ` de `src/cours<n>/diapo/` ne peut pas
lire une image de `data/` ; et `--input captures=true` quand les captures
d'écran sont en place, sinon les diapositives retombent silencieusement sur
leurs schémas dessinés. Ce script s'en charge : il regarde ce qui est présent
et passe les options qui conviennent.

    python outils/compiler_diapos.py                  # le cours 1, à projeter
    python outils/compiler_diapos.py --notes          # + les notes de conduite
    python outils/compiler_diapos.py --corrige        # + le corrigé des manipulations
    python outils/compiler_diapos.py --tous           # les sept jeux
    python outils/compiler_diapos.py --cours 3        # un autre cours

`--sans-captures` force le repli dessiné, pour vérifier que le document tient
aussi sans les images.
"""

from __future__ import annotations

import argparse
import re
import shutil
import subprocess
import sys
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent

# Les noms de fichiers attendus sont écrits dans les `.typ` eux-mêmes : plutôt
# que de tenir une liste en double, on les y relit. Les supports les désignent
# depuis la racine du projet (`/data/…`), typst résolvant sinon le chemin par
# rapport au fichier où `image` est appelé, c'est-à-dire au thème.
MOTIF_IMAGE = re.compile(r'"/?(?:\.\./)*(data/[^"]+\.(?:png|jpg|jpeg))"')


def sources(source: Path) -> list[Path]:
    """Le fichier d'assemblage, et les parties qu'il inclut."""
    return [source] + sorted((source.parent / "parties").glob("*.typ"))


def captures_presentes(source: Path) -> tuple[bool, list[str]]:
    """Dit si toutes les images citées par les `.typ` sont là, et liste les absentes."""
    textes = "".join(f.read_text(encoding="utf-8") for f in sources(source))
    attendues = sorted(set(MOTIF_IMAGE.findall(textes)))
    manquantes = [c for c in attendues if not (RACINE / c).exists()]
    return (bool(attendues) and not manquantes), manquantes


def compiler(cours: int, options: argparse.Namespace) -> int:
    source = RACINE / f"src/cours{cours}/diapo/cours{cours}.typ"
    if not source.exists():
        print(f"{source} : introuvable", file=sys.stderr)
        return 1

    completes, manquantes = captures_presentes(source)
    avec_captures = completes and not options.sans_captures

    commande = ["typst", "compile", "--root", str(RACINE)]
    if avec_captures:
        commande += ["--input", "captures=true"]
    if options.notes:
        commande += ["--input", "notes=true"]
    if options.corrige:
        commande += ["--input", "corrige=true"]
    commande.append(str(source))

    suffixe = "".join(
        s for s, actif in (("-notes", options.notes), ("-corrige", options.corrige)) if actif
    )
    if suffixe:
        commande.append(str(source.with_name(f"cours{cours}{suffixe}.pdf")))

    print(f"cours {cours} :", " ".join(commande[1:]))
    if manquantes and not options.sans_captures:
        print(f"  captures absentes ({len(manquantes)}), schémas dessinés à la place :")
        for c in manquantes:
            print(f"    {c}")
    elif avec_captures:
        print("  captures en place, elles seront employées")

    resultat = subprocess.run(commande, check=False)
    return resultat.returncode


def main() -> int:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("--cours", type=int, default=1, help="numéro du cours (défaut : 1)")
    analyseur.add_argument("--tous", action="store_true", help="les sept jeux")
    analyseur.add_argument("--notes", action="store_true", help="version annotée")
    analyseur.add_argument("--corrige", action="store_true", help="corrigé des manipulations")
    analyseur.add_argument(
        "--sans-captures", action="store_true",
        help="ignorer les captures d'écran, pour vérifier le repli dessiné",
    )
    options = analyseur.parse_args()

    if shutil.which("typst") is None:
        print("typst est introuvable : `conda activate info01` d'abord.", file=sys.stderr)
        return 2

    cours = range(1, 8) if options.tous else [options.cours]
    return max(compiler(n, options) for n in cours)


if __name__ == "__main__":
    sys.exit(main())
