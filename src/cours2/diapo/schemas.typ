// Schémas du cours 2 — ceux qui ne sont pas des graphes de commits.
//
// Le support d'origine de Florent Geniet portait ces dessins en images
// matricielles, produites hors LaTeX. Ils sont redessinés ici avec cetz : rien
// à distribuer avec les sources, et une modification ne demande plus de
// retrouver l'outil qui avait fait l'image.
//
// Les graphes de commits sont dans `src/commun/schemas_git.typ`, d'où le
// cours 6 pourra les reprendre.
//
// `cetz.draw` n'est pas ouvert ici : ses noms masqueraient ceux de typst chez
// qui importerait ce fichier avec `: *`.

#import "@preview/cetz:0.4.2"
#import "../../commun/theme.typ": accent, estompe, brun, gris, attention, alerte, demi-gras, police-code

#let vert-chemin = rgb("#00A651")     // chemin relatif, relevé sur le support
#let rouge-chemin = rgb("#E8112D")    // chemin absolu

// ---------------------------------------------------------------------------
// Pictogrammes de l'arborescence
//
// Dessinés aux primitives, comme ceux du thème : ni police d'icônes, ni
// fichier à installer.

// Un dossier : la patte, puis le corps.
#let _dossier(d, p, taille: 0.46, couleur: accent) = {
  let l = taille
  let h = taille * 0.76
  d.line(
    (p.at(0) - l / 2, p.at(1) - h / 2),
    (p.at(0) - l / 2, p.at(1) + h / 2),
    (p.at(0) - l / 2 + l * 0.34, p.at(1) + h / 2),
    (p.at(0) - l / 2 + l * 0.44, p.at(1) + h / 2 - h * 0.18),
    (p.at(0) + l / 2, p.at(1) + h / 2 - h * 0.18),
    (p.at(0) + l / 2, p.at(1) - h / 2),
    close: true,
    fill: couleur,
    stroke: none,
  )
}

// Un fichier : la feuille, le coin corné, et trois lignes de texte.
#let _fichier(d, p, taille: 0.42, couleur: accent) = {
  let l = taille * 0.78
  let h = taille
  let coin = l * 0.34
  d.line(
    (p.at(0) - l / 2, p.at(1) - h / 2),
    (p.at(0) - l / 2, p.at(1) + h / 2),
    (p.at(0) + l / 2 - coin, p.at(1) + h / 2),
    (p.at(0) + l / 2, p.at(1) + h / 2 - coin),
    (p.at(0) + l / 2, p.at(1) - h / 2),
    close: true,
    fill: white,
    stroke: 1pt + couleur,
  )
  for i in range(3) {
    let y = p.at(1) + h * 0.12 - i * h * 0.18
    d.line(
      (p.at(0) - l * 0.26, y), (p.at(0) + l * 0.26, y),
      stroke: 0.8pt + couleur,
    )
  }
}

// ---------------------------------------------------------------------------
// L'arborescence de fichiers
//
// Les positions sont écrites une fois pour toutes plutôt que calculées : le
// support d'origine place ses nœuds à la main, et un algorithme de placement
// donnerait un dessin ressemblant mais différent d'une diapositive à l'autre.
//
// `chemin` colore une suite d'arêtes — le chemin absolu en rouge depuis la
// racine, le chemin relatif en vert depuis le dossier courant. `courant`
// pose le terminal à côté du dossier où il est ouvert. `caches` ajoute le
// fichier `.config`, en gris, pour la diapositive des fichiers cachés.
#let _noeuds = (
  racine:   (x: 0.0,   y: 3.1,  nom: "/",                type: "dossier"),
  users:    (x: -3.1,  y: 1.6,  nom: "users",            type: "dossier"),
  libs:     (x: 0.0,   y: 1.6,  nom: "libs",             type: "dossier"),
  etc:      (x: 3.1,   y: 1.6,  nom: "etc",              type: "dossier"),
  liste:    (x: -4.4,  y: 0.1,  nom: "users_list.txt",   type: "fichier"),
  fgeniet:  (x: -2.2,  y: 0.1,  nom: "FGeniet",          type: "dossier"),
  numpy:    (x: 0.0,   y: 0.1,  nom: "numpy.py",         type: "fichier"),
  ssh:      (x: 2.2,   y: 0.1,  nom: "ssh",              type: "dossier"),
  cpp:      (x: 4.4,   y: 0.1,  nom: "c++",              type: "dossier"),
  config:   (x: 2.2,   y: -1.5, nom: "ssh_config.json",  type: "fichier"),
  cache:    (x: -2.2,  y: -1.5, nom: ".config",          type: "fichier"),
)

