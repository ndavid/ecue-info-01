// Schémas du cours 2, hors graphes de commits (voir `commun/schemas_git.typ`).
//
// Le support d'origine portait ces dessins en images. Ils sont redessinés avec
// cetz, en unités de `cetz.canvas`, mis à l'échelle par `echelle`.
//
// `cetz.draw` n'est ouvert que dans les `canvas` : ses noms masqueraient ceux
// de typst chez qui importerait ce fichier avec `: *`.
//
//   arborescence(…)       l'arbre de fichiers, avec un chemin coloré
//   invite-commentee(…)   l'invite du terminal et ses trois parties
//   sortie-terminal(…)    un bloc de sortie de terminal
//   note-fichier(…)       un fichier montré à côté d'un commit
//   dossier-projet(…)     le dossier `projet` et son `.git`
//   cycle-de-vie(…)       les états d'un fichier et les commandes entre eux
//   gitflow(…)            main, develop, et une branche par fonctionnalité
//   intro-git(…)          les quatre usages de git autour de la marque

#import "@preview/cetz:0.4.2"
#import "../../commun/theme.typ": accent, estompe, gris, demi-gras, police-code, police-texte
#import "../../commun/schemas_git.typ": rouge-attention

// Couleurs relevées sur le support d'origine.
#let rouge-chemin = rgb("#E8112D")     // chemin absolu
#let vert-chemin = rgb("#00A651")      // chemin relatif
#let fond-terminal = rgb("#300A24")    // terminal GNOME d'Ubuntu
#let gris-barre = rgb("#222222")       // barre de titre de la fenêtre
#let vert-invite = rgb("#26A269")      // utilisateur, dans l'invite bash
#let bleu-invite = rgb("#5674BA")      // dossier courant

// ---------------------------------------------------------------------------
// Pictogrammes, dessinés aux primitives. `d` est le module `cetz.draw`, `p`
// le centre.

#let _dossier(d, p, taille: 0.68, couleur: accent) = {
  let l = taille
  let h = taille * 0.76
  d.line(
    (p.at(0) - l / 2, p.at(1) - h / 2),
    (p.at(0) - l / 2, p.at(1) + h / 2),
    (p.at(0) - l / 2 + l * 0.34, p.at(1) + h / 2),
    (p.at(0) - l / 2 + l * 0.44, p.at(1) + h / 2 - h * 0.18),
    (p.at(0) + l / 2, p.at(1) + h / 2 - h * 0.18),
    (p.at(0) + l / 2, p.at(1) - h / 2),
    close: true, fill: couleur, stroke: none,
  )
}

// La feuille, le coin corné, trois lignes.
#let _fichier(d, p, taille: 0.64, couleur: accent) = {
  let l = taille * 0.78
  let h = taille
  let coin = l * 0.34
  d.line(
    (p.at(0) - l / 2, p.at(1) - h / 2),
    (p.at(0) - l / 2, p.at(1) + h / 2),
    (p.at(0) + l / 2 - coin, p.at(1) + h / 2),
    (p.at(0) + l / 2, p.at(1) + h / 2 - coin),
    (p.at(0) + l / 2, p.at(1) - h / 2),
    close: true, fill: white, stroke: 1pt + couleur,
  )
  for i in range(3) {
    let y = p.at(1) + h * 0.12 - i * h * 0.18
    d.line((p.at(0) - l * 0.26, y), (p.at(0) + l * 0.26, y), stroke: 0.8pt + couleur)
  }
}

// Tête et buste.
#let personne(d, p, taille: 0.42, couleur: accent) = {
  let t = taille
  d.circle((p.at(0), p.at(1) + t * 0.46), radius: t * 0.26, stroke: 0.9pt + couleur, fill: white)
  d.line(
    (p.at(0) - t * 0.42, p.at(1) - t * 0.5),
    (p.at(0) - t * 0.40, p.at(1) + t * 0.06),
    (p.at(0) - t * 0.24, p.at(1) + t * 0.22),
    (p.at(0) + t * 0.24, p.at(1) + t * 0.22),
    (p.at(0) + t * 0.40, p.at(1) + t * 0.06),
    (p.at(0) + t * 0.42, p.at(1) - t * 0.5),
    close: true, stroke: 0.9pt + couleur, fill: white,
  )
}

