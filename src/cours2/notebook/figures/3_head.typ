// « Head » (parties/04_branches.typ) : HEAD avant et après git checkout.
#import "_gabarit.typ": *
#import "_graphes.typ": *
#show: schema-de-cours.with(largeur: auto)

#align(center)[
  #graphe-reference(echelle: 1.0, extra: (pos, d) => marque-tete(d, pos("c6")))
  #v(0.2em)
  #grid(
    columns: (auto, auto), column-gutter: 8pt, align: horizon,
    text(size: 26pt, fill: accent)[#sym.arrow.b],
    text(size: 14pt, weight: demi-gras, fill: accent)[git checkout commit_7],
  )
  #v(0.2em)
  #graphe-reference(echelle: 1.0, extra: (pos, d) => marque-tete(d, pos("c7"), dy: 0.85))
]
