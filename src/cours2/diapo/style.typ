// Éléments de présentation propres au cours 2.
//
// Le support d'origine est un Beamer de Florent Geniet, composé avec le thème
// « Bruno » — le même que celui porté dans `src/commun/theme.typ`. La séance
// est reprise telle qu'il l'a écrite : listes à puces et révélation
// progressive comprises. Ces deux formes n'existent pas ailleurs dans le
// module, et les gabarits qui les portent restent donc ici plutôt que dans
// `src/commun/`.
//
// Deux éléments :
//
//   code(…)               un listing, au style du paquet LaTeX `listings`
//   liste-progressive(…)  une liste qui se dévoile d'une diapositive à l'autre

#import "../../commun/theme.typ": accent, estompe, demi-gras
#import "beamer.typ": police-code-beamer as police-code, estompe-beamer

// --------------------------------------------------------------------------
// Listings
//
// Couleurs relevées au pixel sur le PDF d'origine : les commentaires en vert,
// les primitives du shell en magenta, sur un fond très légèrement chaud.
#let vert-commentaire = rgb("#009900")
#let magenta-mot-cle = rgb("#EC008C")
#let fond-code = rgb("#F2F2EB")

// `listings` colore les primitives internes de bash, et elles seules : c'est
// pourquoi `cd` et `pwd` ressortent quand `ls` et `cp`, qui sont des
// programmes et non des primitives, restent noirs. `source` est coloré pour la
// même raison, alors qu'il désigne ici un fichier à copier — l'effet est
// fortuit, mais il est dans le support d'origine et on le garde.
#let _primitives = (
  "cd", "pwd", "source", "help", "continue", "echo", "export", "alias",
  "exit", "read", "set", "unset", "shift", "test", "eval", "exec",
)

// Découpe une ligne en segments colorés. Un commentaire prend toute la ligne ;
// ailleurs, seuls les mots de `_primitives` sont teintés, y compris à
// l'intérieur d'une option longue (`--help`, `--continue`).
#let _ligne-coloree(ligne) = {
  if ligne.trim().starts-with("#") {
    text(fill: vert-commentaire)[#ligne]
  } else {
    let morceaux = ()
    let courant = ""
    // On découpe sur les caractères qui ne composent pas un mot : ce qui
    // sépare les mots est conservé, faute de quoi l'alignement du listing
    // sauterait.
    for c in ligne.clusters() {
      if c.match(regex("[A-Za-z0-9_]")) != none {
        courant = courant + c
      } else {
        if courant != "" { morceaux.push(courant); courant = "" }
        morceaux.push(c)
      }
    }
    if courant != "" { morceaux.push(courant) }

    for m in morceaux {
      if _primitives.contains(m) {
        text(fill: magenta-mot-cle)[#m]
      } else {
        text(fill: accent)[#m]
      }
    }
  }
}

// Un listing. `centre` reproduit la seule diapositive où le support d'origine
// centre la commande au lieu de l'aligner à gauche (« git init »).
//
// Corps et interligne sont ceux de `listings` dans le PDF d'origine : un
// caractère y mesure 5,3 pt sur une page de 453 pt, soit un corps de 10,1 pt
// en Latin Modern Mono — 19 pt ici, arrondi à 18 — et une avance de 1,04
// corps d'une ligne à la suivante. typst mesure ses lignes à la hauteur de
// capitale, 0,61 em pour cette police : l'interligne qui donne cette avance
// est donc 0,42 em, et non 0,04.
#let code(corps, centre: false, taille: 18pt, interligne: 0.42em) = block(
  width: 100%, fill: fond-code, inset: (x: 10pt, y: 8pt), above: 0.7em, below: 0.7em,
)[
  #set text(font: police-code, size: taille)
  #set par(leading: interligne, justify: false)
  #align(if centre { center } else { left })[
    #for (i, ligne) in corps.split("\n").enumerate() {
      if i > 0 { linebreak() }
      // Une ligne vide ne porte aucune boîte : sans cette espace, typst la
      // supprimerait et le listing se resserrerait.
      if ligne.trim() == "" { sym.space } else { _ligne-coloree(ligne) }
    }
  ]
]

// Commande isolée dans le fil du texte, sans bloc : même fond, une seule ligne.
#let code-ligne(corps, taille: 18pt) = box(
  fill: fond-code, inset: (x: 5pt, y: 3pt), outset: (y: 2pt),
)[
  #set text(font: police-code, size: taille)
  #_ligne-coloree(corps)
]

// --------------------------------------------------------------------------
// Listes qui se dévoilent
//
// Beamer affiche les items déjà vus en gris et le dernier en noir. La
// diapositive est rejouée autant de fois qu'elle compte d'items : c'est ce que
// fait `etape`, et c'est pourquoi une même diapositive apparaît plusieurs fois
// dans les fichiers de `parties/`.
//
//   #liste-progressive(3, ([premier], [deuxième], [troisième], [quatrième]))
//
// À l'étape 3 : les deux premiers en gris, le troisième en noir, le quatrième
// absent.
#let liste-progressive(etape, items, estompe-precedents: true) = {
  let visibles = items.slice(0, calc.min(etape, items.len()))
  list(
    ..visibles.enumerate().map(((i, item)) => {
      if estompe-precedents and i < etape - 1 {
        text(fill: estompe-beamer)[#item]
      } else {
        item
      }
    }),
  )
}

// Le surlignage vert des motifs, sur les diapositives d'expressions
// régulières. C'est un `\colorbox` du support d'origine, et son contenu y
// est composé dans la police du texte, pas en chasse fixe.
#let motif(corps) = box(
  fill: rgb("#8FD35B"), inset: (x: 4pt, y: 2pt), outset: (y: 3pt),
)[
  #text(fill: accent)[#corps]
]
