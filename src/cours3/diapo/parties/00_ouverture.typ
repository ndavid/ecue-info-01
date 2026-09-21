// Ouverture du cours 3 — incluse par `cours3.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#page-titre(
  titre: "Cours 3",
  sous-titre: "Chemins, fichiers et ligne de commande, en Python",
  auteur: "1re année géomatique",
  date: "29 septembre 2026",
)

// --------------------------------------------
#d("Objectifs de la séance")[
  #annonce[
    Manipuler des chemins et lire des fichiers en Python.\
    Construire un programme en ligne de commande en Python.\ 
    Revoir les notions des cours 1 et 2 côté code Python.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Vu aux cours 1 et 2], [Aujourd'hui, en Python],
    [chemin relatif, chemin absolu ], [`Path`, `/`, `resolve()`, `Path(__file__)`],
    [fichier texte, encodage (cours 1)], [`open(file_path, encoding="utf-8")`, `fichier.write(..)`],
    [texte et binaire (cours 1)], [`open(file_path, "wb", ..`, une image écrite en format texte et binaire],
    [lancer un programme au terminal (cours 2)], [`subprocess.run([...])`,  avec pandoc  md -> html],
    [Ecrire une ligne de commande], [`argparse`, dans un programme qu'on écrit],
  )

  #notes[
    Les notions sont connues des cours précédent. Ici on les revoit et on étudie comment
    les manipuler avec les fonctionnalités de la librairie standard Python.
  ]
]

// --------------------------------------------
#d("Contenu de la séance")[
  #annonce[
    La séance contient trois notebooks ; les deux premiers s'exécutent pendant
    la présentation du cours. Chaque TD a son dossier dans l'archive
    `cours3/`, avec ses propres données.
  ]

  #tableau(
    columns: (auto, auto, 1fr, auto),
    align: (left + horizon, left + horizon, left + horizon, center + horizon),
    [Partie], [Fichier], [Contenu], [Durée],
    [Fichiers et outils], [], [récupérer l'archive, lancer JupyterLab ou VS~Code], [10 min],
    [Chemins], [`recette.ipynb`], [le programme « recette » du cours 1 : chemins, appel d'une commande depuis Python], [20 min],
    [Texte et binaire], [`fichiers.ipynb` #linebreak() `images.ipynb`], [ouvrir, lire et écrire un fichier ; texte et binaire : poids et temps de lecture, encodages du texte], [45 min],
    [Ligne de commande], [`recette.py`], [un outil en ligne de commande : `main`, `argparse` ; un commit par étape], [45 min],
  )

  #notes[
    Les trois notebooks se font pendant l'exposé : chaque diapositive qui
    porte un cartouche « § n » correspond à une section du notebook, à
    exécuter à ce moment. Le rythme est celui de la salle.

    La dernière partie est un TD classique : cinq diapositives d'exposé,
    puis le travail dans l'éditeur, pas à pas.
  ]
]

// --------------------------------------------
#d("Lancement de la séance : récupération données")[
  #annonce[
    L'archive `info01-cours3.zip` est dans le dossier partagé `formationTemp`.
    Il faut la copier sur le Bureau (ou autre dossier de votre préférence) puis la décompresser; 
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [ouvrir le dossier partagé `formationTemp`, copier `info01-cours3.zip` sur le Bureau],
      [l'archive sur le Bureau, 14 Mo],
    [2], [clic droit sur l'archive #sym.arrow.r Extraire tout],
      [un dossier `cours3/`, trois sous-dossiers `1a_recette/`, `2a_images/`, `3a_cli/`],
    [3], [ouvrir `cours3/1a_recette/` : `depart/`, `travail/` vide, la feuille du TD],
      [`depart/notebook/` contient les deux notebooks],
  )

  #avertissement[
    Ne pas travailler dans le dossier partagé, ne pas chercher à ouvrir un fichier
    de l'archive avec vscode ou aute.
  ]

  #notes[
    Vécu à la séance 1 : des fichiers ouverts depuis l'archive sans
    extraction, et du travail fait dans le dossier partagé, perdu ou écrasé
    par le voisin. Faire les trois étapes ensemble, avant de lancer quoi que
    ce soit.
  ]
]

// --------------------------------------------
#d("Lancement de la séance : test notebook")[
  #annonce[
    La séance demande d'exécuter des notebooks et d'écrire du code Python.
    Avant de commencer, chacun vérifie que ses outils se lancent.\ 
    Par défault on utilisera vscode ou jupyter lab.
    Si ça ne fonctionne pas demandez, selon les cas ça sera dépannage ou changement de poste.
  ]

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: left + horizon,
    [Outil], [Comment le lancer], [Ce qui doit apparaître],
    [JupyterLab], [Anaconda Navigator #sym.arrow.r fiche JupyterLab #sym.arrow.r *Launch* ; si rien ne vient après trente secondes : Anaconda Prompt, puis `jupyter lab`],
      [un onglet du navigateur, adresse `localhost`],
    [Un éditeur], [VS Code, configuré au TD 2a du cours 1 ; sinon Spyder, depuis Navigator],
      [l'éditeur, avec un terminal qui répond à `python --version`],
    [Un terminal], [menu Démarrer #sym.arrow.r Anaconda Prompt],
      [`(base)` en tête de ligne],
  )

  #legende[
    En cas de problème : les pages « Avant les séances » du support, ou la
    main levée.
  ]

  #notes[
    Dix minutes, pas plus. Navigator a été lent ou muet sur les VM à la
    séance 1 : donner la commande `jupyter lab` tout de suite à ceux qui
    n'ont rien au bout de trente secondes ; les deux ouvrent le même
    serveur.

    VS Code sert pour le TD 3a, pas pour les notebooks : s'il ne trouve pas
    l'environnement d'Anaconda sur ces postes, et pas le temps de configurer
    tenter spyder.

    Un poste qui ne lance ni JupyterLab ni un éditeur en dix minutes : en
    changer ou suivre avec un collègue, la séance ne peut pas attendre.
  ]
]
