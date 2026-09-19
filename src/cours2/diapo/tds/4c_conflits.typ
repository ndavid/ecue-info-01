// TD 4c — fabriquer un conflit, puis le résoudre (questions 21 à 25 du TP).
#import "../../../commun/prelude.typ": *
#import "../style.typ": *

#let td = (
  numero: "4c",
  titre: "Créer et résoudre un conflit",
  annonce: "Deux versions du même fichier, deux branches, un merge qui s'arrête.",
  dossier: "cours2/4c_conflits/",
  duree: "25′",
)

#separateur-td(..td)

#d("TD 4c — la première version")[

  #legende[
    On travaille dans le dépôt créé au TD 3a,
    `cours2/3a_premier_depot/travail/projet_2`.
  ]
  #question(21)[
    Sur *main_code*, ajoutez le code de `depart/main_regex.py` à la suite de
    celui de la question 11, puis faites un commit.
    *Cette fois on ne fusionne pas le changement dans develop.*
  ]

  #v(0.6em)
  #code("#Au début du fichier :
from operations import *
import re

#À la fin du fichier, dans la boucle if :
    s = input()
    search_result = re.search(r\"\\d+[\\+\\-\\*\\/]\\d+\", s)
    if search_result:
        operation = search_result[0]
        ...", taille: 11.5pt, interligne: 0.48em)

]

#d("TD 4c — la seconde version")[
  #question(22)[
    Repassez sur *develop*, créez une branche *main_code_bis* et placez-vous
    dedans. Les modifications de la question précédente ne doivent plus être
    visibles.
  ]

  #v(0.5em)
  #question(23)[
    Ajoutez dans `main.py` le code de `depart/main_operations.py` de ce dossier, puis
    faites un commit.
  ]

  #v(0.5em)
  #code("#Au début du fichier :
import operations as op

#À la fin du fichier, dans la boucle if :
    print(\"Tapez une opération :\")
    operation = input()
    if \"+\" in operation:
        [x,y] = operation.split(\"+\")
        ...", taille: 12pt, interligne: 0.5em)
]

#d("TD 4c — le conflit")[
  #question(24)[
    Retournez sur *develop*. Fusionnez *main_code_bis* dans *develop*, puis
    *main_code* dans *develop*. Le second merge ne peut pas aller au bout.
  ]

  #v(0.6em)
  #question(25)[
    Réglez les conflits en choisissant le code à garder, puis poursuivez le
    merge.
  ]

  #v(0.8em)
  #tableau(
    columns: (1fr, 1.2fr),
    align: left + horizon,
    [Étape], [Ce que git affiche],
    [le merge s'arrête], [reponse[`CONFLIT (contenu) : Conflit de fusion dans src/main.py`]],
    [dans le fichier], [reponse[les marqueurs `<<<<<<<`, `=======` et `>>>>>>>`]],
    [une fois résolu], [reponse[`git add` puis `git merge --continue`]],
  )

  #notes[
    Les marqueurs sont du texte ordinaire : ils doivent disparaître du
    fichier. Vérifier que le fichier est encore du Python exécutable avant de
    poursuivre le merge.
  ]
]
