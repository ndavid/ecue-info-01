// Cours 3 — fichier d'assemblage.
//
// Même organisation que le cours 1 : `parties/` porte l'exposé, `tds/` les
// TD, et ce fichier ne pose que les réglages globaux et l'ordre. Particularité
// de cette séance : les deux premiers blocs d'exposé se jouent pendant que
// les étudiants exécutent un notebook (un pour la partie 1, deux pour la
// partie 2 : TD 2a puis TD 2b), et leurs diapositives portent le cartouche
// `cellule` qui renvoie à la section du notebook. L'ouverture du TD (lancer JupyterLab,
// ouvrir le fichier) précède donc l'exposé qu'elle accompagne.
//
//   python outils/compiler_diapos.py --cours 3
//   python outils/compiler_diapos.py --cours 3 --notes
//   python outils/compiler_diapos.py --cours 3 --corrige
//   python outils/compiler_diapos.py --cours 3 --sans-tds

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique",
  auteur-court: "1re année géomatique",
)

#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/0a_environnement.typ": td as td-0a
#import "tds/1a_recette.typ": td as td-1a
#import "tds/2a_fichiers.typ": td as td-2a
#import "tds/2b_images.typ": td as td-2b
#import "tds/3a_cli.typ": td as td-3a

// Les parties 1 et 2 se jouent notebook ouvert : leur ouverture est commune
// au TD, une page partagée entre le bleu de l'exposé et le brun du TD.
#let partie-1 = (
  titre: "Chemins",
  annonce: "Améliorer le code de génération de recette : ses chemins avec pathlib, sa conversion avec pandoc",
)
#let partie-2 = (
  titre: "Texte et binaire",
  annonce: "Comment le code ouvre, lit et écrit ses fichiers texte ; puis, sur des images au format PGM, ce qu'un fichier binaire contient et ce que le format change au poids et au temps de lecture",
)

#include "parties/00_ouverture.typ"

// TD d'environnement, selon les groupes (syllabus v1.5) : la partie 4 du
// cours 1 n'a pas été jouée en 2026.
#if tds {
  include "tds/0a_environnement.typ"
} else {
  sommaire-td(td-0a)
}

// L'ouverture commune vaut aussi sans les TD : l'exposé se suit notebook
// ouvert, et la page dit lequel.
#separateur-cours-td(
  partie-1.titre, annonce-partie: partie-1.annonce,
  notebook: "recette.ipynb", ..td-1a,
)
#if tds {
  include "tds/1a_recette.typ"
} else {
  sommaire-td(td-1a)
}
#include "parties/01_chemins.typ"

#separateur-cours-td(
  partie-2.titre, annonce-partie: partie-2.annonce,
  notebook: "fichiers.ipynb", ..td-2a,
)
#if tds {
  include "tds/2a_fichiers.typ"
} else {
  sommaire-td(td-2a)
}
#include "parties/02a_fichiers.typ"

// Seconde moitié de la partie 2 : le TD 2b fait ouvrir le notebook des images.
#if tds {
  include "tds/2b_images.typ"
} else {
  sommaire-td(td-2b)
}
#include "parties/02b_images.typ"

#include "parties/03_cli.typ"
#if tds {
  include "tds/3a_cli.typ"
} else {
  sommaire-td(td-3a)
}

#include "parties/99_cloture.typ"
