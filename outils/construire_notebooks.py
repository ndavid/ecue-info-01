#!/usr/bin/env python3
"""Convertit les notebooks MyST du dépôt en `.ipynb`, et les exécute.

Les sources sont en MyST Markdown : c'est du texte, qui se relit, se compare
ligne à ligne et se versionne — la démonstration du cours 1 appliquée à ses
propres supports. Le `.ipynb` en est dérivé, comme un PDF l'est d'un `.typ`.

Ne sont convertis que les notebooks écrits pour un TD,
`src/cours<n>/notebook/td/<td>/`, où `<td>` nomme le dossier de `data/cours<n>/`
qui les reçoit. Les autres pages de `notebook/` sont des chapitres du book :
elles s'exécutent à la construction du book, et n'ont pas à être distribuées en
`.ipynb`.

Il est déposé dans `produit/` du TD sur les notebooks de la séance, le dossier
de `data/cours<n>/` dont le nom finit par `_notebooks` : c'est là que le TD
envoie les étudiants, et `outils/livrer_tds.py` le prend au passage, comme le
reste de `produit/`.

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
SOURCES = sorted((RACINE / "src").glob("cours*/notebook/td/*/*.md"))


def destination(source: Path) -> Path | None:
    """`produit/` du TD que nomme le dossier de la source, ou None.

    Le chemin d'une source est `src/cours<n>/notebook/td/<td>/<nom>.md`, et le
    dossier `<td>` est celui de `data/cours<n>/` où le `.ipynb` doit aller.
    Écrire la destination dans l'arborescence plutôt que dans le script évite
    d'avoir à tenir une table de correspondance.
    """
    cours = source.parents[3].name
    td = RACINE / "data" / cours / source.parent.name
    return td / "produit" if td.is_dir() else None


def convertir(source: Path, executer: bool) -> bool:
    dossier = destination(source)
    if dossier is None:
        print(f"{source.relative_to(RACINE)} : pas de dossier "
              f"data/{source.parents[3].name}/{source.parent.name}/, ignoré",
              file=sys.stderr)
        return False
    dossier.mkdir(parents=True, exist_ok=True)
    cible = dossier / source.with_suffix(".ipynb").name
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
