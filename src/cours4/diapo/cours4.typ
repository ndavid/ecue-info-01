// Cours 4 — une animation, du notebook au programme.
//
// La séance est un TD, au choix la montre (4a) ou le tourbillon (4b), sur
// les mêmes étapes. Deux niveaux de consignes :
//
//   - `tds/4a_montre.typ` et `tds/4b_tourbillon.typ` : les étapes en résumé,
//     projetées ici et compilées en feuilles de TD par
//     `outils/compiler_tds.py --cours 4` ;
//   - le guide A4 de chaque TD, `src/cours4/notebook/td/<td>/guide.md`, avec
//     le code à coller et la vérification de chaque commande, compilé par
//     `outils/compiler_guides.py --cours 4`.
//
//   python outils/compiler_diapos.py --cours 4
//   python outils/compiler_diapos.py --cours 4 --notes
//   python outils/compiler_diapos.py --cours 4 --sans-tds

#import "../../commun/prelude.typ": *
#import "../../cours3/diapo/schemas.typ": code-commente, sortie
#import "schemas.typ": programme-montre, programme-tourbillon

#show: diapos.with(
  titre-court: "Introduction à l'informatique",
  auteur-court: "1re année géomatique",
)

#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/4a_montre.typ": td as td-4a
#import "tds/4b_tourbillon.typ": td as td-4b

#page-titre(
  titre: "Cours 4",
  sous-titre: "Une animation, du notebook à un programme en ligne de commande",
  auteur: "1re année géomatique",
  date: "",
)

// --------------------------------------------
#d("Objectifs de la séance")[
  #annonce[
    Écrire un projet Python qui fabrique une courte vidéo animée.\
    Le rendu est un dossier versionné avec git, qui contient un script
    appelable en ligne de commande : `python montre.py` ou
    `python tourbillon.py`.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: (left + horizon, left + horizon, center + horizon),
    [Partie], [Ce qu'on fait], [Durée],
    [Présentation], [les deux TD, les outils, les étapes], [10 min],
    [A · Exécuter le notebook], [dans VS Code, terminal Git Bash : créer l'environnement `animation`, y lancer JupyterLab, exécuter le notebook], [35 min],
    [B · Du notebook au programme], [dans VS Code : le script construit par fonctionnalités (une image, une série, la vidéo), une branche git par fonctionnalité], [70 min],
    [Fin], [montrer sa vidéo et son `git log`], [5 min],
  )

  #notes[
    Chaque élève choisit un des deux TD. Les étapes sont les mêmes ; seules
    les fonctions de dessin et les options changent. Le guide A4 du TD,
    dans son dossier, détaille chaque étape : le distribuer ou le faire
    ouvrir dès le début.
  ]
]

// --------------------------------------------
#d("Deux TD au choix")[
  #annonce[
    Les deux TD fabriquent une vidéo de quelques secondes. Chaque image de
    la vidéo correspond à une valeur d'un paramètre : l'heure pour la
    montre, l'angle de torsion pour le tourbillon.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [4a · La montre du Lapin blanc], [4b · La Vague en tourbillon],
    [Dossier], [`cours4/4a_montre/`], [`cours4/4b_tourbillon/`],
    [Une image], [un cadran, deux aiguilles, le Lapin, l'heure], [*La Grande Vague*, tordue par `-swirl`, l'angle],
    [Ce qui varie], [l'heure, d'une minute par image], [l'angle, de 15° par image, aller et retour],
    [Ce que Python calcule], [la position des aiguilles, par `sin` et `cos`], [la liste des angles],
    [Les fonctionnalités (partie B)], [une image : `--heure 10:05` ; une série : `--minutes` ; la vidéo : `--video`], [une image : `vague.jpg --angle 90` ; une série : `--maximum` ; la vidéo : `--video`],
  )

  #legende[
    Dans le TD 4a, chaque image est dessinée à partir de formes simples ;
    dans le TD 4b, chaque image est une transformation d'une image existante.
  ]
]

// --------------------------------------------
#d("Des outils en ligne de commande")[
  #annonce[
    ImageMagick (`magick`) et ffmpeg sont des programmes en ligne de
    commande, comme git (cours 2) et pandoc (cours 3). Le script Python les
    lance avec `subprocess.run` : une fois par image pour `magick`, une fois
    à la fin pour `ffmpeg`. Python automatise ainsi toutes les étapes de la
    fabrication de la vidéo.
  ]

  #code-commente(
    taille-code: 12pt, taille-texte: 12pt,
    ("magick -size 640x480 xc:#fbf7ee -draw \"…\" img_0001.png", "4a : une image unie, puis des formes"),
    ("magick petite.png -swirl 90 -extent 640x480 img_0001.png", "4b : l'image, tordue de 90 degrés"),
    ("ffmpeg -framerate 12 -i img_%04d.png montre.mp4", "12 images par seconde ; `%04d` : un numéro à quatre chiffres"),
  )

  #legende[
    Pendant le développement, chaque étape se termine par un commit git : le
    dépôt garde une version qui fonctionne à chaque étape.
  ]

  #notes[
    `magick` et `ffmpeg` ne sont pas dans l'environnement `base`
    d'Anaconda : c'est la raison de la partie A.
  ]
]

