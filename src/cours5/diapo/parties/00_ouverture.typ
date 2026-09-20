// Cours 5 — ouverture. Incluse par `cours5.typ`, qui porte les réglages
// globaux ; un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#page-titre(
  titre: "Cours 5",
  sous-titre: "Matériel, réseau, clés SSH et secrets",
  auteur: "1re année géomatique",
  date: "13 octobre",
)

// --------------------------------------------
#d("Contenu de la séance")[
  #annonce[
    Deux moitiés : les ordres de grandeur du matériel et du réseau, puis ce
    qu'il faut avoir en place avant de travailler sur une forge.
  ]

  #tableau(
    columns: (1fr, auto, auto),
    align: (left + horizon, left + horizon, right + horizon),
    [Partie], [Nature], [Durée],
    [Le matériel], [cours], [20′],
    [Le réseau], [cours et TD 1a], [30′],
    [S'identifier auprès d'une machine distante], [cours et TD 2a], [40′],
    [Secrets et sécurité], [cours ; TD 3a facultatif], [20′],
  )

  #legende[
    Durées indicatives. Aujourd'hui, tout est dans `cours5/` ; les deux TD en
    séance durent 40′ en tout.
  ]

  #notes[
    Séance plus courte en TD que les précédentes, et volontairement : la
    première moitié est de la culture générale, la seconde prépare le cours 6.

    Le TD 2a est le seul indispensable : sans clé sur le compte, le cours 6
    commence par vingt minutes d'installation. Il faut un compte GitHub créé
    avant la séance (page « Avant les séances » du book).
  ]
]
