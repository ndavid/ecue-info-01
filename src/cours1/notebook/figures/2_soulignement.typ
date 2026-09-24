// « Texte brut et règles du langage » (parties/02_programmation.typ) : la
// faute soulignée par l'éditeur.
#import "_gabarit.typ": *
#import "../../diapo/schemas.typ": souligne-ondule
#show: schema-de-cours.with(largeur: auto)

#block(
  inset: (x: 18pt, y: 9pt), fill: gris,
  stroke: 1pt + accent.lighten(62%),
)[
  #set text(size: 21pt)
  #set align(left)
  #raw("altitudes = [128.4, 131.0]") \
  #raw("for altitude in ")#souligne-ondule[#raw("altitudes")] \
  #raw("    print(altitude)")
]
