// Le nom et l'extension, repris de « Fichier, extension et type de fichier »
// (parties/01_logiciels.typ).
#import "_gabarit.typ": *
#show: schema-de-cours.with(largeur: auto)

#block[
  #grid(
    columns: (auto, auto),
    row-gutter: 9pt,
    align: center,
    text(font: police-code, size: 27pt, fill: estompe)[releve\_2026],
    text(font: police-code, size: 27pt, fill: accent, weight: "bold")[.csv],
    text(size: 13pt, fill: estompe)[le nom, que vous choisissez],
    text(size: 13pt, fill: accent)[l'extension],
  )
]
