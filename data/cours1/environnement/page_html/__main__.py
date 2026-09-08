"""Ce qui s'exécute quand on lance le paquet.

    python -m page_html                      # ../markdown/recette.md
    python -m page_html chemin/fichier.md    # un autre fichier

Après `pip install -e .`, la même chose s'obtient en tapant `page-html` : c'est
ce que déclare la section `[project.scripts]` de `pyproject.toml`.
"""

import sys
from pathlib import Path

from . import convertir

ICI = Path(__file__).resolve().parent.parent
DEFAUT = ICI.parent / "markdown" / "recette.md"


def main(arguments=None):
    arguments = sys.argv[1:] if arguments is None else arguments
    source = Path(arguments[0]) if arguments else DEFAUT
    if not source.exists():
        sys.exit(f"{source} : introuvable")
    page = convertir(source, ICI)
    print(f"{source.name} -> {page.name}, {page.stat().st_size} octets")
    print(page.as_uri())
    return 0


if __name__ == "__main__":
    sys.exit(main())
