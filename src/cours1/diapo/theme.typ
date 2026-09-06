// Thème de diapositives du module.
//
// Reprend l'identité du thème Beamer « Bruno » (Rémi Cérès et Mattéo Delabre,
// 2017-2019, licence CC0 1.0), analysé et porté dans `themes/bruno/`. Les
// valeurs relevées sur le PDF Beamer de référence y sont documentées ; elles
// sont ici transposées à une page de projection plus grande, en conservant les
// rapports d'origine (facteur 1,909, qui laisse le corps de texte à 21 pt).
//
// Chaque diapositive porte un titre descriptif, une phrase d'annonce si elle
// est nécessaire, puis une preuve visuelle (schéma, sortie, comparaison).
// Pas de liste à puces. Voir STYLE.md à la racine du dépôt.
//
//   typst compile cours1.typ                        # diapositives seules
//   typst compile --input notes=true cours1.typ     # avec les notes de conduite

// Bruno impose Fira Sans avec `BoldFont={* Medium}` : son « gras » n'est que du
// demi-gras. Fira Sans n'étant pas toujours installée, la pile retombe sur
// Lato, qui possède également une graisse 500.
#let police-texte = ("Fira Sans", "Lato", "DejaVu Sans")
#let police-code = ("DejaVu Sans Mono",)

// Les trois couleurs du thème d'origine, et rien de plus.
#let accent = rgb("#182936")      // brunoblue : texte, titres, structure
#let encre = rgb("#182936")
#let estompe = rgb("#6b7683")     // dérivée pour le texte secondaire
#let manip = rgb("#704730")       // brunomarroon : filet, et parties TD
#let gris = rgb("#E6E6E6")        // brunolightgray : pied de page, blocs

// Le « gras » du thème, qui est un demi-gras.
#let demi-gras = 500

// Tailles de Bruno (classe 11 pt) multipliées par 1,909.
#let pt-tiny = 11.5pt             // pied de page
#let pt-footnotesize = 17pt
#let pt-normalsize = 21pt
#let pt-LARGE = 33pt              // titre de diapositive et de la page de titre

#let marge-x = 18.5mm             // 10 mm sur 160 mm, transposé
#let hauteur-pied = 21.6pt

#let notes-visibles = sys.inputs.at("notes", default: "") == "true"

// Petites capitales : ni Fira Sans ni Lato ne portent de table `smcp`, donc
// `smallcaps()` resterait sans effet. On les fabrique.
#let petites-capitales(corps) = text(size: 0.85em, tracking: 0.08em)[
  #upper(corps)
]

// Image de la page de titre, découpée en trapèze le long du bord droit. Beamer
// rogne avec \clip ; typst ne sait pas rogner selon une forme quelconque, donc
// la gauche est masquée par un polygone blanc. Proportions d'origine : le
// trapèze fait 32 % de la largeur en haut et 51 % en bas.
#let fond-titre(chemin, largeur, hauteur) = {
  place(top + right, image(chemin, height: hauteur))
  place(top + right, rect(
    width: 62% * largeur, height: hauteur,
    fill: gradient.linear(
      rgb("#000000"), rgb("#00000000"), angle: -15deg, space: rgb,
    ),
  ))
  place(top + left, polygon(
    fill: white,
    (0pt, 0pt),
    (0.68 * largeur, 0pt),
    (0.49 * largeur, hauteur),
    (0pt, hauteur),
  ))
}

