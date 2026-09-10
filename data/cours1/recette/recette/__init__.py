"""Le calcul des quantités, et le gabarit de la page.

Ce fichier ne porte que ce que les trois programmes du projet ont en commun :
les deux conversions, et l'enveloppe HTML dans laquelle le texte converti est
posé. Tout le reste — lire le CSV, écrire le tableau, l'insérer dans la
recette — se lit de haut en bas dans `recette_a_la_main.py`,
`recette_avec_tabulate.py` et `recette/__main__.py`.

Deux fonctions, parce qu'elles répondent à deux questions différentes et
qu'on peut vouloir l'une sans l'autre : combien de convives, et dans quelles
unités.
"""

__all__ = ["pour_personnes", "convertir", "en_unites", "GABARIT", "VERS_US"]

# Un facteur par unité de départ, et le nom de l'unité d'arrivée. Les unités
# de comptage — un œuf, une pincée — n'ont pas d'équivalent : elles ne sont pas
# dans la table, et traversent la conversion inchangées.
VERS_US = {
    "g": (1 / 28.3495, "oz"),      # once, 28,3495 g
    "ml": (1 / 236.588, "cup"),    # cup, 236,588 ml
}


def pour_personnes(ingredients: list[dict], personnes: int) -> list[dict]:
    """Les mêmes ingrédients, pour ce nombre de convives.

    Le CSV ne contient que du texte : `float` en fait un nombre, sans quoi
    multiplier « 60 » par 4 donnerait « 60606060 ».
    """
    return [i | {"quantite": float(i["quantite"]) * personnes} for i in ingredients]


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




# L'enveloppe de la page. `markdown.markdown` ne rend qu'un fragment : les
# titres et les paragraphes convertis, sans `<!doctype>`, sans `<head>`, et
# donc sans lien vers la feuille de style. C'est ici que la page devient un
# document : un type déclaré, un encodage, un titre d'onglet, et `style.css`.
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
