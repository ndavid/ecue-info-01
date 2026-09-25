// « Branches » (parties/04_branches.typ) : deux branches depuis le même commit.
#import "_gabarit.typ": *
#import "../../../commun/schemas_git.typ": *
#show: schema-de-cours.with(largeur: auto)

#graphe-git(
  taille-etiquette: 11pt,
  echelle: 1.5,
  commits: (
    (nom: "a", col: 0, voie: 0, id: "c1"),
    (nom: "b", col: 1, voie: 0, id: "c2", parents: ("a",)),
    (nom: "c", col: 1, voie: 1.6, id: "c3", parents: ("a",)),
  ),
  branches: (
    (nom: "branche", voie: 1.6, col: 1, ancre: "west", dy: 0.42),
    (nom: "master", voie: 0, col: 1, ancre: "west", dy: -0.42),
  ),
  fleches: ((depuis: "b", longueur: 0.9), (depuis: "c", longueur: 0.9)),
)
