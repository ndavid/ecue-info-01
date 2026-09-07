#!/usr/bin/env python3
"""Convertit les notebooks MyST du dépôt en `.ipynb`, et les exécute.

Les sources sont en MyST Markdown : c'est du texte, qui se relit, se compare
ligne à ligne et se versionne — la démonstration du cours 1 appliquée à ses
propres supports. Le `.ipynb` en est dérivé, comme un PDF l'est d'un `.typ`, et
il est dans `.gitignore`.

    python outils/construire_notebooks.py            # convertit
    python outils/construire_notebooks.py --executer # convertit puis exécute

`--executer` remplit les sorties : c'est ce qu'on distribue aux étudiants quand
on veut qu'ils voient le résultat attendu sans avoir à tout relancer. Sans
l'option, les cellules sont vides, ce qui est la forme à ouvrir en séance.

Sort en code 1 si une conversion ou une exécution échoue.
"""

from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
SOURCES = sorted((RACINE / "src").glob("cours*/notebook/*.md"))


def convertir(source: Path, executer: bool) -> bool:
    cible = source.with_suffix(".ipynb")
    conversion = subprocess.run(
        ["jupytext", "--to", "ipynb", "--output", str(cible), str(source)],
        capture_output=True, text=True,
    )
    if conversion.returncode != 0:
        print(f"{source.relative_to(RACINE)} : conversion échouée", file=sys.stderr)
        print(conversion.stderr.strip(), file=sys.stderr)
        return False
    print(f"  {cible.relative_to(RACINE)}")

    if not executer:
        return True

    # Le dossier de travail est celui du notebook : ses chemins relatifs sont
    # écrits pour être ouverts là, dans l'éditeur comme dans JupyterLab.
    execution = subprocess.run(
        ["jupyter", "nbconvert", "--to", "notebook", "--execute", "--inplace",
         str(cible)],
        capture_output=True, text=True, cwd=cible.parent,
    )
    if execution.returncode != 0:
        print(f"{cible.relative_to(RACINE)} : exécution échouée", file=sys.stderr)
        print(execution.stderr.strip()[-1500:], file=sys.stderr)
        return False
    print(f"    exécuté")
    return True


def main() -> int:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument(
        "--executer", action="store_true",
        help="exécuter les notebooks après conversion, pour remplir les sorties",
    )
    options = analyseur.parse_args()

    if not SOURCES:
        print("aucun notebook MyST trouvé sous src/cours*/notebook/", file=sys.stderr)
        return 1

    echecs = 0
    for source in SOURCES:
        print(f"{source.relative_to(RACINE)}")
        if not convertir(source, options.executer):
            echecs += 1
    return 1 if echecs else 0


if __name__ == "__main__":
    sys.exit(main())