// --------------------------------------------
#d("Le programme montre.py, étape par étape")[
  #annonce[
    Pour chaque minute, Python calcule l'angle et l'extrémité des deux
    aiguilles, puis lance `magick`, qui dessine l'image. ffmpeg assemble les
    120 images.
  ]

  #programme-montre(hauteur-vignette: 64pt)

  #notes[
    Les étapes du programme, pas celles du TD. Les fonctions `point`,
    `graduations` et `aiguilles` font les étapes 2 et 3 ; `image` construit
    et lance la commande de l'étape 4 ; `assembler` lance ffmpeg.
  ]
]

// --------------------------------------------
#d("Le programme tourbillon.py, étape par étape")[
  #annonce[
    Python calcule la liste des angles de torsion, puis, pour chaque angle,
    lance `magick`, qui tord l'image réduite. ffmpeg assemble les 49 images.
  ]

  #programme-tourbillon(hauteur-vignette: 64pt)

  #notes[
    Les étapes du programme, pas celles du TD. `reduire` fait l'étape 2,
    `angles` l'étape 3, `image` l'étape 4, `assembler` l'étape 5.
  ]
]

// --------------------------------------------
#separateur(
  "A · Exécuter le notebook",
  annonce: "Un environnement conda décrit par environment.yml, JupyterLab lancé depuis cet environnement",
)

// --------------------------------------------
#d("L'environnement animation")[
  #annonce[
    `environment.yml` liste ce que le projet demande. `conda env create` crée
    l'environnement à partir de ce fichier ; `conda activate` le rend actif
    dans le terminal.
  ]

  #face-a-face(
    panneau("depart/environment.yml")[
      #sortie("name: animation\nchannels:\n  - conda-forge\ndependencies:\n  - python=3.12\n  - jupyterlab\n  - imagemagick\n  - ffmpeg", taille: 12pt)
    ],
    panneau("Dans le terminal Git Bash, dans depart/")[
      #tableau(
        entete: false,
        columns: (1fr,),
        align: left + horizon,
        [`conda env create -f environment.yml`],
        [`conda env list` #h(0.5em) → une ligne `animation`],
        [`conda activate animation` #h(0.5em) → `(animation)`],
        [`magick -version`, `ffmpeg -version`],
      )
    ],
  )

  #legende[
    Guide, étapes A2 et A3. Avant la première commande, une fois par poste :
    `conda` rendu disponible dans Git Bash. La création télécharge les
    paquets : plusieurs minutes.
  ]

  #notes[
    Rappel du cours 1 (TD 4a et 4b) : un environnement est un dossier avec
    son Python et ses programmes ; `activate` met ses dossiers en tête de
    `PATH`.

    Si deux élèves partagent un poste, le second obtient `prefix already
    exists` : l'environnement est déjà là, passer à l'activation.
  ]
]

// --------------------------------------------
#d("JupyterLab lancé depuis l'environnement")[
  #annonce[
    Le notebook appelle `magick` et `ffmpeg` : il les cherche dans le `PATH`
    du terminal qui a lancé JupyterLab. JupyterLab se lance donc depuis le
    terminal Git Bash de VS Code, l'environnement `animation` actif.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous devez obtenir],
    [1], [copier `depart/notebook/<nom>.ipynb` dans `travail/`], [`travail/<nom>.ipynb`],
    [2], [`cd travail`, puis `jupyter lab`], [le navigateur s'ouvre sur `travail/`],
    [3], [ouvrir le notebook, exécuter la section 1], [trois chemins qui contiennent `envs\animation`],
    [4], [exécuter les sections suivantes, une à une], [une image d'essai par section, puis la vidéo],
  )

  #avertissement[
    Lancé depuis Anaconda Navigator, JupyterLab tourne dans `base` : la
    section 1 affiche `magick : None`.
  ]
]

// --------------------------------------------
// Les deux TD, étape par étape, en résumé ; le guide A4 de chacun les détaille.
#if tds {
  include "tds/4a_montre.typ"
  include "tds/4b_tourbillon.typ"
} else {
  sommaire-td(td-4a, td-4b)
}

// --------------------------------------------
#d("Ce qu'on rend")[
  #annonce[
    Le dossier du projet, avec son historique git : le code, `environment.yml`
    et le README, qui permettent de refaire la vidéo sur un autre poste.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Commande], [Ce qu'elle doit montrer],
    [`git log --oneline --graph --all`], [dix commits (onze avec B5), dont un commit de fusion],
    [`git status`], [« rien à valider » ; `sortie/` n'est pas listé],
    [`python <nom>.py --help`], [les options des trois fonctionnalités, et leur aide],
    [`sortie/<nom>.mp4`], [la vidéo, qui s'ouvre par un double-clic],
  )

  #notes[
    Le cours 6 publie le dépôt sur GitHub : le README en est la page
    d'accueil.
  ]
]