#let _aretes = (
  ("racine", "users"), ("racine", "libs"), ("racine", "etc"),
  ("users", "liste"), ("users", "fgeniet"),
  ("libs", "numpy"),
  ("etc", "ssh"), ("etc", "cpp"),
  ("ssh", "config"),
)

#let arborescence(
  chemin: (),            // arêtes à colorer : (("racine","etc"), ("etc","ssh"), …)
  couleur-chemin: rouge-chemin,
  legende: none,         // (texte, couleur) posé en haut à droite
  courant: none,         // clé du nœud où le terminal est ouvert
  caches: false,
  racine-annotee: false, // le filet pointillé « racine (root) »
  echelle: 1.0,
) = cetz.canvas(length: echelle * 1cm, {
  import cetz.draw: *

  let pos(k) = (_noeuds.at(k).x, _noeuds.at(k).y)
  let dans-chemin(a, b) = chemin.any(p => p.at(0) == a and p.at(1) == b)

  for (a, b) in _aretes {
    if b == "cache" { continue }
    let colore = dans-chemin(a, b)
    line(
      pos(a), pos(b),
      stroke: (
        paint: if colore { couleur-chemin } else { accent },
        thickness: if colore { 1.4pt } else { 0.7pt },
      ),
    )
  }
  if caches {
    line(pos("fgeniet"), pos("cache"), stroke: 0.7pt + estompe)
  }

  for (cle, n) in _noeuds.pairs() {
    if cle == "cache" and not caches { continue }
    let p = (n.x, n.y)
    let teinte = if cle == "cache" { estompe } else { accent }
    if n.type == "dossier" { _dossier(cetz.draw, p, couleur: teinte) }
    else { _fichier(cetz.draw, p, couleur: teinte) }
    content(
      (p.at(0), p.at(1) + 0.4),
      text(size: 8pt, fill: teinte)[#n.nom],
      anchor: "south",
    )
  }

  if racine-annotee {
    let p = pos("racine")
    line(
      (p.at(0) + 0.32, p.at(1)), (p.at(0) + 1.9, p.at(1)),
      stroke: (paint: accent, thickness: 0.6pt, dash: "dotted"),
    )
    content((p.at(0) + 2.0, p.at(1)), text(size: 8pt, fill: accent)[racine (root)], anchor: "west")
  }

  if legende != none {
    let (texte, couleur) = legende
    let y = 2.4
    line((3.6, y), (4.4, y), stroke: 1.4pt + couleur)
    content((4.55, y), text(size: 8pt, fill: accent)[#texte], anchor: "west")
  }

  // Le terminal, posé sous le dossier où il est ouvert, et la flèche épaisse
  // qui l'y rattache : c'est ce dossier qui sert d'origine au chemin relatif.
  if courant != none {
    let p = pos(courant)
    rect(
      (p.at(0) - 0.55, p.at(1) - 1.55), (p.at(0) + 0.55, p.at(1) - 0.9),
      fill: rgb("#2B0A28"), stroke: none,
    )
    line(
      (p.at(0), p.at(1) - 0.88), (p.at(0), p.at(1) - 0.3),
      stroke: 2pt + accent, mark: (end: ">", fill: accent, scale: 0.6),
    )
  }
})

// ---------------------------------------------------------------------------
// Sortie de terminal
//
// Le support d'origine colle des captures de son terminal. Le texte est ici
// composé : il reste net à la projection, et il se corrige.
//
//   #sortie-terminal((
//     ("Sur la branche master", none),
//     ("        modifié :   file.py", rouge-chemin),
//   ))
#let fond-terminal = rgb("#2B0A28")

#let sortie-terminal(lignes, taille: 12pt, largeur: 100%) = block(
  width: largeur, fill: fond-terminal, inset: (x: 10pt, y: 8pt),
)[
  #set text(font: police-code, size: taille, fill: rgb("#EDEDED"))
  #set par(leading: 0.55em, justify: false)
  #for (i, l) in lignes.enumerate() {
    if i > 0 { linebreak() }
    let (texte, couleur) = if type(l) == array { l } else { (l, none) }
    if texte == "" { sym.space }
    else if couleur == none { texte }
    else { text(fill: couleur)[#texte] }
  }
]

// ---------------------------------------------------------------------------
// Un fichier montré à côté d'un commit, avec son coin corné.
#let note-fichier(nom, corps, largeur: 100%) = block(
  width: largeur, stroke: 0.9pt + accent, inset: 0pt,
)[
  #block(width: 100%, inset: (x: 8pt, top: 5pt, bottom: 2pt))[
    #text(size: 11pt, fill: accent)[#nom]
  ]
  #block(width: 100%, inset: (x: 8pt, top: 0pt, bottom: 7pt))[
    #set text(font: police-code, size: 11.5pt)
    #set par(leading: 0.6em)
    #corps
  ]
]

