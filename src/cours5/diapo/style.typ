// Réglages propres au cours 5.
//
//     #import "../style.typ": terminal
//
// `terminal` affiche une session de terminal telle quelle : le texte est passé
// en chaîne brute, si bien que les guillemets restent droits et que `--` reste
// deux tirets, ce que le balisage typst transformerait en « » et en tiret
// demi-cadratin. Les sorties montrées sont des sorties réelles.
#import "../../commun/prelude.typ": *

#let terminal(titre, texte, taille: 14pt, hauteur: auto) = fenetre(titre, hauteur: hauteur)[
  #set text(size: taille / 0.78)
  #set par(leading: 0.55em)
  #raw(block: true, texte)
]
