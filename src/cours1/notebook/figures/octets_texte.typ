// Les huit premiers octets de raven_une_ligne.txt, repris de « Le fichier
// texte » (parties/01_logiciels.typ).
#import "_gabarit.typ": *
#show: schema-de-cours.with(largeur: auto)

#block(inset: (x: 12pt, y: 10pt), fill: gris)[
  #octets(
    ("4F", "6E", "63", "65", "20", "75", "70", "6F"),
    ("O", "n", "c", "e", "␣", "u", "p", "o"),
    taille: 16pt,
  )
]