// Un écran sur son pied.
#let ecran(d, p, taille: 0.42, couleur: accent) = {
  d.rect(
    (p.at(0) - taille / 2, p.at(1) - taille * 0.34),
    (p.at(0) + taille / 2, p.at(1) + taille * 0.34),
    stroke: 0.9pt + couleur, fill: white,
  )
  d.line(
    (p.at(0) - taille * 0.18, p.at(1) - taille * 0.34),
    (p.at(0) + taille * 0.18, p.at(1) - taille * 0.34),
    stroke: 1.6pt + couleur,
  )
}

// ---------------------------------------------------------------------------
// L'arborescence de fichiers
//
// Positions écrites une fois pour toutes, comme dans le support d'origine.
// `place` dit de quel côté du pictogramme le nom se pose : le côté qu'aucune
// arête n'occupe. À revoir si un nœud est déplacé.
#let _noeuds = (
  racine:   (x: 0.0,   y: 3.1,  nom: "/",               type: "dossier", place: "dessus"),
  users:    (x: -3.1,  y: 1.6,  nom: "users",           type: "dossier", place: "gauche"),
  libs:     (x: 0.0,   y: 1.6,  nom: "libs",            type: "dossier", place: "gauche"),
  etc:      (x: 3.1,   y: 1.6,  nom: "etc",             type: "dossier", place: "droite"),
  liste:    (x: -4.4,  y: 0.1,  nom: "users_list.txt",  type: "fichier", place: "dessous"),
  fgeniet:  (x: -2.2,  y: 0.1,  nom: "FGeniet",         type: "dossier", place: "droite"),
  numpy:    (x: 0.0,   y: 0.1,  nom: "numpy.py",        type: "fichier", place: "dessous"),
  ssh:      (x: 2.2,   y: 0.1,  nom: "ssh",             type: "dossier", place: "gauche"),
  cpp:      (x: 4.4,   y: 0.1,  nom: "c++",             type: "dossier", place: "droite"),
  config:   (x: 2.2,   y: -1.5, nom: "ssh_config.json", type: "fichier", place: "dessous"),
  cache:    (x: -2.2,  y: -1.5, nom: ".config",         type: "fichier", place: "dessous"),
)

#let _aretes = (
  ("racine", "users"), ("racine", "libs"), ("racine", "etc"),
  ("users", "liste"), ("users", "fgeniet"),
  ("libs", "numpy"),
  ("etc", "ssh"), ("etc", "cpp"),
  ("ssh", "config"),
)

