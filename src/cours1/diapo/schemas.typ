// Schémas dessinés du cours 1.
//
// Le code d'un dessin n'est pas du contenu de diapositive : le garder ici
// laisse `parties/*.typ` lisible comme une suite de diapositives. S'importe
// depuis une partie, en plus du prélude, et **nommément** :
//
//     #import "../schemas.typ": schema-ou-sexecute
//
// Pas de `: *` : ce fichier ouvre `cetz.draw`, dont les noms (`grid`, `line`,
// `circle`, `content`, `rect`, `scale`…) masqueraient ceux de typst chez qui
// l'importerait en bloc. La faute ne se voit qu'à la compilation, et loin de
// sa cause.
//
// Ce qui est ici ne sert qu'au cours 1 ; `commun/schemas.typ` porte au
// contraire les gabarits employés par toutes les séances.

#import "../../commun/prelude.typ": *
#import "@preview/cetz:0.4.2"
#import cetz.draw: *

// Trait fin des détails intérieurs, dérivé de la couleur de structure.
#let _trait = accent.lighten(45%)

// ---------------------------------------------------------------------------
// « Où s'exécute une application web ? »
//
// Deux lieux d'exécution, ce qui traverse le réseau entre eux, et la règle qui
// décide du partage. Les couleurs codent : `accent` la structure dessinée et
// les étiquettes principales, `estompe` le secondaire, `gris` les remplissages,
// `alerte` ce qui sort de la machine, `attention` la règle du partage.

// Un portable dont l'écran est une fenêtre de navigateur affichant une image en
// cours de retouche. Dessiné dans son repère propre, l'origine au coin
// bas-gauche de l'écran ; l'écran est nommé pour que les flèches s'y accrochent
// sans qu'aucune coordonnée soit réécrite ailleurs.
#let _portable(l, h) = {
  line((-0.8, -0.34), (l + 0.8, -0.34), (l + 0.1, 0), (-0.1, 0),
       close: true, stroke: 1.4pt + accent, fill: gris)
  rect((0, 0), (l, h), radius: 0.1, stroke: 1.6pt + accent, fill: white,
       name: "ecran")

  // barre du navigateur : pastilles et champ d'adresse
  let y-barre = h - 0.58
  rect((0, y-barre), (l, h), radius: (north: 0.1, rest: 0), stroke: none,
       fill: gris)
  line((0, y-barre), (l, y-barre))
  for i in range(3) {
    circle((0.34 + i * 0.32, h - 0.29), radius: 0.095)
  }
  rect((1.5, h - 0.44), (l - 0.32, h - 0.14), radius: 0.07, fill: white)

  // la page affichée : une image, et les curseurs qui la règlent
  let m = 0.4
  let (yh, yb) = (y-barre - m, m)
  let xi = m + (l - 2 * m) * 0.60
  rect((m, yb), (xi, yh), fill: gris.lighten(45%))
  line((m + 0.2, yb + 0.05), (m + 1.35, yh - 0.75), (m + 2.5, yb + 0.05),
       close: true, stroke: none, fill: _trait)
  line((m + 1.9, yb + 0.05), (m + 2.5, yh - 1.25), (m + 3.1, yb + 0.05),
       close: true, stroke: none, fill: accent.lighten(62%))
  circle((m + 0.55, yh - 0.4), radius: 0.16, stroke: none, fill: _trait)
  for i in range(3) {
    let y = (yh + yb) / 2 + (1 - i) * 0.55
    line((xi + 0.3, y), (l - m, y))
    circle((xi + 0.3 + (l - m - xi - 0.3) * (0.28 + 0.24 * i), y),
           radius: 0.115, stroke: none, fill: accent)
  }
}

