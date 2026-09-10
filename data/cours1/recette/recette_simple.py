"""La recette pour quatre personnes, en unités SI.

Ce script se lance tel quel :

    python recette_simple.py

Pour un autre nombre de convives ou un autre système d'unités, changez les
deux valeurs ci-dessous et relancez. C'est la façon la plus directe de se
servir du code — et sa limite : elle demande d'ouvrir le fichier et d'y
écrire. La ligne de commande de `python -m recette` fait la même chose sans
modifier quoi que ce soit.
"""

from pathlib import Path

from recette import (
    en_unites, inserer_ingredients, lire_ingredients, page_html,
    pour_personnes, tableau_markdown,
)

# ---- Les deux valeurs à changer -------------------------------------------
PERSONNES = 4
UNITES = "SI"      # "SI" ou "US"
# ---------------------------------------------------------------------------

ICI = Path(__file__).resolve().parent

ingredients = lire_ingredients(ICI / "ingredients.csv")
ingredients = pour_personnes(ingredients, PERSONNES)
ingredients = en_unites(ingredients, UNITES)

recette = inserer_ingredients(
    (ICI / "recette.md").read_text(encoding="utf-8"),
    tableau_markdown(ingredients),
)

page = ICI / "recette.html"
page.write_text(page_html(recette, "Crêpes"), encoding="utf-8")
print(f"{page.name} écrit pour {PERSONNES} personne(s), en unités {UNITES}")
