// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

// ==================== Programmation et éditeur de code =====================

#separateur("Programmation et éditeur de code")
#d("Programmes et applications")[
  #annonce[
    Un programme est un texte d'instructions qui accomplit une tâche ;
    programmer, c'est écrire ce texte. Une application est un programme
    empaqueté pour celui qui s'en sert.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Programme], [Application],
    [Ce qu'on reçoit],
      [le code source, un fichier texte],
      [un produit installé, prêt à l'emploi],
    [Pour l'exécuter],
      [savoir quel outil le lance, et le lui demander],
      [ouvrir la fenêtre],
    [Interface],
      [souvent aucune : le terminal suffit],
      [prévue pour l'utilisateur],
    [Dans ce module],
      [automatiser une tâche, traiter des données],
      [ce qu'on utilise, pas ce qu'on écrit],
  )

  #legende[
    La frontière tient à l'empaquetage et à l'usage, non à la technique : le
    même code, distribué prêt à l'emploi, se présente comme une application.
  ]

  #notes[
    Motiver avant de définir : renommer 300 photos par leur date prend une
    soirée à la main, quelques secondes par programme ; la deuxième
    exécution ne coûte rien, et une erreur de recopie devient
    systématique, donc repérable. C'est le genre de programme demandé ici
    — automatisation et traitement de données, pas applications.

    Trois mots à séparer : « programmation » nomme l'activité, « programme
    » son résultat, « application » ce que reçoit celui qui s'en sert.
    Dire que la frontière entre les deux derniers est floue : un même code
    se lance depuis un terminal, puis s'empaquette avec une interface. Ce
    qui change est ce que reçoit l'utilisateur.

    Reprendre le schéma entrée → traitement → sortie du début de séance :
    la boîte du milieu est un fichier, et les deux diapositives suivantes
    disent comment il est fabriqué.
  ]
]
#d("Deux chemins du texte à l'exécution")[
  #annonce[
    Compiler traduit tout le programme une fois pour toutes. Interpréter lit
    et exécute le texte à chaque lancement.
  ]

  #block(width: 100%, fill: gris, inset: (x: 12pt, y: 5pt), below: 0.4em)[
    #text(size: 15pt, fill: estompe, weight: demi-gras)[Compilé]
    #v(0.25em)
    #chaine(
      ("bonjour.cpp", "le texte écrit"),
      ("compilateur", "une fois"),
      ("bonjour.exe", "des instructions"),
      ("résultat", "à chaque lancement"),
    )
  ]

  #block(width: 100%, fill: accent.lighten(92%), inset: (x: 12pt, y: 5pt))[
    #text(size: 15pt, fill: accent, weight: demi-gras)[Interprété]
    #v(0.25em)
    #chaine(
      ("bonjour.py", "le texte écrit"),
      ("interpréteur", "à chaque lancement"),
      ("résultat", "rien sur le disque"),
    )
  ]

  #legende[
    Lancer un programme Python ne crée rien sur le disque, et c'est aussi
    pourquoi il est plus lent.
  ]

  #notes[
    La chaîne compilée a une étape de plus, faite une fois ; l'interprétée
    en a une de moins, refaite à chaque exécution.

    Semer le facteur ×100 à ×1000 du cours 6 et du TD 7 : `numpy` délègue
    à du C compilé. Ne pas développer.

    Les noms de fichiers sont ceux de la manipulation à venir ; le dire
    une fois.

    « Et Java ? » vient toujours : répondre en une phrase, les deux à la
    fois.
  ]
]
#d("Code source et fichier exécutable")[
  #annonce[
    Au bout de la chaîne compilée, un fichier que le processeur lit et
    qu'aucun humain ne peut lire. Il a pourtant été produit à partir d'un
    texte écrit au clavier.
  ]

  #face-a-face(
    panneau("Ce qu'a écrit un humain")[
      ```python
      largeur = 1920
      hauteur = 1080
      print(largeur * hauteur)
      ```
    ],
    panneau("Ce que lit le processeur")[
      ```
      7f45 4c46 0201 0100 0000
      0300 3e00 0100 0000 1ef5
      4000 0000 0000 0000 887d
      0000 0000 4000 3800 0c00
      ```
    ],
  )

  #legende[Premiers octets de l'exécutable `python3`, vus en hexadécimal.]

  #notes[
    Faire remarquer `7f 45 4c 46`, soit « ELF » en ASCII : un binaire
    n'est pas du bruit, il a une structure. On l'ouvrira au cours 3.

    Le fichier montré est l'exécutable de `python3` : l'interpréteur du
    chemin de droite est lui-même arrivé au bout du chemin de gauche.
    C'est la diapositive suivante.
  ]
]
#d("La place de l'interpréteur")[
  #annonce[
    Un programme compilé s'adresse directement au système. Un programme
    interprété passe d'abord par l'interpréteur, lui-même un exécutable.
  ]

  #couche(
    icone-fenetre(taille: 30pt), "Programme interprété",
    "bonjour.py, une page web", plein: true,
  )
  #liaison("le texte à exécuter", "le résultat")
  #couche(
    icone-fenetre(taille: 30pt), "Interpréteur",
    "python, le navigateur",
  )
  #liaison("« ouvre ce fichier »", "le contenu")
  #couche(
    icone-engrenage(taille: 30pt), "Système d'exploitation",
    "Windows, macOS, Linux",
  )

  #legende[
    Un programme compilé n'a pas cet étage intermédiaire : `bonjour.exe`
    s'adresse directement au système.
  ]

  #notes[
    Un interpréteur est un programme comme les autres. Celui de Python
    s'appelle `python`, et c'est son exécutable dont les premiers octets
    viennent d'être montrés. Ce qui exécute du texte est soi-même un
    binaire.

    Conséquence pratique : lancer un programme Python suppose Python
    installé, alors qu'un exécutable compilé se lance seul. C'est ce que
    la manipulation fera constater, et pourquoi la partie « Environnement
    de programmation » existe.

    Le navigateur interprète trois langages sans qu'on l'appelle «
    interpréteur » : le mot désigne un rôle, pas une catégorie de
    logiciel.
  ]
]
#d("Il n'existe pas qu'un interpréteur Python")[
  #annonce[
    « Python » nomme le langage. Plusieurs programmes savent l'exécuter, et
    celui que tout le monde emploie est écrit en C.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Interpréteur], [Écrit en], [Ce qui le distingue],
    [CPython], [C], [la référence, celle que vous installez sans le savoir],
    [PyPy], [Python], [plus rapide sur les longs calculs, compatible en partie],
    [Jython], [Java], [permet d'employer les bibliothèques Java],
    [MicroPython], [C], [tient dans un microcontrôleur],
  )

  #legende[
    `python --version` ne dit pas lequel tourne ; la première ligne de la
    session interactive, si.
  ]

  #notes[
    Une minute. Elle décolle le langage de son interpréteur : un langage
    est une convention d'écriture, plusieurs programmes peuvent
    l'appliquer.

    Le seul qu'ils rencontreront est CPython ; le dire ainsi pour qu'ils
    ne cherchent pas à choisir. PyPy et Jython annoncent leur nom dans la
    bannière interactive, CPython ne donne que sa version et le
    compilateur qui l'a produit, `[GCC 15.3.0]` ici. Bannière relevée dans
    `info01` ; elle varie avec le canal et la version.

    L'interpréteur de référence est écrit en C : les octets de « Code
    source et fichier exécutable » étaient ceux de ce programme.

    Ne pas ouvrir la question de la vitesse : elle est au cours 6, et la
    réponse n'est pas de changer d'interpréteur.
  ]
]
#d("L'éditeur de code")[
  #annonce[
    Un éditeur de code réunit trois choses dans une fenêtre : à gauche
    l'arborescence du projet, au centre le texte du programme, en bas un
    terminal pour le lancer.
  ]

  #align(center)[
    #illustration(
      "/illustrations/cours1/vscode_projet.png",
      fenetre("trajet — Visual Studio Code", hauteur: hauteur-capture)[
        #text(size: 13pt, fill: estompe)[
          à gauche l'arborescence, au centre le code, en bas le terminal
        ]
      ],
      hauteur: hauteur-capture,
    )
  ]

  #legende[
    Le fichier `trajet.png` apparaît dans l'arborescence : il vient d'être
    produit par la commande tapée en bas.
  ]

  #notes[
    Un éditeur de code n'est pas un traitement de texte : il enregistre du
    texte brut, et ce qu'il ajoute à l'écran — couleurs, numéros de ligne
    — est un affichage, pas du contenu.

    Les trois zones suffisent aujourd'hui ; débogueur, extensions et git
    viennent aux cours 2 et 3.

    VSCode s'affiche en anglais par défaut ; le module ne demande pas d'en
    changer.
  ]
]
#d("Les fonctions d'un IDE")[
  #annonce[
    IDE, pour _integrated development environment_, se traduit par
    environnement de développement intégré : un seul logiciel réunit ce qui
    demandait autant d'outils séparés.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [La fonction], [Ce que l'éditeur en fournit],
    [Écrire le code],
      [coloration, indentation, complétion, soulignement des fautes],
    [Le lancer et le tester],
      [un terminal intégré et un bouton d'exécution, sans quitter la fenêtre],
    [Naviguer dans le projet],
      [l'arborescence à gauche, la recherche dans tous les fichiers],
    [Déboguer],
      [exécuter pas à pas, arrêter sur une ligne, lire les variables],
  )

  #legende[
    Un éditeur de texte ordinaire ne fait que la première ligne. C'est
    l'intégration des autres qui fait l'environnement.
  ]

  #notes[
    Le sigle reste anglais : « environnement de développement intégré »
    est la traduction officielle, « EDI » son abréviation, que personne
    n'emploie. Le dire une fois pour que le mot lu ailleurs soit reconnu.

    Deuxième et troisième lignes : elles distinguent un IDE d'un éditeur
    de texte, et ce sont celles qu'on emploie aujourd'hui — terminal
    intégré à la manipulation qui vient, arborescence dès qu'on ouvre un
    dossier.

    Débogage et panneau git sont nommés, pas montrés : cours 2.

    Microsoft présente VSCode comme un éditeur plutôt que comme un IDE,
    ses fonctions avancées venant d'extensions. Ne pas s'y attarder si la
    question ne vient pas.
  ]
]
#d("Lancer un programme depuis l'éditeur")[
  #annonce[
    Le bouton exécute le fichier ouvert, le terminal exécute ce qu'on y tape.
    Le premier est plus rapide, le second est le même partout.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Le bouton d'exécution], [Le terminal intégré],
    [Où le trouver],
      [en haut à droite de l'éditeur],
      [Terminal #sym.arrow.r Nouveau terminal],
    [Sur un `.py`],
      [« Run Python File »],
      [`python bonjour.py`],
    [Sur un `.cpp`],
      [« Run C/C++ File », qui demande le compilateur la première fois],
      [`g++ …`, puis l'exécutable produit],
    [Ce qu'il choisit à votre place],
      [l'interpréteur, réglé par `Ctrl` + `Maj` + `P` #sym.arrow.r « Python: Select Interpreter »],
      [rien : la commande dit tout],
  )

  #legende[
    Le bouton écrit sa commande dans le terminal avant de l'exécuter : elle
    reste lisible, et c'est celle-là qu'il faut savoir écrire.
  ]

  #notes[
    Trois menus, et c'est tout ce qu'il faut aujourd'hui.

    Dire pourquoi le module fait écrire la commande à la main : elle est
    identique sur les trois systèmes, elle se relit, et c'est elle qu'on
    enchaînera au cours 2 puis qu'on mettra en script au cours 3. Le
    bouton diffère d'un langage à l'autre et masque ce qu'il fait.

    Dernière ligne, la plus coûteuse si elle est sautée : le bouton
    exécute avec l'interpréteur sélectionné, pas forcément celui du module
    — origine du `ModuleNotFoundError` annoncé à la partie 4. La sélection
    vaut aussi pour le terminal.

    Le bouton C++ existe, « Run C/C++ File » : il demande un compilateur
    au premier lancement et écrit un `tasks.json`. Ne pas l'employer en
    séance, mais savoir répondre.
  ]
]
#d("De quoi compiler du C++")[
  #annonce[
    Python vient avec l'environnement du module. Un compilateur C++, non :
    Windows n'en fournit aucun, et il faut l'installer avant la manipulation.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Linux, macOS], [Windows],
    [Le compilateur],
      [`g++`, presque toujours déjà là],
      [aucun d'origine],
    [Comment l'obtenir],
      [rien à faire],
      [`conda install -c conda-forge gxx`],
    [Ce qu'on tape ensuite],
      [`g++ …`],
      [`x86_64-w64-mingw32-g++ …`],
  )

  #legende[
    L'environnement conda ne sert pas qu'à Python : il installe des outils, et
    ici un compilateur. La partie « Environnement de programmation » dira
    pourquoi on procède ainsi plutôt qu'en installant sur la machine.
  ]

  #notes[
    À faire avant la séance si possible : quelques minutes, et le réseau
    de la salle n'est pas garanti. À défaut, lancer l'installation au
    début de la manipulation et enchaîner sur Python pendant ce temps.

    Le nom de l'exécutable est le piège, à projeter : sous Windows, conda-
    forge installe `x86_64-w64-mingw32-g++.exe`, pas `g++`. C'est le nom
    complet de la cible, et il ne s'invente pas. Relevé dans le contenu du
    paquet `gxx_win-64` ; non confirmé sur une machine Windows.

    Ne pas employer `m2w64-toolchain`, encore présent dans de vieilles
    réponses en ligne : le paquet s'annonce lui-même obsolète et renvoie
    vers `gcc`, `gxx` et `gfortran`.

    L'environnement est expliqué à la partie 4 : aujourd'hui on s'en sert.
  ]
]
#separateur-manip(
  "Un hello world en Python et en C++",
  annonce: "Ouvrir les deux projets dans l'éditeur, puis les exécuter depuis son terminal",
  dossier: "data/cours1/hello/",
)
#d("Ouvrir un terminal où conda existe")[
  #annonce[
    `conda` n'est pas disponible dans n'importe quel terminal. Il faut ouvrir
    celui qu'Anaconda installe, ou dire à l'éditeur quel environnement employer.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Où], [Le geste], [Ce qui le prouve],
    [Windows, hors éditeur],
      [menu Démarrer, chercher « Anaconda Prompt »],
      [l'invite commence par `(base)`],
    [Linux, macOS],
      [un terminal ordinaire suffit],
      [l'invite commence par `(base)`],
    [Dans l'éditeur],
      [`Ctrl` + `Maj` + `P`, « Python: Select Interpreter », choisir `info01`],
      [le terminal ouvert ensuite commence par `(info01)`],
  )

  #legende[
    Le nom entre parenthèses en tête d'invite est la seule preuve qu'on est
    dans le bon environnement. Sans lui, la commande installera ailleurs.
  ]

  #notes[
    Les postes de la salle ont Anaconda, d'où l'« Anaconda Prompt » du
    menu Démarrer. `cmd` et PowerShell ne connaissent pas `conda` tant
    qu'ils n'ont pas été initialisés : première cause de « la commande
    n'existe pas ».

    Troisième ligne, utile toute l'année : choisir l'interpréteur dans
    l'éditeur suffit, l'extension Python plaçant ensuite les terminaux
    intégrés dans cet environnement. Plus besoin de `conda activate`.

    Faire lire l'invite à voix haute : `(base)` et `(info01)` ne sont pas
    la même chose, et les confondre fait installer les paquets là où ils
    ne serviront pas.

    Ce que fait un environnement est expliqué à la partie 4.
  ]
]
#d("Lancer les deux programmes")[
  #annonce[
    Six gestes, dans cet ordre, et un septième facultatif. Le terminal de
    l'éditeur s'ouvre déjà dans le dossier du projet : il n'y a aucun chemin à
    écrire.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [Fichier #sym.arrow.r Ouvrir le dossier, puis choisir `data/cours1/hello/`],
    [2], [`Ctrl` + `Maj` + `P`, « Python: Select Interpreter », choisir `info01`],
    [3], [Terminal #sym.arrow.r Nouveau terminal : il s'ouvre en bas, dans `hello/`],
    [4], [taper `python python/bonjour.py`, puis Entrée],
    [5], [taper `g++ cpp/bonjour.cpp -o cpp/bonjour`, puis Entrée],
    [6], [taper `cpp/bonjour`, puis Entrée],
    [7], [en option : mettre tout `bonjour.cpp` sur une seule ligne, recompiler],
  )

  #legende[
    L'étape 5 n'affiche rien, et c'est normal : elle produit un fichier. Sous
    Windows, la commande est `x86_64-w64-mingw32-g++`, l'exécutable produit
    s'appelle `cpp\bonjour.exe` et se lance par `.\cpp\bonjour.exe`.
    À l'étape 7, le programme compile et s'exécute à l'identique : en C++, les
    retours à la ligne ne comptent pas. En Python, la même opération échoue.
  ]

  #notes[
    Projeter les gestes un par un : une étape sous-entendue est une étape
    où la moitié de la salle s'arrête sans le dire.

    Étape 2 : elle évite le `ModuleNotFoundError` de fin de séance, le
    terminal pouvant ouvrir un autre Python que celui du module. Elle ne
    coûte rien aujourd'hui, aucune bibliothèque n'étant importée.

    Étape 5 : rien ne s'affiche, la question vient. Faire regarder
    l'arborescence à gauche, où `cpp/bonjour` vient d'apparaître.

    Sous Windows, le compilateur est celui installé deux diapositives plus
    tôt, `x86_64-w64-mingw32-g++`. Vérifier avant la séance que
    l'installation est passée : c'est la seule étape qui demande du
    réseau.

    Étape 7, facultative : tout `bonjour.cpp` tient sur une ligne —
    `#include <iostream>` doit rester seul, c'est une directive — et le
    programme compile et affiche la même chose. Le compilateur ne voit pas
    les retours à la ligne, seulement les points-virgules et les
    accolades. La mise en page du code est pour les humains.

    Faire ensuite tenter la même chose sur un programme Python à boucle :
    cela échoue, le retour à la ligne y séparant les instructions et
    l'indentation y délimitant les blocs. C'est « Espaces, tabulations et
    fins de ligne » démontré.

    Le bouton d'exécution fait la même chose que l'étape 4 ; le montrer
    après, jamais avant.
  ]
]
#d("Ce que chaque lancement a produit")[
  #annonce[
    Les deux programmes affichent la même phrase. Ce qui les distingue est le
    nombre d'étapes, et ce qui reste sur le disque.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [`python/bonjour.py`], [`cpp/bonjour.cpp`],
    [Nombre d'étapes], reponse[une], reponse[deux : compiler, puis exécuter],
    [Ce qui apparaît dans l'arborescence],
      reponse[rien],
      reponse[`cpp/bonjour`, un exécutable],
    [Taille du fichier source], [121 octets], [230 octets],
    [Taille du fichier produit],
      reponse[aucun fichier],
      reponse[environ 20 000 octets],
  )

  #legende[
    La taille de l'exécutable dépend du compilateur et du système ; le
    rapport à la source, près de cent fois, n'en dépend pas.
  ]

  #notes[
    C'est « Deux chemins du texte à l'exécution » fait à la main : y
    renvoyer.

    Le rapport de taille est le chiffre à faire dire. L'exécutable
    embarque de quoi tourner sans le compilateur, d'où le facteur cent ;
    le fichier Python ne peut rien sans l'interpréteur, déjà installé et
    qu'on ne compte donc pas.

    Faire ouvrir `cpp/bonjour` dans l'éditeur : illisible, c'est « Code
    source et fichier exécutable » vérifié par eux. Ajouter que `python`
    est un exécutable de la même espèce.

    Le terminal est repris à la partie « Environnement de programmation »,
    où le dossier courant est nommé.
  ]
]
// Le résultat de la manipulation, quand la capture est disponible.
#if captures-disponibles {
d("Les deux exécutions dans l'éditeur")[
  #annonce[
    Le terminal de l'éditeur garde la trace des trois commandes, et
    l'arborescence montre le fichier que la compilation vient de produire.
  ]

  #align(center)[
    #illustration(
      "/illustrations/cours1/vscode_hello.png",
      none,
      hauteur: hauteur-capture-pleine,
    )
  ]

  #legende[
    `cpp/bonjour` n'existait pas avant la deuxième commande. Le programme
    Python, lui, n'a rien laissé.
  ]

  #notes[
    Trois commandes, deux langages, une seule fenêtre : l'argument de
    l'éditeur de code, montré plutôt qu'énoncé.

    La sortie est identique, le chemin pour l'obtenir non.
  ]
]
}
#separateur-manip(
  "Le même programme, trois façons de l'exécuter",
  annonce: "En entier, ligne à ligne, puis pas à pas en regardant les variables",
  dossier: "data/cours1/hello/",
)
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
