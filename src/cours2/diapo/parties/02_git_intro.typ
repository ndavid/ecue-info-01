// Cours 2, partie 2 — ce qu'est git et à quoi il sert (diapositives 8 à 10).
#import "../../../commun/prelude.typ": *
#import "../beamer.typ": d-beamer as d
#import "../../../commun/schemas_git.typ": *
#import "../schemas.typ": *
#import "../style.typ": *

// --------------------------------------------- 8/26, en cinq étapes
//
// Le support d'origine pose d'abord la seule marque git, puis un cercle par
// usage. La première étape ne montre donc aucun cercle.
//
// Le support d'origine titre cette diapositive « intro » et relègue le sujet
// en sous-titre : c'est un reste de découpage, et le titre projeté n'annonce
// alors rien. Le sujet remonte donc en titre.
#for etape in range(0, 5) {
  d("Git : c'est quoi ?")[
    #align(center, intro-git(etape: etape, echelle: 1.15))

    #if etape == 4 {
      notes[
        Les quatre usages répondent aux quatre questions qui reviennent :
        comment revenir en arrière, comment travailler à plusieurs, où mettre
        le code, avec quoi le manipuler. La séance traite les deux premiers ;
        la forge attend le cours 6.
      ]
    }
  ]
}

// --------------------------------------------- 9/26, en six étapes
//
// La liste et le graphe avancent ensemble : chaque item ajoute au dessin ce
// dont il parle. Le graphe est celui qui servira à toute la séance.
#let _fonctions = (
  [Stockage des états du projet à chaque changement *enregistré*],
  [Modifications en *parallèle*],
  [Développement sur des *versions différentes*],
  [et *fusion* d'états modifiés parallèlement],
  [*Labellisation* de certains états (versions)],
  [Les utilisateurs ont accès aux différentes versions],
)

// Les quatre commits du tronc reçoivent leur pastille de version à l'étape 5 :
// la teinte étant portée par le commit, la liste est reconstruite à chaque
// étape plutôt que corrigée après coup.
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
    // Les développeurs produisent les commits ; leurs flèches se croisent,
    // comme dans le support d'origine : deux personnes travaillent en même
    // temps sur des états différents.
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
    // La fusion, puis ce qu'elle produit.
    if etape >= 4 {
      arete-epaisse(d, pos("c6"), pos("c8"))
      cerne(d, pos("c6"), pos("c8"))
    }
    // Les utilisateurs consomment les versions publiées.
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
        Le même graphe servira jusqu'à la fin de la séance : commits, branches,
        fusion, étiquettes. Y revenir à chaque nouvelle notion plutôt que d'en
        dessiner un autre.
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
    En solo, git sert d'abord de filet : revenir à l'état qui marchait. À
    plusieurs, il devient le moyen de mettre le travail en commun sans
    s'écraser mutuellement. Les deux projets du module font l'un puis l'autre.
  ]
]
