// « La place de l'interpréteur » (parties/02_programmation.typ).
#import "_gabarit.typ": *
#show: schema-de-cours

#couche(
  icone-fenetre(taille: 30pt), "Programme interprété",
  "bonjour.py, une page web", plein: true,
)
#liaison("son texte", "le résultat")
#couche(
  icone-fenetre(taille: 30pt), "Interpréteur : traduit en bytecode, puis l'exécute",
  "python, le navigateur",
)
#liaison(
  [un appel système : #text(font: police-code)[open], #text(font: police-code)[read]],
  [des octets],
)
#couche(
  icone-engrenage(taille: 30pt), "Système d'exploitation",
  "Windows, macOS, Linux",
)
