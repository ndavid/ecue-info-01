// Schémas git : le graphe de commits, le cycle de vie d'un fichier, et le
// modèle de branches des bonnes pratiques.
//
// Ces dessins servent au cours 2 et reviendront au cours 6 (forge et git en
// équipe) : ils vivent donc dans `commun/` et non dans le dossier d'une
// séance. Ils reprennent les schémas du support de Florent Geniet, qui étaient
// des images matricielles ; ils sont ici redessinés, donc lisibles à toute
// échelle et modifiables sans revenir à l'outil qui les avait produits.
//
// Aucune hauteur n'est écrite en points : les dessins sont en unités de
// `cetz.canvas(length: 1cm)`, et la diapositive les met à l'échelle.
//
// `cetz.draw` n'est jamais ouvert au niveau du fichier : ses noms (`grid`,
// `line`, `content`, `rect`) masqueraient ceux de typst chez qui importerait
// ce module avec `: *`. L'ouverture se fait dans chaque `canvas`.

#import "@preview/cetz:0.4.2"
#import "theme.typ": accent, estompe, brun, gris, attention, alerte, demi-gras, police-code

// Le rouge du support d'origine, qui n'entoure que ce qu'il faut regarder :
// l'arête de fusion, puis le conflit. Il ne code rien d'autre.
#let rouge-attention = rgb("#E8112D")

#let _pastille = 0.3          // rayon d'un commit
#let _ecart-x = 1.75          // d'un commit au suivant
#let _ecart-y = 1.3           // d'une voie à la suivante

// ---------------------------------------------------------------------------
// Le graphe de commits
//
// Un commit est un dictionnaire :
//
//   (nom: "c1", col: 0, voie: 0, etiquette: "commit 1", parents: ("c0",))
//
// `col` place le commit sur l'axe du temps, `voie` sur sa ligne de
// développement ; `etape` dit à partir de quelle étape il apparaît. Les champs
// facultatifs : `teinte` (fond de la pastille), `place` (« dessus » ou
// « dessous » pour l'étiquette, par défaut dessous sur la voie du bas et
// dessus ailleurs).
//
// `branches` étiquette la fin d'une voie, `fleches` prolonge une voie d'une
// flèche ouverte vers la droite, comme le fait le support d'origine pour dire
// que l'histoire continue.
//
// `extra` reçoit `(pos, d)` — la fonction qui donne les coordonnées d'un
// commit, et le module `cetz.draw` — pour les annotations d'une seule
// diapositive : HEAD, l'ellipse rouge, l'étoile de conflit. Les y mettre évite
// d'ajouter à cette fonction autant d'options que de diapositives.
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

  // Les prolongements d'abord : ils passent sous les pastilles.
  for f in fleches {
    if f.at("etape", default: 0) > etape { continue }
    let depart = pos(f.depuis)
    line(
      depart,
      (depart.at(0) + f.at("longueur", default: 1.4) * ecart-x, depart.at(1)),
      stroke: (paint: accent, thickness: 0.9pt, dash: "densely-dashed"),
      mark: (end: ">", fill: accent, scale: 0.55),
    )
  }

  // Les arêtes, puis les pastilles : une arête qui arriverait par-dessus une
  // pastille se verrait au travers du fond blanc.
  for c in commits {
    if not visible(c) { continue }
    for p in c.at("parents", default: ()) {
      if not visible(par-nom.at(p)) { continue }
      line(
        pos(p), pos(c.nom),
        stroke: (paint: accent, thickness: 0.9pt, dash: "densely-dashed"),
      )
    }
  }

  for c in commits {
    if not visible(c) { continue }
    let p = pos(c.nom)
    circle(p, radius: _pastille, fill: c.at("teinte", default: white),
           stroke: 1.1pt + accent)
    let etiquette = c.at("etiquette", default: "")
    if etiquette != "" {
      let dessous = c.at("place", default: if c.voie == 0 { "dessous" } else { "dessus" })
      content(
        (p.at(0), p.at(1) + if dessous == "dessous" { -0.52 } else { 0.52 }),
        text(size: taille-etiquette, fill: accent)[#etiquette],
        anchor: if dessous == "dessous" { "north" } else { "south" },
      )
    }
  }

  // Le nom d'une branche, posé au bout de sa voie.
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
// Annotations réutilisées d'une diapositive à l'autre.
//
// Écrites comme des fonctions à appeler depuis `extra`, elles reçoivent le
// module `cetz.draw` : les diapositives n'ont ainsi pas à l'importer.

// La flèche épaisse qui désigne le commit courant.
// `dy` négatif fait venir la flèche d'en bas à droite, positif d'en haut. Le
// choix se fait selon la voie visée : l'étiquette du commit occupe déjà le
// dessous sur la voie du bas, et le dessus ailleurs.
#let marque-tete(d, p, dx: 0.95, dy: -0.8, texte: "HEAD") = {
  let sens = if dy < 0 { -1 } else { 1 }
  d.line(
    (p.at(0) + dx, p.at(1) + dy),
    (p.at(0) + _pastille * 0.75, p.at(1) + sens * _pastille * 0.75),
    stroke: 1.6pt + accent,
    mark: (end: ">", fill: accent, scale: 0.7),
  )
  d.content(
    (p.at(0) + dx, p.at(1) + dy),
    text(size: 10pt, weight: demi-gras, fill: accent)[#texte],
    anchor: if sens < 0 { "north-west" } else { "south-west" },
  )
}

// L'ellipse rouge du support d'origine, autour de l'arête qu'il faut regarder.
#let cerne(d, a, b, largeur: 0.42) = {
  let cx = (a.at(0) + b.at(0)) / 2
  let cy = (a.at(1) + b.at(1)) / 2
  let h = calc.abs(b.at(1) - a.at(1)) / 2 + 0.3
  d.circle((cx, cy), radius: (largeur, h), stroke: 1.1pt + rouge-attention)
}

// L'étoile et le mot « Conflit ».
#let marque-conflit(d, p, texte: "Conflit") = {
  let branches-etoile = 10
  let sommets = range(branches-etoile).map(i => {
    let a = 90deg + i * (360deg / branches-etoile)
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

// Une accolade plate reliant deux commits, pour « Même état ».
#let pont(d, a, b, texte, hauteur: 1.15) = {
  let sommet = ((a.at(0) + b.at(0)) / 2, a.at(1) + hauteur)
  d.line((a.at(0), a.at(1) + _pastille), sommet, stroke: 0.9pt + estompe)
  d.line((b.at(0), b.at(1) + _pastille), sommet, stroke: 0.9pt + estompe)
  d.content(sommet, text(size: 9pt, fill: accent)[#texte], anchor: "south")
}

// Une arête mise en avant (la fusion), tracée d'un bord de pastille à l'autre.
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

// L'étiquette d'une arête, posée à son milieu (« merge », « git revert »).
#let etiquette-arete(d, a, b, texte, decalage: (0, -0.3), taille: 9pt) = {
  d.content(
    ((a.at(0) + b.at(0)) / 2 + decalage.at(0),
     (a.at(1) + b.at(1)) / 2 + decalage.at(1)),
    text(size: taille, fill: accent)[#texte],
  )
}
