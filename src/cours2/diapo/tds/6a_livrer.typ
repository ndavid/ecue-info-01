// TD 6a — publier une version (questions 26 et 27 du TP).
#import "../../../commun/prelude.typ": *
#import "../style.typ": *

#let td = (
  numero: "6a",
  titre: "Publier une version",
  annonce: "Ramener develop dans master, et étiqueter le commit obtenu.",
  dossier: "cours2/6a_livrer/",
  duree: "10′",
)

#separateur-td(..td)

#d("TD 6a — publier une version")[

  #legende[
    On travaille dans le dépôt créé au TD 3a,
    `cours2/3a_premier_depot/travail/projet_2`.
  ]
  #question(26)[
    Le projet est dans un état satisfaisant pour en faire une v1. Placez-vous
    dans *master*, et faites un merge avec *develop*.
  ]

  #v(0.4em)
  #question(27)[
    Taggez le nouveau commit avec `git tag`.
  ]

  #v(0.5em)
  #tableau(
    columns: (1fr, 1.3fr),
    align: left + horizon,
    [Commande], [Résultat observé],
    [`git llog`], [reponse[master rejoint develop, et l'étiquette s'affiche à côté du commit]],
  )

  #notes[
    C'est le schéma des bonnes pratiques, joué en vrai : master ne reçoit que
    des versions complètes, et le tag les nomme. Faire remarquer que c'est
    exactement ce que ce dépôt-ci fait pour livrer chaque séance.
  ]
]
