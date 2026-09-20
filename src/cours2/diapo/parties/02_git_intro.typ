// Cours 2, partie 2 — ce qu'est git et à quoi il sert (diapositives 8 à 10).
#import "../../../commun/prelude.typ": *
#import "../beamer.typ": d-beamer as d
#import "../../../commun/schemas_git.typ": *
#import "../schemas.typ": *
#import "../style.typ": *

// --------------------------------------------- 8/26, en cinq étapes
//
// Étape 0 : la marque seule ; puis un cercle par usage.
// Le support d'origine titre « intro » et met le sujet en sous-titre ; le
// sujet est ici le titre.
#for etape in range(0, 5) {
  d("Git : c'est quoi ?")[
    #align(center, intro-git(etape: etape, echelle: 1.15))

    #if etape == 4 {
      notes[
        Quatre usages : le versionnement du code, le travail à plusieurs,
        l'hébergement en ligne (GitHub, GitLab), les outils (ligne de
        commande, logiciels dédiés, IDE). La séance traite les deux premiers,
        en ligne de commande ; l'hébergement est au cours 6.
      ]
    }
  ]
}

// --------------------------------------------- 9/26, en six étapes
//
// La liste et le graphe avancent ensemble, un élément par étape.
#let _fonctions = (
  [Stockage des états du projet à chaque changement *enregistré*],
  [Modifications en *parallèle*],
  [Développement sur des *versions différentes*],
  [et *fusion* d'états modifiés parallèlement],
  [*Labellisation* de certains états (versions)],
  [Les utilisateurs ont accès aux différentes versions],
)

// La teinte est un champ du commit : la liste est construite pour chaque
// étape, les commits du tronc prenant leur couleur de version à l'étape 5.
#let _commits-fonctions(etape) = {
  let versions = (
    rgb("#C3D9F2"), rgb("#BFE3BF"), rgb("#F5C6C6"), rgb("#D8C9EC"),
  )
  let tronc = ("c1", "c4", "c7", "c8")
  (
    ..tronc.enumerate().map(((i, nom)) => (
      nom: nom, col: i, voie: 0,
      etiquette: if etape >= 5 { "v" + str(i + 1) } else { "" },
      teinte: if etape >= 5 { versions.at(i) } else { white },
      parents: if i == 0 { () } else { (tronc.at(i - 1),) },
    )),
    (nom: "c2", col: 1, voie: 2, etiquette: "", parents: ("c1",), etape: 2),
    (nom: "c3", col: 2, voie: 2, etiquette: "", parents: ("c2",), etape: 2),
    (nom: "c6", col: 3, voie: 2, etiquette: "", parents: ("c3",), etape: 2),
    (nom: "c5", col: 2, voie: 1, etiquette: "", parents: ("c4",), etape: 2),
  ).flatten()
}

#let _graphe-fonctions(etape) = graphe-git(
  commits: _commits-fonctions(etape),
  fleches: ((depuis: "c8"),),
  etape: etape,
  echelle: 0.95,
  extra: (pos, d) => {
    // Les développeurs, au-dessus, avec une flèche vers un commit.
    if etape >= 3 {
      let haut = 4.6
      let cibles = ("c5", "c8", "c6")
      for (i, x) in (0.6, 2.0, 3.4).enumerate() {
        personne(d, (x, haut), taille: 0.55)
        ecran(d, (x + 0.6, haut + 0.25), taille: 0.6)
        let c = pos(cibles.at(i))
        d.line(
          (x, haut - 0.35), (c.at(0) - 0.05, c.at(1) + 0.34),
          stroke: 0.9pt + accent, mark: (end: ">", fill: accent, scale: 0.45),
        )
      }
      d.content((-0.5, haut), text(size: 9pt, fill: accent)[Développeurs], anchor: "east")
    }
    // La fusion.
    if etape >= 4 {
      arete-epaisse(d, pos("c6"), pos("c8"))
      cerne(d, pos("c6"), pos("c8"))
    }
    // Les utilisateurs, au-dessous, avec une flèche vers une version.
    if etape >= 6 {
      let bas = -2.2
      for (i, x) in (0.0, 1.75, 3.5, 5.25).enumerate() {
        for (j, dx) in (-0.3, 0.3).enumerate() {
          personne(d, (x + dx, bas + if j == 0 { 0.0 } else { -0.45 }), taille: 0.5)
        }
        let c = pos(("c1", "c4", "c7", "c8").at(i))
        d.line(
          (x, bas + 0.4), (c.at(0), c.at(1) - 0.34),
          stroke: 0.9pt + accent, mark: (end: ">", fill: accent, scale: 0.45),
        )
      }
      d.content((-0.9, bas), text(size: 9pt, fill: accent)[Utilisateurs], anchor: "east")
    }
  },
)

#for etape in range(1, 7) {
  d("Fonctionnalités")[
    #grid(
      columns: (1.25fr, 1.1fr), column-gutter: 12pt, align: horizon,
      liste-progressive(etape, _fonctions),
      align(center, _graphe-fonctions(etape)),
    )

    #if etape == 6 {
      notes[
        Le même graphe sert jusqu'à la fin de la séance : commits, branches,
        fusion, étiquettes.
      ]
    }
  ]
}

// --------------------------------------------- 10/26, en deux étapes
#d("Git : quand l'utiliser ?")[
  On utilise git pour gérer des *projets informatiques*.
  #list([
    En projet solo :
    #list(
      [Utilisation comme système de sauvegarde],
      [Potentielle mise à disposition des versions finies],
      [Structure git simple],
    )
  ])
]

#d("Git : quand l'utiliser ?")[
  On utilise git pour gérer des *projets informatiques*.
  #list(
    [En projet solo :],
    [
      En projet à plusieurs :
      #list(
        [Mise en commun du travail simplifiée],
        [Travail sur des états parallèles $=>$ on ne se gêne pas],
        [Application des bonnes pratiques en termes de structure git],
      )
    ],
  )

  #notes[
    Le projet de la séance 4 emploie git seul ; le cours 6 et le projet de la
    séance 7 l'emploient à plusieurs.
  ]
]
