// TD 3a — créer un dépôt et y enregistrer un premier état.
//
// Les cinq premières questions du TP de Florent Geniet
// (`livraison/cours2_florent/TP_session_2.md`). Le TP est un seul exercice
// filé : les cinq TD de la séance travaillent tous dans le même dossier
// `cours2/TP_git/`, et chacun reprend là où le précédent s'est arrêté.
#import "../../../commun/prelude.typ": *
#import "../style.typ": *

#let td = (
  numero: "3a",
  titre: "Un premier dépôt",
  annonce: "Configurer l'affichage du graphe, créer le dépôt, enregistrer un premier commit.",
  dossier: "cours2/3a_premier_depot/",
  duree: "15′",
)

#separateur-td(..td)

#d("TD 3a — un premier dépôt")[
  #question(1)[
    Configurez l'alias qui affichera le graphe du projet :
    #code("git config --global alias.llog 'log --graph --pretty=oneline --abbrev-commit --decorate'",
          taille: 12pt)
    On pourra désormais voir le graphe avec `git llog`.
  ]

  #v(0.5em)
  #question(2)[
    En ligne de commande, placez-vous dans `TP_git/travail/`. Créez un dossier
    `projet_2`, puis entrez dedans.
  ]

  #v(0.5em)
  #question(3)[
    Initialisez un dépôt git dans ce dossier.
  ]
]

#d("TD 3a — enregistrer le premier état")[
  #question(4)[
    Créez un fichier *markdown* `README.md` à la racine du projet,
    c'est-à-dire dans `projet_2`.
  ]

  #v(0.6em)
  #question(5)[
    Créez un nouveau commit contenant le fichier nouvellement créé.
  ]

  #v(0.8em)
  #tableau(
    columns: (1.1fr, 1fr),
    align: left + horizon,
    [Commande], [Ce que `git status` répond ensuite],
    [`git init`], [reponse[dépôt vide, aucun commit, `README.md` non suivi]],
    [`git add README.md`], [reponse[modification à valider : nouveau fichier]],
    [`git commit -m "…"`], [reponse[arbre de travail propre]],
  )

  #notes[
    Passer dans les rangs pendant la question 3 : l'erreur la plus fréquente
    est d'initialiser le dépôt un cran trop haut, dans `travail/` au lieu de
    `projet_2`. `git status` le dit, encore faut-il le lire.
  ]
]
