"""La recette pour quatre personnes, sans autre bibliothèque que `markdown`.

    python recette_a_la_main.py

Le programme se lit de haut en bas : lire le tableau des ingrédients, le
mettre à l'échelle, le convertir, en faire un tableau Markdown, l'insérer dans
la recette, convertir le tout en HTML, écrire la page.

Pour un autre nombre de convives ou un autre système d'unités, changez les
deux valeurs ci-dessous et relancez.

La fonction `tabulate` écrite ici porte le nom et la signature de celle de la
bibliothèque `tabulate`, employée par `recette_avec_tabulate.py` : les deux
fichiers ne diffèrent que par leur première ligne. C'est l'occasion de voir ce
qu'une bibliothèque fait à votre place, sur un cas où le faire soi-même tient
en cinq lignes.
"""

import csv
from pathlib import Path

import markdown

from recette import GABARIT, en_unites, pour_personnes

# ---- Les deux valeurs à changer -------------------------------------------
PERSONNES = 4
UNITES = "SI"      # "SI" ou "US"
# ---------------------------------------------------------------------------

ICI = Path(__file__).resolve().parent


def tabulate(donnees, headers=(), tablefmt="pipe"):
    """Un tableau Markdown, à partir de lignes et d'un en-tête.

    Même appel que la fonction de la bibliothèque `tabulate`, réduite au seul
    format dont on se sert ici.
    """
    lignes = ["| " + " | ".join(headers) + " |", "|" + "---|" * len(headers)]
    for donnee in donnees:
        lignes.append("| " + " | ".join(str(c) for c in donnee) + " |")
    return "\n".join(lignes)


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
