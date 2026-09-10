// Schémas de la partie « Notebooks » du cours 1.
//
// Séparé de `schemas.typ`, qui porte ceux de la partie « Structure d'un projet
// Python » : les deux parties se rédigent ainsi sans se gêner. Même
// convention d'import que l'autre fichier, et pour la même raison :
//
//     #import "../schemas_notebooks.typ": schema-notebook
//
// Pas de `: *`, ce fichier ouvrant `cetz.draw`, dont les noms masqueraient
// ceux de typst chez qui l'importerait en bloc.

#import "../../commun/prelude.typ": *
#import "@preview/cetz:0.4.2"
#import cetz.draw: *

#let _trait = accent.lighten(45%)

// ---------------------------------------------------------------------------
// Un notebook, ses trois sortes de blocs
//
// Même procédé que la capture annotée de VSCode : un contour de couleur par
// zone, et une étiquette de la même couleur qui la nomme. La couleur ne sert
// qu'à relier un contour à son nom, comme là-bas.
//
// Le document est dessiné plutôt que photographié : il se projette à la même
// taille partout, et ne vieillit pas avec la version de JupyterLab.

// L'étiquette posée sur le bord d'un bloc, à droite de son contour.
#let _etiquette-bloc(x, y, texte, couleur) = {
  content((x, y), anchor: "east", box(
    fill: couleur, inset: (x: 7pt, y: 4pt), radius: 3pt,
    text(size: 14pt, fill: white, weight: demi-gras)[#texte],
  ))
}

// Une ligne de faux texte : un trait gris de longueur donnée. Le propos est la
// place qu'occupe chaque sorte de bloc, pas ce qui y est écrit.
#let _ligne-grise(x, y, l, epaisseur: 0.16) = {
  rect((x, y), (x + l, y + epaisseur), stroke: none, fill: gris.darken(6%))
}

#let schema-notebook() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)

  let (x0, x1) = (0.4, 21.6)
  let marge = 0.55

  // Le document, et la barre qui le nomme.
  rect((0, -0.15), (22, 8.35), radius: 0.12, stroke: 1.4pt + accent, fill: white)
  rect((0, 7.6), (22, 8.35), radius: (north: 0.12, rest: 0), stroke: none,
       fill: gris)
  line((0, 7.6), (22, 7.6), stroke: 1pt + accent.lighten(45%))
  content((0.5, 7.97), anchor: "west",
          text(size: 15pt, font: police-code)[trajet.ipynb])

  // — 1. le texte, écrit en Markdown et affiché mis en forme
  rect((x0, 5.35), (x1, 7.25), radius: 0.08, stroke: 2.2pt + attention)
  content((x0 + marge, 6.80), anchor: "west",
          text(size: 19pt, weight: demi-gras, fill: accent)[Longueur du trajet])
  _ligne-grise(x0 + marge, 6.25, 15.5)
  _ligne-grise(x0 + marge, 5.80, 10.8)
  _etiquette-bloc(x1 - 0.25, 7.05, "texte", attention)

  // — 2. le code, dans une cellule numérotée
  rect((x0, 2.75), (x1, 5.00), radius: 0.08, stroke: 2.2pt + manip)
  content((x0 + 0.45, 4.35), anchor: "west",
          text(size: 14pt, font: police-code, fill: estompe)[\[1\]:])
  rect((x0 + 1.35, 3.00), (x1 - 0.3, 4.72), stroke: none, fill: gris.lighten(45%))
  content((x0 + 1.6, 4.35), anchor: "west",
          text(size: 15pt, font: police-code)[import numpy as np])
  content((x0 + 1.6, 3.82), anchor: "west", {
    set smartquote(enabled: false)
    text(size: 15pt, font: police-code)[points = np.loadtxt("trajet.csv")]
  })
  content((x0 + 1.6, 3.29), anchor: "west",
          text(size: 15pt, font: police-code)[print(points.shape)])
  _etiquette-bloc(x1 - 0.25, 4.80, "code", manip)

  // — 3. ce que l'exécution a produit, gardé dans le document
  rect((x0, 1.20), (x1, 2.45), radius: 0.08, stroke: 2.2pt + alerte)
  content((x0 + 0.45, 1.82), anchor: "west",
          text(size: 14pt, font: police-code, fill: estompe)[\[1\]:])
  content((x0 + 2.2, 1.82), anchor: "west",
          text(size: 15pt, font: police-code)[(128, 2)])
  _etiquette-bloc(x1 - 0.25, 2.25, "résultat", alerte)

  // — la suite du document, qui reprend au texte
  rect((x0, 0.2), (x1, 0.95), radius: 0.08,
       stroke: (paint: estompe.lighten(55%), thickness: 1pt, dash: "dashed"))
  _ligne-grise(x0 + marge, 0.5, 12.5)
  content((x1 - 0.4, 0.58), anchor: "east",
          text(size: 14pt, fill: estompe)[et ainsi de suite])
})