#let diapos(
  titre: "",
  sous-titre: "",
  auteur: "",
  date: "",
  fond: none,
  titre-court: none,
  auteur-court: none,
  corps,
) = {
  let titre-pied = if titre-court != none { titre-court } else { titre }
  let auteur-pied = if auteur-court != none { auteur-court } else { auteur }

  set text(font: police-texte, size: pt-normalsize, fill: encre, lang: "fr")
  set par(justify: false, leading: 0.65em)
  show strong: set text(weight: demi-gras)
  show raw: set text(font: police-code, size: 0.78em)

  // itemize item [square], itemize subitem [circle].
  set list(
    marker: (
      text(fill: accent, size: 0.7em)[■],
      text(fill: accent, size: 0.7em)[●],
    ),
    indent: 11pt, body-indent: 13pt, spacing: 0.62em,
  )
  show list: set block(above: 0.62em, below: 0.62em)

  set page(
    paper: "presentation-16-9",
    // Le bandeau supérieur est vidé par le thème : la zone de texte commence au
    // bord du papier. La version annotée réserve en plus le bas de page.
    margin: (
      x: marge-x,
      top: 0mm,
      bottom: if notes-visibles { 36mm } else { 10.3mm },
    ),
    // La barre de pied de page est posée en avant-plan, seul moyen de la coller
    // au bord inférieur et de la faire courir sur toute la largeur du papier,
    // comme le fait Beamer en donnant à \textwidth la valeur de \paperwidth.
    foreground: context {
      let numero = counter(page).get().first()
      let total = counter(page).final().first()
      place(bottom + left, block(
        width: 100%, height: hauteur-pied, fill: gris, inset: (x: marge-x),
      )[
        #set text(size: pt-tiny, fill: accent)
        #align(horizon)[
          #titre-pied
          #h(1fr)
          #auteur-pied
          #h(2em)
          #numero #sym.slash #total
        ]
      ])
    },
  )

  corps
}

// Page de titre, posée explicitement là où on la veut : le deck peut ainsi
// ouvrir sur la couverture du module et ne présenter la séance qu'ensuite.
// Beamer ne centre pas ce bloc : il répartit l'espace libre selon
// \beamer@frametopskip contre \beamer@framebottomskip, soit 0,4 contre 0,6.
#let page-titre(titre: "", sous-titre: "", auteur: "", date: "", fond: none) = {
  context {
    let l = page.width
    let h = page.height
    page(
      background: if fond != none { fond-titre(fond, l, h) },
      {
        v(0.4fr)
        block(width: 70%)[
          #text(size: pt-LARGE, weight: demi-gras)[#titre]
          #v(0.2em)
          #line(length: 70%, stroke: 0.955pt + manip)
          #v(1.35em)
          #text(size: pt-normalsize)[#sous-titre]
          #v(1.4em)
          #text(size: pt-footnotesize)[
            #auteur \
            #date
          ]
        ]
        v(0.6fr)
      },
    )
  }
}

// Couverture du module : la seule diapositive qui présente l'ensemble des sept
// séances, et la seule à porter la mention de l'auteur sur fond plein.
#let separateur-module(titre-module, annonce: none, auteur: "", date: "") = {
  set page(foreground: none, fill: accent)
  align(horizon + left, block(width: 82%)[
    #text(size: pt-footnotesize, fill: manip.lighten(30%), weight: demi-gras)[
      #petites-capitales("Module")
    ]
    #v(0.5em)
    #text(size: pt-LARGE * 1.15, fill: white, weight: demi-gras)[#titre-module]
    #v(0.45em)
    #line(length: 45%, stroke: 1.5pt + manip.lighten(25%))
    #if annonce != none [
      #v(0.6em)
      #text(size: pt-normalsize, fill: white.darken(18%))[#annonce]
    ]
    #v(2.2em)
    #text(size: pt-footnotesize, fill: white.darken(32%))[
      #auteur #h(1fr) #date
    ]
  ])
  pagebreak(weak: true)
}

// Une diapositive : un titre descriptif, un sous-titre facultatif en petites
// capitales, puis le corps. Décalage du titre et rapport de centrage du corps
// relevés sur le PDF Beamer (26 pt sur 255, et 0,85 contre 1).
#let d(titre-diapo, sous-titre: none, corps) = {
  v(52.5pt)
  block(below: 0em)[
    #set text(size: pt-LARGE, fill: accent, weight: demi-gras)
    #set par(leading: 0.4em)
    #titre-diapo
    #if sous-titre != none [
      #linebreak()
      #text(size: pt-normalsize, fill: estompe)[
        #petites-capitales(sous-titre)
      ]
    ]
  ]
  v(0.85fr)
  corps
  v(1fr)
  pagebreak(weak: true)
}

