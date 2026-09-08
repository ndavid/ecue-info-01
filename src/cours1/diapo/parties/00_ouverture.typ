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
    [« rendez votre code »], [versionner avec git, partager un dépôt],
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
    Maîtriser les bonnes pratiques de gestion d'un projet de code :
    documentation (`README`), organisation des fichiers, usage des
    bibliothèques pour faciliter la programmation, et des environnements 
    pour faciliter la contruction ET la distribution d'un programme. 
    Savoir construire un programma mais aussi le rendre facile à utiliser et à
    reprendre.
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
  ]
]

// --------------------------------------------
#d("Les trois compétences du module")[
  #annonce[
    Trois savoir-faire reviennent à chaque séance. Des notion  de culture informatique les accompagnent, 
    rattachés aux enseignements et TD qui viennent d'être vus.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: 88pt,
    gutter: 12pt,
    bloc("Éditer", "éditeur de code, arborescence de projet"),
    bloc("Versionner", "git : enregistrer, revenir, partager"),
    bloc("Structurer", "README, environnement, ligne de commande"),
  )

  #v(0.6em)
  #block(
    width: 100%, inset: (x: 14pt, y: 9pt), fill: gris,
    stroke: 1pt + accent.lighten(62%),
  )[
    #grid(
      columns: (auto, 1fr), column-gutter: 16pt, align: horizon,
      text(size: 17pt, weight: demi-gras)[Et, par apartés],
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
#d("Ce que vous avez peut-être déjà vu")[
  #annonce[
    Une bonne part de la première séance reprend des notions déjà au programme
    du lycée. Elles sont rappelées pour que la suite du module parte du même
    point pour tout le monde.
  ]

  #tableau(
    columns: (1fr, auto),
    align: (left + horizon, left + horizon),
    [Notion reprise en séance 1], [Où elle a pu être abordée],
    [Le Web, HTML et CSS, adresses de pages], [SNT, seconde],
    [Formats d'image, compression avec et sans perte], [SNT, seconde],
    [Données en tableau, fichiers `.csv`], [SNT, seconde],
    [Binaire, hexadécimal, encodage du texte], [NSI, première],
    [Système d'exploitation, ligne de commande], [NSI, première],
    [Écrire et exécuter un programme Python], [NSI, ou tronc commun en CPGE],
  )

  #legende[
    Programmes de SNT et de NSI : Bulletin officiel spécial n°1 du 22 janvier
    2019. Informatique du tronc commun des CPGE scientifiques.
  ]

  #notes[
    Trente secondes. Dire qu'on a conscience que ce sera une redite pour
    une partie de la salle.

    Justification, origine du choix: ce qui est reproché aux étudiants dans
    les autres cours n'est pas toujours l'algorithmique. C'est un chemin
    de fichier faux, un environnement mal installé, un code qui ne
    s'installe pas sur une autre machine. Ces gestes ne sont enseignés
    nulle part ailleurs.
  ]
]

// --------------------------------------------
#d("Organisation : sept séances de deux heures")[
  #annonce[
    Chaque séance alterne des explications courtes et des manipulations faites
    sur votre machine. Deux d'entre elles sont des travaux dirigés, qui
    reprennent sur un livrable complet ce que les séances précédentes ont vu.
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

  #notes[
    Les deux TD appliquent ce qui précède sur un livrable complet.
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
#d("Le rythme de la première partie")[
  #annonce[
    La première partie reprend des notions qui devraient être connues, 
    et avance donc plus vite que les suivantes. 
  ]

  #v(0.4em)
  #bloc-titre("Point d'attention")[
    #set text(size: 19pt)
    Si quelque chose n'est pas clair dans cette partie, posez la question
    tout de suite, sans attendre la fin.
    #v(0.5em)
    Tout ce qui suit s'appuie dessus. Une notion laissée de côté aujourd'hui
    se paiera sur les six séances suivantes, et c'est le retard pris au début
    qui est le plus difficile à rattraper.
  ]

  #notes[
    La raison du choix de rythme : la partie 1 reprend ce qui a pu être vu au lycée, 
    préférence à accorder plus de temps pour la suite du cours et les TD pratiques
  ]
]

// --------------------------------------------
#d("Les fichiers du cours")[
  #annonce[
    Les fichiers nécessaires aux TD sont rangés par séance, puis par
    TD. Chaque ouverture de TD rappelle son dossier.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Dossier], [Ce qu'il contient],
    [`data/cours1/`], [les fichiers des manipulations, un dossier par manipulation],
    [`data/cours1/*/produit/`], [ce qu'une commande fabrique : on peut le supprimer, il se refait],
    [`data/cours1/*/fourni/`], [ce qui vient d'ailleurs et ne se refait pas],
    [`src/cours1/notebook/`], [les pages du cours, qui s'exécutent],
  )

  #legende[
    Les diapositives brunes qui ouvrent une manipulation portent le chemin de
    son dossier, sous leur titre.
  ]

  #notes[
    À montrer une fois, et à rappeler à chaque manipulation. Sans quoi la
    question « on est où, là ? » revient à chaque bloc sur machine.

    Faire ouvrir le dossier du cours dans l'éditeur maintenant pour vérifier
    qu'ils l'ont tous.

    REM : À compléter avant la séance : la façon dont le dossier leur est remis
    n'est écrite nulle part dans le dépôt. Nommer ici le canal employé, et
    le rappeler sur la consigne d'installation envoyée avant la rentrée.
  ]
]

// --------------------------------------------
#d("Contenu de la séance")[
  #annonce[
    Cinq parties, des notions les plus générales jusqu'à l'installation de
    l'environnement de programmation.
  ]

  #tableau(
    columns: (1fr, auto, auto),
    align: (left + horizon, left + horizon, right + horizon),
    [Partie], [Nature], [Durée],
    [Logiciels et formats de fichier], [cours et manipulation], [25′],
    [Programmation et éditeur de code], [cours et manipulation], [25′],
    [Édition de texte et contenu des fichiers], [cours et manipulation], [30′],
    [Environnement de programmation], [cours et manipulation], [25′],
    [Notebooks], [cours], [10′],
  )

  #legende[
    Durées indicatives ; ce qui n'a pas été traité est repris en annexe.
  ]

  #notes[
    Les diapositives brunes sont les manipulations : sept, dans les cinq
    parties. Annoncer que la séance n'est pas un exposé continu.

    L'ordre, en une phrase : ce qu'est un logiciel et ce qu'il manipule,
    comment on en écrit un, ce qu'un fichier contient vraiment, comment on
    installe de quoi travailler, et l'outil qui réunit tout cela.

  ]
]