// `chemin` : les arêtes à colorer, par paires de clés de `_noeuds`.
// `legende` : (texte, couleur), en haut à droite.
// `courant` : la clé du dossier où le terminal est ouvert.
// `caches` : ajoute `.config`, en gris.
// `racine-annotee` : le filet « racine (root) ».
#let arborescence(
  chemin: (),
  couleur-chemin: rouge-chemin,
  legende: none,
  courant: none,
  caches: false,
  racine-annotee: false,
  echelle: 1.0,
) = cetz.canvas(length: echelle * 1cm, {
  import cetz.draw: *

  let pos(k) = (_noeuds.at(k).x, _noeuds.at(k).y)
  let dans-chemin(a, b) = chemin.any(p => p.at(0) == a and p.at(1) == b)

  for (a, b) in _aretes {
    let colore = dans-chemin(a, b)
    line(pos(a), pos(b), stroke: (
      paint: if colore { couleur-chemin } else { accent },
      thickness: if colore { 1.4pt } else { 0.7pt },
    ))
  }
  if caches { line(pos("fgeniet"), pos("cache"), stroke: 0.7pt + estompe) }

  for (cle, n) in _noeuds.pairs() {
    if cle == "cache" and not caches { continue }
    let p = (n.x, n.y)
    let teinte = if cle == "cache" { estompe } else { accent }
    if n.type == "dossier" { _dossier(cetz.draw, p, couleur: teinte) }
    else { _fichier(cetz.draw, p, couleur: teinte) }

    let ecart = 0.46
    let (dx, dy, ancre) = (
      dessus: (0, ecart, "south"),
      dessous: (0, -ecart, "north"),
      gauche: (-ecart, 0, "east"),
      droite: (ecart, 0, "west"),
    ).at(n.place)
    content((p.at(0) + dx, p.at(1) + dy), text(size: 10.5pt, fill: teinte)[#n.nom], anchor: ancre)
  }

  if racine-annotee {
    let p = pos("racine")
    line((p.at(0) + 0.32, p.at(1)), (p.at(0) + 1.9, p.at(1)),
         stroke: (paint: accent, thickness: 0.6pt, dash: "dotted"))
    content((p.at(0) + 2.0, p.at(1)), text(size: 10pt, fill: accent)[racine (root)], anchor: "west")
  }

  if legende != none {
    let (texte, couleur) = legende
    line((3.6, 2.4), (4.4, 2.4), stroke: 1.4pt + couleur)
    content((4.55, 2.4), text(size: 10pt, fill: accent)[#texte], anchor: "west")
  }

  // Le terminal sous le dossier courant, et la flèche qui l'y rattache.
  if courant != none {
    let p = pos(courant)
    rect((p.at(0) - 0.55, p.at(1) - 1.55), (p.at(0) + 0.55, p.at(1) - 0.9),
         fill: fond-terminal, stroke: none)
    line((p.at(0), p.at(1) - 0.88), (p.at(0), p.at(1) - 0.3),
         stroke: 2pt + accent, mark: (end: ">", fill: accent, scale: 0.6))
  }
})

// ---------------------------------------------------------------------------
// L'invite du terminal, commentée
//
// L'invite est composée segment par segment, avec les couleurs de bash, et
// une accolade tombe sous chacune des trois parties nommées. Les positions
// sont calculées au caractère : DejaVu Sans Mono a une chasse de 0,602 em.

// Une accolade ouverte vers le bas, en arcs échantillonnés.
#let _arc-points(cx, cy, r, a0, a1, n: 7) = range(n + 1).map(i => {
  let a = a0 + (a1 - a0) * i / n
  (cx + r * calc.cos(a), cy + r * calc.sin(a))
})

#let _accolade(d, x0, x1, y, profondeur: 0.22, couleur: white, epaisseur: 1.1pt) = {
  let r = calc.min(profondeur / 2, (x1 - x0) / 4)
  let xm = (x0 + x1) / 2
  d.line(
    .._arc-points(x0 + r, y, r, 180deg, 270deg),
    (xm - r, y - r),
    .._arc-points(xm - r, y - 2 * r, r, 90deg, 0deg),
    .._arc-points(xm + r, y - 2 * r, r, 180deg, 90deg),
    (x1 - r, y - r),
    .._arc-points(x1 - r, y, r, 270deg, 360deg),
    stroke: epaisseur + couleur,
  )
}

// Les segments de l'invite et l'indice de leur premier caractère.
#let _invite = (
  (texte: "(base) ", debut: 0, couleur: white, gras: false),
  (texte: "FGeniet@LNV2410P066", debut: 7, couleur: vert-invite, gras: true),
  (texte: ":", debut: 26, couleur: white, gras: false),
  (texte: "~/SIMV/itowns-2.46.0", debut: 27, couleur: bleu-invite, gras: true),
  (texte: "$", debut: 47, couleur: white, gras: false),
)

