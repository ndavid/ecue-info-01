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
#d("Objectif du cours")[
  #annonce[
    Consolider ou acquérir les bases informatiques nécessaires aux autres
    enseignements, en particulier ceux de programmation et les TD utilisant
    Python.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Demandé dans les autres cours], [(re)vu dans ce module],
    [« ouvrez le projet fourni »], [travailler dans un éditeur de code, lire une arborescence],
    [« installez Python et numpy »], [créer un environnement et le réinstaller ailleurs],
    [« le script lit `donnees.csv` »], [manipuler des fichiers depuis Python],
    [« rendez votre code »], [versionner avec git, partager un dépôt],
  )

  #notes[
    Ces bases sont en partie connues, par le lycée ou la prépa. Les maîtriser
    évite de prendre du retard dans les autres cours : on s'y consacre au
    contenu du cours plutôt qu'à l'outil qu'on ne sait pas employer.
  ]
]
#d("Objectifs du module liés à la programmation")[
  #annonce[
    Maîtriser les bonnes pratiques de gestion d'un projet de code :
    documentation (`README`), organisation des fichiers, et usage des
    bibliothèques permettant d'écrire un programme facile à utiliser et à
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
#d("Les trois compétences du module")[
  #annonce[
    Trois savoir-faire reviennent à chaque séance. Une culture des ordres de
    grandeur s'y ajoute par apartés, pour expliquer pourquoi les outils sont
    faits ainsi.
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
    Les trois blocs sont les fils rouges : chaque séance en reprend au moins
    un, et les deux TD les mobilisent ensemble.

    Le bandeau n'est pas un quatrième domaine, et c'est pour cela qu'il n'a
    pas la même forme. Il désigne ce qui revient en apartés : ce que pèse un
    fichier, ce que coûte un calcul, ce qui circule sur le réseau, ce qu'on ne
    met pas dans un dépôt. La séance 5 lui est consacrée, les autres le
    croisent.

    Dire pourquoi ce registre existe plutôt que de le laisser en liste. Il
    porte le « pourquoi » des gestes demandés : on ne versionne pas du
    binaire, on ne recopie pas une boucle Python là où numpy va cent fois plus
    vite. Ces deux règles ne se retiennent que si l'ordre de grandeur qui les
    justifie a été donné une fois.
  ]
]
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
    Diapositive à commenter en trente secondes. Dire qu'on a conscience que
    ce sera une redite pour une partie de la salle.

    Formulation qui passe bien : ce qui est reproché aux étudiants dans les
    autres cours n'est pas toujours l'algorithmique. C'est un chemin de fichier
    faux, un environnement mal installé, une documentation peu claire, un code
    qui ne s'installe pas sur une autre machine. Ces gestes ne sont enseignés
    nulle part ailleurs : le module fait le choix de les enseigner plutôt que
    d'attendre que chacun se forme seul.
  ]
]
#d("Le rythme de la première partie")[
  #annonce[
    La première partie reprend ces notions, et avance donc plus vite que les
    suivantes. C'est la seule de la séance où le rythme est délibérément élevé.
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
    Diapositive courte, mais à ne pas expédier : c'est le contrat de la
    séance, et il vaut la peine de s'arrêter dessus dix secondes de plus que
    le contenu ne le demande.

    Dire les deux moitiés dans cet ordre. D'abord la raison du rythme, qui
    est un choix et non de la précipitation : la partie 1 reprend ce qui a pu
    être vu au lycée, et le temps ainsi gagné va aux manipulations. Ensuite
    la contrepartie, qui est à leur charge.

    Formulation qui fonctionne mieux qu'une invitation générale à poser des
    questions : dire qu'ici, ne pas comprendre est probable et normal, parce
    qu'on va vite exprès. La question n'est donc pas un aveu, c'est ce que le
    rythme suppose.

    Le passage à surveiller en pratique est le vocabulaire de la partie 1 —
    logiciel, application, format, extension, chemin. Ce sont des mots qu'ils
    croient connaître, et c'est là que les malentendus s'installent sans
    bruit.
  ]
]
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
    Diapositive d'orientation : on y revient à chaque changement de partie, en
    s'appuyant sur les diapositives de séparation.

    Les diapositives brunes du déroulé sont les manipulations : sept, dans les
    cinq parties. Annoncer dès maintenant que la séance n'est pas un exposé
    continu.

    L'ordre a une logique à énoncer en une phrase : on décrit d'abord ce qu'est
    un logiciel et ce qu'il manipule, puis comment on en écrit un, puis ce
    qu'un fichier contient vraiment, puis comment on installe de quoi
    travailler, et enfin l'outil qui réunit tout cela.

    Les durées sont le budget visé, pas le contenu du deck, qui est plus large :
    ce qui n'est pas traité part en annexe.
  ]
]
