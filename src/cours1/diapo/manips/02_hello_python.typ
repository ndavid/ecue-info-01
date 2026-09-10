// Manipulation du cours 1 — « Un hello world en Python ».
//
// Incluse par `cours1.typ`, qui porte les réglages globaux, et compilable
// seule par `outils/compiler_manips.py`, qui en tire la feuille d'instructions
// déposée dans le dossier de données de la manipulation. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#import "../schemas.typ": capture-ide


#separateur-manip(
  "Un hello world en Python",
  annonce: "Ouvrir le projet dans l'éditeur, choisir son interpréteur, puis exécuter le programme de trois façons",
  dossier: "data/cours1/hello/",
)
#d("Visual Studio Code")[
  #align(center, capture-ide(hauteur: 345pt))

  #notes[
    L'annonce est passée ici pour laisser la place à la capture : l'éditeur du
    module, générique, une extension par langage, et trois zones aujourd'hui.

    Dire le choix et ses conséquences : VSCode n'est pas le seul éditeur, c'est
    celui du module. Il est générique, donc il faut le configurer pour chaque
    langage, par une extension, et la configuration dépend du système — c'est
    ce que la diapositive précédente vient de montrer sur le compilateur C++.

    Faire ouvrir la fenêtre en même temps, et faire retrouver les trois zones
    chez eux : les couleurs de la capture ne servent qu'à les nommer une fois.

    À faire remarquer sur la capture, sans l'écrire : `trajet.png` vient
    d'apparaître dans l'arborescence, produit par la commande tapée en bas.
    Les trois zones se répondent.

    Un éditeur de code n'est pas un traitement de texte : il enregistre du
    texte brut, et ce qu'il ajoute à l'écran — couleurs, numéros de ligne
    — est un affichage, pas du contenu.

    Les trois zones suffisent aujourd'hui ; débogueur, extensions et git
    viennent aux cours 2 et 3.

    VSCode s'affiche en anglais par défaut ; le module ne demande pas d'en
    changer. Les intitulés cités plus loin sont donc les intitulés anglais.
  ]
]

