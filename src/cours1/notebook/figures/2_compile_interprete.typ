// « Deux chemins du texte à l'exécution » (parties/02_programmation.typ),
// sans les phrases d'explication, reprises dans la page.
#import "_gabarit.typ": *
#show: schema-de-cours

#block(width: 100%, fill: gris, inset: (x: 12pt, y: 7pt), below: 0.5em)[
  #text(size: 15pt, fill: estompe, weight: demi-gras)[Compilé]
  #v(0.25em)
  #chaine(
    ("bonjour.cpp", "le texte écrit"),
    ("compilateur", "une fois"),
    ("bonjour.exe", "des instructions"),
    ("résultat", "à chaque lancement"),
  )
]

#block(width: 100%, fill: accent.lighten(92%), inset: (x: 12pt, y: 7pt))[
  #text(size: 15pt, fill: accent, weight: demi-gras)[Interprété]
  #v(0.25em)
  #chaine(
    ("bonjour.py", "le texte écrit"),
    ("interpréteur", "à chaque lancement"),
    ("résultat", "rien sur le disque"),
  )
]