// Coloration du python des fichiers montrés : le support d'origine emploie le
// style par défaut de `listings`, mots-clés en gras et appels en bleu.
#let py-mot(corps) = text(fill: rgb("#0000C0"), weight: "bold")[#corps]
#let py-appel(corps) = text(fill: rgb("#2A6F97"))[#corps]
#let py-marque(corps) = text(fill: rgb("#B35309"), weight: "bold")[#corps]

// ---------------------------------------------------------------------------
// Le dossier d'un projet et son sous-dossier caché.
#let dossier-projet(echelle: 1.0) = cetz.canvas(length: echelle * 1cm, {
  import cetz.draw: *
  // Le filet en équerre, comme celui d'un explorateur de fichiers.
  line((0, 2.0), (0, 0.9), stroke: 0.9pt + accent)
  line((0, 0.9), (0.55, 0.9), stroke: 0.9pt + accent)
  line((0.55, 0.9), (0.55, -0.6), stroke: 0.9pt + accent)
  line((0.55, -0.6), (1.1, -0.6), stroke: 0.9pt + accent)
  line((0.55, -1.5), (0.55, -0.6), stroke: 0.9pt + accent)

  _dossier(cetz.draw, (0.95, 0.9), taille: 0.85)
  content((1.5, 0.9), text(size: 9pt, fill: accent)[projet], anchor: "west")
  _dossier(cetz.draw, (1.5, -0.6), taille: 0.85)
  content((2.05, -0.6), text(size: 9pt, fill: accent)[.git], anchor: "west")
  content((0.55, -1.6), text(size: 9pt, fill: estompe)[...], anchor: "north")
})

// ---------------------------------------------------------------------------
// Pictogrammes des personnes et des postes, pour la diapositive des
// fonctionnalités : qui produit les états, et qui les consomme.
#let personne(d, p, taille: 0.42, couleur: accent) = {
  let t = taille
  d.circle((p.at(0), p.at(1) + t * 0.46), radius: t * 0.26,
           stroke: 0.9pt + couleur, fill: white)
  // Le buste, en trapèze aux épaules arrondies : un arc laisserait la forme
  // ouverte sous la tête.
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

#let ecran(d, p, taille: 0.42, couleur: accent) = {
  d.rect(
    (p.at(0) - taille / 2, p.at(1) - taille * 0.34),
    (p.at(0) + taille / 2, p.at(1) + taille * 0.34),
    stroke: 0.9pt + couleur, fill: white,
  )
  d.line((p.at(0) - taille * 0.18, p.at(1) - taille * 0.34),
         (p.at(0) + taille * 0.18, p.at(1) - taille * 0.34),
         stroke: 1.6pt + couleur)
}

