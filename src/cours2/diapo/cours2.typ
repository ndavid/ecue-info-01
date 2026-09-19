// Cours 2 — fichier d'assemblage.
//
// La séance reprend le support de Florent Geniet
// (`livraison/cours2_florent/`), composé sous Beamer avec le thème « Bruno »
// — celui-là même que `src/commun/theme.typ` porte en typst. Le portage suit
// le support d'origine diapositive par diapositive, listes à puces et
// révélation progressive comprises ; les 57 pages du PDF d'origine sont les
// 57 pages produites ici.
//
// Les schémas, qui étaient des images matricielles, sont redessinés :
// `src/commun/schemas_git.typ` pour les graphes de commits, que le cours 6
// reprendra, et `schemas.typ` pour le reste.
//
//   python outils/compiler_diapos.py --cours 2              # à projeter
//   python outils/compiler_diapos.py --cours 2 --notes      # notes de conduite
//   python outils/compiler_diapos.py --cours 2 --corrige    # corrigé des TD
//   python outils/compiler_diapos.py --cours 2 --sans-tds   # le fil du cours
//
// Conventions d'écriture : STYLE.md à la racine. Gabarits : voir
// `src/cours1/diapo/README.md`.

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique",
  auteur-court: "1re année géomatique",
)

// Le TP livré par Florent est un seul exercice filé : ses vingt-sept questions
// construisent le même projet. Il est découpé en cinq TD, joués chacun après
// la partie qui l'outille, et tous travaillent dans `cours2/TP_git/`.
#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/3a_premier_depot.typ": td as td-3a
#import "tds/4a_branches.typ": td as td-4a
#import "tds/4b_annuler.typ": td as td-4b
#import "tds/4c_conflits.typ": td as td-4c
#import "tds/6a_livrer.typ": td as td-6a

#include "parties/00_ouverture.typ"

#include "parties/01_ligne_commande.typ"

#include "parties/02_git_intro.typ"

#include "parties/03_git_local.typ"
#if tds {
  include "tds/3a_premier_depot.typ"
} else {
  sommaire-td(td-3a)
}

#include "parties/04_branches.typ"
#if tds {
  include "tds/4a_branches.typ"
  include "tds/4b_annuler.typ"
  include "tds/4c_conflits.typ"
} else {
  sommaire-td(td-4a, td-4b, td-4c)
}

#include "parties/05_informations.typ"

#include "parties/06_bonnes_pratiques.typ"
#if tds {
  include "tds/6a_livrer.typ"
} else {
  sommaire-td(td-6a)
}