#let invite-commentee(taille: 17pt, echelle: 1.0) = cetz.canvas(length: echelle * 1cm, {
  import cetz.draw: *

  let cw = 0.602 * taille / (echelle * 1cm)     // chasse, en unités du dessin
  let x-de(i) = 0.7 * cw + i * cw
  let largeur = x-de(69)
  let haut-barre = 0.62

  // La fenêtre : barre de titre, corps.
  rect((0, 0.34), (largeur, 0.34 + haut-barre), fill: gris-barre, stroke: none)
  rect((0, -2.5), (largeur, 0.34), fill: fond-terminal, stroke: none)
  let titre-fenetre = "FGeniet@LNV2410P066: ~/SIMV/itowns-2.46.0"   // chaîne : typst lirait « ~ » comme une espace
  content((largeur / 2, 0.34 + haut-barre / 2),
          text(font: police-texte, size: 11pt, fill: white)[#titre-fenetre])
  content((largeur - 0.3, 0.34 + haut-barre / 2),
          text(font: police-texte, size: 11pt, fill: rgb("#BBBBBB"))[#sym.minus #h(6pt) $square$ #h(6pt) #sym.times],
          anchor: "east")

  for s in _invite {
    content(
      (x-de(s.debut), 0),
      text(font: police-code, size: taille, fill: s.couleur,
           weight: if s.gras { "bold" } else { "regular" })[#s.texte],
      anchor: "west",
    )
  }
  rect((x-de(48.15), -0.22), (x-de(48.95), 0.28), fill: white, stroke: none)   // le curseur

  let nommer(i0, i1, etiquette, profondeur: 0.24) = {
    _accolade(cetz.draw, x-de(i0), x-de(i1), -0.34, profondeur: profondeur)
    content(
      ((x-de(i0) + x-de(i1)) / 2, -0.34 - profondeur - 0.14),
      block(width: 3.4cm)[
        #set par(leading: 0.45em)
        #align(center, text(font: police-texte, size: 12pt, fill: white)[#etiquette])
      ],
      anchor: "north",
    )
  }
  nommer(7, 26, "Utilisateur")
  nommer(27, 47, "Dossier courant")
  nommer(48.05, 49.05, "Zone d'écriture\npour l'utilisateur", profondeur: 0.2)
})

// ---------------------------------------------------------------------------
// Sortie de terminal
//
//   #sortie-terminal((
//     ("Sur la branche master", none),
//     ("        modifié :   file.py", rouge-chemin),
//   ))
#let sortie-terminal(lignes, taille: 12pt, largeur: 100%) = block(
  width: largeur, fill: fond-terminal, inset: (x: 10pt, y: 8pt),
)[
  #set text(font: police-code, size: taille, fill: rgb("#EDEDED"))
  #set par(leading: 0.55em, justify: false)
  #set align(left)
  #for (i, l) in lignes.enumerate() {
    if i > 0 { linebreak() }
    let (texte, couleur) = if type(l) == array { l } else { (l, none) }
    if texte == "" { sym.space }
    else if couleur == none { texte }
    else { text(fill: couleur)[#texte] }
  }
]

// ---------------------------------------------------------------------------
// Un fichier montré à côté d'un commit : nom, puis contenu en chasse fixe.
#let note-fichier(nom, corps, largeur: 100%) = block(
  width: largeur, stroke: 0.9pt + accent, inset: 0pt,
)[
  #block(width: 100%, inset: (x: 8pt, top: 5pt, bottom: 2pt))[#text(size: 11pt, fill: accent)[#nom]]
  #block(width: 100%, inset: (x: 8pt, top: 0pt, bottom: 7pt))[
    #set text(font: police-code, size: 11.5pt)
    #set par(leading: 0.6em)
    #corps
  ]
]

// Coloration du python dans ces fichiers : le style par défaut de `listings`.
#let py-mot(corps) = text(fill: rgb("#0000C0"), weight: "bold")[#corps]
#let py-appel(corps) = text(fill: rgb("#2A6F97"))[#corps]
#let py-marque(corps) = text(fill: rgb("#B35309"), weight: "bold")[#corps]