// Deux baies de serveurs, celle du fond simplement suggérée. Même convention :
// origine au coin bas-gauche de la baie de devant, qui porte le nom.
#let _serveurs(l, h) = {
  rect((0.6, 0.22), (l + 0.6, h + 0.22), radius: 0.1,
       stroke: 1.1pt + _trait, fill: white)
  rect((0, 0), (l, h), radius: 0.1, stroke: 1.6pt + accent, fill: white,
       name: "baie")

  let (n, m) = (3, 0.28)
  let hu = (h - m * (n + 1)) / n
  for i in range(n) {
    let y = m + i * (hu + m)
    rect((m, y), (l - m, y + hu), fill: gris.lighten(45%))
    circle((m + 0.3, y + hu / 2), radius: 0.095, stroke: none, fill: accent)
    circle((m + 0.62, y + hu / 2), radius: 0.095, stroke: none, fill: _trait)
    for k in range(4) {
      let x = l - m - 0.38 - k * 0.26
      line((x, y + 0.16), (x, y + hu - 0.16))
    }
  }
}

// Le nom du lieu, puis ce qui s'y fait et un exemple. Les trois se posent aux
// mêmes hauteurs dans les deux colonnes : c'est ce qui les aligne, alors que
// les deux appareils dessinés n'ont ni la même taille ni la même assise.
#let _etiquettes(x, nom, travail, exemple, y-titre: 8.85, y-legende: 2.80) = {
  content((x, y-titre), anchor: "north",
          text(size: pt-footnotesize, fill: accent, weight: demi-gras)[
            #petites-capitales(nom)])
  content((x, y-legende), anchor: "north", box(width: 12cm)[
    #align(center)[
      #text(size: 15pt, fill: accent)[#travail]
      #v(0.3em)
      #text(size: 14pt, fill: estompe)[#exemple]
    ]
  ])
}

#let schema-ou-sexecute() = cetz.canvas(length: 1cm, {
  // Le trait fin des détails intérieurs est le défaut ; ce qui s'en écarte
  // (contours des appareils, flèches) le dit sur place.
  set-style(stroke: 0.9pt + _trait)

  // Seules ces valeurs fixent la composition : la position des deux colonnes,
  // et la hauteur des trois lignes horizontales du schéma. Les appareils ne
  // grandissent qu'en hauteur : leur écartement est déjà à la limite de la
  // largeur utile de la diapositive.
  let (x-local, x-distant) = (6.2, 19.8)
  let (l-ecran, h-ecran, y-ecran) = (6.6, 4.2, 3.5)
  let (l-baie, h-baie, y-baie) = (4.4, 4.5, 3.16)
  let y-lien = 5.5
  let y-axe = 0.85

  // — les deux lieux d'exécution
  group(name: "local", {
    translate((x-local - l-ecran / 2, y-ecran))
    _portable(l-ecran, h-ecran)
  })
  group(name: "distant", {
    translate((x-distant - l-baie / 2 - 0.3, y-baie))
    _serveurs(l-baie, h-baie)
  })

  _etiquettes(x-local, "dans le navigateur",
              "affichage, interactions, rendu", "retouche d'image en ligne")
  _etiquettes(x-distant, "sur un serveur, à distance",
              "requêtes sur une base de données, calculs lourds",
              "recherche, itinéraire, IA générative")

  // — la traversée du réseau
  //
  // Les flèches s'accrochent au bord des appareils : leur abscisse vient du
  // dessin, seule leur hauteur est décidée ici. Redimensionner un appareil ou
  // déplacer une colonne les suit, sans coordonnée à corriger.
  // `(a, "|-", b)` prend l'abscisse de `a` et l'ordonnée de `b`, comme en
  // TikZ : l'abscisse vient donc de l'appareil, la hauteur du réglage.
  let bord(ancre, y, ecart) = (rel: (ecart, 0), to: (ancre, "|-", (0, y)))
  let depart = bord("local.ecran.east", y-lien + 0.5, 0.85)
  let arrivee = bord("distant.baie.west", y-lien + 0.5, -0.85)
  let retour-depart = bord("distant.baie.west", y-lien - 0.5, -0.85)
  let retour-arrivee = bord("local.ecran.east", y-lien - 0.5, 0.85)

  bezier(depart, arrivee, (rel: (0, 0.75), to: (depart, 50%, arrivee)),
         stroke: 2.2pt + alerte, mark: (end: ">", fill: alerte, scale: 1.5))
  bezier(retour-depart, retour-arrivee,
         (rel: (0, -0.75), to: (retour-depart, 50%, retour-arrivee)),
         stroke: 1.6pt + accent, mark: (end: ">", fill: accent, scale: 1.3))

  content((rel: (0, 0.9), to: (depart, 50%, arrivee)), anchor: "south",
          text(size: pt-footnotesize, fill: alerte, weight: demi-gras)[
            sort de votre ordinateur])
  content((rel: (0, -0.9), to: (retour-depart, 50%, retour-arrivee)),
          anchor: "north", text(size: 16pt, fill: estompe)[le résultat revient])
  content((rel: (0, -0.5), to: (depart, 50%, arrivee)), anchor: "center",
          text(size: 14pt, fill: estompe)[#petites-capitales("réseau")])

  // — ce qui décide du partage
  line((x-local, y-axe), (x-distant, y-axe), stroke: 1pt + attention,
       mark: (end: ">", fill: attention, scale: 1.3))
  content(((x-local, y-axe), 50%, (x-distant, y-axe)), anchor: "north",
          padding: 0.15,
          text(size: 14pt, fill: attention)[complexité du calcul])
})

