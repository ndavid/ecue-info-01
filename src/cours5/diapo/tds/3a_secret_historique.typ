// TD 3a du cours 5 — « Un secret dans l'historique », facultatif.
//
// Inclus par `cours5.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`.
#import "../../../commun/prelude.typ": *
#import "../style.typ": terminal

#let td = (
  numero: "3a",
  titre: "Un secret dans l'historique",
  annonce: "Committer une fausse clé, la supprimer, constater qu'elle est toujours dans le dépôt, puis l'en tenir à l'écart",
  dossier: "cours5/3a_secret_historique/",
  duree: "10′",
  facultatif: true,
)
#separateur-td(..td)

#d("Committer, supprimer, relire")[
  #annonce[
    Un dépôt neuf dans `travail/`, un fichier avec une clé inventée, deux commits.
  ]

  #terminal("Anaconda Prompt", "> git init travail
> cd travail
> echo CLE_IGN = \"d7f3a9c1e5b24086\" > config.py
> git add config.py
> git commit -m \"Premier script de carte\"
> git rm config.py
> git commit -m \"Supprime la clé du dépôt\"
> git log -p -- config.py", taille: 12pt)

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr),
    align: (left + horizon, left + horizon),
    [Question], [Ce que vous constatez],
    [`config.py` est-il encore dans le dossier ?], reponse[non : `git rm` l'a supprimé du dossier et de l'index],
    [La clé est-elle encore dans le dépôt ?], reponse[oui : `git log -p` affiche la ligne `+CLE_IGN = …` du premier commit],
  )

  #notes[
    Le fichier a disparu du dossier de travail. L'historique le contient
    toujours, et toute personne qui clone le dépôt reçoit les deux commits.
  ]
]

#d("Tenir le secret à l'écart")[
  #annonce[
    Le dépôt reçoit un modèle et une règle d'exclusion ; le fichier avec la
    vraie valeur reste hors de portée de `git add`.
  ]

  #terminal("Anaconda Prompt", "> echo CLE_IGN = \"à remplir\" > config.example.py
> echo config.py > .gitignore
> echo CLE_IGN = \"d7f3a9c1e5b24086\" > config.py
> git add .
> git status
> git commit -m \"Modèle de configuration, secret ignoré\"", taille: 12pt)

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr),
    align: (left + horizon, left + horizon),
    [Question], [Ce que vous constatez],
    [Que liste `git status` après `git add .` ?], reponse[`config.example.py` et `.gitignore` ; `config.py` n'y est pas],
    [Que dit `git check-ignore -v config.py` ?], reponse[`.gitignore:1:config.py  config.py` : la règle qui l'exclut, et sa ligne],
  )

  #notes[
    `git add .` est la commande qui fait entrer les secrets par erreur : c'est
    pourquoi le `.gitignore` s'écrit avant. Sur ce dépôt, la première clé
    reste dans les deux premiers commits : la seule façon de l'en sortir est
    de recréer le dépôt, ce que la feuille du TD propose en dernière étape.
  ]
]
