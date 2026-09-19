// Graphe de commits, et ses annotations.
//
// Sert au cours 2 ; le cours 6 (forge et git en équipe) le reprendra. Les
// dessins sont en unités de `cetz.canvas`, mis à l'échelle par `echelle`.
//
// `cetz.draw` n'est ouvert que dans les `canvas` : ses noms (`grid`, `line`,
// `content`, `rect`) masqueraient ceux de typst chez qui importerait ce
// fichier avec `: *`.

#import "@preview/cetz:0.4.2"
#import "theme.typ": accent, estompe, demi-gras

// Le rouge du support d'origine : l'arête de fusion, le conflit.
#let rouge-attention = rgb("#E8112D")

#let _pastille = 0.3          // rayon d'un commit
#let _ecart-x = 1.75          // d'un commit au suivant
#let _ecart-y = 1.3           // d'une voie à la suivante

// ---------------------------------------------------------------------------
// Le graphe de commits
//
// Un commit :
//
//   (nom: "c1", col: 0, voie: 0, etiquette: "commit 1", parents: ("c0",))
//
// `col` est l'abscisse, `voie` la ligne de développement. Facultatifs :
// `etape` (le commit apparaît à partir de cette étape), `teinte` (fond de la
// pastille), `place` (« dessus » ou « dessous » pour l'étiquette ; par défaut
// dessous sur la voie 0, dessus ailleurs).
//
// `branches` : (nom, voie, col, ancre: "west" | "east", dy).
// `fleches` : (depuis, longueur) — un prolongement en tirets vers la droite.
// `extra` : fonction `(pos, d)` appelée en dernier, avec `pos(nom)` qui donne
// les coordonnées d'un commit et `d` le module `cetz.draw`. Sert aux
// annotations propres à une diapositive.
#let graphe-git(
  commits: (),
  branches: (),
  fleches: (),
  etape: 99,
  extra: none,
  echelle: 1.0,
  ecart-x: _ecart-x,
  ecart-y: _ecart-y,
  taille-etiquette: 9pt,
) = cetz.canvas(length: echelle * 1cm, {
  import cetz.draw: *

  let par-nom = (:)
  for c in commits { par-nom.insert(c.nom, c) }
  let pos(nom) = {
    let c = par-nom.at(nom)
    (c.col * ecart-x, c.voie * ecart-y)
  }
  let visible(c) = c.at("etape", default: 0) <= etape
  let tirets = (paint: accent, thickness: 0.9pt, dash: "densely-dashed")

  // Prolongements, arêtes, puis pastilles : ce qui passe dessous d'abord.
  for f in fleches {
    if f.at("etape", default: 0) > etape { continue }
    let depart = pos(f.depuis)
    line(
      depart, (depart.at(0) + f.at("longueur", default: 1.4) * ecart-x, depart.at(1)),
      stroke: tirets, mark: (end: ">", fill: accent, scale: 0.55),
    )
  }

  for c in commits {
    if not visible(c) { continue }
    for p in c.at("parents", default: ()) {
      if visible(par-nom.at(p)) { line(pos(p), pos(c.nom), stroke: tirets) }
    }
  }

  for c in commits {
    if not visible(c) { continue }
    let p = pos(c.nom)
    circle(p, radius: _pastille, fill: c.at("teinte", default: white), stroke: 1.1pt + accent)
    let etiquette = c.at("etiquette", default: "")
    if etiquette != "" {
      let dessous = c.at("place", default: if c.voie == 0 { "dessous" } else { "dessus" }) == "dessous"
      content(
        (p.at(0), p.at(1) + if dessous { -0.52 } else { 0.52 }),
        text(size: taille-etiquette, fill: accent)[#etiquette],
        anchor: if dessous { "north" } else { "south" },
      )
    }
  }

  for b in branches {
    if b.at("etape", default: 0) > etape { continue }
    let ancre = b.at("ancre", default: "west")
    let dx = if ancre == "west" { 0.55 } else { -0.55 }
    content(
      ((b.col + dx) * ecart-x, b.voie * ecart-y + b.at("dy", default: 0)),
      text(size: taille-etiquette + 1pt, weight: demi-gras, fill: accent)[#b.nom],
      anchor: ancre,
    )
  }

  if extra != none { extra(pos, cetz.draw) }
})

// ---------------------------------------------------------------------------
// Annotations, à appeler depuis `extra`. `d` est le module `cetz.draw`, `p`,
// `a` et `b` des positions de commit.

// La flèche HEAD. `dy` négatif : la flèche vient d'en bas ; positif : d'en
// haut. Choisir le côté que l'étiquette du commit n'occupe pas.
#let marque-tete(d, p, dx: 0.95, dy: -0.8, texte: "HEAD") = {
  let sens = if dy < 0 { -1 } else { 1 }
  d.line(
    (p.at(0) + dx, p.at(1) + dy),
    (p.at(0) + _pastille * 0.75, p.at(1) + sens * _pastille * 0.75),
    stroke: 1.6pt + accent, mark: (end: ">", fill: accent, scale: 0.7),
  )
  d.content(
    (p.at(0) + dx, p.at(1) + dy),
    text(size: 10pt, weight: demi-gras, fill: accent)[#texte],
    anchor: if sens < 0 { "north-west" } else { "south-west" },
  )
}

// L'ellipse rouge autour d'une arête.
#let cerne(d, a, b, largeur: 0.42) = {
  let centre = ((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2)
  let h = calc.abs(b.at(1) - a.at(1)) / 2 + 0.3
  d.circle(centre, radius: (largeur, h), stroke: 1.1pt + rouge-attention)
}

// L'étoile de conflit et son mot.
#let marque-conflit(d, p, texte: "Conflit") = {
  let n = 10
  let sommets = range(n).map(i => {
    let a = 90deg + i * (360deg / n)
    let r = if calc.rem(i, 2) == 0 { 0.26 } else { 0.11 }
    (p.at(0) + r * calc.cos(a), p.at(1) + r * calc.sin(a))
  })
  d.line(..sommets, close: true, stroke: 0.9pt + rouge-attention, fill: white)
  d.content(
    (p.at(0) + 0.2, p.at(1) + 0.3),
    text(size: 9pt, fill: rouge-attention)[#texte],
    anchor: "south-west",
  )
}

// Deux traits qui joignent deux commits à un sommet portant un texte
// (« Même état »).
#let pont(d, a, b, texte, hauteur: 1.15) = {
  let sommet = ((a.at(0) + b.at(0)) / 2, a.at(1) + hauteur)
  d.line((a.at(0), a.at(1) + _pastille), sommet, stroke: 0.9pt + estompe)
  d.line((b.at(0), b.at(1) + _pastille), sommet, stroke: 0.9pt + estompe)
  d.content(sommet, text(size: 9pt, fill: accent)[#texte], anchor: "south")
}

// Une arête épaisse, d'un bord de pastille à l'autre.
#let arete-epaisse(d, a, b, epaisseur: 2pt) = {
  let dx = b.at(0) - a.at(0)
  let dy = b.at(1) - a.at(1)
  let norme = calc.sqrt(dx * dx + dy * dy)
  let (ux, uy) = (dx / norme, dy / norme)
  d.line(
    (a.at(0) + ux * _pastille, a.at(1) + uy * _pastille),
    (b.at(0) - ux * _pastille * 1.25, b.at(1) - uy * _pastille * 1.25),
    stroke: (paint: accent, thickness: epaisseur, dash: "dashed"),
    mark: (end: ">", fill: accent, scale: 0.5),
  )
}

// Un texte au milieu d'une arête (« merge », « git revert »).
#let etiquette-arete(d, a, b, texte, decalage: (0, -0.3), taille: 9pt) = {
  d.content(
    ((a.at(0) + b.at(0)) / 2 + decalage.at(0), (a.at(1) + b.at(1)) / 2 + decalage.at(1)),
    text(size: taille, fill: accent)[#texte],
  )
}
