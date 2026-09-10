// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

// =============================== Introduction ===============================

#separateur-module(
  "Introduction à l'informatique",
  annonce: "Objectifs, contenu et organisation du module",
  auteur: "1re année géomatique",
  date: "15 septembre",
)

// --------------------------------------------
#d("Objectif du cours")[
  #annonce[
    Consolider ou acquérir les bases informatiques nécessaires aux autres
    enseignements, en particulier ceux de programmation et les TD utilisant
    Python.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Demandé dans les autres modules et cours], [(re)vu dans ce module],
    [« ouvrez le projet fourni »], [travailler dans un éditeur de code, lire une arborescence],
    [« installez Python et numpy »], [créer un environnement et le réinstaller ailleurs],
    [« le script lit `donnees.csv` »], [manipuler des fichiers depuis Python],
    [« rendez votre code »], [versionner avec git, partager un dépôt, documentation README.md],
  )

  #notes[
    Ces bases sont en partie connues, par le lycée ou la prépa. Les maîtriser
    évite de prendre du retard dans les autres cours : on s'y consacre au
    contenu du cours plutôt qu'à l'outil qu'on ne sait pas employer.
    Ces notions sont utiles pour les autres cours informatiques et de programmation
    mais aussi pour tous les cours non informatiques qui demandent des expérimentations
    ou rendu de projet sous forme de code.
  ]
]

// --------------------------------------------
#d("Objectifs du module liés à la programmation")[
  #annonce[
    Maîtriser la forme d'un projet de code : documentation, organisation des
    fichiers, bibliothèques et environnements.
  ]

  #tableau(
    columns: (1.7fr, 0.8fr, 1fr),
    align: (left + horizon, center + horizon, center + horizon),
    [], [ce cours], [cours de programmation],
    [Quel algorithme choisir ?], [], [oui],
    [Comment écrire cette boucle ?], [], [oui],
    [Où mettre ce fichier ?], [oui], [],
    [Comment lancer le script ailleurs ?], [oui], [],
  )

  #notes[
    L'algorithmique relève du cours de programmation, qui se déroule en
    parallèle. Ajouter oralement : « retrouver la version qui marchait » relève
    aussi de ce module.

    Développer l'annonce à l'oral : ces pratiques servent déjà quand on
    programme seul, et deviennent nécessaires dès qu'on travaille en équipe ou
    qu'on distribue son programme à un utilisateur.
  ]
]

// --------------------------------------------
#d("Les trois compétences du module")[

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: 88pt,
    gutter: 12pt,
    bloc("Éditer", "éditeur de code, arborescence de projet"),
    bloc("Versionner", "git : enregistrer, revenir, partager"),
    bloc("Structurer", "README, environnement, ligne de commande"),
  )

  #annonce[
    Des notions de culture informatique au fil de l'eau, rattachées aux enseignements et TD en cours.
  ]

  #v(0.6em)
  #block(
    width: 100%, inset: (x: 14pt, y: 9pt), fill: gris,
    stroke: 1pt + accent.lighten(62%),
  )[
    #grid(
      columns: (auto, 1fr), column-gutter: 16pt, align: horizon,
      text(size: 17pt, weight: demi-gras)[Culture informatique],
      align(right, text(size: 14pt, fill: estompe)[
        ordres de grandeur, sécurité : pourquoi les outils sont faits ainsi
      ]),
    )
  ]

  #notes[
    Les trois blocs sont les fils rouges : chaque séance en reprend au
    moins un, les deux TD les mobilisent ensemble.
  ]
]