// ---------------------------------------------------------------------------
// La fenêtre de Visual Studio Code, annotée
//
// Les trois zones de l'éditeur, entourées sur la capture, chacune nommée par
// une étiquette de la même couleur que son contour. La couleur ne sert qu'à
// relier un contour à son nom.
//
// Les coordonnées sont des fractions de la capture, qui mesure 1200 × 596 :
// elles suivent l'image quelle que soit la taille à laquelle on la pose.

#let _zone-ide(couleur, x, y, l, h, etiquette, coin, dx: 0pt, dy: 0pt) = place(
  top + left, dx: x, dy: y,
  box(width: l, height: h, stroke: 2.5pt + couleur)[
    #place(coin, dx: dx, dy: dy, box(
      fill: couleur, inset: (x: 6pt, y: 4pt),
      text(size: 13pt, fill: white, weight: demi-gras, etiquette),
    ))
  ],
)

#let capture-ide(hauteur: 280pt) = {
  let largeur = hauteur * 1200 / 596
  if captures-disponibles {
    box(width: largeur, height: hauteur, stroke: 1pt + accent.lighten(55%))[
      #image("/illustrations/cours1/vscode_projet.png", width: 100%, height: 100%)
      #_zone-ide(attention, 3%, 6%, 21%, 92.5%, "l'arborescence",
                 bottom + left, dx: 5pt, dy: -5pt)
      #_zone-ide(brun, 24.3%, 6%, 54.7%, 75.5%, "le code",
                 top + right, dx: -5pt, dy: 5pt)
      #_zone-ide(alerte, 24.3%, 82.6%, 54.7%, 16.4%, "le terminal",
                 bottom + right, dx: -5pt, dy: -5pt)
    ]
  } else {
    fenetre("trajet — Visual Studio Code", hauteur: hauteur)[
      #text(size: 13pt, fill: estompe)[
        à gauche l'arborescence, au centre le code, en bas le terminal
      ]
    ]
  }
}

// ---------------------------------------------------------------------------
// Espaces et tabulations rendus visibles
//
// L'éditeur dessine un point médian par espace et une flèche par tabulation ;
// les extraits projetés emploient les mêmes signes, écrits dans le texte. Ce
// `show` les teinte pour qu'ils se lisent comme des marques et non comme des
// caractères du programme.
#let blancs(corps) = {
  show regex("[·→]"): it => text(fill: attention)[#it]
  corps
}