// ---------------------------------------------------------------------------
// Le cycle de vie d'un fichier
//
// Quatre états en colonnes, chacun avec sa ligne de vie, et les commandes qui
// font passer de l'un à l'autre. Le support d'origine dévoile une colonne et
// une flèche à la fois : `etape` rejoue le même dessin à chaque état.
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
    // La boîte d'état, et la ligne de vie qui en descend.
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
    line(
      (x0 + 0.06 * sens, t.y), (x1 - 0.06 * sens, t.y),
      stroke: 2.2pt + accent, mark: (end: ">", fill: accent, scale: 0.45),
    )
    content(
      ((x0 + x1) / 2, t.y + 0.18),
      text(size: 8.5pt, fill: accent)[#t.texte],
      anchor: "south",
    )
  }
})

// ---------------------------------------------------------------------------
// Le modèle de branches des bonnes pratiques
//
// Trois niveaux : `main` ne reçoit que les versions distribuables, `develop`
// porte la version en cours, et une branche par fonctionnalité. Les couleurs
// sont celles du support d'origine — elles distinguent les trois rôles, et
// c'est la seule chose qu'elles codent.
#let _vert-main = rgb("#4FC94F")
#let _bleu-develop = rgb("#6B6BE0")
#let _rose-feature = rgb("#EE77EE")