// Gabarit commun aux diapositives de séparation : fond plein, filet et titre.
// Bruno n'en fournit aucun ; celui-ci n'emploie que les couleurs du thème.
#let _separation(fond, sur-fond, filet, titre-partie, annonce, mention) = {
  set page(foreground: none, fill: fond)
  align(horizon + left, block(width: 78%)[
    #if mention != none [
      #text(size: pt-footnotesize, fill: filet, weight: demi-gras)[
        #petites-capitales(mention)
      ]
      #v(0.5em)
    ]
    #line(length: 40%, stroke: 1.5pt + filet)
    #v(0.7em)
    #text(size: pt-LARGE, fill: sur-fond, weight: demi-gras)[#titre-partie]
    #if annonce != none [
      #v(0.45em)
      #text(size: pt-normalsize, fill: sur-fond.lighten(35%))[#annonce]
    ]
  ])
  pagebreak(weak: true)
}

// Diapositive de section, entre deux parties de la séance : fond bleu.
#let separateur(titre-partie, annonce: none, mention: none) = _separation(
  accent, white, manip.lighten(25%), titre-partie, annonce, mention,
)

// Ouverture d'une partie de travaux dirigés : fond brun, la seconde couleur du
// thème. Elle code une information réelle et répétée, le passage de l'exposé au
// travail sur machine.
#let separateur-td(titre-td, annonce: none, mention: "Travaux dirigés") = {
  _separation(manip, white, gris, titre-td, annonce, mention)
}

// Ouverture d'un bloc de manipulation à l'intérieur d'un cours : même gabarit
// que les travaux dirigés, mention différente.
#let separateur-manip(titre-manip, annonce: none) = separateur-td(
  titre-manip, annonce: annonce, mention: "Manipulation",
)

// Phrase d'annonce placée entre le titre et la preuve visuelle.
#let annonce(corps) = block(width: 100%, below: 0.8em)[
  #set text(size: 17pt)
  #corps
]

// Notes de conduite : ce que l'enseignant dit, et qui n'a donc pas à être
// projeté. Masquées par défaut (voir --input notes=true en tête de fichier).
#let notes(corps) = {
  if notes-visibles {
    place(bottom, dy: 2.3cm, block(width: 100%)[
      #line(length: 100%, stroke: 0.5pt + estompe.lighten(40%))
      #v(0.25em)
      #set text(size: 10pt, fill: estompe)
      #set par(leading: 0.5em)
      #corps
    ])
  }
}

// Légende sous une preuve visuelle (source, condition de mesure…).
#let legende(corps) = block(width: 100%, above: 0.6em)[
  #set text(size: 13pt, fill: estompe)
  #corps
]

// Tableau.
//
// Le style est ici et nulle part ailleurs : les diapositives ne passent que le
// contenu, les colonnes et l'alignement. Le corps est réduit d'un cran par
// rapport au texte courant, les colonnes sont séparées par un filet, et la
// ligne d'en-tête ressort par un fond très clair, un demi-gras et un filet
// plus marqué.
//
// `entete: false` pour un tableau dont la première ligne est déjà une donnée,
// comme les tableaux d'appariement « terme / définition ».
#let tableau(entete: true, ..args) = {
  let filet-leger = 0.4pt + gris.darken(10%)
  let contenu = table(
    inset: (x: 9pt, y: 7pt),
    fill: (x, y) => if entete and y == 0 { gris.lighten(45%) },
    stroke: (x, y) => (
      left: if x > 0 { 0.5pt + gris.darken(6%) },
      top: if y == 0 { none } else if y == 1 and entete {
        0.9pt + accent
      } else { filet-leger },
    ),
    ..args,
  )
  set text(size: pt-footnotesize)
  if entete {
    show table.cell.where(y: 0): set text(weight: demi-gras)
    contenu
  } else {
    contenu
  }
}

// Deux colonnes de comparaison, pour opposer deux objets de même nature.
#let face-a-face(gauche, droite, ecart: 22pt) = grid(
  columns: (1fr, 1fr), gutter: ecart, gauche, droite,
)

// Étiquette d'un panneau de comparaison.
#let panneau(titre, corps) = block(width: 100%)[
  #text(size: 15pt, fill: estompe, weight: demi-gras)[#titre]
  #v(0.35em)
  #corps
]