// ---------------------------------------------------------------------------
// Soulignement ondulé
//
// Ce que l'éditeur de code trace sous une faute, plutôt qu'un trait droit :
// c'est la forme qu'ils verront à l'écran, et elle se reconnaît sans légende.
// Dessiné avec `curve`, natif à typst — cetz n'exporte pas ce nom, l'import en
// bloc de ce fichier ne le masque donc pas.
//
// Le tracé est posé par-dessus le texte, sans occuper de place : la ligne de
// code garde exactement la largeur qu'elle aurait sans lui.
#let souligne-ondule(
  corps, couleur: alerte, amplitude: 1.6pt, periode: 4.5pt, epaisseur: 1.2pt,
) = context {
  let n = calc.max(1, int(measure(corps).width / periode))
  let arcs = range(n).map(i => curve.quad(
    (periode / 2, if calc.even(i) { -amplitude } else { amplitude }),
    (periode, 0pt),
    relative: true,
  ))
  box(baseline: 0pt)[
    #corps
    #place(bottom + left, dy: 3.5pt,
           curve(stroke: epaisseur + couleur, curve.move((0pt, 0pt)), ..arcs))
  ]
}

// ---------------------------------------------------------------------------
// Environnements et bibliothèques
//
// Deux schémas qui partagent la même boîte « environnement », dessinée par
// `_environnement` : le premier montre pourquoi on cloisonne, le second d'où
// vient ce qu'on y installe.
//
// La convention de couleur est celle du schéma « Où s'exécute une application
// web » : `alerte` marque ce qui traverse la frontière de la machine, ou ce qui
// entrerait en conflit sans elle. `accent` porte la structure, `estompe` le
// secondaire.

