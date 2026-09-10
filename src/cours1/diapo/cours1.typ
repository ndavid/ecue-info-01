// Cours 1 — fichier d'assemblage.
//
// Le contenu est dans `parties/`, une partie de la séance par fichier. Ce
// fichier ne porte que les réglages globaux et l'ordre des parties : les
// règles `#show` posées ici s'appliquent à tout ce qui est inclus ensuite.
//
//   python outils/compiler_diapos.py                # à projeter
//   python outils/compiler_diapos.py --notes        # avec les notes de conduite
//   python outils/compiler_diapos.py --corrige      # corrigé des manipulations
//
// Conventions d'écriture : STYLE.md à la racine. Gabarits : parties/README
// n'existe pas, voir `src/cours1/diapo/README.md`.

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique",
  auteur-court: "1re année géomatique",
)

#include "parties/00_ouverture.typ"
#include "parties/01_logiciels.typ"
#include "parties/02_programmation.typ"
#include "parties/03_environnement.typ"
#include "parties/04_notebooks.typ"
#include "parties/05_formats_texte.typ"
