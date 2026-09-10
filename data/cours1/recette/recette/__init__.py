"""Le calcul des quantités, et le gabarit de la page.

Ce fichier ne porte que ce que les trois programmes du projet ont en commun :
les deux conversions, et l'enveloppe HTML dans laquelle le texte converti est
posé. Tout le reste — lire le CSV, écrire le tableau, l'insérer dans la
recette — se lit de haut en bas dans `recette_a_la_main.py`,
`recette_avec_tabulate.py` et `recette/__main__.py`.

Un ingrédient est un triplet : son nom, sa quantité, son unité. Une recette
est la liste de ses ingrédients. Les deux fonctions ci-dessous en prennent
une et en rendent une autre, sans jamais modifier celle qu'on leur a donnée.
"""

__all__ = ["pour_personnes", "convertir", "en_unites", "GABARIT"]


def pour_personnes(ingredients, personnes):
    """Les mêmes ingrédients, pour ce nombre de convives."""
    resultat = []
    for nom, quantite, unite in ingredients:
        resultat.append((nom, quantite * personnes, unite))
    return resultat


def convertir(quantite, unite):
    """Une quantité et son unité, exprimées en unités américaines.

    Ce qui se compte — les œufs — n'a pas d'équivalent : la quantité et
    l'unité ressortent inchangées, « une once d'œuf » ne voulant rien dire.
    """
    if unite == "g":
        return quantite / 28.3495, "oz"      # une once vaut 28,3495 g
    if unite == "ml":
        return quantite / 236.588, "cup"     # une cup vaut 236,588 ml
    return quantite, unite


def en_unites(ingredients, systeme):
    """Les mêmes ingrédients, exprimés dans le système demandé."""
    if systeme == "SI":
        return ingredients
    resultat = []
    for nom, quantite, unite in ingredients:
        quantite, unite = convertir(quantite, unite)
        resultat.append((nom, quantite, unite))
    return resultat


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
