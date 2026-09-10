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

#import "theme.typ": accent, estompe, manip, demi-gras, police-code

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

// La même chaîne, empilée de haut en bas.
//
// Sert quand la largeur manque, par exemple lorsqu'une diapositive porte deux
// schémas côte à côte. Les boîtes y prennent la largeur disponible et leur
// hauteur propre : rien à mesurer, l'empilement n'ayant pas à les égaliser.
#let fleche-bas = align(center, text(size: 24pt, fill: accent)[↓])

#let chaine-verticale(..cellules, gabarit: etape, ecart: 4pt) = {
  let items = cellules.pos()
  let contenu = ()
  for (i, cellule) in items.enumerate() {
    if i > 0 { contenu.push(fleche-bas) }
    contenu.push(gabarit(..cellule))
  }
  grid(columns: 1, row-gutter: ecart, ..contenu)
}

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

// Hauteurs des captures d'écran. Elles valaient moins dans la version annotée,
// du temps où celle-ci prenait sa bande de notes sur la diapositive elle-même.
// Les notes étant désormais posées à droite, sur une page deux fois plus large,
// la zone de diapositive est la même dans les deux variantes : une seule valeur
// suffit, et la moitié gauche de la version annotée est au millimètre celle qui
// est projetée.
#let hauteur-capture = 235pt
#let hauteur-terminal = 166pt
// Pour les diapositives où la capture est seule : elle peut prendre la place.
#let hauteur-capture-pleine = 242pt


// Une frise chronologique : un axe daté, et une étiquette par repère.
//
// Les étiquettes alternent au-dessus et au-dessous de l'axe. C'est ce qui
// permet d'en placer six sans qu'elles se chevauchent, et de garder lisibles
// deux repères que deux ans séparent.
//
//   #frise(
//     (2008, "pip", "installe des paquets Python"),
//     (2012, "conda", "l'environnement et les paquets"),
//   )
//
// La position sur l'axe est proportionnelle à la date : c'est ce que la frise
// apporte sur un tableau, où les six lignes seraient équidistantes.
//
// La hauteur n'est pas écrite à la main. Les étiquettes sont posées avec
// `place`, qui ne contribue pas à la mise en page : sans mesure préalable,
// elles débordent du bloc et viennent se superposer à la légende. On mesure
// donc la plus haute et on dimensionne le bloc pour deux d'entre elles.
#let frise(..evenements, debut: none, fin: none, largeur-etiquette: 128pt, tige: 34pt) = {
  let items = evenements.pos()
  let annees = items.map(e => e.at(0))
  let a0 = if debut == none { calc.min(..annees) } else { debut }
  let a1 = if fin == none { calc.max(..annees) } else { fin }

  let etiquette(nom, annee, detail) = block(width: largeur-etiquette)[
    #align(center)[
      #text(size: 16pt, weight: demi-gras, fill: accent)[#nom]
      #h(5pt)
      #text(size: 14pt, fill: estompe)[#str(annee)]
      #v(0.15em)
      #text(size: 12pt, fill: estompe)[#detail]
    ]
  ]

  context {
    let haut-etiquette = calc.max(
      ..items.map(e => measure(etiquette(e.at(1), e.at(0), e.at(2))).height),
    )
    // Deux étiquettes, deux tiges, et le rayon du point au milieu.
    let hauteur = 2 * (haut-etiquette + tige) + 10pt
    let axe = hauteur / 2

    layout(dispo => {
      // La demi-étiquette de marge de chaque côté garde la première et la
      // dernière dans la page.
      let marge = largeur-etiquette / 2
      let large = dispo.width - 2 * marge
      let x = annee => marge + large * (annee - a0) / (a1 - a0)

      block(width: 100%, height: hauteur, {
        place(top + left, dy: axe, line(length: 100%, stroke: 1pt + accent.lighten(35%)))
        for (i, item) in items.enumerate() {
          let (annee, nom, detail) = item
          let dessus = calc.rem(i, 2) == 0
          let cx = x(annee)

          place(top + left, dx: cx - 3.5pt, dy: axe - 3.5pt,
                circle(radius: 3.5pt, fill: accent))
          place(top + left, dx: cx, dy: if dessus { axe - tige } else { axe },
                line(angle: 90deg, length: tige, stroke: 0.8pt + accent.lighten(45%)))
          place(
            top + left,
            dx: cx - largeur-etiquette / 2,
            dy: if dessus { axe - tige - haut-etiquette } else { axe + tige },
            block(width: largeur-etiquette, height: haut-etiquette)[
              #align(if dessus { bottom } else { top })[
                #etiquette(nom, annee, detail)
              ]
            ],
          )
        }
      })
    })
  }
}

// ---------------------------------------------------------------------------
// Une poignée d'octets, et ce qu'ils donnent lus comme des caractères
//
// Deux lignes alignées colonne par colonne : la valeur hexadécimale au-dessus,
// le caractère au-dessous. Un octet qui ne correspond à aucun caractère
// affichable porte un point médian estompé, comme le montrerait un éditeur.
// La colonne, et non la flèche, fait le lien entre les deux lectures.
#let octets(valeurs, caracteres, taille: 15pt) = grid(
  columns: valeurs.len(),
  column-gutter: 6pt,
  row-gutter: 5pt,
  ..valeurs.map(v => align(center, text(font: police-code, size: taille, fill: accent)[#v])),
  ..caracteres.map(c => align(center, if c == none {
    text(font: police-code, size: taille, fill: estompe)[·]
  } else {
    text(font: police-code, size: taille, weight: demi-gras, fill: manip)[#c]
  })),
)
