// « Exemple de programme : l'objectif » (parties/04_projet_python.typ).
#import "_gabarit.typ": *
#show: schema-de-cours

#grid(
  columns: (auto, auto, auto, auto, 1fr),
  column-gutter: 11pt,
  align: horizon,
  // Les deux entrées, avec un extrait de leur contenu réel.
  grid(
    rows: 2, row-gutter: 9pt,
    block(width: 158pt, inset: (x: 9pt, y: 7pt), fill: gris,
          stroke: 0.8pt + gris.darken(15%))[
      #text(font: police-code, size: 12pt, weight: demi-gras)[ingredients.csv]
      #v(0.3em)
      #set text(font: police-code, size: 10.5pt, fill: estompe)
      #set par(leading: 0.55em)
      ingredient,quantite,unite \
      Farine,60,g \
      Lait,125,ml
    ],
    block(width: 158pt, inset: (x: 9pt, y: 7pt), fill: gris,
          stroke: 0.8pt + gris.darken(15%))[
      #text(font: police-code, size: 12pt, weight: demi-gras)[recette.md]
      #v(0.3em)
      #set text(font: police-code, size: 10.5pt, fill: estompe)
      #set par(leading: 0.55em)
      \# Crêpes \
      \*10 minutes de préparation.\* \
      … \
      \#\# Ingrédients
    ],
  ),
  fleche,
  block(width: 152pt, inset: (x: 10pt, y: 9pt), fill: accent.lighten(92%),
        stroke: 0.8pt + accent.lighten(55%))[
    #set text(size: 13pt)
    Multiplier les quantités, les convertir, et poser le tableau sous le
    titre « Ingrédients ».
  ],
  fleche,
  // La sortie, où l'on retrouve les mêmes lignes.
  block(width: 100%, inset: (x: 11pt, y: 7pt),
        stroke: 0.8pt + estompe.lighten(50%))[
    #text(size: 16pt, weight: "bold")[Crêpes]
    #v(0.2em)
    #text(size: 12pt, style: "italic", fill: estompe)[10 minutes de préparation.]
    #v(0.2em)
    #text(size: 12pt, fill: estompe)[…]
    #v(0.1em)
    #text(size: 14pt, weight: "bold")[Ingrédients]
    #v(0.1em)
    #show table.cell: set text(size: 12.5pt)
    #tableau(
      columns: (1fr, auto),
      align: left + horizon,
      [Ingrédient], [Quantité],
      [Farine], [240 g],
      [Lait], [500 ml],
    )
  ],
)
