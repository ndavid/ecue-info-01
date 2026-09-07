// Schémas des supports du module : boîtes, chaînes et piles de couches.
//
// Ces gabarits vivaient en tête de `cours1.typ`, où les autres séances ne
// pouvaient pas les atteindre alors qu'ils n'ont rien de propre au cours 1.
// Ils ne dépendent du thème que par ses couleurs et ses graisses.
//
// Aucune hauteur n'y est écrite à la main : `chaine` mesure ses boîtes à la
// largeur qu'elles occuperont et impose la plus haute à toutes. Une valeur
// fixe dépendrait de la police effectivement installée, et c'est ainsi que du
// texte est passé par-dessus le bord de ses cadres.

#import "theme.typ": accent, estompe, demi-gras, notes-visibles

#let bloc(titre, detail, plein: false, hauteur: auto) = block(
  width: 100%, height: hauteur, inset: 12pt,
  fill: if plein { accent.lighten(88%) } else { none },
  stroke: 1pt + accent.lighten(if plein { 40% } else { 65% }),
)[
  #align(center + horizon)[
    #text(size: 19pt, weight: "semibold")[#titre]
    #if detail != "" [
      #v(0.25em)
      #text(size: 14pt, fill: estompe)[#detail]
    ]
  ]
]

#let fleche = align(horizon + center, text(size: 26pt, fill: accent)[→])

// Met une cellule de tableau en valeur sans introduire de couleur nouvelle :
// le fond est celui des blocs pleins du thème.
#let surligne(corps) = table.cell(fill: accent.lighten(90%))[#corps]

// Une étape d'une chaîne de traitement, plus compacte que `bloc`.
#let etape(titre, detail, hauteur: auto) = block(
  width: 100%, height: hauteur, inset: (x: 8pt, y: 5pt), fill: white,
  stroke: 1pt + accent.lighten(55%),
)[
  #align(center + horizon)[
    #text(size: 15pt, weight: demi-gras)[#titre]
    #if detail != "" [
      #v(0.15em)
      #text(size: 11.5pt, fill: estompe)[#detail]
    ]
  ]
]

// Une suite de boîtes reliées par des flèches, toutes à la même hauteur.
//
// Cette hauteur n'est pas écrite à la main : elle est mesurée sur les boîtes,
// à la largeur qu'elles occuperont, puis imposée à toutes. Une valeur fixe
// dépendrait de la police effectivement présente sur le poste, et c'est ainsi
// que le texte débordait des cadres quand Fira Sans manquait.
//
//   #chaine(("raven.c", "le texte écrit"), ("raven.exe", "des instructions"))
//
// `gabarit` choisit entre `etape` (compacte) et `bloc` ; `pleins` donne les
// indices des boîtes à remplir, que seul `bloc` sait faire.
#let chaine(..cellules, gabarit: etape, ecart: 26pt, pleins: ()) = layout(dispo => {
  let items = cellules.pos()
  let n = items.len()
  let largeur = (dispo.width - ecart * (n - 1)) / n
  let boite(i, hauteur) = if gabarit == bloc {
    bloc(..items.at(i), plein: pleins.contains(i), hauteur: hauteur)
  } else {
    gabarit(..items.at(i), hauteur: hauteur)
  }

  context {
    let hauteur = calc.max(
      ..range(n).map(i => measure(boite(i, auto), width: largeur).height),
    )
    let colonnes = ()
    let contenu = ()
    for i in range(n) {
      if i > 0 {
        colonnes.push(ecart)
        contenu.push(fleche)
      }
      colonnes.push(largeur)
      contenu.push(boite(i, hauteur))
    }
    grid(columns: colonnes, rows: hauteur, align: horizon, ..contenu)
  }
})

// Une couche du schéma en pile : pictogramme, nom, exemples.
#let couche(icone, titre, exemples, plein: false) = block(
  width: 100%, inset: (x: 14pt, y: 5pt),
  fill: if plein { accent.lighten(90%) } else { none },
  stroke: 1pt + accent.lighten(if plein { 35% } else { 62% }),
)[
  #grid(
    columns: (34pt, auto, 1fr), column-gutter: 14pt, align: horizon,
    icone,
    text(size: 19pt, weight: "semibold")[#titre],
    align(right, text(size: 14pt, fill: estompe)[#exemples]),
  )
]

// Ce qui circule entre deux couches, dans les deux sens.
#let liaison(descendant, montant) = block(width: 100%, inset: (y: 1pt))[
  #grid(
    columns: (1fr, 1fr), column-gutter: 24pt,
    align(right)[
      #text(size: 13.5pt, fill: estompe)[#descendant]
      #h(7pt) #text(size: 18pt, fill: accent)[↓]
    ],
    align(left)[
      #text(size: 18pt, fill: accent)[↑] #h(7pt)
      #text(size: 13.5pt, fill: estompe)[#montant]
    ],
  )
]

#let hauteur-capture = if notes-visibles { 190pt } else { 235pt }
#let hauteur-terminal = if notes-visibles { 112pt } else { 166pt }
// Pour les diapositives où la capture est seule : elle peut prendre la place.
#let hauteur-capture-pleine = if notes-visibles { 192pt } else { 242pt }

