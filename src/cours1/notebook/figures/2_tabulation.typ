// « L'indentation, en espaces ou en tabulation » (parties/02_programmation.typ).
#import "_gabarit.typ": *
#import "../../diapo/schemas.typ": blancs
#show: schema-de-cours

#face-a-face(
  panneau("Tabulation réglée sur 4 colonnes")[
    #blancs[#raw("def surface(longueur, largeur):\n····aire = longueur * largeur\n→   return aire", block: true)]
    #v(0.3em)
    #text(size: 14pt, fill: estompe)[les deux lignes semblent alignées]
  ],
  panneau("Le même fichier, tabulation sur 8")[
    #blancs[#raw("def surface(longueur, largeur):\n····aire = longueur * largeur\n→       return aire", block: true)]
    #v(0.3em)
    #text(size: 14pt, fill: brun)[le décalage apparaît]
  ],
)
