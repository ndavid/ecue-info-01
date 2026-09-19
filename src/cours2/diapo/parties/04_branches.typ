// Cours 2, partie 4 — branches, HEAD, fusion et conflits (diapositives 17 à
// 20). C'est ici qu'apparaît le graphe à huit commits, que les quatre
// diapositives se repassent : le même dessin sert à montrer le rebase, le
// merge, HEAD et le conflit.
#import "../../../commun/prelude.typ": *
#import "../../../commun/schemas_git.typ": *
#import "../schemas.typ": *
#import "../style.typ": *

// Le graphe de référence : deux branches ouvertes sur commit 1, et un commit
// resté seul sur une voie intermédiaire.
#let _reference = (
  (nom: "c1", col: 0, voie: 0, etiquette: "commit 1"),
  (nom: "c4", col: 1, voie: 0, etiquette: "commit 4", parents: ("c1",)),
  (nom: "c7", col: 2, voie: 0, etiquette: "commit 7", parents: ("c4",)),
  (nom: "c8", col: 3, voie: 0, etiquette: "commit 8", parents: ("c7",)),
  (nom: "c2", col: 1, voie: 2, etiquette: "commit 2", parents: ("c1",)),
  (nom: "c3", col: 2, voie: 2, etiquette: "commit 3", parents: ("c2",)),
  (nom: "c6", col: 3, voie: 2, etiquette: "commit 6", parents: ("c3",)),
  (nom: "c5", col: 2, voie: 1, etiquette: "commit 5", parents: ("c4",)),
)

#let _branches-reference = (
  (nom: "branche 1", voie: 0, col: 3, ancre: "west"),
  (nom: "branche 2", voie: 2, col: 0, ancre: "east"),
)

// Quand les noms de branche sont affichés, le support d'origine remplace la
// flèche de prolongement par l'étiquette : les deux se superposeraient.
#let _graphe-reference(echelle: 0.92, branches: (), extra: none) = graphe-git(
  commits: _reference,
  branches: branches,
  fleches: if branches.len() == 0 { ((depuis: "c8"),) } else { () },
  echelle: echelle,
  extra: extra,
)

// --------------------------------------------- 17/26, en deux étapes
#let _deux-branches(haut, bas, echelle: 1.0) = graphe-git(
  commits: (
    (nom: "a", col: 0, voie: 0, etiquette: ""),
    (nom: "b", col: 1, voie: 0, etiquette: "", parents: ("a",)),
    (nom: "c", col: 1, voie: 1.6, etiquette: "", parents: ("a",)),
  ),
  branches: (
    (nom: haut, voie: 1.6, col: 1, ancre: "west"),
    (nom: bas, voie: 0, col: 1, ancre: "west", dy: -0.42),
  ),
  fleches: ((depuis: "b", longueur: 0.9), (depuis: "c", longueur: 0.9)),
  echelle: echelle,
)

#d("Branches")[
  #grid(
    columns: (1.15fr, 1fr), column-gutter: 18pt, align: horizon,
    [
      Création de *branches* de commits évoluant en parallèle.
      #code("#Créer une nouvelle branche
#à partir du commit courant
git branch <nom_de_branche>

#Créer une nouvelle branche
#et s'y placer
git checkout -b <nom_branche>

#Changer de branche
git checkout <nom_de_branche>

#voir les différentes branches
git branch", taille: 13pt, interligne: 0.5em)
    ],
    align(center, _deux-branches("branche 2", "branche 1", echelle: 0.95)),
  )
]

#d("Branches")[
  #grid(
    columns: (1fr, 1fr), column-gutter: 18pt, align: horizon,
    [La branche initiale s'appelle *master*, ou parfois *main*.],
    align(center, _deux-branches("branche", "main", echelle: 1.15)),
  )

  #notes[
    `master` est le nom historique ; `main` est celui que créent aujourd'hui
    GitHub et GitLab. Les deux se croisent encore, et `git init` en choisit un
    selon la version de git installée. Le dire évite la surprise au TD.
  ]
]

