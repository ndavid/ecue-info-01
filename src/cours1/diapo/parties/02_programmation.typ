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
    Motiver avant de définir. Renommer 300 photos par leur date prend une
    soirée à la main et quelques secondes par programme ; la deuxième
    exécution ne coûte rien, et une erreur de recopie devient systématique,
    donc repérable. C'est le genre de programme demandé dans ce module : de
    l'automatisation et du traitement de données, pas des applications.

    Trois mots à séparer une fois pour toutes : « programmation » nomme
    l'activité, « programme » son résultat, « application » ce que reçoit
    celui qui s'en sert. Dire que la frontière entre les deux derniers est
    floue plutôt que la laisser deviner : ce n'est pas une catégorie
    technique. Un même code se lance à la main depuis un terminal, puis
    s'empaquette avec une interface et se distribue ; ce qui change est ce
    que reçoit l'utilisateur, et ce qu'il doit savoir pour le faire tourner.

    Reprendre ensuite le schéma entrée → traitement → sortie du début de
    séance : la boîte du milieu est elle aussi un fichier, et la question qui
    ouvre la suite est de savoir comment ce fichier est fabriqué. Les deux
    diapositives suivantes y répondent : d'abord les deux chemins qui mènent
    du texte à l'exécution, puis ce que devient ce texte une fois traduit.
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
    Le schéma dit tout : la chaîne compilée a une étape de plus, mais elle
    n'est faite qu'une fois ; la chaîne interprétée en a une de moins, mais
    elle la refait à chaque exécution.

    Semer ici le facteur ×100 à ×1000 du cours 6 et du TD 7 : `numpy` est
    rapide parce qu'il délègue à du C compilé. Ne pas développer maintenant.

    Les noms de fichiers sont ceux de la manipulation de tout à l'heure : le
    schéma et le geste porteront les mêmes, et le rapprochement se fera tout
    seul. Le dire une fois, ici.

    Question qui vient toujours : « et Java ? ». Répondre en une phrase, les
    deux à la fois, et ne pas s'y engager.
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
    Faire remarquer `7f 45 4c 46` : c'est « ELF », lisible en ASCII. Un fichier
    binaire n'est pas du bruit, il a une structure — on l'ouvrira nous-mêmes au
    cours 3.

    Le fichier montré est l'exécutable de `python3`, et ce n'est pas un hasard :
    l'interpréteur du chemin de droite est lui-même arrivé au bout du chemin de
    gauche. C'est ce que la diapositive suivante met en place.
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
    Le mot à donner : un interpréteur est un programme comme les autres.
    Celui de Python s'appelle `python`, et c'est son exécutable dont les
    premiers octets viennent d'être montrés, `7f 45 4c 46`.
    Ce qui exécute du texte est soi-même un binaire.

    La conséquence pratique est celle qui compte : pour lancer un programme
    Python, il faut que Python soit installé, alors qu'un exécutable compilé
    se lance seul. C'est ce que la manipulation fera constater, et c'est
    pourquoi la partie « Environnement de programmation » existe.

    Le navigateur est le second exemple, et le plus parlant : il interprète
    trois langages sans que personne ne l'appelle « interpréteur ». Le mot
    désigne un rôle, pas une catégorie de logiciel. Sous les trois couches il
    y a le matériel, comme à la diapositive « Le système d'exploitation ».
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
    Diapositive de remarque, à passer en une minute. Elle sert à décoller le
    langage de son interpréteur, distinction que la précédente a rendue
    visible : un langage est une convention d'écriture, et plusieurs
    programmes peuvent l'appliquer.

    Le seul qu'ils rencontreront est CPython, et il faut le dire ainsi pour
    qu'ils ne cherchent pas à choisir. La bannière affichée au lancement de
    `python` le nomme, avec le compilateur qui l'a produit : c'est la ligne
    `packaged by conda-forge … [GCC 14.4.0]`.

    Le fait que l'interpréteur de référence soit écrit en C boucle avec « Code
    source et fichier exécutable » : les octets montrés étaient ceux de ce
    programme, compilé comme le `bonjour.exe` de la manipulation.

    Ne pas ouvrir la question de la vitesse ici. Elle revient au cours 6 avec
    numpy, et la réponse n'est pas « changer d'interpréteur ».
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
      "/data/cours1/illustrations/vscode_projet.png",
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
    texte brut, sans mise en forme, et tout ce qu'il ajoute à l'écran (les
    couleurs, les numéros de ligne) est un affichage, pas du contenu.

    Les trois zones suffisent aujourd'hui. Le débogueur, les extensions et
    l'intégration git viennent aux cours 2 et 3.

    VSCode s'affiche en anglais par défaut ; le module ne demande pas de le
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
    Le sigle est anglais et le restera : « environnement de développement
    intégré » est la traduction officielle, « EDI » son abréviation, et
    personne ne l'emploie. Le dire une fois pour que le mot lu ailleurs soit
    reconnu.

    Les deuxième et troisième lignes sont celles qui distinguent un IDE d'un
    éditeur de texte, et ce sont elles qu'on va employer aujourd'hui : le
    terminal intégré à la manipulation qui vient, l'arborescence dès qu'on
    ouvre un dossier plutôt qu'un fichier.

    Le débogage est nommé, pas montré : il vient au cours 2, une fois qu'il y
    aura des programmes assez longs pour en avoir besoin. Le panneau git est
    dans la même situation.

    Microsoft présente VSCode comme un éditeur de code plutôt que comme un
    IDE, la différence étant que les fonctions avancées viennent d'extensions
    installées. La frontière est commerciale autant que technique ; ne pas
    s'y attarder si la question ne vient pas.
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
    La diapositive répond à une question que la partie laissait ouverte : on a
    dit qu'un IDE sert à lancer et tester, sans jamais montrer par où. Trois
    menus, et c'est tout ce qu'il faut aujourd'hui.

    Le module fait écrire la commande à la main, et il faut dire pourquoi
    plutôt que de l'imposer : elle est identique sur les trois systèmes, elle
    se relit, et c'est elle qu'on enchaînera au cours 2 puis qu'on mettra dans
    un script au cours 3. Le bouton, lui, est différent d'un langage à
    l'autre et masque ce qu'il fait.

    La dernière ligne est celle qui coûte le plus cher si elle est sautée. Le
    bouton exécute avec l'interpréteur sélectionné, qui n'est pas forcément
    celui de l'environnement du module : c'est l'origine du `ModuleNotFoundError`
    « sur un paquet qu'on vient d'installer », annoncé à la partie 4. La
    sélection vaut aussi pour le terminal, que l'extension Python active
    ensuite toute seule.

    Sur le bouton C++ : il existe, il s'appelle « Run C/C++ File », et il
    demande de choisir un compilateur au premier lancement, puis écrit un
    `tasks.json` dans le projet. Ne pas l'employer en séance — cela ajoute un
    fichier de configuration à expliquer — mais savoir répondre à celui qui
    l'aura trouvé.
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
    À faire avant la séance si possible, l'installation prenant quelques
    minutes et le réseau de la salle n'étant pas garanti. À défaut, la lancer
    au début de la manipulation et enchaîner sur Python pendant qu'elle
    tourne.

    Le nom de l'exécutable est le piège, et il faut le projeter : sous
    Windows, conda-forge installe `x86_64-w64-mingw32-g++.exe`, pas `g++`.
    C'est le nom complet de la cible — architecture, système, format — et il
    ne s'invente pas. Relevé dans le contenu du paquet `gxx_win-64` ; à
    confirmer sur une machine Windows, ce qui n'a pas pu être fait ici.

    Ne pas employer `m2w64-toolchain`, qu'on trouve encore dans de vieilles
    réponses en ligne : le paquet affiche lui-même à l'activation qu'il est
    obsolète et renvoie vers `gcc`, `gxx` et `gfortran`.

    La justification de l'environnement est repoussée à la partie 4, et il
    faut le dire plutôt que de laisser la question en suspens : aujourd'hui on
    s'en sert, on l'expliquera tout à l'heure.
  ]
]
#separateur-manip(
  "Un hello world en Python et en C++",
  annonce: "Ouvrir les deux projets dans l'éditeur, puis les exécuter depuis son terminal",
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
    Les postes de la salle ont Anaconda installé : c'est lui qui fournit
    l'« Anaconda Prompt » du menu Démarrer. Le terminal Windows ordinaire,
    `cmd` ou PowerShell, ne connaît pas `conda` tant qu'il n'a pas été
    initialisé, et c'est la première cause de « la commande n'existe pas ».

    La troisième ligne est celle qui sert le reste de l'année : choisir
    l'interpréteur dans l'éditeur suffit, l'extension Python plaçant ensuite
    tous les terminaux intégrés dans cet environnement. On n'a alors plus à
    taper `conda activate`.

    Faire lire l'invite à voix haute une fois. `(base)` et `(info01)` ne sont
    pas la même chose, et confondre les deux fait installer les paquets dans
    l'environnement de base, où ils ne serviront pas.

    Ce que fait exactement un environnement est repoussé à la partie 4. Ici on
    s'en sert, on ne l'explique pas.
  ]
]
#d("Lancer les deux programmes")[
  #annonce[
    Six gestes, dans cet ordre. Le terminal de l'éditeur s'ouvre déjà dans le
    dossier du projet : il n'y a aucun chemin à écrire.
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
    Les gestes sont écrits un par un, et il faut les projeter tels quels.
    L'objectif seul ne suffit pas à cette séance : une étape sous-entendue
    est une étape où la moitié de la salle s'arrête sans le dire.

    Le bouton d'exécution fait la même chose que l'étape 4, et il existe aussi
    pour le C++ — c'est la diapositive précédente. Le montrer après, jamais
    avant : c'est la commande écrite à la main qui doit rester, parce qu'elle
    est la même partout et qu'elle se relit.

    L'étape 2 évite le `ModuleNotFoundError` de fin de séance : sans elle, le
    terminal peut ouvrir un autre Python que celui du module. Elle ne coûte
    rien aujourd'hui, où aucune bibliothèque n'est importée, et c'est
    justement pourquoi on la fait maintenant.

    L'étape 5 est celle où l'on attend une question, puisqu'il ne se passe
    rien à l'écran. Faire regarder l'arborescence à gauche plutôt que le
    terminal : le fichier `cpp/bonjour` vient d'y apparaître.

    Sous Windows, le compilateur est celui installé deux diapositives plus
    tôt, et il s'appelle `x86_64-w64-mingw32-g++`. Vérifier avant la séance
    que l'installation est passée : c'est la seule étape qui demande du
    réseau.

    L'étape 7 est facultative et vaut la minute qu'elle prend. Tout
    `bonjour.cpp` tient sur une ligne — `#include <iostream>` doit rester
    seul, c'est une directive — et le programme compile et affiche la même
    chose. Le compilateur ne voit pas les retours à la ligne, seulement les
    points-virgules et les accolades. Personne n'écrit ainsi, et c'est le
    propos : la mise en page du code est pour les humains.

    Faire ensuite tenter la même chose sur un programme Python à boucle. Cela
    ne marche pas : le retour à la ligne y sépare les instructions et
    l'indentation y délimite les blocs. C'est « Espaces, tabulations et fins
    de ligne », démontré au lieu d'être annoncé.
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
    C'est la diapositive « Deux chemins du texte à l'exécution », faite à la
    main. Y renvoyer explicitement : la chaîne compilée a une étape de plus,
    mais elle ne la refait pas.

    Le rapport de taille est le chiffre à faire dire. L'exécutable embarque
    de quoi tourner sans le compilateur, d'où le facteur cent ; le fichier
    Python, lui, ne peut rien faire sans l'interpréteur, qui est déjà
    installé et qu'on ne compte donc pas.

    Faire ouvrir `cpp/bonjour` dans l'éditeur pour constater qu'il est
    illisible : c'est la diapositive « Code source et fichier exécutable »,
    vérifiée par eux. Ajouter que `python` est un exécutable de la même
    espèce, ce qui referme la diapositive sur l'interpréteur.

    Le terminal est repris pour lui-même à la partie « Environnement de
    programmation », et c'est là que la notion de dossier courant est nommée.
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
      "/data/cours1/illustrations/vscode_hello.png",
      none,
      hauteur: hauteur-capture-pleine,
    )
  ]

  #legende[
    `cpp/bonjour` n'existait pas avant la deuxième commande. Le programme
    Python, lui, n'a rien laissé.
  ]

  #notes[
    Trois commandes, deux langages, une seule fenêtre : c'est aussi
    l'argument de l'éditeur de code, montré plutôt qu'énoncé.

    Faire remarquer que la sortie affichée est identique, alors que le chemin
    pour l'obtenir ne l'est pas. C'est le fil de toute la partie.
  ]
]
}
#separateur-manip(
  "Le même programme, trois façons de l'exécuter",
  annonce: "En entier, ligne à ligne, puis pas à pas en regardant les variables",
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
    Le programme est choisi pour trois raisons : il tient en six lignes, il a
    une boucle donc un état qui change, et son résultat se vérifie de tête.
    Le `hello world` n'avait aucune de ces propriétés.

    Les altitudes sont celles de la diapositive « Coloration syntaxique » :
    le même extrait, devenu un programme qui tourne. Le dire, cela ferme une
    boucle et ne coûte rien.

    Le point à poser avant la suite : ce programme ne montre que sa dernière
    ligne. Les deux façons suivantes servent précisément à voir ce qu'il fait
    entre le début et la fin.
  ]
]
#d("Python en interactif")[
  #annonce[
    Taper `python` sans nom de fichier ouvre une session interactive : chaque
    ligne est lue, exécutée, et son résultat affiché aussitôt.
  ]

  ```console
  $ python
  Python 3.12.14 | packaged by conda-forge | (main, Sep  1 2026) [GCC 14.4.0]
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
    Faire remarquer les trois chevrons : c'est l'invite de Python, et non
    celle du terminal. Confondre les deux est l'erreur de début de semestre,
    et elle produit un `SyntaxError` quand on tape une commande du système
    dans Python. Les trois points sont la suite d'un bloc commencé.

    On y entre par `python`, on en sort par `exit()` ou `Ctrl` + `D`. Le dire
    tout de suite : on ne devine pas comment sortir.

    Ce que la session apporte ici est l'accès à `total`, que le script ne
    montrait pas. Faire refaire la boucle en affichant `total` à chaque tour
    si la salle suit : 128,4 puis 259,4 puis 387,0.

    Un script se relance à l'identique et ne laisse rien à l'écran ; une
    session interactive montre tout et ne laisse rien sur le disque. Ce sont
    deux usages, pas deux niveaux.

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
    C'est la troisième façon, et celle qui restera. Les deux premières
    montrent le début et la fin ; celle-ci montre le milieu, ligne par ligne,
    sur le programme tel qu'il est écrit.

    Le réflexe à installer contre celui qu'ils ont déjà : on n'ajoute pas des
    `print` partout pour savoir ce qui se passe, on pose un point d'arrêt.
    C'est plus rapide, et cela ne laisse pas de traces à effacer ensuite.

    Ligne 4 est choisie exprès : c'est le corps de la boucle, donc l'arrêt se
    répète trois fois et `total` change sous leurs yeux. Faire prédire la
    valeur avant chaque `F10`.

    Ne pas aller plus loin. `F11` entre dans les fonctions appelées, ce qui
    n'a pas d'intérêt ici et perd tout le monde dans les entrailles de
    Python. Le débogage pour lui-même vient au cours 2.

    Raccourcis par défaut, relevés dans la documentation de VSCode et non sur
    les postes de la salle : vérifier que personne n'a un jeu de raccourcis
    modifié.
  ]
]
