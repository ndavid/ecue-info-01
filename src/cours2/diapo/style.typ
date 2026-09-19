// Gabarits du cours 2 : listings et listes à révélation progressive.
//
// Ces formes viennent du support Beamer d'origine et n'existent pas dans le
// thème commun. Les valeurs de corps, d'interligne et de police sont dans
// `beamer.typ`.
//
//   code(…)                un listing
//   code-ligne(…)          une commande dans le fil du texte
//   liste-progressive(…)   une liste dévoilée item par item
//   motif(…)               un motif surligné en vert

#import "../../commun/theme.typ": accent
#import "beamer.typ": police-code-beamer, corps-code-beamer, interligne-code-beamer, estompe-beamer

// ---------------------------------------------------------------------------
// Listings
//
// Couleurs relevées sur le PDF d'origine.
#let vert-commentaire = rgb("#009900")
#let magenta-mot-cle = rgb("#EC008C")
#let fond-code = rgb("#F2F2EB")

// `listings` colore les primitives internes de bash, et elles seules. `cd`
// et `pwd` ressortent, `ls` et `cp` non ; `source` est coloré même quand il
// désigne un fichier, comme dans le support d'origine.
#let _primitives = (
  "cd", "pwd", "source", "help", "continue", "echo", "export", "alias",
  "exit", "read", "set", "unset", "shift", "test", "eval", "exec",
)

// Une ligne, en segments colorés. Un commentaire prend toute la ligne ;
// ailleurs, seuls les mots de `_primitives` sont teintés, y compris dans une
// option longue (`--help`). Les séparateurs sont conservés pour garder
// l'alignement.
#let _ligne-coloree(ligne) = {
  if ligne.trim().starts-with("#") {
    text(fill: vert-commentaire)[#ligne]
  } else {
    let morceaux = ()
    let courant = ""
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
      text(fill: if _primitives.contains(m) { magenta-mot-cle } else { accent })[#m]
    }
  }
}

// `centre` sert à la seule diapositive où le support centre la commande
// (« git init »).
#let code(
  corps,
  centre: false,
  taille: corps-code-beamer,
  interligne: interligne-code-beamer,
) = block(
  width: 100%, fill: fond-code, inset: (x: 10pt, y: 8pt), above: 0.7em, below: 0.7em,
)[
  #set text(font: police-code-beamer, size: taille)
  #set par(leading: interligne, justify: false)
  #align(if centre { center } else { left })[
    #for (i, ligne) in corps.split("\n").enumerate() {
      if i > 0 { linebreak() }
      // Une ligne vide doit porter une espace, sinon typst la supprime.
      if ligne.trim() == "" { sym.space } else { _ligne-coloree(ligne) }
    }
  ]
]

#let code-ligne(corps, taille: corps-code-beamer) = box(
  fill: fond-code, inset: (x: 5pt, y: 3pt), outset: (y: 2pt),
)[
  #set text(font: police-code-beamer, size: taille)
  #_ligne-coloree(corps)
]

// ---------------------------------------------------------------------------
// Listes dévoilées
//
// Les items avant `etape` sont en gris, l'item `etape` en noir, les suivants
// absents. La diapositive est écrite une fois par étape.
//
//   #liste-progressive(3, ([a], [b], [c], [d]))   → a et b en gris, c en noir
#let liste-progressive(etape, items, estompe-precedents: true) = {
  let visibles = items.slice(0, calc.min(etape, items.len()))
  list(
    ..visibles.enumerate().map(((i, item)) => {
      if estompe-precedents and i < etape - 1 { text(fill: estompe-beamer)[#item] } else { item }
    }),
  )
}

// Le `\colorbox` vert des motifs, dans la police du texte.
#let motif(corps) = box(
  fill: rgb("#8FD35B"), inset: (x: 4pt, y: 2pt), outset: (y: 3pt),
)[#text(fill: accent)[#corps]]