// --------------------------------------------- 18/26
//
// Deux états du même graphe, séparés par la commande qui fait passer de l'un
// à l'autre : c'est la flèche verticale qui porte le propos.
#d("Head")[
  #grid(
    columns: (0.85fr, 1.45fr), column-gutter: 16pt, align: horizon,
    [
      HEAD : désigne le commit sur lequel on se trouve (commit courant)
      #code("#Changer de commit
git checkout <nom_de_commit>", taille: 13.5pt)
    ],
    align(center)[
      #_graphe-reference(echelle: 0.95, extra: (pos, d) => marque-tete(d, pos("c6")))
      #v(0.2em)
      #grid(
        columns: (auto, auto), column-gutter: 8pt, align: horizon,
        text(size: 26pt, fill: accent)[#sym.arrow.b],
        text(size: 14pt, weight: demi-gras, fill: accent)[git checkout commit_7],
      )
      #v(0.2em)
      #_graphe-reference(echelle: 0.95, extra: (pos, d) => marque-tete(d, pos("c7"), dy: 0.85))
    ],
  )
]

// --------------------------------------------- 19/26, en trois étapes
#d("Fusionner deux branches")[
  #grid(
    columns: (1fr, 1.2fr), column-gutter: 18pt, align: horizon,
    [
      Deux branches peuvent être fusionnées #sym.arrow.r.double les
      modifications des deux branches sont ajoutées.
    ],
    align(center, _graphe-reference(echelle: 0.95, extra: (pos, d) => {
      arete-epaisse(d, pos("c6"), pos("c8"))
      cerne(d, pos("c6"), pos("c8"))
    })),
  )
]

#d("Fusionner deux branches")[
  #grid(
    columns: (1fr, 1.2fr), column-gutter: 18pt, align: horizon,
    [
      Une première façon de fusionner est le *merge*.\
      Le merge crée un nouveau commit de fusion
      #code("#Merge la branche b_1
#dans la branche courante
git merge <b_1>", taille: 13.5pt, interligne: 0.5em)
    ],
    align(center, _graphe-reference(echelle: 0.95, extra: (pos, d) => {
      d.line(pos("c6"), pos("c8"),
             stroke: (paint: estompe, thickness: 1pt, dash: "densely-dashed"))
      etiquette-arete(d, pos("c6"), pos("c8"), "merge", decalage: (0.42, 0))
    })),
  )
]

// Le rebase montre deux états : avant, et après que les commits de la branche
// source ont été replacés au sommet de la branche cible.
#let _rebase-apres = (
  (nom: "c1", col: 0, voie: 0, etiquette: "commit 1"),
  (nom: "c4", col: 1, voie: 0, etiquette: "commit 4", parents: ("c1",)),
  (nom: "c7", col: 2, voie: 0, etiquette: "commit 7", parents: ("c4",)),
  (nom: "c8", col: 3, voie: 0, etiquette: "commit 8", parents: ("c7",)),
  (nom: "c5", col: 1.6, voie: 1, etiquette: "commit 5", parents: ("c4",)),
  (nom: "c2b", col: 3.7, voie: 2, etiquette: "commit 2 bis", parents: ("c8",)),
  (nom: "c3b", col: 5.2, voie: 2, etiquette: "commit 3 bis", parents: ("c2b",)),
  (nom: "c6b", col: 6.7, voie: 2, etiquette: "commit 6 bis", parents: ("c3b",)),
)

#d("Fusionner deux branches")[
  #grid(
    columns: (0.85fr, 1.45fr), column-gutter: 16pt, align: horizon,
    [
      Une seconde façon de fusionner est le *rebase*.\
      Le rebase rajoute les commits de la branche source au sommet de la
      branche cible.
      #code("#Rebase la branche b_1
#dans la branche b_2
git rebase <b_1> <b_2>", taille: 13.5pt, interligne: 0.5em)
    ],
    align(center)[
      #_graphe-reference(echelle: 0.82, branches: _branches-reference)
      #v(0.15em)
      #text(size: 24pt, fill: accent)[#sym.arrow.b]
      #v(0.15em)
      #graphe-git(
        commits: _rebase-apres,
        branches: (
          (nom: "branche 1", voie: 0, col: 3, ancre: "west"),
          (nom: "branche 2", voie: 2, col: 3.7, ancre: "east"),
        ),
        echelle: 0.82,
      )
    ],
  )

  #notes[
    Le rebase réécrit l'historique : les commits replacés sont de nouveaux
    commits, d'où les « bis ». C'est pourquoi on ne rebase pas une branche que
    quelqu'un d'autre a déjà récupérée. Le TD le fait constater sur la branche
    `main_code`.
  ]
]

