// « Entrées et sorties d'un logiciel » (parties/01_logiciels.typ).
#import "_gabarit.typ": *
#show: schema-de-cours

#layout(dispo => context {
  let ecart = 34pt
  let largeur = (dispo.width - 2 * ecart) / 3
  let gouttiere = 10pt
  let entrees = (
    ("Entrée : un fichier", "un relevé GPS, une image"),
    ("Entrée : un périphérique", "clavier, souris, réseau"),
  )
  let sorties = (
    ("Sortie : un fichier", "une image, un tableau, une vidéo"),
    ("Sortie : un périphérique", "écran, son, réseau"),
  )
  let hauteur = calc.max(
    measure(bloc("Traitement", "le logiciel"), width: largeur).height,
    ..(entrees + sorties).map(
      s => 2 * measure(bloc(..s), width: largeur).height + gouttiere,
    ),
  )
  let colonne(paire) = grid(
    rows: ((hauteur - gouttiere) / 2,) * 2, row-gutter: gouttiere,
    ..paire.map(s => bloc(..s, hauteur: 100%)),
  )
  grid(
    columns: (largeur, ecart, largeur, ecart, largeur),
    rows: hauteur,
    align: horizon,
    colonne(entrees),
    fleche,
    bloc("Traitement", "le logiciel", plein: true, hauteur: hauteur),
    fleche,
    colonne(sorties),
  )
})
