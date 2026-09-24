// Les parties d'un chemin, reprises de « Quizz : vocabulaire associé aux
// chemins de fichier - Réponse » (parties/01_logiciels.typ).
#import "_gabarit.typ": *
#show: schema-de-cours.with(largeur: auto)

// Les étiquettes débordent de leur segment : la marge leur laisse la place.
#pad(x: 75pt)[
  #context {
    let taille = 25pt
    let segments = (
      (estompe, "C:\\", "la racine, ou le disque"),
      (brun, "Users\\alice\\Documents\\", "trois noms de dossier"),
      (accent, "raven.odt", "le nom du fichier, extension comprise"),
    )
    let morceau(couleur, chaine) = text(
      font: police-code, size: taille, fill: couleur,
      weight: if couleur == brun { demi-gras } else { "regular" },
      chaine,
    )
    grid(
      columns: segments.map(((c, t, _)) => measure(morceau(c, t)).width),
      column-gutter: 0pt,
      row-gutter: 13pt,
      ..segments.map(((c, t, _)) => morceau(c, t)),
      ..segments.map(((c, _, e)) => {
        let etiq = text(size: 14pt, fill: c)[#e]
        box(width: 100%, height: 1.2em)[
          #place(center + top, box(width: measure(etiq).width, etiq))
        ]
      }),
    )
  }
]

