// Manipulation du cours 1 — « Le notebook du cours, ouvert de trois façons ».
//
// Incluse par `cours1.typ`, qui porte les réglages globaux, et compilable
// seule par `outils/compiler_manips.py`, qui en tire la feuille d'instructions
// déposée dans le dossier de données de la manipulation. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *


#separateur-manip(
  "Le notebook du cours, ouvert de trois façons",
  annonce: "Objectif : ouvrir le même notebook de trois façons, et reconnaître dans chacune où tourne le noyau",
  dossier: "src/cours1/notebook/",
)
#d("Ouvrir le même notebook, trois fois")[
  #annonce[
    `04_premiers_octets.ipynb` lit les premiers octets d'un fichier et en
    déduit le format. Le même fichier, ouvert de trois façons.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Le geste], [Ce qu'on observe],
    [Dans le navigateur],
      [ouvrir #link("https://jupyter.org/try-jupyter/lab/")[jupyter.org/try-jupyter], y déposer le fichier],
      reponse[aucun compte, aucune installation, et le calcul se fait chez vous],
    [Dans l'éditeur],
      [ouvrir le `.ipynb`, choisir le noyau `info01`],
      reponse[les cellules s'exécutent par `Maj` + `Entrée`],
    [Dans JupyterLab],
      [`jupyter lab` au terminal, puis le fichier dans l'arborescence],
      reponse[une adresse `localhost`, donc un serveur qui est le vôtre],
  )

  #legende[
    Le notebook est produit depuis un fichier MyST par
    `python outils/construire_notebooks.py`. Le premier chargement de
    JupyterLite prend une dizaine de secondes.
  ]

  #notes[
    L'ordre est celui de l'engagement croissant : rien à installer, puis
    l'éditeur qu'ils ont déjà, puis un serveur qu'ils lancent eux-mêmes.
    Si le réseau de la salle est mauvais, sauter la première et la montrer
    au tableau.

    Le contenu du notebook n'est pas neuf : c'est la lecture des premiers
    octets, passée en annexe des diapositives parce qu'elle se prête mieux
    à un notebook qu'à une projection. Ils y retrouvent le `50 4B 03 04`
    du `.odt` et l'absence de signature des fichiers texte, en
    l'exécutant.

    Faire attendre la dernière cellule : elle copie le `.odt` sous un nom
    en `.pdf`, relit les octets, et montre que le nom ment. C'est « Deux
    extensions échangées » faite par eux, en trois lignes.

    Le noyau à choisir dans l'éditeur est la même question que
    l'interpréteur de la partie 2, et la même réponse : `info01`.

    Le fichier source est en MyST, donc du texte, donc comparable ligne à
    ligne : « Deux formats de notebook » vérifié sur le support qu'ils ont
    sous les yeux.
  ]
]
#d("Le noyau d'un autre environnement")[
  #annonce[
    Dans `info01`, le client et le noyau sont ensemble. On les sépare ici, et
    le notebook s'exécute quand même.
  ]

  #tableau(
    columns: (auto, 1.7fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [`conda create -n analyse -c conda-forge python=3.12 ipykernel numpy`], [],
    [2], [`conda run -n analyse python -m ipykernel install --user --name analyse`],
      reponse[`Installed kernelspec analyse`],
    [3], [`conda activate info01`, puis `jupyter kernelspec list`],
      reponse[deux noyaux, dont `analyse`, absent d'`info01`],
    [4], [ouvrir le notebook dans VSCode, choisir le noyau `analyse`],
      reponse[`import numpy` passe sans que `info01` soit actif],
  )

  #legende[
    Sorties réelles. `analyse` n'a pas `jupyterlab`, et n'en a pas besoin : le
    `kernel.json` écrit à l'étape 2 ne contient qu'un chemin,
    `…/envs/analyse/bin/python`.
  ]

  #notes[
    Le cas du module est le plus simple : `jupyterlab` tire `ipykernel`
    avec lui, et les deux moitiés du schéma sont dans le même dossier. Le
    faire vérifier avant de commencer, `conda list -n info01`.

    Le cas d'ici est celui qu'ils rencontreront en stage : un client
    installé une fois, et un environnement par projet.

    Étape 2, à faire lire : le client ne devine pas les environnements. Il
    lit un dossier de déclarations, et `ipykernel install` y écrit un
    `kernel.json` qui n'est qu'un chemin vers un interpréteur. Ouvrir le
    fichier si le temps le permet, c'est trois lignes utiles.

    Étape 4 : VSCode est un client au même titre que JupyterLab, et il lit
    la même liste. C'est la réponse à « pourquoi VSCode me demande de
    choisir un noyau ».

    À retenir pour l'année : une bibliothèque manquante s'installe dans
    l'environnement du *noyau*, jamais dans celui du client. C'est le
    `ModuleNotFoundError` de la partie précédente, dans sa version
    notebook.

    Rendre la main : `conda env remove -n analyse`, et
    `jupyter kernelspec remove analyse` pour retirer la déclaration.
  ]
]
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
    versions d'un fichier et transmettre leur différence. La manipulation
    qui le fait faire est en annexe, sous « Comparer deux versions d'un
    fichier », si l'horaire le permet.
  ]
]
