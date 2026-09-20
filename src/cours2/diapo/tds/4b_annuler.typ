// TD 4b — revenir en arrière, et remettre une branche à jour
// (questions 18 à 20 du TP).
#import "../../../commun/prelude.typ": *
#import "../style.typ": *

#let td = (
  numero: "4b",
  titre: "Annuler et remettre à jour",
  annonce: "Annuler un commit avec revert, puis mettre main_code à jour sur develop avec rebase.",
  dossier: "cours2/4b_annuler/",
  duree: "15′",
)

#separateur-td(..td)

#d("TD 4b — annuler une erreur")[

  #legende[
    On travaille dans le dépôt créé au TD 3a,
    `cours2/3a_premier_depot/travail/projet_2`.
  ]
  #question(18)[
    On simule une fausse manœuvre. Supprimez le code présent dans `main.py`
    et dans `operations.py`, puis faites un commit.

    #v(0.3em)
    Comment revenir en arrière ?
  ]

  #v(0.6em)
  #question(19)[
    `git revert` crée un nouveau commit qui annule les modifications du
    commit visé.

    #v(0.3em)
    Repérez d'abord le commit avec `git log`, puis annulez-le avec
    `git revert`. Affichez le graphe.
  ]

]

#d("TD 4b — remettre une branche à jour")[
  #tableau(
    columns: (1.4fr, 1fr),
    align: left + horizon,
    [Question], [Réponse],
    [Le commit créé par `git revert` porte-t-il le même identifiant que celui
     que vous aviez repéré ?],
    reponse[non : `revert` a créé un nouveau commit, avec son propre
     identifiant ; le projet est revenu au contenu d'avant la suppression],
  )

  #v(0.7em)
  #question(20)[
    Revenez sur la branche *main_code*. Mettez-la à jour en utilisant un
    `rebase`.
  ]

  #v(0.6em)
  #legende[
    Le rebase réécrit l'historique de la branche : ses commits changent
    d'identifiant. Une branche que quelqu'un d'autre a déjà récupérée ne se
    rebase pas ; ici, personne ne l'a récupérée.
  ]

  #notes[
    Faire afficher `git llog` avant et après le rebase : les commits de
    main_code ont changé d'identifiant, comme les « bis » de la diapositive.
  ]
]
