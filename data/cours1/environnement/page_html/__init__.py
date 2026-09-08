"""Conversion d'un fichier Markdown en page HTML autonome.

Le Markdown écrit à la partie 3 et le HTML ouvert à la partie 1 sont deux
écritures du même contenu. Passer de l'une à l'autre est un travail que
personne n'a besoin d'écrire : la bibliothèque `markdown` le fait, et il reste
à dire quel fichier lire et où poser le résultat.

Ce fichier porte la conversion. Ce qui s'exécute est dans `__main__.py`.
"""

from pathlib import Path

import markdown

__all__ = ["convertir", "GABARIT"]

# La page produite est volontairement minimale : un en-tête, un lien vers la
# feuille de style, et le contenu converti. C'est la structure vue à la
# première partie, où le `.html` porte le contenu et le `.css` la présentation.
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


def convertir(source: Path, dossier: Path) -> Path:
    """Écrit dans `dossier` la page HTML du fichier Markdown, et renvoie son chemin.

    La page est posée à côté de `style.css` : c'est ce qui permet au navigateur
    de trouver la feuille de style par un chemin relatif.
    """
    # Ni les tableaux ni les blocs de code ne font partie du Markdown publié en
    # 2004 : la bibliothèque sait les traduire, mais il faut le lui demander.
    corps = markdown.markdown(
        source.read_text(encoding="utf-8"),
        extensions=["tables", "fenced_code"],
    )
    page = dossier / (source.stem + ".html")
    page.write_text(GABARIT.format(titre=source.stem, corps=corps), encoding="utf-8")
    return page
