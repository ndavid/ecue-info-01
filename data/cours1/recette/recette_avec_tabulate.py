"""La recette pour quatre personnes, avec la bibliothèque `tabulate`.

    python recette_avec_tabulate.py

Le programme se lit de haut en bas : lire le tableau des ingrédients, le
mettre à l'échelle, le convertir, en faire un tableau Markdown, l'insérer dans
la recette, convertir le tout en HTML, écrire la page.

Pour un autre nombre de convives ou un autre système d'unités, changez les
deux valeurs ci-dessous et relancez.

`tabulate` vient ici d'une bibliothèque installée. `recette_a_la_main.py` est
le même programme, la fonction écrite à la place de l'import.
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

# ---- Lire le tableau des ingrédients --------------------------------------
# Une ligne du fichier donne un ingrédient : son nom, sa quantité, son unité.
ingredients = []
with open(ICI / "ingredients.csv", encoding="utf-8") as fichier:
    lecteur = csv.reader(fichier)
    next(lecteur)                      # la première ligne nomme les colonnes
    for nom, quantite, unite in lecteur:
        ingredients.append((nom, float(quantite), unite))

# ---- Mettre à l'échelle, puis convertir ------------------------------------
ingredients = pour_personnes(ingredients, PERSONNES)
ingredients = en_unites(ingredients, UNITES)

# ---- En faire un tableau Markdown ------------------------------------------
table = []
for nom, quantite, unite in ingredients:
    table.append((nom, f"{quantite:.3g} {unite}".strip()))

tableau = tabulate(table, headers=["Ingrédient", "Quantité"], tablefmt="github")

# ---- Poser le tableau dans la recette, et en faire une page ----------------
source = (ICI / "recette.md").read_text(encoding="utf-8")
source = source.replace("## Ingrédients", "## Ingrédients\n\n" + tableau)

corps = markdown.markdown(source, extensions=["tables"])
page = GABARIT.format(titre="Crêpes", corps=corps)

sortie = ICI / "recette.html"
sortie.write_text(page, encoding="utf-8")
print(f"{sortie.name} écrit pour {PERSONNES} personne(s), en unités {UNITES}")
