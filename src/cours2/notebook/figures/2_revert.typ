// « Annuler un commit » (parties/03_git_local.typ).
#import "_gabarit.typ": *
#import "../../../commun/schemas_git.typ": *
#show: schema-de-cours.with(largeur: auto)

#graphe-git(
  taille-etiquette: 11pt,
  echelle: 1.25,
  commits: (
    (nom: "k0", col: 0, voie: 0, etiquette: "commit 1"),
    (nom: "k1", col: 1, voie: 0, etiquette: "commit 2", teinte: rgb("#F5C6C6"), parents: ("k0",)),
    (nom: "k2", col: 2, voie: 0, etiquette: "commit 3", parents: ("k1",)),
  ),
  fleches: ((depuis: "k2", longueur: 0.9),),
  extra: (pos, d) => {
    pont(d, pos("k0"), pos("k2"), "Même état")
    d.content((pos("k2").at(0), pos("k2").at(1) - 0.55),
              text(size: 9pt, fill: accent)[git revert c2], anchor: "north")
  },
)
