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
#separateur-manip(
  "Un hello world en Python et en C++",
  annonce: "Ouvrir les deux projets dans l'éditeur, puis les exécuter depuis son terminal",
)
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
  )

  #legende[
    L'étape 5 n'affiche rien, et c'est normal : elle produit un fichier.
    Sous Windows, l'exécutable s'appelle `cpp\bonjour.exe` et se lance par
    `.\cpp\bonjour.exe`.
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

    Sous Windows, `g++` n'est pas fourni : il vient avec MinGW-w64, MSYS2 ou
    le sous-système Windows pour Linux. Prévoir un poste de démonstration si
    personne dans la salle n'en dispose.
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
