// Démonstration du portage typst du thème Beamer « Bruno ».
// Reprend la structure de `example_beamer/part1.tex`.
//
//   typst compile demo.typ

#import "bruno.typ": bruno, diapo, bloc, bloc-definition, filet, bleu, marron, gris

#show: bruno.with(
  titre: [Cours d'OpenGL : \ Introduction],
  auteurs: ("Florent GENIET",),
  institut: "ENSG",
  date: "6 septembre 2026",
  fond: "exemple-fond.jpg",
  titre-court: "Cours d'OpenGL",
  auteur-court: "F. GENIET",
)

#diapo("Titre de diapositive", sous-titre: "Sous-titre en petites capitales")[
  Le texte courant est en #raw("brunoblue") (`#182936`), pas en noir : c'est la
  couleur `normal text` du thème. La police est Fira Sans si elle est
  installée, Lato sinon.

  - une puce carrée, comme `itemize item [square]`
    - une sous-puce ronde, comme `itemize subitem [circle]`
  - le marqueur reprend la couleur de structure
]

#diapo("Les blocs")[
  #grid(columns: (1fr, 1fr), column-gutter: 8mm)[
    #bloc("Bloc ordinaire")[
      Bandeau de titre bleu sur texte blanc, corps sur fond gris
      `#E6E6E6`. Angles vifs : le thème n'appelle jamais
      `\setbeamertemplate{blocks}[rounded]`.
    ]
  ][
    #bloc-definition("Définition")[
      La police `blockdef` du thème d'origine est `\large` en gras, soit
      12 pt en graisse 500.
    ]
  ]
]

#diapo("Le filet", sous-titre: "Gabarit separator")[
  Le seul usage de #raw("brunomarroon") dans tout le thème est ce filet, sur la
  page de titre. Il fait 0,7 largeur de texte et 0,5 pt d'épaisseur.

  #v(0.8em)
  #filet
  #v(0.8em)

  Le reste du thème n'emploie que trois valeurs : le bleu du texte, le gris du
  pied de page et des blocs, et le blanc du fond.
]

#diapo("Ce que le thème ne fait pas")[
  Relevé utile si l'on compare avec un autre thème :

  #v(0.5em)
  #table(
    columns: (auto, 1fr),
    inset: 5pt,
    align: left + horizon,
    stroke: (x, y) => if y > 0 { (top: 0.4pt + gris.darken(25%)) },
    [Élément], [Dans Bruno],
    [Barre de progression], [absente, contrairement à Metropolis],
    [Diapositive de section], [aucun gabarit ; rien ne se déclenche sur `\section`],
    [Bandeau supérieur], [supprimé (`headline` vidé)],
    [Symboles de navigation], [supprimés],
    [Numérotation], [dans le pied, sous la forme `n / total`],
  )
]