// ---------------------------------------------------------------------------
// Le dossier `projet` et son `.git`, avec le filet en équerre d'un explorateur.
#let dossier-projet(echelle: 1.0) = cetz.canvas(length: echelle * 1cm, {
  import cetz.draw: *
  let filet = 0.9pt + accent
  line((0, 2.0), (0, 0.9), (0.55, 0.9), stroke: filet)
  line((0.55, 0.9), (0.55, -1.5), stroke: filet)
  line((0.55, -0.6), (1.1, -0.6), stroke: filet)

  _dossier(cetz.draw, (0.95, 0.9), taille: 0.85)
  content((1.5, 0.9), text(size: 9pt, fill: accent)[projet], anchor: "west")
  _dossier(cetz.draw, (1.5, -0.6), taille: 0.85)
  content((2.05, -0.6), text(size: 9pt, fill: accent)[.git], anchor: "west")
  content((0.55, -1.6), text(size: 9pt, fill: estompe)[...], anchor: "north")
})

// ---------------------------------------------------------------------------
// Le cycle de vie d'un fichier
//
// Un état par colonne, avec sa ligne de vie ; une flèche par commande. Chaque
// élément porte l'étape à partir de laquelle il apparaît.
#let _etats = (
  (nom: "Non suivi", x: 0.0, etape: 1),
  (nom: "suivi & non\nmodifié", x: 3.0, etape: 2),
  (nom: "nouvel état", x: 6.0, etape: 3),
  (nom: "modifié", x: 9.0, etape: 4),
)

#let _transitions = (
  (de: 0, vers: 1, y: -0.9,  texte: "add",              etape: 2),
  (de: 1, vers: 2, y: -1.75, texte: "commit",           etape: 3),
  (de: 2, vers: 3, y: -2.6,  texte: "modifier fichier", etape: 4),
  (de: 3, vers: 1, y: -3.45, texte: "add",              etape: 4),
  (de: 1, vers: 2, y: -4.3,  texte: "commit",           etape: 5),
)

#let cycle-de-vie(etape: 99, echelle: 1.0) = cetz.canvas(length: echelle * 1cm, {
  import cetz.draw: *
  let bas = -5.1

  for e in _etats {
    if e.etape > etape { continue }
    content(
      (e.x, 0),
      block(fill: gris.lighten(35%), stroke: 0.7pt + accent, inset: (x: 5pt, y: 3pt))[
        #set par(leading: 0.4em)
        #align(center, text(size: 8.5pt, fill: accent)[#e.nom])
      ],
      anchor: "south",
    )
    line((e.x, -0.08), (e.x, bas), stroke: 0.7pt + accent)
  }

  for t in _transitions {
    if t.etape > etape { continue }
    let x0 = _etats.at(t.de).x
    let x1 = _etats.at(t.vers).x
    let sens = if x1 > x0 { 1 } else { -1 }
    line((x0 + 0.06 * sens, t.y), (x1 - 0.06 * sens, t.y),
         stroke: 2.2pt + accent, mark: (end: ">", fill: accent, scale: 0.45))
    content(((x0 + x1) / 2, t.y + 0.18), text(size: 8.5pt, fill: accent)[#t.texte], anchor: "south")
  }
})

// ---------------------------------------------------------------------------
// Le modèle de branches
//
// Étapes : 1 main ; 2 develop ; 3 les branches de fonctionnalité ; 4 develop
// fusionnée dans feature_2, entourée. Couleurs du support d'origine.
#let _vert-main = rgb("#4FC94F")
#let _bleu-develop = rgb("#6B6BE0")
#let _rose-feature = rgb("#EE77EE")

