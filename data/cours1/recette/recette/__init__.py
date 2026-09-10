"""Une recette écrite en Markdown, mise à l'échelle et convertie en page HTML.

Le fichier `ingredients.csv` donne les quantités **pour une personne, en
unités SI**. Tout le reste s'en déduit : multiplier par le nombre de convives,
convertir dans un autre système d'unités, en faire un tableau, et poser ce
tableau dans la recette à l'endroit où le titre « Ingrédients » l'annonce.

Chaque étape est une fonction séparée. C'est ce qui permet de les lire, de les
essayer une par une dans l'interpréteur, et d'en changer une sans toucher aux
autres.

Ce fichier porte les fonctions. Ce qui s'exécute est dans `__main__.py`.
"""

import csv
from pathlib import Path

import markdown

__all__ = [
    "lire_ingredients", "pour_personnes", "convertir", "en_unites",
    "tableau_markdown", "inserer_ingredients", "page_html",
]

# Un facteur par unité de départ, et le nom de l'unité d'arrivée. Les unités
# de comptage — un œuf, une pincée — n'ont pas d'équivalent : elles ne sont pas
# dans la table, et traversent la conversion inchangées.
VERS_US = {
    "g": (1 / 28.3495, "oz"),      # once, 28,3495 g
    "ml": (1 / 236.588, "cup"),    # cup, 236,588 ml
}

TITRE_INGREDIENTS = "## Ingrédients"


def lire_ingredients(chemin: Path) -> list[dict]:
    """Les lignes du CSV, quantités converties en nombres."""
    with open(chemin, encoding="utf-8", newline="") as fichier:
        return [
            {"ingredient": l["ingredient"],
             "quantite": float(l["quantite"]),
             "unite": l["unite"]}
            for l in csv.DictReader(fichier)
        ]


def pour_personnes(ingredients: list[dict], personnes: int) -> list[dict]:
    """Les mêmes ingrédients, pour ce nombre de convives."""
    return [i | {"quantite": i["quantite"] * personnes} for i in ingredients]


def convertir(ingredient: dict) -> dict:
    """La quantité et l'unité de cet ingrédient, en unités américaines.

    Une unité absente de la table est laissée telle quelle : c'est le cas de
    ce qui se compte, où « une once d'œuf » ne voudrait rien dire.
    """
    facteur, unite = VERS_US.get(ingredient["unite"], (1, ingredient["unite"]))
    return {"quantite": ingredient["quantite"] * facteur, "unite": unite}


def en_unites(ingredients: list[dict], systeme: str) -> list[dict]:
    """Les mêmes ingrédients, exprimés dans le système demandé."""
    if systeme == "SI":
        return ingredients
    return [i | convertir(i) for i in ingredients]


def tableau_markdown(ingredients: list[dict]) -> str:
    """Le tableau Markdown des ingrédients, en-tête compris."""
    lignes = ["| Ingrédient | Quantité |", "|---|---|"]
    for i in ingredients:
        quantite = f"{i['quantite']:.2f}".rstrip("0").rstrip(".")
        # Une unité vide est celle des ingrédients qui se comptent : « 4 »,
        # et non « 4 unité ».
        lignes.append(f"| {i['ingredient']} | {quantite} {i['unite']} |".replace("  |", " |"))
    return "\n".join(lignes)


def inserer_ingredients(source: str, tableau: str) -> str:
    """La recette, avec le tableau posé sous le titre « Ingrédients »."""
    if TITRE_INGREDIENTS not in source:
        raise ValueError(f"{TITRE_INGREDIENTS!r} est absent de la recette")
    return source.replace(
        TITRE_INGREDIENTS, f"{TITRE_INGREDIENTS}\n\n{tableau}", 1,
    )


# La page est volontairement minimale : un en-tête, un lien vers la feuille de
# style, et le contenu converti. C'est la structure vue à la première partie,
# où le `.html` porte le contenu et le `.css` la présentation.
GABARIT = """<!doctype html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <title>{titre}</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <article>
{corps}
  </article>
</body>
</html>
"""


def page_html(texte: str, titre: str) -> str:
    """La page HTML complète de cette recette Markdown."""
    # Ni les tableaux ni les blocs de code ne font partie du Markdown publié en
    # 2004 : la bibliothèque sait les traduire, mais il faut le lui demander.
    corps = markdown.markdown(texte, extensions=["tables", "fenced_code"])
    return GABARIT.format(titre=titre, corps=corps)
