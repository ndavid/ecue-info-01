// Clôture du cours 1 — incluse en dernier par `cours1.typ`, après les TD.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#d("À retenir")[
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [Un logiciel], [transforme une entrée en sortie ; son traitement part d'un texte],
    [Une application], [est un logiciel destiné à une tâche ; « app » en est l'abréviation],
    [Une interface], [décide de ce qu'il reste du travail, pas de ce qu'il produit],
    [Une extension], [nomme le fichier, elle ne dit pas ce qu'il contient],
    [Un format], [décide de ce qu'on peut relire, comparer et versionner],
    [Une dépendance], [du code écrit par d'autres, réutilisé, qu'il faut installer et déclarer],
    [Un environnement], [rend l'outillage reproductible d'un poste à l'autre],
    [Un notebook], [un client qui affiche, un noyau qui exécute et qui retient],
  )

  #notes[
    Enchaîner sur le dépôt de notes : chacun écrit les notes du jour en
    Markdown. Git arrive au cours 2 ; aujourd'hui, seulement le fichier.

    Ce que le cours 2 apporte se nomme en une phrase : comparer deux
    versions d'un fichier et transmettre leur différence. Le TD
    qui le fait faire est en annexe, sous « Comparer deux versions d'un
    fichier », si l'horaire le permet.
  ]
]
