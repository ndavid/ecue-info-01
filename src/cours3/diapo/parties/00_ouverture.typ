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
    Manipuler des chemins et lire des fichiers en Python, puis construire un
    programme en ligne de commande en Python. Les notions des cours 1 et 2
    reviennent, écrites cette fois en code.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Vu aux cours 1 et 2], [Aujourd'hui, en Python],
    [chemin relatif, chemin absolu (TD 2b, `chemin.py`)], [`Path`, `/`, `resolve()`, `Path(__file__)`],
    [fichier texte, encodage (cours 1)], [`read_text(encoding="utf-8")`, `write_text`],
    [texte et binaire (cours 1)], [`read_bytes()`, une image en chiffres puis en octets],
    [lancer un programme au terminal (cours 2)], [`subprocess.run([...])`, avec pandoc et ImageMagick],
    [les options d'une commande, `--help` (cours 2)], [`argparse`, dans un programme qu'on écrit],
  )

  #notes[
    Rien de neuf comme notion : la colonne de gauche a été vue. Ce qui est
    neuf est la colonne de droite, la même chose écrite en Python. Le dire
    ainsi, et s'y tenir pendant la séance : « vous savez ce que c'est, voici
    comment on l'écrit ». Le commit par étape du cours 2 revient au TD 3a.
  ]
]

// --------------------------------------------
#d("Contenu de la séance")[
  #annonce[
    Trois notebooks exécutés pendant l'exposé, puis un programme écrit dans
    l'éditeur et lancé au terminal. Chaque TD a son dossier dans l'archive
    `cours3/`, avec ses propres données.
  ]

  #tableau(
    columns: (auto, auto, 1fr, auto),
    align: (left + horizon, left + horizon, left + horizon, center + horizon),
    [Partie], [Fichier], [Ce qu'on y fait], [Durée],
    [Fichiers et outils], [], [récupérer l'archive, vérifier que JupyterLab et l'éditeur se lancent], [10 min],
    [Chemins], [`recette.ipynb`], [le programme de la recette du cours 1 : où il lit, où il écrit ; pandoc appelé depuis Python], [20 min],
    [Texte et binaire], [`fichiers.ipynb` #linebreak() `images.ipynb`], [comment le programme ouvre ses fichiers ; une image PGM en chiffres et en octets ; poids et temps de lecture selon le format ; ce qu'un caractère pèse], [45 min],
    [Ligne de commande], [`recette.py`], [le code du notebook dans un fichier, puis `main`, `argparse`, un README ; un commit par étape], [45 min],
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
#d("Les fichiers de la séance")[
  #annonce[
    L'archive `info01-cours3.zip` est dans le dossier partagé `formationTemp`.
    Elle se copie sur le Bureau et s'y décompresse ; tout le travail se fait
    dans le dossier décompressé.
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
    Ne pas travailler dans le dossier partagé, et ne pas ouvrir un fichier
    depuis l'archive : l'explorateur le montre, mais rien ne s'y enregistre.
  ]

  #notes[
    Vécu à la séance 1 : des fichiers ouverts depuis l'archive sans
    extraction, et du travail fait dans le dossier partagé, perdu ou écrasé
    par le voisin. Faire les trois étapes ensemble, avant de lancer quoi que
    ce soit.
  ]
]

// --------------------------------------------
#d("Lancement des outils")[
  #annonce[
    La séance demande d'exécuter des notebooks et d'écrire du code Python.
    Avant de commencer, chacun vérifie que ses outils se lancent. Un poste
    qui ne les lance pas se règle maintenant, ou se change.
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
    main levée. Le terminal de `jupyter lab` reste ouvert tant que le
    notebook sert.
  ]

  #notes[
    Dix minutes, pas plus. Navigator a été lent ou muet sur les VM à la
    séance 1 : donner la commande `jupyter lab` tout de suite à ceux qui
    n'ont rien au bout de trente secondes ; les deux ouvrent le même
    serveur.

    VS Code sert pour le TD 3a, pas pour les notebooks : il ne trouve pas
    l'environnement d'Anaconda sur ces postes, et le temps de le configurer
    est celui qu'on n'a pas. Spyder convient tout autant pour éditer
    `recette.py`.

    Un poste qui ne lance ni JupyterLab ni un éditeur en dix minutes : en
    changer, la séance ne peut pas attendre.
  ]
]