#let gitflow(etape: 99, echelle: 1.0) = cetz.canvas(length: echelle * 1cm, {
  import cetz.draw: *

  let y-main = 0.0
  let y-dev = 1.3
  let n = (
    v0: (0.0, y-main), v1: (5.7, y-main), v2: (8.65, y-main),
    d1: (1.3, y-dev), d2: (3.7, y-dev), d3: (5.2, y-dev), d4: (7.9, y-dev),
    f1a: (2.3, 2.6), f1b: (3.0, 2.6),
    f2a: (2.3, 3.45), f2b: (4.2, 3.45), f2c: (4.7, 3.45),
    f3a: (6.45, 2.65), f3b: (7.1, 2.65),
  )

  let arete(a, b, couleur) = line(n.at(a), n.at(b), stroke: 1.4pt + couleur)
  let prolongement(a, longueur, couleur) = line(
    n.at(a), (n.at(a).at(0) + longueur, n.at(a).at(1)),
    stroke: 1.4pt + couleur, mark: (end: ">", fill: couleur, scale: 0.5),
  )
  let pastilles(cles, couleur) = for c in cles {
    circle(n.at(c), radius: 0.22, fill: couleur.lighten(55%), stroke: 1.1pt + couleur)
  }
  // Noms de branche, soulignés. `x` force l'abscisse quand deux branches
  // partent du même commit.
  let nom-branche(texte, p, x: none) = content(
    (if x == none { p.at(0) - 0.42 } else { x }, p.at(1)),
    text(size: 9pt, weight: demi-gras, fill: accent)[#underline(texte)],
    anchor: "east",
  )

  arete("v0", "v1", _vert-main)
  arete("v1", "v2", _vert-main)
  prolongement("v2", 1.1, _vert-main)

  if etape >= 2 {
    arete("v0", "d1", _vert-main)
    for (a, b) in (("d1", "d2"), ("d2", "d3"), ("d3", "d4"), ("d3", "v1"), ("d4", "v2")) {
      arete(a, b, _bleu-develop)
    }
    prolongement("d4", 1.3, _bleu-develop)
  }

  if etape >= 3 {
    for (a, b) in (
      ("d1", "f1a"), ("f1a", "f1b"), ("f1b", "d2"),
      ("d1", "f2a"), ("f2a", "f2b"), ("f2b", "f2c"), ("f2c", "d3"),
      ("d3", "f3a"), ("f3a", "f3b"), ("f3b", "d4"),
    ) {
      arete(a, b, _rose-feature)
    }
  }

  if etape >= 4 {
    arete("d2", "f2b", _rose-feature)
    let centre = ((n.d2.at(0) + n.f2b.at(0)) / 2, (n.d2.at(1) + n.f2b.at(1)) / 2)
    circle(centre, radius: (0.28, 1.25), stroke: 1.2pt + rouge-attention)
  }

  pastilles(("v0", "v1", "v2"), _vert-main)
  if etape >= 2 { pastilles(("d1", "d2", "d3", "d4"), _bleu-develop) }
  if etape >= 3 { pastilles(("f1a", "f1b", "f2a", "f2b", "f2c", "f3a", "f3b"), _rose-feature) }

  nom-branche("Main", n.v0)
  if etape >= 2 { nom-branche("Develop", n.d1) }
  if etape >= 3 {
    nom-branche("feature_1", n.f1a, x: 1.15)
    nom-branche("feature_2", n.f2a, x: 1.15)
    nom-branche("feature_3", n.f3a, x: 6.05)
  }

  for (i, cle) in ("v0", "v1", "v2").enumerate() {
    content((n.at(cle).at(0), y-main - 0.33), text(size: 8.5pt, fill: accent)[V#sub[#i]], anchor: "north")
  }
})

// ---------------------------------------------------------------------------
// « Git : c'est quoi ? »
//
// Quatre cercles autour de la marque git, un par usage, révélés par `etape`.
// Les logos sont des images de `illustrations/cours2/logos/`, dimensionnées
// en multiples de `echelle` comme le reste du dessin.

#let _logos = "/illustrations/cours2/logos/"

#let _usages = (
  (cle: "versions", centre: (-6.3, 0.6), etape: 1, titre: "Versionnement\ndu code"),
  (cle: "equipe", centre: (-2.3, -3.0), etape: 2, titre: "Travail à plusieurs"),
  (cle: "forge", centre: (2.3, -3.0), etape: 3, titre: "Hébergement du code\nen ligne"),
  (cle: "outils", centre: (6.3, 0.6), etape: 4, titre: "ligne de commande,\nlogiciels dédiés, IDE"),
)

