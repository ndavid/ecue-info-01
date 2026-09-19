// TD 4a — ouvrir des branches et les fusionner (questions 6 à 17 du TP).
#import "../../../commun/prelude.typ": *
#import "../style.typ": *

#let td = (
  numero: "4a",
  titre: "Branches et fusions",
  annonce: "Ouvrir develop et documentation, écrire le code à deux endroits, tout fusionner dans develop.",
  dossier: "cours2/4a_branches/",
  duree: "30′",
)

#separateur-td(..td)

#d("TD 4a — ouvrir les branches")[

  #legende[
    On travaille dans le dépôt créé au TD 3a,
    `cours2/3a_premier_depot/travail/projet_2`.
  ]
  #question(6)[
    Créez une branche *develop* à partir de *master*, puis une branche
    *documentation* à partir de *develop*.
  ]

  #v(0.5em)
  #question(7)[
    Écrivez une description rapide du projet dans le `README.md`, et ajoutez
    le logo de l'école à la fin. Faites un commit.
  ]

  #v(0.5em)
  #question(8)[
    Placez-vous dans *develop*, puis ajoutez-y les modifications de
    *documentation* avec un `merge`.
  ]

  #legende[
    Le projet est une petite calculatrice en Python, dont le but est de
    fournir des fonctions mathématiques utiles.
  ]
]

#d("TD 4a — écrire le code à deux endroits")[
  #question(9)[
    On fait comme si deux personnes travaillaient en parallèle. Créez une
    branche *main_code*.
  ]

  #v(0.3em)
  #question(10)[
    Créez un dossier `src` et, dedans, un fichier `main.py`. Ouvrez-le dans
    l'éditeur.
  ]

  #v(0.3em)
  #question(11)[
    Copiez-y le code suivant :
    #code("if __name__==\"__main__\":
    print(\"Geo Calculatrice\")
    print(\"*\"*10)", taille: 12pt, interligne: 0.5em)
  ]

  #v(0.3em)
  #question(12)[
    Faites un commit avec ces changements, puis retournez sur *develop*.
  ]
]

#d("TD 4a — la seconde branche")[
  #question(13)[
    Créez une branche *operations* et placez-vous dedans.
  ]

  #v(0.4em)
  #question(14)[
    Dans `src`, créez `operations.py` et ouvrez-le.
  ]

  #v(0.4em)
  #question(15)[
    Codez-y les fonctions suivantes :
    #tableau(
      columns: (auto, 1fr),
      align: left + horizon,
      [Fonction], [Ce qu'elle renvoie],
      [`add(a,b)`], [l'addition de `a` et `b`],
      [`mult(a,b)`], [la multiplication de `a` et `b`],
      [`neg(a)`], [l'opposé de `a`],
      [`inv(a)`], [l'inverse de `a`],
    )
  ]
]

#d("TD 4a — tout ramener dans develop")[
  #question(16)[
    Faites un commit, puis retournez dans *develop*.
  ]

  #v(0.6em)
  #question(17)[
    Fusionnez *main_code* dans *develop* avec un `merge`, puis *operations*
    dans *develop*. Au second merge, un éditeur s'ouvre dans le terminal pour
    le message de fusion : écrivez une ligne, puis fermez l'éditeur — pas le
    terminal.
  ]

  #v(0.8em)
  #avertissement[
    L'éditeur qui s'ouvre est souvent `vim` : on en sort par `:wq`. Le dire
    avant, sinon la moitié de la salle ferme le terminal.
  ]

  #notes[
    Le premier merge est un avance-rapide, le second crée un commit de
    fusion : c'est exactement la distinction de la diapositive « Fusionner
    deux branches ». Faire afficher `git llog` après chacun.
  ]
]
