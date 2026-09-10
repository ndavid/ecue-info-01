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

// L'exposé est dans `parties/`, les manipulations dans `manips/`, une par
// fichier : chacune se compile aussi seule, en feuille d'instructions déposée
// dans son dossier de données (`outils/compiler_manips.py`).
//
// `--input manips=false` produit le support sans les manipulations, pour une
// relecture du seul fil du cours.
#let manips = sys.inputs.at("manips", default: "") != "false"

#include "parties/00_ouverture.typ"

#include "parties/01_logiciels.typ"
#if manips { include "manips/01_fichiers_formats.typ" }

#include "parties/02_programmation.typ"
#if manips {
  include "manips/02_hello_python.typ"
  include "manips/03_hello_cpp.typ"
  include "manips/04_programmes_fautifs.typ"
}

#include "parties/03_projet_python.typ"
#if manips {
  include "manips/07_markdown.typ"
  include "manips/05_environnement.typ"
}

#include "parties/04_notebooks.typ"
#if manips { include "manips/06_notebooks.typ" }