#let intro-git(etape: 99, echelle: 1.0) = cetz.canvas(length: echelle * 1cm, {
  import cetz.draw: *
  let rayon = 1.45
  let logo = (0, 2.0)
  let fleche = (end: ">", fill: accent, scale: 0.35)

  let marque(fichier, p, largeur) = content(p, image(_logos + fichier, width: largeur * echelle * 1cm))

  for u in _usages {
    if u.etape > etape { continue }
    let (cx, cy) = u.centre

    // Du bord du losange au bord du cercle.
    let dx = cx - logo.at(0)
    let dy = cy - logo.at(1)
    let n = calc.sqrt(dx * dx + dy * dy)
    line(
      (logo.at(0) + dx / n * 1.05, logo.at(1) + dy / n * 1.05),
      (cx - dx / n * rayon, cy - dy / n * rayon),
      stroke: 1.1pt + accent, mark: (end: ">", fill: accent, scale: 0.5),
    )
    circle(u.centre, radius: rayon, stroke: 0.8pt + accent, fill: white)

    if u.cle == "versions" {
      line((cx + 0.45, cy + 0.6), (cx + 0.45, cy - 0.72),
           stroke: (paint: estompe, thickness: 0.7pt, dash: "densely-dashed"),
           mark: (end: ">", fill: estompe, scale: 0.4))
      for (i, teinte) in (rgb("#A8D8A8"), rgb("#F2B8B8"), rgb("#CBB8E8")).enumerate() {
        let y = cy + 0.48 - i * 0.48
        circle((cx + 0.45, y), radius: 0.17, fill: teinte, stroke: 0.7pt + accent)
        content((cx + 0.7, y), text(size: 8pt, fill: accent)[V#(i + 1)], anchor: "west")
      }
    } else if u.cle == "equipe" {
      marque("git.png", (cx, cy + 0.72), 0.62)
      for dx in (-0.68, 0.0, 0.68) {
        personne(cetz.draw, (cx + dx, cy - 0.48), taille: 0.5)
        line((cx + dx * 0.5, cy + 0.36), (cx + dx, cy - 0.18), stroke: 0.7pt + accent, mark: fleche)
      }
    } else if u.cle == "forge" {
      marque("github.png", (cx, cy + 0.92), 1.15)
      marque("gitlab.png", (cx, cy + 0.6), 1.0)
      marque("serveur.png", (cx, cy + 0.18), 0.5)
      for dx in (-0.62, 0.0, 0.62) {
        ecran(cetz.draw, (cx + dx, cy - 0.62), taille: 0.46)
        line((cx + dx * 0.45, cy - 0.06), (cx + dx, cy - 0.38), stroke: 0.7pt + accent, mark: fleche)
      }
    } else {
      marque("gitkraken.png", (cx, cy + 0.7), 0.6)
      marque("terminal.png", (cx - 0.56, cy - 0.02), 0.62)
      marque("vscode.png", (cx + 0.56, cy - 0.02), 0.62)
      marque("tortoisegit.png", (cx, cy - 0.72), 0.85)
    }

    content(
      (cx, cy - rayon - 0.12),
      block(width: 3.1cm)[
        #set par(leading: 0.45em)
        #align(center, text(size: 8.5pt, fill: accent)[#u.titre])
      ],
      anchor: "north",
    )
  }

  marque("git.png", logo, 2.0)
})