#let _pastille(x, y, l, h, texte, couleur: accent) = {
  rect((x, y), (x + l, y + h), radius: 0.09,
       stroke: 1pt + couleur, fill: couleur.lighten(92%))
  content((x + l / 2, y + h / 2),
          text(size: 14pt, fill: couleur, font: police-code)[#texte])
}

// Une boîte d'environnement : un bandeau qui la nomme, puis une pastille par
// paquet. `paquets` est une liste de (texte, couleur). Rendue dans son repère
// propre, coin bas-gauche à l'origine ; sa hauteur suit le nombre de paquets.
#let hauteur-environnement(n) = 1.0 + (0.75 + 0.28) * n + 0.28

#let _environnement(l, nom, paquets) = {
  let h = hauteur-environnement(paquets.len())
  rect((0, 0), (l, h), radius: 0.1, stroke: 1.6pt + accent, fill: white)
  rect((0, h - 1.0), (l, h), radius: (north: 0.1, rest: 0), stroke: none, fill: gris)
  line((0, h - 1.0), (l, h - 1.0), stroke: 1pt + accent.lighten(45%))
  content((l / 2, h - 0.5),
          text(size: 16pt, weight: demi-gras, font: police-code)[#nom])
  for (i, p) in paquets.enumerate() {
    _pastille(0.35, h - 1.0 - (0.75 + 0.28) * (i + 1), l - 0.7, 0.75,
              p.at(0), couleur: p.at(1))
  }
}

// ---- 1. Pourquoi isoler un environnement ---------------------------------

#let schema-isolation() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)

  let l = 10.2
  let (xa, xb) = (1.6, 14.2)
  let y = 2.5
  let h = hauteur-environnement(3)

  // La machine contient les deux environnements, et le Python qu'elle avait
  // déjà : c'est le cloisonnement qui est le propos, pas les boîtes.
  rect((0.5, 1.1), (25.5, y + h + 1.3), radius: 0.15,
       stroke: 1.2pt + estompe, fill: gris.lighten(55%))
  content((1.0, y + h + 0.75), anchor: "west",
          text(size: 15pt, fill: estompe)[#petites-capitales("votre machine")])

  group(name: "a", {
    translate((xa, y))
    _environnement(l, "recette", (
      ("python 3.12", accent),
      ("numpy 1.26", alerte),
      ("pillow 10.4", accent),
    ))
  })
  group(name: "b", {
    translate((xb, y))
    _environnement(l, "autre-projet", (
      ("python 3.11", accent),
      ("numpy 2.1", alerte),
      ("pandas 2.2", accent),
    ))
  })

  // Le Python que la machine avait avant, resté à sa place.
  rect((xa, 1.5), (xb + l, 2.15), radius: 0.08,
       stroke: 1pt + estompe.lighten(40%), fill: white)
  content(((xa + xb + l) / 2, 1.83),
          text(size: 14pt, fill: estompe)[
            le Python du système, auquel aucun des deux n'a touché
          ])

  // Le conflit que le cloisonnement rend inoffensif.
  let y-numpy = y + h - 1.0 - (0.75 + 0.28) * 2 + 0.375
  line((xa + l, y-numpy), (xb, y-numpy),
       stroke: (paint: alerte, thickness: 1.2pt, dash: "dashed"))
  content((13.0, 0.85), anchor: "north",
          text(size: pt-footnotesize, fill: alerte, weight: demi-gras)[
            la même bibliothèque, en deux versions, sans qu'elles se croisent
          ])
})

// ---- 2. D'où viennent les paquets ----------------------------------------

// Un dépôt, dessiné en casier : un couvercle, ce qu'il contient, et ce qui
// décide de ce qui y entre.
#let _depot(l, haut, nom, nombre, unite, porte, plein: false) = {
  let teinte = if plein { accent } else { estompe }
  rect((0, 0), (l, haut), radius: 0.1, stroke: 1.5pt + teinte,
       fill: if plein { accent.lighten(95%) } else { white })
  rect((-0.25, haut - 0.6), (l + 0.25, haut + 0.12), radius: 0.08,
       stroke: 1.5pt + teinte, fill: gris)
  content((l / 2, haut - 0.28),
          text(size: 15pt, weight: demi-gras, font: police-code)[#nom])
  content((l / 2, haut - 1.0), anchor: "north", box(width: l * 1cm)[
    #align(center)[
      #text(size: 26pt, weight: demi-gras, fill: teinte)[#nombre]
      #h(5pt) #text(size: 15pt, fill: estompe)[#unite]
    ]
  ])
  content((l / 2, haut - 1.95), anchor: "north", box(width: (l - 0.3) * 1cm)[
    #align(center, text(size: 14pt, fill: estompe)[#porte])
  ])
}

#let schema-depots() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)

  let l-env = 8.4
  let h-env = hauteur-environnement(3)
  let (l-dep, h-dep) = (9.5, 3.1)
  let (x-dep, x-env) = (16.2, 0.3)
  let y-env = 2.0

  group(name: "env", {
    translate((x-env, y-env))
    _environnement(l-env, "recette", (
      ("python 3.12", accent),
      ("numpy 1.26", accent),
      ("pillow 10.4", alerte),
    ))
  })
  content((x-env + l-env / 2, y-env - 0.25), anchor: "north",
          text(size: 14pt, fill: estompe)[#petites-capitales("votre machine")])

  group(name: "pypi", {
    translate((x-dep, 4.5))
    _depot(l-dep, h-dep, "PyPI", "886 022", "projets",
           "publication immédiate, par qui veut")
  })
  group(name: "forge", {
    translate((x-dep, 0.7))
    _depot(l-dep, h-dep, "conda-forge", "29 411", "paquets",
           "une recette, relue avant d'entrer", plein: true)
  })

  // Ce qui entre, et qui s'exécutera avec vos droits.
  let xa = x-dep - 0.55
  let xb = x-env + l-env + 0.55
  let ym = y-env + h-env / 2
  bezier((xa, 2.25), (xb, ym), ((xa + xb) / 2, ym - 0.45),
         stroke: 2.4pt + alerte, mark: (end: ">", fill: alerte, scale: 1.5))
  content(((xa + xb) / 2, ym + 0.35), anchor: "south", box(width: 7.0cm)[
    #align(center)[
      #text(size: 15pt, fill: alerte, weight: demi-gras,
            font: police-code)[conda install pillow]
      #v(0.2em)
      #text(size: 14pt, fill: alerte)[s'exécute avec vos droits]
    ]
  ])
})

