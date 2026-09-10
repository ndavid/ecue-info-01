"""La même recette, en ligne de commande.

    python -m recette                       # 4 personnes, unités SI
    python -m recette --personnes 12        # pour douze
    python -m recette --unites US           # en onces et en cups
    python -m recette --aide

Après `pip install -e .`, la commande s'appelle `recette` : c'est ce que
déclare la section `[project.scripts]` de `pyproject.toml`.

Ce que la ligne de commande apporte au script `recette_simple.py` : les
valeurs se donnent au lancement, sans ouvrir le fichier, et `--help` dit ce
qu'on peut demander.
"""

import argparse
from pathlib import Path

from . import (
    en_unites, inserer_ingredients, lire_ingredients, page_html,
    pour_personnes, tableau_markdown,
)

ICI = Path(__file__).resolve().parent.parent


def main(arguments=None) -> int:
    analyseur = argparse.ArgumentParser(
        prog="recette",
        description="Met une recette Markdown à l'échelle et en fait une page HTML.",
    )
    analyseur.add_argument(
        "-p", "--personnes", type=int, default=4,
        help="nombre de convives (défaut : 4)",
    )
    analyseur.add_argument(
        "-u", "--unites", choices=("SI", "US"), default="SI",
        help="système d'unités du tableau (défaut : SI)",
    )
    analyseur.add_argument(
        "-s", "--sortie", type=Path, default=ICI / "recette.html",
        help="où écrire la page (défaut : recette.html, à côté du projet)",
    )
    options = analyseur.parse_args(arguments)

    if options.personnes < 1:
        analyseur.error("le nombre de personnes doit valoir au moins 1")

    ingredients = lire_ingredients(ICI / "ingredients.csv")
    ingredients = pour_personnes(ingredients, options.personnes)
    ingredients = en_unites(ingredients, options.unites)

    recette = inserer_ingredients(
        (ICI / "recette.md").read_text(encoding="utf-8"),
        tableau_markdown(ingredients),
    )
    options.sortie.write_text(page_html(recette, "Crêpes"), encoding="utf-8")
    print(
        f"{options.sortie.name} : {options.personnes} personne(s), "
        f"unités {options.unites}, {options.sortie.stat().st_size} octets"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
