// Portage en typst du thème Beamer « Bruno ».
//
// Thème d'origine : Rémi Cérès et Mattéo Delabre, 2017-2019, licence CC0 1.0.
// Inspiré du thème Metropolis. Les fichiers analysés sont dans
// `example_beamer/` : beamercolortheme, beamerfonttheme, beamerinnertheme et
// beamerouterthemeBruno.sty. La correspondance ligne à ligne est dans
// README.md ; les écarts assumés y sont signalés.
//
//   typst compile demo.typ
//
// Police : le thème d'origine impose Fira Sans avec `BoldFont={* Medium}`,
// c'est-à-dire un « gras » qui n'est en réalité que du demi-gras. Fira Sans
// n'étant pas toujours installée, la pile de substitution ci-dessous retombe
// sur Lato, qui possède également une graisse 500.

#let police = ("Fira Sans", "Lato", "DejaVu Sans")

// --------------------------------- Couleurs ---------------------------------
// \definecolor du beamercolortheme, reprises telles quelles.

#let bleu = rgb("#182936")        // brunoblue   : texte et structure
#let marron = rgb("#704730")      // brunomarroon: filet de la page de titre
#let gris = rgb("#E6E6E6")        // brunolightgray : pied de page, corps de bloc

// ----------------------------- Corps de tailles -----------------------------
// Beamer tourne ici en classe 11 pt. Les tailles nommées de LaTeX sont
// reprises à l'identique pour que les proportions soient celles de l'original.

#let pt-footnotesize = 9pt
#let pt-small = 10pt
#let pt-normalsize = 11pt
#let pt-large = 12pt
#let pt-Large = 14.4pt
#let pt-LARGE = 17.28pt

// Le « gras » du thème, qui est un demi-gras (BoldFont={* Medium}).
#let demi-gras = 500

// Petites capitales du sous-titre de diapositive (\scshape dans l'original).
// Ni Fira Sans ni Lato ne portent de table `smcp` : `smallcaps()` n'aurait
// aucun effet visible, pas plus que le \scshape de l'original. On les
// fabrique donc, en capitales légèrement réduites et espacées.
#let petites-capitales(corps) = text(
  size: 0.85em, tracking: 0.04em,
)[#upper(corps)]

// ------------------------------- Géométrie ---------------------------------
// aspectratio=169 : Beamer produit une page de 160 mm sur 90 mm. La conserver
// permet de reprendre les tailles de police sans les recalculer.

#let largeur-page = 160mm      // mesuré : 453,543 pt
#let hauteur-page = 90mm       // mesuré : 255,118 pt
#let marge-x = 10mm            // mesuré : texte à 28,3 pt du bord

// Pied de page. Le gabarit d'origine demande ht=3ex + dp=1,25ex, évalués dans
// la police du pied (\tiny, soit 6 pt) : 11,3 pt mesurés sur le PDF Beamer.
// La barre couvre toute la largeur du papier, Beamer donnant à \textwidth la
// valeur de \paperwidth à l'intérieur d'un gabarit de pied de page.
#let pt-tiny = 6pt
#let hauteur-pied = 11.3pt

// ------------------------------ Page de titre -------------------------------
// L'image de fond est découpée en trapèze le long du bord droit, et voilée par
// un dégradé noir qui s'éteint vers la droite. Beamer découpe avec \clip ;
// typst ne sait pas rogner selon une forme quelconque, donc le même résultat
// est obtenu en masquant la gauche par un polygone blanc.
//
// Coordonnées du trapèze, mesurées depuis le coin bas droit dans le fichier
// d'origine : 51 mm de large en haut, 81 mm en bas.

#let fond-titre(chemin) = {
  place(top + right, image(chemin, height: hauteur-page))
  place(top + right, rect(
    width: 100mm, height: hauteur-page,
    fill: gradient.linear(
      rgb("#000000"), rgb("#00000000"), angle: -15deg, space: rgb,
    ),
  ))
  place(top + left, polygon(
    fill: white,
    (0mm, 0mm),
    (largeur-page - 51mm, 0mm),
    (largeur-page - 81mm, hauteur-page),
    (0mm, hauteur-page),
  ))
}

// Filet horizontal du gabarit `separator` : 0,7 largeur de texte, 0,5 pt.
#let filet = line(
  length: 70% * (largeur-page - 2 * marge-x),
  stroke: 0.5pt + marron,
)

// --------------------------------- Document ---------------------------------

