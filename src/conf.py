"""Configuration Sphinx du book « Introduction à l'informatique ».

Construction (depuis la racine du dépôt) :

    sphinx-build -b html src _build/html      # site statique
    sphinx-autobuild src _build/html          # aperçu live pendant la rédaction

Le HTML produit utilise des **chemins relatifs** et n'appelle aucune ressource
externe : `_build/html/index.html` s'ouvre par double-clic, sans serveur et sans
connexion — c'est la contrainte de distribution aux étudiants.
"""

project = "Introduction à l'informatique"
author = "1re année géomatique"
copyright = "2026, module info01 — CC-BY-4.0"

extensions = [
    "myst_nb",        # Markdown MyST + exécution des cellules
    "sphinx_design",  # grilles et cartes (optionnel, utilisé par le thème)
]

# --- MyST -------------------------------------------------------------------
myst_enable_extensions = [
    "colon_fence",    # blocs :::{note} … :::
    "deflist",
]
# Le titre vient du frontmatter : MyST l'insère comme H1, le corps peut donc
# commencer en H2 sans déclencher d'avertissement.
myst_title_to_header = True
myst_heading_anchors = 3

# --- Exécution des notebooks ------------------------------------------------
# "cache" : n'exécute que ce qui a changé (première construction ~30 s,
# les suivantes quasi instantanées).
nb_execution_mode = "cache"
nb_execution_timeout = 120
nb_execution_raise_on_error = True   # une cellule qui échoue casse la build

# --- Rendu HTML -------------------------------------------------------------
html_theme = "sphinx_book_theme"
html_title = "Introduction à l'informatique"
html_static_path = ["_static"]
html_favicon = "_static/favicon.png"
html_theme_options = {
    "home_page_in_toc": True,
    "show_navbar_depth": 1,
    "use_download_button": False,
    # Pas de bouton « lancer sur Binder/Colab » : le book doit rester lisible
    # hors ligne.
    "launch_buttons": {},
}

exclude_patterns = ["_build", "**/diapo/**", "Thumbs.db", ".DS_Store"]
language = "fr"