// --------------------------------------------- 20/26, en trois étapes
//
// Le graphe se resserre ici sur les quatre commits qui portent le conflit : la
// diapositive doit loger en plus les trois versions du fichier.
#let _graphe-conflit(echelle: 0.85, extra: none) = graphe-git(
  commits: (
    (nom: "c1", col: 0, voie: 0, etiquette: "commit 1"),
    (nom: "c2", col: 1, voie: 1.5, etiquette: "commit 2", parents: ("c1",)),
    (nom: "c3", col: 1, voie: 0, etiquette: "commit 3", parents: ("c1",)),
    (nom: "m", col: 2, voie: 0.75, etiquette: "merge", parents: ("c2", "c3")),
  ),
  echelle: echelle,
  extra: extra,
)

#let _fichier-multiplication = note-fichier("file.py")[
  #py-mot("def") #py-appel("fonction_1")\(a,b\):\
  #h(1em) #py-mot("return") a\*b
]

#let _fichier-addition = note-fichier("file.py")[
  #py-mot("def") #py-appel("fonction_1")\(a,b\):\
  #h(1em) #py-mot("return") a+b
]

#d("Conflits")[
  #grid(
    columns: (1fr, 1.3fr), column-gutter: 16pt, align: horizon,
    [
      Deux modifications peuvent être contradictoires. Il y a alors *conflit* :
      le développeur doit choisir comment fusionner les deux modifications.
    ],
    align(center)[
      #_graphe-reference(echelle: 0.88, extra: (pos, d) => {
        marque-conflit(d, (pos("c8").at(0) + 0.05, pos("c8").at(1) + 0.75))
      })
      #v(0.6em)
      #sortie-terminal((
        ("Fusion automatique de file.py", none),
        ("CONFLIT (contenu) : Conflit de fusion dans file.py", none),
        ("La fusion automatique a échoué ; réglez les conflits et validez le résultat.", none),
      ), taille: 10pt)
    ],
  )
]

#d("Conflits")[
  #grid(
    columns: (1fr, 1.45fr), column-gutter: 14pt, align: horizon,
    [
      En cas de conflit lors d'un *merge*, git suspend le merge et marque les
      conflits *directement dans les fichiers*.
    ],
    grid(
      columns: (1fr, 1.15fr), column-gutter: 10pt, align: horizon,
      grid(
        columns: 1, row-gutter: 8pt,
        _fichier-multiplication,
        align(center, _graphe-conflit(echelle: 0.72, extra: (pos, d) => {
          marque-conflit(d, pos("m"), texte: "")
        })),
        _fichier-addition,
      ),
      note-fichier("file.py")[
        #py-mot("def") #py-appel("fonction_1")\(a,b\):\
        #py-marque("<<<<<<< HEAD")\
        #h(1em) #py-mot("return") a+b\
        #py-marque("=======")\
        #h(1em) #py-mot("return") a\*b\
        #py-marque(">>>>>>> branche_1")
      ],
    ),
  )
]

#d("Conflits")[
  #grid(
    columns: (1fr, 1.45fr), column-gutter: 14pt, align: horizon,
    [
      Les conflits se résolvent directement dans les fichiers. Une fois les
      conflits résolus, on peut reprendre le merge avec la commande
      #code("git merge --continue

#Idem pour le rebase
git rebase --continue", taille: 13.5pt, interligne: 0.5em)
    ],
    grid(
      columns: (1fr, 1.1fr), column-gutter: 10pt, align: horizon,
      grid(
        columns: 1, row-gutter: 8pt,
        _fichier-multiplication,
        align(center, _graphe-conflit(echelle: 0.72)),
        _fichier-addition,
      ),
      note-fichier("file.py")[
        #py-mot("def") #py-appel("fonction_1")\(a,b\):\
        #h(1em) #py-mot("return") [a+b,a\*b]
      ],
    ),
  )

  #notes[
    Le conflit n'est pas une panne : git s'arrête parce qu'il ne peut pas
    choisir à notre place. Les marqueurs `<<<<<<<`, `=======` et `>>>>>>>`
    sont du texte ordinaire, à supprimer une fois le choix fait — c'est ce
    qu'oublient la moitié des étudiants au TD.
  ]
]
