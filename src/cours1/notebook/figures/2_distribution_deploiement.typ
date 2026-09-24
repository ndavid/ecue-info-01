// « D'un programme à une application » (parties/02_programmation.typ).
#import "_gabarit.typ": *
#show: schema-de-cours

#block(width: 100%, fill: gris, inset: (x: 12pt, y: 5pt), below: 0.4em)[
  #text(size: 15pt, fill: estompe, weight: demi-gras)[Distribution]
  #v(0.25em)
  #chaine(
    ("le code source", "ce qu'on écrit"),
    ("empaquetage", "packaging"),
    ("une application", "qui s'installe"),
  )
]

#block(width: 100%, fill: accent.lighten(92%), inset: (x: 12pt, y: 5pt))[
  #text(size: 15pt, fill: accent, weight: demi-gras)[Déploiement]
  #v(0.25em)
  #chaine(
    ("le code source", "ce qu'on écrit"),
    ("mise en ligne", "déploiement"),
    ("une application web", "rien à installer"),
  )
]
