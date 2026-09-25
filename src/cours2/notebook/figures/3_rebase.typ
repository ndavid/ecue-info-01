// « Fusionner deux branches », troisième étape (parties/04_branches.typ) :
// les commits de la branche 2 refaits au bout de la branche 1.
#import "_gabarit.typ": *
#import "_graphes.typ": *
#show: schema-de-cours.with(largeur: auto)

#let apres = (
  (nom: "c1", col: 0, voie: 0, etiquette: "commit 1"),
  (nom: "c4", col: 1, voie: 0, etiquette: "commit 4", parents: ("c1",)),
  (nom: "c7", col: 2, voie: 0, etiquette: "commit 7", parents: ("c4",)),
  (nom: "c8", col: 3, voie: 0, etiquette: "commit 8", parents: ("c7",)),
  (nom: "c5", col: 1.6, voie: 1, etiquette: "commit 5", parents: ("c4",)),
  (nom: "c2b", col: 3.7, voie: 2, etiquette: "commit 2 bis", parents: ("c8",)),
  (nom: "c3b", col: 5.2, voie: 2, etiquette: "commit 3 bis", parents: ("c2b",)),
  (nom: "c6b", col: 6.7, voie: 2, etiquette: "commit 6 bis", parents: ("c3b",)),
)

#align(center)[
  #graphe-reference(echelle: 0.95, branches: branches-reference)
  #v(-0.2em)
  #grid(
    columns: (auto, auto), column-gutter: 8pt, align: horizon,
    text(size: 26pt, fill: accent)[#sym.arrow.b],
    text(size: 14pt, weight: demi-gras, fill: accent)[git rebase branche_1 branche_2],
  )
  #v(-0.2em)
  #graphe-git(
    commits: apres,
    branches: (
      (nom: "branche 1", voie: 0, col: 3, ancre: "west"),
      (nom: "branche 2", voie: 2, col: 3.7, ancre: "east"),
    ),
    echelle: 0.95,
    taille-etiquette: 11pt,
  )
]