// ---------------------------------------------------------------------------
// Le client et le serveur d'un notebook
//
// Reprend la convention du schéma « Où s'exécute une application web » : les
// deux lieux, ce qui passe de l'un à l'autre, et `alerte` sur ce qui sort de
// la machine. Ici, justement, rien n'en sort — c'est le propos.

#let _pastille-outil(x, y, l, texte, sous-titre) = {
  rect((x, y), (x + l, y + 1.9), radius: 0.09,
       stroke: 1pt + accent.lighten(50%), fill: accent.lighten(95%))
  content((x + l / 2, y + 1.32),
          text(size: 16pt, font: police-code, fill: accent)[#texte])
  content((x + l / 2, y + 0.92), anchor: "north", box(width: (l - 0.4) * 1cm,
          align(center, text(size: 13pt, fill: estompe)[#sous-titre])))
}

// Une des deux moitiés : son nom, ce qu'elle fait, et les outils qui la
// tiennent. Rendue dans son repère propre, coin bas-gauche à l'origine ; les
// pastilles descendent sous le titre, une par outil.
#let _moitie(l, h, nom, travail, outils) = {
  rect((0, 0), (l, h), radius: 0.1, stroke: 1.5pt + accent, fill: white)
  content((l / 2, h - 0.5),
          text(size: pt-footnotesize, fill: accent, weight: demi-gras)[
            #petites-capitales(nom)])
  content((l / 2, h - 1.1), text(size: 15pt, fill: estompe)[#travail])
  for (i, o) in outils.enumerate() {
    _pastille-outil(0.45, h - 3.7 - i * 2.1, l - 0.9, o.at(0), o.at(1))
  }
}

#let schema-client-serveur() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)

  let (l-moitie, h-moitie) = (7.0, 6.2)
  let (x-client, x-serveur, y) = (1.0, 11.6, 1.1)

  // La machine, qui contient les deux moitiés.
  rect((0.3, 0.4), (19.3, 8.3), radius: 0.15, stroke: 1.2pt + estompe,
       fill: gris.lighten(55%))
  content((0.8, 7.85), anchor: "west",
          text(size: 15pt, fill: estompe)[#petites-capitales("votre machine")])

  group(name: "client", {
    translate((x-client, y))
    _moitie(l-moitie, h-moitie, "client", "affiche le document", (
      ("jupyterlab", "dans le navigateur"),
      ("VSCode", "un autre client"),
    ))
  })
  group(name: "serveur", {
    translate((x-serveur, y))
    _moitie(l-moitie, h-moitie, "serveur", "exécute le code", (
      ("jupyter-server", "reçoit les cellules"),
      ("ipykernel", "calcule et retient"),
    ))
  })

  // Ce qui passe entre les deux, et ne quitte pas la machine.
  let (xa, xb) = (x-client + l-moitie, x-serveur)
  let xm = (xa + xb) / 2
  line((xa + 0.25, y + 4.3), (xb - 0.25, y + 4.3), stroke: 1.8pt + accent,
       mark: (end: ">", fill: accent, scale: 1.3))
  content((xm, y + 4.5), anchor: "south", box(width: 3.3cm,
          align(center, text(size: 13pt, fill: accent)[la cellule à exécuter])))
  line((xb - 0.25, y + 2.6), (xa + 0.25, y + 2.6), stroke: 1.8pt + accent,
       mark: (end: ">", fill: accent, scale: 1.3))
  content((xm, y + 2.4), anchor: "north",
          text(size: 13pt, fill: accent)[le résultat])
  content((xm, 1.0), anchor: "north",
          text(size: 13pt, font: police-code, fill: estompe)[localhost])

})

// ---------------------------------------------------------------------------
// Les trois emplacements du serveur
//
// Le schéma précédent montre les deux moitiés ; celui-ci montre que la
// frontière entre elles peut tomber à trois endroits. Même convention que
// « Où s'exécute une application web » : `alerte` sur ce qui sort de la
// machine, et c'est le seul des trois cas où quelque chose en sort.

#let _boite(x, y, l, h, texte, sous: none, couleur: accent, fond: white) = {
  rect((x, y), (x + l, y + h), radius: 0.09, stroke: 1.2pt + couleur, fill: fond)
  let dy = if sous == none { h / 2 } else { h / 2 + 0.28 }
  content((x + l / 2, y + dy),
          text(size: 15pt, font: police-code, fill: couleur)[#texte])
  if sous != none {
    content((x + l / 2, y + h / 2 - 0.32), box(width: (l - 0.3) * 1cm,
            align(center, text(size: 12.5pt, fill: estompe)[#sous])))
  }
}

// Le cadre gris de la machine, avec son intitulé en haut à gauche.
#let _machine(x, y, l, h) = {
  rect((x, y), (x + l, y + h), radius: 0.12, stroke: 1.1pt + estompe,
       fill: gris.lighten(55%))
  content((x + 0.25, y + h - 0.32), anchor: "west",
          text(size: 12pt, fill: estompe)[#petites-capitales("votre machine")])
}

#let _titre-cas(x, l, titre, exemple) = {
  content((x + l / 2, 5.35),
          text(size: pt-footnotesize, fill: accent, weight: demi-gras)[
            #petites-capitales(titre)])
  content((x + l / 2, -0.35), anchor: "north", box(width: (l - 0.2) * 1cm,
          align(center, text(size: 13.5pt, fill: estompe)[#exemple])))
}

#let schema-trois-serveurs() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)

  let l = 7.6
  let (x1, x2, x3) = (0.0, 9.2, 18.4)
  let (lb, xb) = (5.6, 1.0)   // largeur d'une boîte, et son décalage dans le cas

  // — 1. le serveur est ailleurs : le réseau traverse la frontière
  _machine(x1 + 0.4, 2.6, 6.8, 2.2)
  _boite(x1 + xb, 2.85, lb, 1.35, "navigateur", sous: "le client")
  _boite(x1 + xb, 0.35, lb, 1.35, "serveur", sous: "et le noyau",
         couleur: alerte, fond: alerte.lighten(94%))
  line((x1 + 3.8, 2.55), (x1 + 3.8, 1.80), stroke: 1.8pt + alerte,
       mark: (end: ">", fill: alerte, scale: 1.2))
  content((x1 + 4.0, 2.2), anchor: "west",
          text(size: 13pt, fill: alerte, weight: demi-gras)[réseau])
  _titre-cas(x1, l, "sur un ordinateur distant", "Colab, un serveur du laboratoire")

  // — 2. les deux moitiés sur la même machine : rien ne sort
  _machine(x2 + 0.4, 0.15, 6.8, 4.65)
  _boite(x2 + xb, 2.85, lb, 1.35, "navigateur", sous: "le client")
  _boite(x2 + xb, 0.55, lb, 1.35, "jupyter-server", sous: "et le noyau")
  line((x2 + 3.8, 2.80), (x2 + 3.8, 1.98), stroke: 1.6pt + accent,
       mark: (end: ">", fill: accent, scale: 1.1))
  content((x2 + 4.0, 2.4), anchor: "west",
          text(size: 12.5pt, font: police-code, fill: estompe)[localhost])
  _titre-cas(x2, l, "sur votre ordinateur", "jupyter lab, ou l'éditeur de code")

  // — 3. le navigateur exécute lui-même le noyau
  _machine(x3 + 0.4, 0.15, 6.8, 4.65)
  rect((x3 + xb, 0.55), (x3 + xb + lb, 3.95), radius: 0.09,
       stroke: 1.2pt + accent, fill: white)
  content((x3 + xb + lb / 2, 3.50),
          text(size: 15pt, font: police-code, fill: accent)[navigateur])
  _boite(x3 + xb + 0.45, 1.25, lb - 0.9, 1.35, "noyau Python",
         couleur: attention, fond: attention.lighten(92%))
  content((x3 + xb + lb / 2, 1.05), anchor: "north",
          text(size: 12.5pt, fill: estompe)[il n'y a pas de serveur])
  _titre-cas(x3, l, "dans le navigateur", "JupyterLite : rien ne sort de l'onglet")
})

// ---------------------------------------------------------------------------
// Les clients d'un notebook
//
// Pendant du schéma précédent, du côté du client. Même grammaire : deux cas
// côte à côte, les mêmes boîtes aux mêmes hauteurs, et ce qui manque à droite
// se voit parce que la place est laissée vide.

#let schema-deux-clients() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)

  let l = 11.0
  let (x1, x2) = (0.5, 14.5)
  let lb = 7.0                       // largeur des boîtes
  let dx = 0.4 + (10.2 - lb) / 2     // leur décalage dans le cas
  let (y-haut, y-milieu, y-bas) = (3.15, 1.75, 0.35)
  let h = 1.15

  let fleche(x, ya, yb) = line((x, ya), (x, yb), stroke: 1.5pt + accent,
                               mark: (end: ">", fill: accent, scale: 1.1))

  // — 1. le client est une page web, servie par un serveur
  _machine(x1 + 0.4, 0.15, 10.2, 4.95)
  _boite(x1 + dx, y-haut, lb, h, "jupyterlab", couleur: manip,
         fond: manip.lighten(94%))
  _boite(x1 + dx, y-milieu, lb, h, "jupyter-server")
  _boite(x1 + dx, y-bas, lb, h, "ipykernel")
  fleche(x1 + dx + lb / 2, y-haut - 0.05, y-milieu + h + 0.05)
  fleche(x1 + dx + lb / 2, y-milieu - 0.05, y-bas + h + 0.05)
  _titre-cas(x1, l, "dans le navigateur", "jupyter lab, puis une adresse localhost")

  // — 2. l'éditeur est le client, et lance le noyau sans serveur
  _machine(x2 + 0.4, 0.15, 10.2, 4.95)
  _boite(x2 + dx, y-haut, lb, h, "VSCode", couleur: manip,
         fond: manip.lighten(94%))
  rect((x2 + dx, y-milieu), (x2 + dx + lb - 1.5, y-milieu + h), radius: 0.09,
       stroke: (paint: estompe.lighten(40%), thickness: 1pt, dash: "dashed"))
  content((x2 + dx + (lb - 1.5) / 2, y-milieu + h / 2),
          text(size: 13.5pt, fill: estompe)[aucun serveur à lancer])
  _boite(x2 + dx, y-bas, lb, h, "ipykernel")
  fleche(x2 + dx + lb - 0.75, y-haut - 0.05, y-bas + h + 0.05)
  _titre-cas(x2, l, "dans l'éditeur de code", "l'éditeur démarre le noyau lui-même")
})