// ---------------------------------------------------------------------------
// Pictogrammes
//
// Dessinés avec les primitives de typst (rect, circle, line, rotate) : ni
// police d'icônes, ni fichier externe, donc rien à installer. Ils servent à
// distinguer les couches d'un schéma, jamais à décorer.

#let icone-fenetre(taille: 34pt, couleur: accent) = box(
  width: taille, height: taille * 0.78,
)[
  #place(top + left, rect(
    width: taille, height: taille * 0.78, radius: 2pt, stroke: 1.6pt + couleur,
  ))
  #place(top + left, rect(
    width: taille, height: taille * 0.2, radius: 2pt, fill: couleur,
  ))
  #place(top + left, dx: taille * 0.08, dy: taille * 0.05,
         circle(radius: taille * 0.04, fill: white))
  #place(top + left, dx: taille * 0.2, dy: taille * 0.05,
         circle(radius: taille * 0.04, fill: white))
]

#let icone-engrenage(taille: 34pt, couleur: accent) = box(
  width: taille, height: taille,
)[
  #for i in range(6) {
    place(center + horizon, rotate(i * 30deg, rect(
      width: taille * 0.16, height: taille * 0.98, radius: 1pt, fill: couleur,
    )))
  }
  #place(center + horizon, circle(radius: taille * 0.33, fill: couleur))
  #place(center + horizon, circle(radius: taille * 0.14, fill: white))
]

#let icone-puce(taille: 34pt, couleur: accent) = box(
  width: taille, height: taille,
)[
  #let c = taille * 0.6
  #for i in range(3) {
    let d = (i - 1) * c * 0.33
    place(center + horizon, dx: d, dy: -c * 0.62,
          rect(width: 1.6pt, height: c * 0.2, fill: couleur))
    place(center + horizon, dx: d, dy: c * 0.62,
          rect(width: 1.6pt, height: c * 0.2, fill: couleur))
    place(center + horizon, dx: -c * 0.62, dy: d,
          rect(width: c * 0.2, height: 1.6pt, fill: couleur))
    place(center + horizon, dx: c * 0.62, dy: d,
          rect(width: c * 0.2, height: 1.6pt, fill: couleur))
  }
  #place(center + horizon, rect(
    width: c, height: c, radius: 2pt, stroke: 1.6pt + couleur,
  ))
  #place(center + horizon, rect(
    width: c * 0.38, height: c * 0.38, radius: 1pt, fill: couleur,
  ))
]

// ---------------------------------------------------------------------------

// Question posée à la salle, à laquelle les étudiants répondent à l'oral.
#let question(numero, corps) = block(
  width: 100%, inset: (x: 14pt, y: 11pt),
  fill: gris, stroke: (left: 3pt + accent),
)[
  #grid(
    columns: (auto, 1fr), column-gutter: 12pt, align: horizon,
    text(size: 21pt, fill: accent, weight: demi-gras)[#numero],
    text(size: 18pt)[#corps],
  )
]

// Étiquette d'extension, en chasse fixe, pour les grilles de reconnaissance.
#let etiquette(nom, reponse: none) = block(
  width: 100%, inset: (x: 8pt, y: 6pt),
  fill: gris, stroke: 0.8pt + gris.darken(12%),
)[
  #align(center)[
    #text(font: police-code, size: 16pt, weight: demi-gras, fill: accent)[#nom]
    #if reponse != none [
      #v(0.25em)
      #text(size: 12pt, fill: estompe)[#reponse]
    ]
  ]
]

// Bloc Beamer : bandeau de titre bleu sur texte blanc, corps sur fond gris,
// angles vifs. Le thème d'origine n'appelle jamais blocks[rounded].
#let bloc-titre(titre, corps) = block(width: 100%, breakable: false)[
  #block(width: 100%, fill: accent, inset: (x: 11pt, y: 7pt))[
    #text(fill: white, size: pt-normalsize)[#titre]
  ]
  #block(width: 100%, fill: gris, inset: (x: 11pt, y: 11pt))[
    #corps
  ]
]
