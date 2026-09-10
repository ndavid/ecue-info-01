"""La recette pour quatre personnes, avec la bibliothèque `tabulate`.

    python recette_avec_tabulate.py

Le programme se lit de haut en bas : lire les ingrédients, les adapter au
nombre de convives et au système d'unités, en faire un tableau Markdown,
l'insérer dans la recette, convertir le tout en HTML, écrire la page.

Pour un autre nombre de convives ou un autre système d'unités, changez les
deux valeurs ci-dessous et relancez.

`tabulate` vient ici d'une bibliothèque installée. `recette_a_la_main.py` est
le même programme, la fonction écrite à la place de l'import.
"""

from pathlib import Path

import markdown
from tabulate import tabulate

from recette import GABARIT, adapter, en_table, lire_ingredients

# ---- Les deux valeurs à changer -------------------------------------------
PERSONNES = 4
UNITES = "SI"      # "SI" ou "US"
# ---------------------------------------------------------------------------

ICI = Path(__file__).resolve().parent

ingredients = lire_ingredients(ICI / "ingredients.csv")
ingredients = adapter(ingredients, PERSONNES, UNITES)

lignes = en_table(ingredients)
tableau = tabulate(lignes, headers=["Ingrédient", "Quantité"], tablefmt="github")

source = (ICI / "recette.md").read_text(encoding="utf-8")
source = source.replace("## Ingrédients", "## Ingrédients\n\n" + tableau)

corps = markdown.markdown(source, extensions=["tables"])
page = GABARIT.format(titre="Crêpes", corps=corps)

sortie = ICI / "recette.html"
sortie.write_text(page, encoding="utf-8")
print(f"{sortie.name} écrit pour {PERSONNES} personne(s), en unités {UNITES}")
