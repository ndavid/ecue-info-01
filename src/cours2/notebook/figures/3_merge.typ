// « Fusionner deux branches », deuxième étape (parties/04_branches.typ) :
// le commit de fusion créé par git merge.
#import "_gabarit.typ": *
#import "_graphes.typ": *
#show: schema-de-cours.with(largeur: auto)

#graphe-git(
  commits: reference + (
    (nom: "c9", col: 4, voie: 0, etiquette: "merge", parents: ("c8", "c6")),
  ),
  branches: branches-reference,
  taille-etiquette: 11pt,
  echelle: 1.2,
  extra: (pos, d) => {
    etiquette-arete(d, pos("c6"), pos("c9"), "merge", decalage: (0.55, 0.1))
  },
)
