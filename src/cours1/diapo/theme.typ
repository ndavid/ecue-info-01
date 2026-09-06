// Thème de diapositives du module.
//
// Chaque diapositive porte un titre descriptif, une phrase d'annonce si elle
// est nécessaire, puis une preuve visuelle (schéma, sortie, comparaison).
// Pas de liste à puces. Voir STYLE.md à la racine du dépôt.
//
// Aucune dépendance externe et uniquement des polices embarquées dans typst :
// `typst compile` fonctionne hors ligne, à l'identique sur tous les postes.
//
//   typst compile cours1.typ                        # diapositives seules
//   typst compile --input notes=true cours1.typ     # avec les notes de conduite

#let police-texte = ("Libertinus Serif",)
#let police-code = ("DejaVu Sans Mono",)

#let accent = rgb("#1f6f8b")
#let encre = rgb("#22252a")
#let estompe = rgb("#6f747c")

#let notes-visibles = sys.inputs.at("notes", default: "") == "true"

#let diapos(titre: "", sous-titre: "", auteur: "", date: "", corps) = {
  set page(
    paper: "presentation-16-9",
    // La version annotée réserve le bas de page pour les notes.
    margin: (x: 2.4cm, top: 2cm, bottom: if notes-visibles { 4.2cm } else { 1.6cm }),
    footer: context [
      #set text(size: 9pt, fill: estompe)
      #titre
      #h(1fr)
      #counter(page).display("1")
    ],
  )
  set text(font: police-texte, size: 21pt, fill: encre)
  set par(justify: false, leading: 0.72em)
  show raw: set text(font: police-code, size: 0.78em)
  show table.cell.where(y: 0): strong

  align(horizon + left)[
    #text(size: 38pt, fill: accent, weight: "bold")[#titre]
    #v(0.1em)
    #text(size: 21pt, fill: estompe)[#sous-titre]
    #v(1.6em)
    #text(size: 14pt, fill: estompe)[#auteur #h(1fr) #date]
  ]
  pagebreak()

  corps
}

// Une diapositive : un titre descriptif, puis le corps.
#let d(titre-diapo, corps) = {
  block(below: 1.1em, width: 100%)[
    #set text(size: 25pt, fill: accent, weight: "bold")
    #set par(leading: 0.5em)
    #titre-diapo
    #v(0.35em)
    #line(length: 100%, stroke: 0.8pt + accent.lighten(55%))
  ]
  // Corps légèrement au-dessus du centre optique : la preuve visuelle se lit
  // mieux là que collée sous le titre.
  v(0.55fr)
  corps
  v(1fr)
  pagebreak(weak: true)
}

// Diapositive de séparation, entre deux parties de la séance.
#let separateur(titre-partie, annonce: none) = {
  set page(footer: none)
  align(horizon + left)[
    #line(length: 28%, stroke: 2pt + accent)
    #v(0.6em)
    #text(size: 32pt, fill: accent, weight: "bold")[#titre-partie]
    #if annonce != none [
      #v(0.4em)
      #text(size: 19pt, fill: estompe)[#annonce]
    ]
  ]
  pagebreak(weak: true)
}

// Phrase d'annonce placée entre le titre et la preuve visuelle.
#let annonce(corps) = block(width: 100%, below: 0.8em)[
  #set text(size: 17pt)
  #corps
]

// Notes de conduite : ce que l'enseignant dit, et qui n'a donc pas à être
// projeté. Masquées par défaut (voir --input notes=true en tête de fichier).
#let notes(corps) = {
  if notes-visibles {
    place(bottom, dy: 1cm, block(width: 100%)[
      #line(length: 100%, stroke: 0.5pt + estompe.lighten(40%))
      #v(0.3em)
      #set text(size: 11pt, fill: estompe)
      #set par(leading: 0.55em)
      #corps
    ])
  }
}

// Légende sous une preuve visuelle (source, condition de mesure…).
#let legende(corps) = block(width: 100%, above: 0.6em)[
  #set text(size: 13pt, fill: estompe)
  #corps
]

// Deux colonnes de comparaison, pour opposer deux objets de même nature.
#let face-a-face(gauche, droite, ecart: 22pt) = grid(
  columns: (1fr, 1fr), gutter: ecart, gauche, droite,
)

// Étiquette d'un panneau de comparaison.
#let panneau(titre, corps) = block(width: 100%)[
  #text(size: 15pt, fill: estompe, weight: "semibold")[#titre]
  #v(0.35em)
  #corps
]
