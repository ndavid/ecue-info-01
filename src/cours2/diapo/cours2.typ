// Cours 2 — fichier d'assemblage.
//
// Portage du support Beamer de Florent Geniet (`livraison/cours2_florent/`),
// page pour page : 57 pages d'exposé, listes à puces et révélation
// progressive comprises. Les schémas sont redessinés dans
// `src/commun/schemas_git.typ` (graphes de commits) et `schemas.typ`.
//
//   python outils/compiler_diapos.py --cours 2              # à projeter
//   python outils/compiler_diapos.py --cours 2 --notes      # notes de conduite
//   python outils/compiler_diapos.py --cours 2 --corrige    # corrigé des TD
//   python outils/compiler_diapos.py --cours 2 --sans-tds   # le fil du cours
//
// Conventions d'écriture : STYLE.md à la racine. Gabarits : voir
// `src/cours1/diapo/README.md`.

#import "../../commun/prelude.typ": *
#import "beamer.typ": reglages-beamer

#show: diapos.with(
  titre-court: "Introduction à l’informatique",
  auteur-court: "1re année géomatique",
)
// Réglages propres à cette séance : voir `beamer.typ`.
#show: reglages-beamer

// Le TP d'origine est un seul exercice de 27 questions, découpé en cinq TD
// joués chacun après la partie qui l'outille. Le projet qu'ils construisent
// reste dans `cours2/3a_premier_depot/travail/projet_2`.
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