#let bruno(
  titre: "",
  auteurs: (),
  institut: "",
  date: "",
  fond: none,
  titre-court: none,
  auteur-court: none,
  corps,
) = {
  let titre-pied = if titre-court != none { titre-court } else { titre }
  let auteur-pied = if auteur-court != none {
    auteur-court
  } else if auteurs.len() > 0 { auteurs.at(0) } else { "" }

  set text(font: police, size: pt-normalsize, fill: bleu, lang: "fr")
  set par(justify: false, leading: 0.65em)
  show strong: set text(weight: demi-gras)

  // itemize item [square], itemize subitem [circle]. Retraits mesurés sur le
  // PDF de référence : 21,9 pt pour le premier niveau, 43,7 pt pour le second.
  set list(marker: (
    text(fill: bleu, size: 0.7em)[■],
    text(fill: bleu, size: 0.7em)[●],
  ), indent: 6pt, body-indent: 7pt, spacing: 0.62em)

  // Beamer serre la liste contre le paragraphe qui la précède ; typst l'en
  // écarte davantage par défaut.
  show list: set block(above: 0.62em, below: 0.62em)
  set enum(numbering: n => text(fill: bleu)[#n.])

  // Le pied de page est posé en avant-plan plutôt que dans le gabarit `footer`
  // de typst : c'est le seul moyen de coller la barre au bord inférieur du
  // papier et de la faire courir sur toute la largeur, comme dans l'original.
  set page(
    width: largeur-page,
    height: hauteur-page,
    // Le bandeau supérieur étant vidé par le thème, la zone de texte commence au
    // bord du papier : mesuré, le haut de la zone est à 0 et le bas à la barre
    // de pied de page (239,9 pt).
    margin: (x: marge-x, top: 0mm, bottom: 5.4mm),
    foreground: context {
      let numero = counter(page).get().first()
      let total = counter(page).final().first()
      place(bottom + left, block(
        width: 100%, height: hauteur-pied, fill: gris, inset: (x: marge-x),
      )[
        #set text(size: pt-tiny, fill: bleu)
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

  // Page de titre : bloc de 70 % de large, aligné à gauche, centré
  // verticalement comme toute diapositive Beamer. Elle est produite par la
  // *fonction* `page` et non par un `set`, pour que le fond et l'absence de
  // pied de page ne débordent pas sur les diapositives suivantes.
  // La page de titre conserve le pied de page : vérifié sur le PDF Beamer, qui
  // y affiche « 1 / 3 ».
  // Beamer ne centre pas le bloc de titre : il répartit l'espace libre selon
  // \beamer@frametopskip / \beamer@framebottomskip, soit 0,4 contre 0,6. Le
  // haut du titre tombe alors à 41,4 pt, ce que mesure le PDF de référence.
  page(
    background: if fond != none { fond-titre(fond) },
    {
      v(0.4fr)
      block(width: 70%)[
      #text(size: pt-LARGE, weight: demi-gras)[#titre]
      #v(0.2em)
      #filet
      #v(1.35em)
      #text(size: pt-normalsize)[
        #auteurs.join(linebreak())
      ]
      #v(1.4em)
      #text(size: pt-footnotesize)[
        #institut \
        #date
      ]
      ]
      v(0.6fr)
    },
  )

  corps
}

// --------------------------------- Éléments ---------------------------------

// Une diapositive : titre (\LARGE) et sous-titre facultatif en petites
// capitales, puis le corps. Beamer laisse 1 em au-dessus du titre.
// Beamer centre verticalement le corps d'une diapositive. Le rapport 0,7 / 1
// entre l'espace au-dessus et celui au-dessous est celui mesuré sur le PDF de
// référence (47,5 pt contre 68 pt).
#let diapo(titre, sous-titre: none, corps) = {
  v(27.5pt)
  block(below: 0em)[
    #text(size: pt-LARGE, weight: demi-gras)[#titre]
    #if sous-titre != none [
      #linebreak()
      #text(size: pt-normalsize)[#petites-capitales(sous-titre)]
    ]
  ]
  v(0.85fr)
  corps
  v(1fr)
  pagebreak(weak: true)
}

// Bloc Beamer : bandeau de titre bleu sur texte blanc, corps sur fond gris.
// Angles vifs : le thème n'appelle pas \setbeamertemplate{blocks}[rounded].
#let bloc(titre, corps) = block(width: 100%, breakable: false)[
  #block(width: 100%, fill: bleu, inset: (x: 6pt, y: 4pt))[
    #text(fill: white, size: pt-normalsize)[#titre]
  ]
  #block(width: 100%, fill: gris, inset: (x: 6pt, y: 6pt))[
    #corps
  ]
]

// Bloc de définition : la police `blockdef` du thème d'origine (\large gras).
#let bloc-definition(titre, corps) = block(width: 100%, breakable: false)[
  #block(width: 100%, fill: bleu, inset: (x: 6pt, y: 4pt))[
    #text(fill: white, size: pt-large, weight: demi-gras)[#titre]
  ]
  #block(width: 100%, fill: gris, inset: (x: 6pt, y: 6pt))[
    #corps
  ]
]
