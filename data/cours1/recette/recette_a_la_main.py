"""La recette pour quatre personnes, sans autre bibliothèque que `markdown`.

    python recette_a_la_main.py

Le programme se lit de haut en bas : lire les ingrédients, les adapter au
nombre de convives et au système d'unités, en faire un tableau Markdown,
l'insérer dans la recette, convertir le tout en HTML, écrire la page.

Pour un autre nombre de convives ou un autre système d'unités, changez les
deux valeurs ci-dessous et relancez.

La fonction `tabulate` écrite ici porte le nom et la signature de celle de la
bibliothèque `tabulate`, qu'emploie `recette_avec_tabulate.py` : les deux
fichiers ne diffèrent que par là. C'est le plus court exemple de ce qu'une
bibliothèque fait à votre place.
"""

from pathlib import Path

import markdown

from recette import GABARIT, adapter, en_table, lire_ingredients

# ---- Les deux valeurs à changer -------------------------------------------
PERSONNES = 4
UNITES = "SI"      # "SI" ou "US"
# ---------------------------------------------------------------------------


def tabulate(donnees, headers=(), tablefmt="github"):
    """Un tableau Markdown, à partir de lignes et d'un en-tête.

    Même nom et même appel que la fonction de la bibliothèque `tabulate`,
    réduite au seul format dont on se sert ici.
    """
    lignes = []
    lignes.append("| " + " | ".join(headers) + " |")
    lignes.append("|" + "---|" * len(headers))
    for donnee in donnees:
        lignes.append("| " + " | ".join(donnee) + " |")
    return "\n".join(lignes)


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
