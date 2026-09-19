// TD 4b — revenir en arrière, et remettre une branche à jour
// (questions 18 à 20 du TP).
#import "../../../commun/prelude.typ": *
#import "../style.typ": *

#let td = (
  numero: "4b",
  titre: "Annuler et remettre à jour",
  annonce: "Défaire une suppression avec revert, puis rattraper develop avec un rebase.",
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
    [reponse[non : c'est un nouveau commit, qui porte le même contenu mais
     une autre empreinte]],
  )

  #v(0.7em)
  #question(20)[
    Revenez sur la branche *main_code*. Mettez-la à jour en utilisant un
    `rebase`.
  ]

  #v(0.6em)
  #avertissement[
    Le rebase réécrit l'historique de la branche : ses commits changent
    d'identifiant. C'est sans danger ici, parce que personne d'autre n'a
    récupéré cette branche.
  ]

  #notes[
    Faire afficher `git llog` avant et après : c'est le seul moyen de voir
    que les commits ont changé d'identifiant, et c'est ce que la diapositive
    sur le rebase annonçait avec les « bis ».
  ]
]
