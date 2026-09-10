"""La recette pour quatre personnes, avec la bibliothèque `tabulate`.

    python recette_avec_tabulate.py

Le programme se lit de haut en bas : lire le tableau des ingrédients, le
mettre à l'échelle, le convertir, en faire un tableau Markdown, l'insérer dans
la recette, convertir le tout en HTML, écrire la page.

Pour un autre nombre de convives ou un autre système d'unités, changez les
deux valeurs ci-dessous et relancez.

`tabulate` vient ici d'une bibliothèque installée. `recette_a_la_main.py` est
le même programme, avec une fonction `tabulate` écrite en cinq lignes à la
place de l'import : comparez les deux fichiers, ils ne diffèrent que par là.
"""

import csv
from pathlib import Path

import markdown
from tabulate import tabulate

from recette import GABARIT, en_unites, pour_personnes

# ---- Les deux valeurs à changer -------------------------------------------
PERSONNES = 4
UNITES = "SI"      # "SI" ou "US"
# ---------------------------------------------------------------------------

ICI = Path(__file__).resolve().parent


ingredients = list(csv.DictReader(open(ICI / "ingredients.csv", encoding="utf-8")))
ingredients = pour_personnes(ingredients, PERSONNES)
ingredients = en_unites(ingredients, UNITES)

table = [[i["ingredient"], f"{i['quantite']:g} {i['unite']}".strip()] for i in ingredients]
tableau = tabulate(table, headers=["Ingrédient", "Quantité"], tablefmt="pipe")

source = (ICI / "recette.md").read_text(encoding="utf-8")
source = source.replace("## Ingrédients", "## Ingrédients\n\n" + tableau)

corps = markdown.markdown(source, extensions=["tables"])
page = GABARIT.format(titre="Crêpes", corps=corps)

sortie = ICI / "recette.html"
sortie.write_text(page, encoding="utf-8")
print(f"{sortie.name} écrit pour {PERSONNES} personne(s), en unités {UNITES}")