#let gitflow(etape: 99, echelle: 1.0) = cetz.canvas(length: echelle * 1cm, {
  import cetz.draw: *

  let y-main = 0.0
  let y-dev = 1.3
  let y-f1 = 2.6
  let y-f2 = 3.45
  let y-f3 = 2.65

  let n = (
    v0: (0.0, y-main), v1: (5.7, y-main), v2: (8.65, y-main),
    d1: (1.3, y-dev), d2: (3.7, y-dev), d3: (5.2, y-dev), d4: (7.9, y-dev),
    f1a: (2.3, y-f1), f1b: (3.0, y-f1),
    f2a: (2.3, y-f2), f2b: (4.2, y-f2), f2c: (4.7, y-f2),
    f3a: (6.45, y-f3), f3b: (7.1, y-f3),
  )

  let arete(a, b, couleur) = line(n.at(a), n.at(b), stroke: 1.4pt + couleur)
  let pastille(cle, couleur) = circle(
    n.at(cle), radius: 0.22, fill: couleur.lighten(55%), stroke: 1.1pt + couleur,
  )

  // Niveau 1 — main seul.
  arete("v0", "v1", _vert-main)
  arete("v1", "v2", _vert-main)
  line(n.v2, (n.v2.at(0) + 1.1, y-main), stroke: 1.4pt + _vert-main,
       mark: (end: ">", fill: _vert-main, scale: 0.5))

  // Niveau 2 — develop, ouverte depuis main et refermée sur elle.
  if etape >= 2 {
    arete("v0", "d1", _vert-main)
    arete("d1", "d2", _bleu-develop)
    arete("d2", "d3", _bleu-develop)
    arete("d3", "d4", _bleu-develop)
    arete("d3", "v1", _bleu-develop)
    arete("d4", "v2", _bleu-develop)
    line(n.d4, (n.d4.at(0) + 1.3, y-dev), stroke: 1.4pt + _bleu-develop,
         mark: (end: ">", fill: _bleu-develop, scale: 0.5))
  }

  // Niveau 3 — une branche par fonctionnalité.
  if etape >= 3 {
    arete("d1", "f1a", _rose-feature)
    arete("f1a", "f1b", _rose-feature)
    arete("f1b", "d2", _rose-feature)
    arete("d1", "f2a", _rose-feature)
    arete("f2a", "f2b", _rose-feature)
    arete("f2b", "f2c", _rose-feature)
    arete("f2c", "d3", _rose-feature)
    arete("d3", "f3a", _rose-feature)
    arete("f3a", "f3b", _rose-feature)
    arete("f3b", "d4", _rose-feature)
  }

  // Niveau 4 — develop redescend dans la branche de fonctionnalité, ce que
  // l'ellipse rouge désigne.
  if etape >= 4 {
    arete("d2", "f2b", _rose-feature)
  }

  for cle in ("v0", "v1", "v2") { pastille(cle, _vert-main) }
  if etape >= 2 { for cle in ("d1", "d2", "d3", "d4") { pastille(cle, _bleu-develop) } }
  if etape >= 3 {
    for cle in ("f1a", "f1b", "f2a", "f2b", "f2c", "f3a", "f3b") {
      pastille(cle, _rose-feature)
    }
  }

  if etape >= 4 {
    let a = n.d2
    let b = n.f2b
    let cx = (a.at(0) + b.at(0)) / 2
    let cy = (a.at(1) + b.at(1)) / 2
    circle((cx, cy), radius: (0.28, 1.25), stroke: 1.2pt + rouge-chemin)
  }

  // Les noms de branche, soulignés comme dans le support d'origine. Ceux des
  // fonctionnalités sont alignés à gauche du tronc plutôt que collés à leur
  // premier commit : c'est ainsi que le support les pose, et deux branches
  // ouvertes au même endroit auraient sinon leurs noms l'un sur l'autre.
  let nom-branche(texte, p, x: none) = content(
    (if x == none { p.at(0) - 0.42 } else { x }, p.at(1)),
    text(size: 9pt, weight: demi-gras, fill: accent)[#underline(texte)],
    anchor: "east",
  )
  nom-branche("Main", n.v0)
  if etape >= 2 { nom-branche("Develop", n.d1) }
  if etape >= 3 {
    nom-branche("feature_1", n.f1a, x: 1.15)
    nom-branche("feature_2", n.f2a, x: 1.15)
    nom-branche("feature_3", n.f3a, x: 6.05)
  }

  // Les versions livrées, sous main.
  for (cle, nom) in (("v0", "V"), ("v1", "V"), ("v2", "V")).zip((0, 1, 2)).map(((c, i)) => (c.at(0), i)) {
    content((n.at(cle).at(0), y-main - 0.33),
            text(size: 8.5pt, fill: accent)[V#sub[#nom]], anchor: "north")
  }
})

// ---------------------------------------------------------------------------
// « Git : c'est quoi ? »
//
// Le support d'origine porte ici une seule image, montage de logos et de
// pictogrammes. La structure est redessinée — les cercles, les flèches, les
// personnes, les postes — et les logos sont repris tels quels : ce sont des
// marques, qu'un tracé approché rendrait moins reconnaissables qu'elles ne le
// sont. Ils vivent dans `illustrations/cours2/logos/`, et sont affichés à
// chaque compilation, sans passer par `illustration(…)`.
//
// Les images sont dimensionnées en multiples de `echelle`, comme le reste du
// dessin : sans cela, elles garderaient leur taille quand le schéma rétrécit.

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

  // Un logo posé à un point, à une largeur donnée en unités du dessin.
  let marque(fichier, p, largeur) = content(
    p, image(_logos + fichier, width: largeur * echelle * 1cm),
  )

  for u in _usages {
    if u.etape > etape { continue }
    let (cx, cy) = u.centre
    // La flèche part du bord du losange et s'arrête au bord du cercle.
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
      // Trois états du même projet, reliés par le fil du temps.
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
        line((cx + dx * 0.5, cy + 0.36), (cx + dx, cy - 0.18),
             stroke: 0.7pt + accent, mark: (end: ">", fill: accent, scale: 0.35))
      }
    } else if u.cle == "forge" {
      marque("github.png", (cx, cy + 0.92), 1.15)
      marque("gitlab.png", (cx, cy + 0.6), 1.0)
      marque("serveur.png", (cx, cy + 0.18), 0.5)
      for dx in (-0.62, 0.0, 0.62) {
        ecran(cetz.draw, (cx + dx, cy - 0.62), taille: 0.46)
        line((cx + dx * 0.45, cy - 0.06), (cx + dx, cy - 0.38),
             stroke: 0.7pt + accent, mark: (end: ">", fill: accent, scale: 0.35))
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