#d("Extension de fichier et extension de VSCode")[
  #annonce[
    Le même mot désigne deux choses sans rapport : la fin du nom d'un fichier,
    et un greffon qu'on installe dans l'éditeur.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [L'extension du fichier], [L'extension de l'éditeur],
    [Ce que c'est],
      [la fin du nom, après le dernier point : `.py`, `.cpp`, `.md`],
      [un greffon installé dans VSCode : `ms-python.python`],
    [Dans le fichier],
      [rien : les trois sont du texte, sans marque ni en-tête],
      [rien non plus : elle n'agit que sur l'affichage],
    [Ce qu'elle apporte],
      [une indication de langage, à qui lit le nom],
      [la coloration fine, et la vérification des règles d'écriture],
  )

  #legende[
    Les trois du module : `ms-python.python`, `ms-vscode.cpptools`,
    `ms-toolsai.jupyter`. Panneau Extensions, `Ctrl` + `Maj` + `X`, où l'on
    cherche l'identifiant et jamais le nom affiché.
  ]

  #notes[
    Deux sens pour un mot : « installe l'extension Python » et « le
    fichier a l'extension `.py` » ne parlent pas de la même chose. Le dire
    une fois.

    Colonne de gauche, le point neuf : un `.py` et un `.cpp` sont des
    fichiers texte, et rien dans leurs octets ne les distingue — ni marque
    binaire, ni en-tête, ni signature. L'extension dit ce qu'on peut
    espérer trouver, elle ne le garantit pas. `python bonjour.txt` exécute
    parfaitement un programme Python.

    C'est ce que la manipulation « Les premiers octets d'un fichier » fera
    constater : les formats texte n'ont aucune signature, contrairement au
    ZIP et au PDF.

    La vérification porte sur les règles d'écriture, pas sur le sens : un
    programme peut être irréprochable pour l'extension et faire le
    contraire de ce qu'on voulait.

    Chercher l'identifiant en chasse fixe et non le nom affiché :
    plusieurs extensions non officielles portent le même titre.
    L'extension Python installe elle-même Pylance, qui fait la
    vérification ; ne le dire que si quelqu'un le remarque. Identifiants
    relevés sur le poste de préparation.
  ]
]
#d("Installer l'extension d'un langage")[
  #annonce[
    Ouvrir le dossier de la manipulation, puis installer l'extension Python :
    c'est elle qui fera tout ce qui suit.
  ]

  #tableau(
    columns: (1.1fr, 1fr),
    align: left + horizon,
    [Le geste], [Ce que vous observez],
    [Fichier #sym.arrow.r Ouvrir le dossier, sur `data/cours1/hello/`],
      [deux dossiers, `python/` et `cpp/`, et un `README.md`],
    [Ouvrir `python/bonjour.py` avant toute installation],
      reponse[le texte est déjà coloré : l'éditeur connaît Python de naissance],
    [`Ctrl` + `Maj` + `X`, chercher `ms-python.python`, installer],
      reponse[Pylance et le débogueur s'installent avec, et la barre d'état
              propose un interpréteur],
    [Ouvrir `cpp/bonjour.cpp`],
      reponse[l'éditeur propose l'extension C/C++, installée plus tard],
  )

  #legende[
    Une extension s'installe une fois pour toutes : elle sera là aux séances
    suivantes, et pour les autres cours.
  ]

  #notes[
    C'est le premier geste de la séance sur l'éditeur, et il sert partout
    ensuite : le choix de l'interpréteur, le lancement, le débogueur pas à
    pas, et la manipulation des programmes fautifs en fin de partie.

    Deuxième ligne, la surprise voulue : la coloration ne vient pas de
    l'extension, elle est fournie d'origine pour les langages courants. Ce
    que l'extension apporte vient après — l'interpréteur, l'exécution, la
    vérification des règles d'écriture.

    Chercher l'identifiant `ms-python.python` et non le nom affiché :
    plusieurs extensions non officielles portent le même titre. Celle de
    Microsoft entraîne Pylance, qui vérifie l'écriture, et le débogueur ;
    il n'y a donc qu'une extension à chercher.

    L'éditeur n'a pas pu être piloté sur le poste de préparation : la
    proposition automatique de l'extension C/C++ dépend d'un réglage, à
    vérifier en salle.

    Poste sans réseau : les extensions ne s'installent pas. Le prévoir,
    car la suite de la manipulation en dépend cette fois.
  ]
]
#d("Choisir l'interpréteur Python")[
  #annonce[
    Plusieurs Python peuvent coexister sur une machine. Dire à l'éditeur lequel
    employer suffit : il place les terminaux qu'il ouvre dans cet environnement.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Où], [Le geste], [Ce qui le prouve],
    [Dans l'éditeur],
      [`Ctrl` + `Maj` + `P`, « Python: Select Interpreter », choisir `info01`],
      [le terminal ouvert ensuite commence par `(info01)`],
    [Windows, hors éditeur],
      [menu Démarrer, chercher « Anaconda Prompt »],
      [l'invite commence par `(base)`],
    [Linux, macOS],
      [un terminal ordinaire suffit],
      [l'invite commence par `(base)`],
  )

  #avertissement[
    Le nom entre parenthèses en tête d'invite est la seule preuve qu'on est dans
    le bon environnement. Sans lui, la commande installera ailleurs.
  ]

  #notes[
    Première ligne, la seule à retenir aujourd'hui : la documentation de VSCode
    est explicite, « when you open a terminal in VS Code, the extension
    automatically activates your selected Python environment so that `python`,
    `pip`, and related commands use the correct interpreter ». Plus besoin de
    `conda activate`.

    Elle évite le `ModuleNotFoundError` de fin de séance, le terminal pouvant
    ouvrir un autre Python que celui du module. Elle ne coûte rien aujourd'hui,
    aucune bibliothèque n'étant importée.

    Les postes de la salle ont Anaconda, d'où l'« Anaconda Prompt » du menu
    Démarrer. `cmd` et PowerShell ne connaissent pas `conda` tant qu'ils n'ont
    pas été initialisés : première cause de « la commande n'existe pas ».

    Faire lire l'invite à voix haute : `(base)` et `(info01)` ne sont pas la
    même chose. Ce que fait un environnement est expliqué à la partie 3.
  ]
]
#d("Lancer le programme")[
  #annonce[
    Quatre gestes. Le terminal de l'éditeur s'ouvre déjà dans le dossier du
    projet : il n'y a aucun chemin à écrire.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [Fichier #sym.arrow.r Ouvrir le dossier, puis choisir `data/cours1/hello/`],
    [2], [`Ctrl` + `Maj` + `P`, « Python: Select Interpreter », choisir `info01`],
    [3], [Terminal #sym.arrow.r Nouveau terminal : il s'ouvre en bas, dans `hello/`],
    [4], [taper `python python/bonjour.py`, puis Entrée],
  )

  #legende[
    Le bouton d'exécution, en haut à droite, fait la même chose : il écrit sa
    commande dans le terminal avant de l'exécuter. C'est cette commande qu'il
    faut savoir écrire, elle est identique sur les trois systèmes.
  ]

  #notes[
    Projeter les gestes un par un : une étape sous-entendue est une étape où la
    moitié de la salle s'arrête sans le dire.

    Rien n'apparaît dans l'arborescence : lancer un programme Python ne laisse
    rien sur le disque. C'est vérifié pour de bon à la manipulation suivante,
    quand le C++ produira un fichier.

    Le bouton exécute avec l'interpréteur sélectionné, pas forcément celui du
    module : c'est l'origine du `ModuleNotFoundError` annoncé à la partie 3. Le
    montrer après le terminal, jamais avant.
  ]
]
#d("Le programme de la manipulation")[
  #annonce[
    Six lignes qui calculent une moyenne d'altitudes, sans rien emprunter à
    personne. Il tient à l'écran, et son résultat se vérifie de tête.
  ]

  #face-a-face(
    panneau[`python/altitudes.py`][
      ```python
      altitudes = [128.4, 131.0, 127.6]
      total = 0
      for altitude in altitudes:
          total = total + altitude
      moyenne = total / len(altitudes)
      print(f"moyenne : {moyenne:.1f} m")
      ```
    ],
    panneau("Lancé en entier")[
      ```console
      $ python python/altitudes.py
      moyenne : 129.0 m
      ```
      #v(0.4em)
      #text(size: 14pt, fill: estompe)[
        Une seule ligne de sortie : c'est le `print` de la fin, et rien
        d'autre. Ce qui s'est passé entre-temps n'est pas visible.
      ]
    ],
  )

  #legende[
    Sortie réelle, Python 3.12. La moyenne de 128,4, 131,0 et 127,6 vaut bien
    129,0.
  ]

  #notes[
    Six lignes, une boucle donc un état qui change, un résultat vérifiable
    de tête : le `hello world` n'avait aucune de ces propriétés.

    Les altitudes sont celles de « Coloration syntaxique », devenues un
    programme qui tourne.

    Ce programme ne montre que sa dernière ligne ; les deux façons
    suivantes servent à voir ce qu'il fait entre le début et la fin.
  ]
]
#d("Python en interactif")[
  #annonce[
    Taper `python` sans nom de fichier ouvre une session interactive : chaque
    ligne est lue, exécutée, et son résultat affiché aussitôt.
  ]

  ```console
  $ python
  Python 3.12.14 (main, Sep  2 2026, 23:27:36) [GCC 15.3.0] on linux
  >>> altitudes = [128.4, 131.0, 127.6]
  >>> total = 0
  >>> for altitude in altitudes:
  ...     total = total + altitude
  ...
  >>> total
  387.0
  >>> total / len(altitudes)
  129.0
  >>> exit()
  ```

  #legende[
    Session réelle. `total` s'affiche sans `print` : c'est propre à la session
    interactive, et c'est ce qui permet de regarder à l'intérieur.
  ]

  #notes[
    Faire remarquer les trois chevrons : c'est l'invite de Python, pas
    celle du terminal. Les confondre produit un `SyntaxError` quand on
    tape une commande du système. Les trois points sont la suite d'un bloc
    commencé.

    On entre par `python`, on sort par `exit()` ou `Ctrl` + `D`. Le dire
    tout de suite.

    La session donne accès à `total`, que le script ne montrait pas. Si la
    salle suit, refaire la boucle en affichant `total` à chaque tour :
    128,4 puis 259,4 puis 387,0.

    Un script se relance à l'identique et ne laisse rien à l'écran ; une
    session montre tout et ne laisse rien sur le disque. Deux usages, pas
    deux niveaux.

    Amorce de la dernière partie : un notebook est cette session, avec le
    texte conservé autour.
  ]
]
#d("Exécuter pas à pas dans l'éditeur")[
  #annonce[
    Le débogueur arrête le programme sur une ligne choisie et laisse regarder
    les variables, sans rien ajouter au code.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Le geste], [Ce qu'on obtient],
    [Poser l'arrêt],
      [cliquer dans la marge à gauche de la ligne 4, ou `F9`],
      [un point rouge : le programme s'y arrêtera],
    [Lancer], [`F5`], [l'exécution s'arrête au point rouge],
    [Avancer d'une ligne], [`F10`], [le panneau des variables se met à jour],
    [Regarder], [le panneau « Variables », en haut à gauche],
      [`total` passe de 0 à 128,4, puis 259,4, puis 387,0],
  )

  #legende[
    Raccourcis par défaut de VSCode. Le débogueur ne modifie pas le fichier :
    les points d'arrêt sont un réglage de l'éditeur, pas du code.
  ]

  #notes[
    Les deux premières façons montrent le début et la fin ; celle-ci
    montre le milieu, ligne par ligne.

    Réflexe à installer : on ne sème pas des `print`, on pose un point
    d'arrêt. Plus rapide, et rien à effacer ensuite.

    Ligne 4 est choisie exprès, c'est le corps de la boucle : l'arrêt se
    répète trois fois et `total` change sous leurs yeux. Faire prédire la
    valeur avant chaque `F10`.

    Ne pas aller plus loin : `F11` entre dans les fonctions appelées et
    perd tout le monde. Le débogage pour lui-même est au cours 2.

    Raccourcis par défaut, relevés dans la documentation de VSCode et non
    sur les postes : vérifier que personne n'a un jeu modifié.
  ]
]
