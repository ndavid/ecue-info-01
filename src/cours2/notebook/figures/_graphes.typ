// Le graphe de référence des diapositives 17 à 20 (parties/04_branches.typ),
// repris pour les schémas de la page « Branches, fusion et conflits ».
#import "../../../commun/schemas_git.typ": *

// Deux branches depuis commit 1, et commit 5 seul sur une voie intermédiaire.
#let reference = (
  (nom: "c1", col: 0, voie: 0, etiquette: "commit 1"),
  (nom: "c4", col: 1, voie: 0, etiquette: "commit 4", parents: ("c1",)),
  (nom: "c7", col: 2, voie: 0, etiquette: "commit 7", parents: ("c4",)),
  (nom: "c8", col: 3, voie: 0, etiquette: "commit 8", parents: ("c7",)),
  (nom: "c2", col: 1, voie: 2, etiquette: "commit 2", parents: ("c1",)),
  (nom: "c3", col: 2, voie: 2, etiquette: "commit 3", parents: ("c2",)),
  (nom: "c6", col: 3, voie: 2, etiquette: "commit 6", parents: ("c3",)),
  (nom: "c5", col: 2, voie: 1, etiquette: "commit 5", parents: ("c4",)),
)

#let branches-reference = (
  (nom: "branche 1", voie: 0, col: 3, ancre: "west"),
  (nom: "branche 2", voie: 2, col: 0, ancre: "east"),
)

#let graphe-reference(echelle: 1.15, branches: (), extra: none) = graphe-git(
  commits: reference,
  taille-etiquette: 11pt,
  branches: branches,
  fleches: if branches.len() == 0 { ((depuis: "c8"),) } else { () },
  echelle: echelle,
  extra: extra,
)