// ---------------------------------------------------------------------------
// Résoudre les dépendances : le cas du diamant
//
// Trois paquets réclament le même quatrième, chacun avec sa propre exigence de
// version. L'outil doit trouver une version qui les satisfasse toutes : c'est
// ce qui distingue une résolution d'un simple parcours du graphe.
//
// Contraintes relevées dans `conda-meta/` de l'environnement `recette`, le
// 10 septembre 2026. Elles ne sont pas inventées : `python` exige libgcc >= 15,
// `liblzma` >= 14 et `libnsl` >= 13, et une seule version est installée.

#let _boite-paquet(nom, version, nom-cetz, couleur: accent, largeur: 5.0) = {
  rect((-largeur / 2, -0.72), (largeur / 2, 0.72), radius: 0.1,
       stroke: 1.5pt + couleur, fill: couleur.lighten(94%), name: nom-cetz)
  content((0, 0.26),
          text(size: 18pt, weight: demi-gras, font: police-code, fill: couleur)[#nom])
  content((0, -0.36), text(size: 14pt, fill: estompe)[#version])
}

// L'exigence portée par une arête, posée sur le trait.
#let _exigence(depuis, vers, texte, position: 50%) = {
  content((depuis, position, vers), anchor: "center",
          box(fill: white, inset: 3pt,
              text(size: 15pt, font: police-code, fill: alerte)[#texte]))
}

#let schema-diamant() = cetz.canvas(length: 1cm, {
  set-style(stroke: 1.2pt + accent.lighten(30%),
            mark: (end: ">", fill: accent.lighten(30%), scale: 1.2))

  let y-haut = 8.4
  let y-milieu = 5.0
  let y-bas = 1.7

  group(name: "py", {
    translate((13.0, y-haut))
    _boite-paquet("pillow", "12.3.0", "b", largeur: 5.4)
  })
  group(name: "lzma", {
    translate((6.2, y-milieu))
    _boite-paquet("libtiff", "4.7.2", "b")
  })
  group(name: "nsl", {
    translate((19.8, y-milieu))
    _boite-paquet("openjpeg", "2.5.4", "b")
  })
  group(name: "gcc", {
    translate((13.0, y-bas))
    _boite-paquet("libzlib", "1.3.2", "b", couleur: attention, largeur: 5.4)
  })

  line("py.b.west", "lzma.b.north")
  line("py.b.east", "nsl.b.north")
  line("lzma.b.south", "gcc.b.west")
  line("nsl.b.south", "gcc.b.east")

  _exigence("py.b.west", "lzma.b.north", "libtiff >=4.7.2", position: 52%)
  _exigence("py.b.east", "nsl.b.north", "openjpeg >=2.5.4", position: 52%)
  _exigence("lzma.b.south", "gcc.b.west", "libzlib >=1.3.2", position: 45%)
  _exigence("nsl.b.south", "gcc.b.east", "libzlib >=1.3.2", position: 45%)

  content((13.0, y-bas - 1.35), anchor: "north", box(width: 17cm)[
    #align(center)[
      #text(size: 16pt, fill: attention, weight: demi-gras)[
        une seule version installée, qui satisfait les deux exigences
      ]
    ]
  ])
})

// ---------------------------------------------------------------------------
// Ce que l'activation d'un environnement change
//
// Le terminal ne cherche pas `python` partout : il parcourt les dossiers de
// `PATH` de gauche à droite et s'arrête au premier trouvé. Activer un
// environnement n'installe rien et ne déplace rien : cela pose un dossier de
// plus en tête de cette liste.
//
// Chemins relevés le 10 septembre 2026, avant et après `conda activate`.

#let _dossier(x, y, l, texte, trouve: false) = {
  rect((x, y), (x + l, y + 1.0), radius: 0.08,
       stroke: (if trouve { 1.8pt + attention } else { 1pt + estompe.lighten(35%) }),
       fill: (if trouve { attention.lighten(92%) } else { white }))
  content((x + l / 2, y + 0.5),
          text(size: 15pt, font: police-code,
               fill: (if trouve { attention } else { estompe }))[#texte])
}

// Largeur d'une boîte de dossier, déduite du nombre de caractères : la police
// du code est à chasse fixe, une lettre y avance de 0,318 cm à 15 pt. Écrire
// les largeurs à la main les désaccorderait du texte au premier chemin changé.
#let _largeur-dossier(texte) = 0.318 * texte.clusters().len() + 0.7

// Une ligne du schéma : son intitulé, les dossiers parcourus de gauche à
// droite, et le programme qui finit par s'exécuter. `decalage` sert à aligner
// les dossiers du système d'une ligne à l'autre, la seconde en portant un de
// plus en tête.
#let _ligne-chemin(y, intitule, dossiers, resultat, indice-trouve,
                   decalage: 0.0) = {
  content((0.4, y + 1.5), anchor: "west",
          text(size: pt-footnotesize, fill: accent, weight: demi-gras)[#intitule])

  let x = 0.4 + decalage
  for (i, d) in dossiers.enumerate() {
    let l = _largeur-dossier(d)
    _dossier(x, y, l, d, trouve: i == indice-trouve)
    if i + 1 < dossiers.len() {
      line((x + l + 0.16, y + 0.5), (x + l + 0.62, y + 0.5),
           stroke: 1pt + estompe.lighten(50%),
           mark: (end: ">", fill: estompe.lighten(50%), scale: 0.8))
    }
    x = x + l + 0.78
  }

  content((x + 0.15, y + 0.5), anchor: "west",
          text(size: 16pt, font: police-code, fill: attention,
               weight: demi-gras)[#resultat])
}

#let schema-chemin() = cetz.canvas(length: 1cm, {
  set-style(stroke: 0.9pt + _trait)

  // Chemins d'un poste Windows, celui de la salle ; la légende de la
  // diapositive donne les équivalents macOS et Linux.
  let dossiers-systeme = ("C:\\Windows\\System32", "C:\\Windows")
  let dossier-env = "…\\envs\\recette"
  let decalage = _largeur-dossier(dossier-env) + 0.78

  // Ce que l'on tape, une fois pour les deux lignes.
  content((0.4, 8.5), anchor: "west", box[
    #text(size: 16pt, fill: estompe)[vous tapez] #h(6pt)
    #box(fill: gris, inset: (x: 8pt, y: 4pt), radius: 3pt,
         text(size: 18pt, font: police-code, weight: demi-gras)[python])
    #h(10pt)
    #text(size: 16pt, fill: estompe)[
      et le terminal parcourt #raw("PATH") de gauche à droite
    ]
  ])

  _ligne-chemin(5.4, [sans environnement actif],
                dossiers-systeme, [introuvable, ou un autre python], -1,
                decalage: decalage)

  _ligne-chemin(1.8, [après #raw("conda activate recette")],
                (dossier-env,) + dossiers-systeme,
                […\\envs\\recette\\python.exe], 0)

  // Le dossier que l'activation ajoute, et rien d'autre.
  content((0.4 + decalage / 2 - 0.39, 1.6), anchor: "north", box(width: 7cm)[
    #align(center)[
      #text(size: 14pt, fill: alerte, weight: demi-gras)[
        posé en tête par l'activation
      ]
    ]
  ])
})
