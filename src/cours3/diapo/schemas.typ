// Schémas propres au cours 3 : des pixels dessinés, pour montrer une image
// à côté du texte qui la définit. Les gabarits communs sont dans
// `src/commun/schemas.typ`.
#import "../../commun/prelude.typ": *

// Une grille de pixels gris, à partir des valeurs 0–255 d'un PGM, une liste
// par rangée. `cote` est la taille d'un pixel à l'écran.
#let pixels-gris(rangees, cote: 24pt) = grid(
  columns: rangees.at(0).len(),
  ..rangees.flatten().map(v => rect(
    width: cote, height: cote, fill: luma(v), stroke: 0.5pt + gris.darken(25%),
  )),
)

// Un dessin en lettres, une lettre par pixel, et la couleur de chaque
// lettre : ce que le notebook fait avec `DESSIN` et `COULEURS`.
#let pixel-art(dessin, couleurs, cote: 20pt) = {
  let rangees = dessin.split("\n").filter(l => l.trim() != "")
  grid(
    columns: rangees.at(0).len(),
    ..rangees.map(r => r.clusters().map(lettre => rect(
      width: cote, height: cote, fill: couleurs.at(lettre), stroke: 0.5pt + gris.darken(25%),
    ))).flatten(),
  )
}

// Une sortie de terminal ou de cellule, passée en chaîne (les `\n` y sont
// des retours à la ligne) : rendue en `raw` pour que les colonnes restent
// alignées, sur fond gris, en taille réduite pour tenir sur une diapositive.
#let sortie(texte, taille: 13pt) = block(
  width: 100%, inset: (x: 10pt, y: 8pt), fill: gris,
)[
  // Le thème règle la taille des blocs `raw` par une règle `show` ; celle-ci,
  // posée plus près, la remplace.
  #show raw: set text(size: taille)
  #raw(block: true, texte)
]

// Un code commenté ligne à ligne : à gauche chaque ligne de code, à droite
// ce qu'elle fait, en une ligne courte. Une paire par ligne ; une paire dont
// le code est vide fait une ligne blanche. Le code se met en `raw` avec
// coloration Python. Le commentaire est lu comme du balisage typst : les
// accents graves y donnent du code en ligne.
//
//   #code-commente(
//     ("from pathlib import Path", "importer la bibliothèque"),
//     ("dossier = Path(\"depart\")", "déclarer un chemin"),
//   )
#let code-commente(..lignes, taille-code: 14pt, taille-texte: 13.5pt) = {
  let paires = lignes.pos()
  // Le thème réduit les `raw` par une règle `show` ; celle-ci, posée plus
  // près, fixe la taille du code.
  show raw: set text(size: taille-code)
  grid(
    columns: (auto, 1fr), column-gutter: 20pt, row-gutter: 6pt,
    align: (left + horizon, left + horizon),
    ..paires.map(paire => (
      if paire.at(0) == "" { [] } else { raw(lang: "python", paire.at(0)) },
      text(size: taille-texte, fill: estompe, eval(paire.at(1), mode: "markup")),
    )).flatten(),
  )
}