// --------------------------------------------
#d("Organisation : sept séances de deux heures")[
  #annonce[
    Chaque séance alterne explications courtes et manipulations sur machine.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: (center + horizon, left + horizon, center + horizon),
    [], [Sujet], [Type],
    [1], [Logiciel, programmation et formats de fichier], [cours],
    [2], [Ligne de commande et git local], [cours],
    [3], [Binaire, données et construction d'une CLI], [cours],
    [4], [Studio d'automatisation (animation vidéo)], [TD],
    [5], [Matériel, réseau, SSH et secrets], [cours],
    [6], [Forge, git en équipe, outil « trajectoire »], [cours],
    [7], [Benchmark image et rapport], [TD],
  )

  #avertissement[
    Une partie de la séance 1 reprend des notions surement vues au lycée et/ou prépa.
  ]

  #notes[
    Développer l'annonce à l'oral : les deux TD font revoir et pratiquer le
    contenu des séances précédentes, par l'élaboration d'un livrable de code
    complet.

    Les deux TD appliquent ce qui précède sur un livrable complet.
    L'important est ici plus la qualité de la forme que le fond,
    c'est à dire est-ce que le projet est bien structuré et documenté
    et moins est-ce que le code est bon/performant.

    Sur l'avertissement : ces notions sont rappelées pour que la suite du
    module parte du même point pour tout le monde. Passer vite, en disant qu'on
    a conscience que ce sera une redite pour une partie de la salle. Notions concernées : données en
    tableau et fichiers csv, le Web, HTML et CSS, les formats d'image (SNT,
    seconde) ; binaire, hexadécimal, encodage du texte, système d'exploitation
    et ligne de commande (NSI, première) ; écrire et exécuter un programme
    Python (NSI, ou tronc commun en CPGE). Programmes de SNT et de NSI :
    Bulletin officiel spécial n°1 du 22 janvier 2019.

    Justification du choix : ce qui est reproché aux étudiants dans les autres
    cours n'est pas toujours l'algorithmique. C'est un chemin de fichier faux,
    un environnement mal installé, un code qui ne s'installe pas sur une autre
    machine. Ces gestes ne sont enseignés nulle part ailleurs.
  ]
]
// ================================ Séance 1 ==================================

#page-titre(
  titre: "Cours 1",
  sous-titre: "Introduction à l'informatique",
  auteur: "1re année géomatique",
  date: "15 septembre",
)

// --------------------------------------------
#d("Les fichiers du cours")[
  #annonce[
    Un dossier par séance. Aujourd'hui, tout est dans `data/cours1/`.
  ]

  #align(center)[
    #block(
      inset: (x: 20pt, y: 13pt), fill: gris,
      stroke: 1pt + accent.lighten(62%),
    )[
      #set text(size: 23pt)
      #set align(left)
      #raw(
"data/
├── cours1/            la séance du jour
│   ├── hello/         un dossier par manipulation
│   ├── formats/
│   ├── markdown/
│   ├── fourni/        ce qui vous est donné
│   └── produit/       ce que vos commandes fabriquent
├── cours2/
├── cours3/
├── ...
└── cours7/")
    ]
  ]

  #legende[
    Les diapositives brunes qui ouvrent une manipulation portent le chemin de
    son dossier, sous leur titre.
  ]

  #notes[
    À montrer une fois, et à rappeler à chaque manipulation. Sans quoi la
    question « on est où, là ? » revient à chaque bloc sur machine.

    Faire ouvrir le dossier du cours dans l'éditeur maintenant pour vérifier
    qu'ils l'ont tous.

    Un seul niveau est déplié, et seulement pour la séance du jour : le reste
    de l'arborescence est celle de qui écrit le cours, elle ne leur sert pas.
    Nommer au passage `src/cours1/notebook/`, les pages du cours qui
    s'exécutent, sans l'afficher.

    REM : À compléter avant la séance : la façon dont le dossier leur est remis
    n'est écrite nulle part dans le dépôt. Nommer ici le canal employé, et
    le rappeler sur la consigne d'installation envoyée avant la rentrée.
  ]
]

// --------------------------------------------
#d("Contenu de la séance")[
  #annonce[
    Quatre parties, des notions les plus générales jusqu'à la structure d'un
    projet Python.
  ]

  #tableau(
    columns: (1fr, auto, auto),
    align: (left + horizon, left + horizon, right + horizon),
    [Partie], [Nature], [Durée],
    [Logiciels et formats de fichier], [cours et manipulation], [25′],
    [Programmation et éditeur de code], [cours et manipulations], [40′],
    [Structure d'un projet Python], [cours et deux manipulations], [40′],
    [Notebooks], [cours et manipulation], [10′],
  )

  #avertissement[
    La première partie de révision avance vite : posez vos questions tout de suite, tout ce
    qui suit s'appuie dessus.
  ]

  #legende[
    Durées indicatives ; ce qui n'a pas été traité est repris en annexe.
  ]

  #notes[
    Les diapositives brunes sont les manipulations : sept, dans les quatre
    parties. Annoncer que la séance n'est pas un exposé continu.

    L'ordre, en une phrase : ce qu'est un logiciel et ce qu'il manipule,
    comment on en écrit un, ce qu'un fichier contient vraiment, comment on
    installe de quoi travailler, et l'outil qui réunit tout cela.

    Sur le point d'attention : la partie 1 reprend ce qui a pu être vu au
    lycée, et va vite pour garder du temps sur la suite et les manipulations.
    Une notion laissée de côté aujourd'hui se paiera sur les six séances
    suivantes, un retard pris au début s'accumule.
  ]
]
