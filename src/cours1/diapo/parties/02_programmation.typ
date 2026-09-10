// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": blancs, capture-ide, souligne-ondule

// ==================== Programmation et éditeur de code =====================

#separateur("Programmation et éditeur de code")
#d("D'un programme à une application")[
  #annonce[
    Programme est souvent un logiciel. Une distinction entre les deux est 
    la façon dont ils sont distribués et ce que doit faire un utilisateur pour
    arriver à s'en servir.
  ]

  #block(width: 100%, fill: gris, inset: (x: 12pt, y: 5pt), below: 0.4em)[
    #text(size: 15pt, fill: estompe, weight: demi-gras)[Distribution]
    #v(0.25em)
    #chaine(
      ("le code source", "ce qu'on écrit"),
      ("empaquetage", "packaging"),
      ("une application", "qui s'installe"),
    )
  ]

  #block(width: 100%, fill: accent.lighten(92%), inset: (x: 12pt, y: 5pt))[
    #text(size: 15pt, fill: accent, weight: demi-gras)[Déploiement]
    #v(0.25em)
    #chaine(
      ("le code source", "ce qu'on écrit"),
      ("mise en ligne", "déploiement"),
      ("une application web", "rien à installer"),
    )
  ]

  #legende[
    C'est l'empaquetage qui change, pas le programme : le même code se distribue
    en application à installer, ou se déploie en application web.
  ]

  #notes[
    Motiver avant de définir : renommer 300 photos par leur date prend une
    soirée à la main, quelques secondes par programme ; la deuxième
    exécution ne coûte rien, et une erreur de recopie devient
    systématique, donc repérable.

    Trois mots à séparer : « programmation » nomme l'activité, « programme »
    son résultat, « application » ce que reçoit celui qui s'en sert. Aucun ne
    désigne une nature différente : c'est l'usage qui les spécialise.

    Ne pas développer l'empaquetage ni le déploiement, les mots suffisent
    aujourd'hui. Ils servent à dire qu'une application n'est pas d'une autre
    nature qu'un programme, et ils reviendront au cours 6.

    Les deux chaînes annoncent celle de « Deux chemins du texte à
    l'exécution », qui suit : même gabarit, autre question.
  ]
]

// --------------------------------------------
#d("Deux chemins du texte à l'exécution")[
  #block(width: 100%, fill: gris, inset: (x: 12pt, y: 7pt), below: 0.5em)[
    #text(size: 17pt, fill: estompe)[
      #text(weight: demi-gras)[Compilé] : le texte est traduit une fois pour
      toutes. À chaque lancement il n'y a plus rien à comprendre, donc c'est
      plus rapide.
    ]
    #v(0.3em)
    #chaine(
      ("bonjour.cpp", "le texte écrit"),
      ("compilateur", "une fois"),
      ("bonjour.exe", "des instructions"),
      ("résultat", "à chaque lancement"),
    )
  ]

  #block(width: 100%, fill: accent.lighten(92%), inset: (x: 12pt, y: 7pt))[
    #text(size: 17pt, fill: accent)[
      #text(weight: demi-gras)[Interprété] : le texte est lu et exécuté à chaque
      lancement. Comprendre le code est donc refait à chaque fois.
    ]
    #v(0.3em)
    #chaine(
      ("bonjour.py", "le texte écrit"),
      ("interpréteur", "à chaque lancement"),
      ("résultat", "rien sur le disque"),
    )
  ]

  #legende[
    Lancer un programme Python ne crée rien sur le disque : il n'y a pas
    d'exécutable à produire.
  ]

  #notes[
    La chaîne compilée a une étape de plus, faite une fois ; l'interprétée
    en a une de moins, refaite à chaque exécution.

    Semer le facteur ×100 à ×1000 du cours 6 et du TD 7 : `numpy` délègue
    à du C compilé. Ne pas développer.

    Les noms de fichiers sont ceux de la manipulation à venir ; le dire
    une fois.

    Si question « Et Java ? » répondre en une phrase, les deux à la
    fois comme js et JIT
  ]
]

// --------------------------------------------
#d("Du code source aux instructions machine")[
  #annonce[
    Compiler enchaîne quatre étapes. Au bout, des instructions que le
    processeur exécute telles quelles.
  ]

  #chaine(
    ("préprocesseur", "un seul texte"),
    ("compilateur", "de l'assembleur"),
    ("assembleur", "des instructions machine"),
    ("éditeur de liens", "un exécutable"),
  )

  #v(0.5em)
  #face-a-face(
    panneau("Ce qu'a écrit un humain")[
      ```cpp
      int largeur = 1920;
      int hauteur = 1080;
      return largeur * hauteur;
      ```
    ],
    panneau("Ce que le processeur exécute")[
      ```
      mov   DWORD PTR -8[rbp], 1920
      mov   DWORD PTR -4[rbp], 1080
      mov   eax,  DWORD PTR -8[rbp]
      imul  eax,  DWORD PTR -4[rbp]
      ```
    ],
  )

  #legende[
    Une instruction machine fait une opération élémentaire : `mov` copie une
    valeur, `imul` en multiplie deux. Le processeur les exécute telles quelles,
    là où un interpréteur doit d'abord lire et analyser la ligne.
  ]

  #notes[
    Les quatre étapes sont celles que documente GCC : « Compilation can involve
    up to four stages: preprocessing, compilation proper, assembly and linking,
    always in that order. » Ne pas détailler l'éditeur de liens : il suffit de
    dire qu'il rassemble le programme et les bibliothèques en un seul fichier.

    L'assembleur affiché est celui que produit vraiment `g++` sur le code de
    gauche, il se refait :
    `g++ -S -O0 -masm=intel -fno-asynchronous-unwind-tables surface.cpp -o -`.
    Les quatre lignes correspondent aux trois du source.

    Lire une ligne à voix haute pour montrer qu'il n'y a rien de mystérieux :
    `mov DWORD PTR -8[rbp], 1920` veut dire « écris 1920 à cet emplacement de
    la mémoire ». `-8[rbp]` est une adresse, calculée à partir du repère `rbp`.

    D'où la différence de vitesse, si la question vient : les deux chemins
    finissent par les mêmes opérations élémentaires, mais l'interprété refait
    l'analyse du texte à chaque exécution, et à chaque tour de boucle.

    L'exécutable de `python3` est arrivé au bout de ce chemin : ce qui exécute
    du texte est soi-même un binaire. C'est la diapositive suivante. Le contenu
    d'un exécutable, octet par octet, est ouvert au cours 3.
  ]
]

// --------------------------------------------
#d("La place de l'interpréteur")[
  #annonce[
    L'interpréteur lit le texte du programme, et c'est lui qui s'adresse au
    système. Un programme compilé s'en passe : il est déjà en instructions
    machine.
  ]

  #couche(
    icone-fenetre(taille: 30pt), "Programme interprété",
    "bonjour.py, une page web", plein: true,
  )
  #liaison("son texte", "le résultat")
  #couche(
    icone-fenetre(taille: 30pt), "Interpréteur : traduit en bytecode, puis l'exécute",
    "python, le navigateur",
  )
  // `raw` tomberait à 0,78 em, soit 10,5 pt : trop petit à la projection.
  #liaison(
    [un appel système : #text(font: police-code)[open], #text(font: police-code)[read]],
    [des octets],
  )
  #couche(
    icone-engrenage(taille: 30pt), "Système d'exploitation",
    "Windows, macOS, Linux",
  )

  #legende[
    Le bytecode n'est pas des instructions machine : l'interpréteur l'exécute
    lui-même.
  ]

  #notes[
    Insister sur la différence entre les deux flèches descendantes, c'est le
    point de la diapositive. En haut circule du texte. En bas circulent des
    appels système, les mêmes que ceux de la partie 1 : l'interpréteur les fait
    à la place du programme, et un exécutable compilé les fait lui-même,
    `bonjour.exe` compris. Le bytecode, lui, ne circule sur aucune des deux
    flèches : il reste à l'intérieur de l'interpréteur.

    Ce que « traduit en bytecode » recouvre, si la question vient : `python`
    traduit le texte entier avant d'exécuter quoi que ce soit, en instructions
    d'une machine virtuelle qui n'existe que dans `python`. Le processeur, lui,
    ne connaît que les instructions machine de la diapositive précédente.
    `python -m dis bonjour.py` affiche ce bytecode ; les fichiers `.pyc` du
    dossier `__pycache__` en sont la version gardée sur le disque, pour ne pas
    refaire la traduction au lancement suivant.

    `open` et `read` sont les noms POSIX, ceux de macOS et de Linux ; Windows
    appelle les siens `CreateFile` et `ReadFile`. Les noms diffèrent, la nature
    de l'échange non. Ne le dire que si la question vient.

    Un interpréteur est un programme comme les autres. Celui de Python
    s'appelle `python`, et c'est son exécutable dont l'assembleur vient d'être
    montré. Ce qui exécute du texte est soi-même en instructions machine.

    Conséquence pratique : lancer un programme Python suppose Python
    installé, alors qu'un exécutable compilé se lance seul. C'est ce que
    la manipulation fera constater, et pourquoi la partie « Environnement
    de programmation » existe.

    Le navigateur interprète trois langages sans qu'on l'appelle «
    interpréteur » : le mot désigne un rôle, pas une catégorie de
    logiciel.
  ]
]

// --------------------------------------------
#d("Les fonctions d'un IDE")[
  #annonce[
    IDE, pour _integrated development environment_ : un logiciel qui réunit
    des fonctions pour aider à l'écriture, test et partage de code.
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
    [Connaître le langage],
      [certains IDE n'en servent qu'un ; d'autres s'étendent par extensions],
  )

  #avertissement[
    Un IDE ne contient pas forcément l'interpréteur ni le compilateur. Ils
    s'installent à part, et se configurent pour chaque langage et chaque
    système.
  ]

  #notes[
    Un éditeur de texte ordinaire ne fait que la première ligne du tableau.
    C'est l'intégration des autres qui fait l'environnement.

    L'avertissement est celui qui coûte le plus cher en séance : le bouton
    d'exécution est dans l'éditeur, pas l'outil qu'il appelle. La documentation
    de VSCode le dit pour le C++ : « The C/C++ extension doesn't include a C++
    compiler or debugger, since VS Code as an editor relies on command-line
    tools for the development workflow. » D'où la diapositive « De quoi
    compiler du C++ », et la partie « Environnement de programmation ».

    Sur la dernière ligne du tableau : un IDE donne « special support for one or
    more programming languages », et le support des autres langages passe le
    plus souvent par des greffons (Wikipédia, _Integrated development
    environment_). Exemples si la question vient : RStudio ou l'IDE Arduino ne
    servent qu'un langage, Eclipse et VSCode s'étendent.

    Débogage et panneau git sont nommés, pas montrés : cours 2.

    Microsoft présente VSCode comme un éditeur plutôt que comme un IDE,
    ses fonctions avancées venant d'extensions. Ne pas s'y attarder si la
    question ne vient pas.
  ]
]

// --------------------------------------------
#d("Les fonctions d'édition de texte d'un IDE")[
  #annonce[
    Programmer nécessite d'éditer des fichiers texte sans 'faute'.
    L'éditeur sert à rendre cela plus simple et rapide.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Dans un éditeur de texte ordinaire], [Dans un éditeur de code],
    [une faute de frappe se découvre à l'exécution],
      [elle est soulignée pendant la frappe],
    [on cherche un fichier dans l'explorateur],
      [l'arborescence et la recherche sont dans la fenêtre],
    [une indentation fausse ne se voit pas],
      [les espaces s'affichent],
  )

  #legende[
    La colonne de droite est ce que cette partie détaille, ligne après ligne.
  ]

  #notes[
    Tout ce qui sera produit cette année passe par l'édition d'un fichier
    texte : le programme, ses réglages, sa documentation, et jusqu'à ce
    que git doit ignorer.

    La colonne de gauche n'est pas une caricature : c'est ce que fait
    quelqu'un qui écrit son code dans le Bloc-notes, et plusieurs l'auront
    fait au lycée. Montrer ce que cela coûte, sans se moquer.
  ]
]

// --------------------------------------------
#d("Texte brut et règles du langage")[
  #annonce[
    Un langage a une syntaxe définie. L'éditeur la connaît, par une extension,
    et colore chaque catégorie de mot sans rien ajouter au fichier.
  ]

  #grid(
    columns: (1.15fr, 0.9fr, 0.95fr), column-gutter: 18pt,
    // Volontairement sans coloration : seule la colonne de droite en porte,
    // sans quoi la comparaison ne montrerait plus rien.
    panneau("Enregistré par un traitement de texte")[
      #raw(
        "<text:p text:style-name=\"P1\">\naltitude = 128.4</text:p>\n<text:p>print(altitude)</text:p>",
        block: true,
      )
    ],
    panneau("Le fichier d'un programme")[
      #raw("altitude = 128.4\nprint(altitude)", block: true)
    ],
    panneau("Affiché par l'éditeur de code")[
      ```python
      altitude = 128.4
      print(altitude)
      ```
    ],
  )

  #v(0.5em)
  #annonce[
    Il souligne de même ce qui ne suit pas ces règles, sans rien lancer.
  ]

  #grid(
    columns: (auto, 1fr), column-gutter: 22pt, align: horizon,
    block(
      inset: (x: 18pt, y: 9pt), fill: gris,
      stroke: 1pt + accent.lighten(62%),
    )[
      #set text(size: 21pt)
      #set align(left)
      #raw("altitudes = [128.4, 131.0]") \
      #raw("for altitude in ")#souligne-ondule[#raw("altitudes")] \
      #raw("    print(altitude)")
    ],
    text(size: 16pt, fill: estompe)[
      Le deux-points manque. Sans l'éditeur, la faute n'apparaîtrait qu'au
      lancement : #raw("SyntaxError: expected ':'").
    ],
  )

  #notes[
    Deux services tirés de la même chose, les règles écrites du langage : la
    couleur, puis le soulignement.

    À gauche, le `content.xml` ouvert en début de séance, le texte noyé dans
    les balises. La règle, sans nuance : on n'écrit jamais de code dans Word ni
    dans LibreOffice. 

    Au milieu et à droite, le même fichier, octet pour octet. Ouvrir le même
    fichier dans le Bloc-notes le montre en une seconde.

    Faire nommer par la salle ce que la couleur distingue : les mots du langage
    et les fonctions connues, les nombres, le texte entre guillemets, les noms
    qu'on choisit.

    Sur le soulignement : un correcteur orthographique souligne le mot pendant
    qu'on tape, il n'attend pas l'impression. L'éditeur fait de même. Message
    relevé sous Python 3.12 ; il désigne ici la bonne ligne, ce qui n'est pas
    toujours le cas 

    Sur la chasse fixe : toutes les lettres y ont la même largeur, alors qu'une
    police proportionnelle fait le `i` plus étroit que le `m`. L'intérêt n'est
    pas esthétique — elle rend les espaces comptables, trois se distinguent de
    quatre et une tabulation se repère, ce dont Python a besoin. Ne pas
    confondre l'indentation, qui est dans le fichier et compte, avec la
    coloration et la police, qui n'y sont pas.

    Un langage a beaucoup moins d'exceptions que l'orthographe du français. 
    C'est ce qui rend la vérification automatique possible : 
    on ne peut pas écrire un logiciel qui corrige un
    texte français de façon sûre, on peut en écrire un qui vérifie un programme.
  ]
]

#d("Chasse fixe et chasse proportionnelle")[
  #annonce[
    Un éditeur de code emploie une police à chasse fixe, où toutes les lettres
    ont la même largeur. Le même programme dans la police d'un traitement de
    texte :
  ]

  #face-a-face(
    panneau("Chasse fixe (éditeur de code)")[
      #raw("def surface(longueur, largeur):\n    aire = longueur * largeur\n    if aire > 250:\n        categorie = \"grande\"\n    else:\n        categorie = \"petite\"\n    return aire, categorie", block: true)
    ],
    // Le même texte, à la même taille, dans la police du corps : seules les
    // largeurs de caractère changent.
    panneau("Chasse proportionnelle (traitement de texte)")[
      #{
        show raw: set text(font: police-texte)
        raw("def surface(longueur, largeur):\n    aire = longueur * largeur\n    if aire > 250:\n        categorie = \"grande\"\n    else:\n        categorie = \"petite\"\n    return aire, categorie", block: true)
      }
    ],
  )

  #legende[
    Même texte, même taille, deux polices. À droite, rien ne dit de combien
    chaque ligne est décalée.
  ]

  #notes[
    Faire chercher par la salle ce qui se perd à droite avant de le dire :
    l'entrée du `if`, celle du `else`, et le fait que `categorie` est au même
    niveau des deux côtés.

    L'intérêt de la chasse fixe n'est pas esthétique. Python compte les
    espaces qui commencent une ligne ; il faut donc les voir. Une police
    proportionnelle fait le `i` plus étroit que le `m`, et deux lignes
    décalées pareil ne le paraissent plus.

    Ne pas confondre l'indentation, qui est dans le fichier et compte, avec
    la police et la coloration, qui n'y sont pas.

    Lien avec LibreOffice, manipulé en début de séance : on y choisit une
    police pour la mise en page ; ici on la subit pour une raison technique.
  ]
]

#d("L'indentation, en espaces ou en tabulation")[
  #annonce[
    Un espace et une tabulation sont deux caractères différents. Une
    tabulation vaut le nombre de colonnes que l'éditeur lui donne, et ce
    réglage change d'un éditeur à l'autre.
  ]

  #face-a-face(
    panneau("Tabulation réglée sur 4 colonnes")[
      #blancs[#raw("def surface(longueur, largeur):\n····aire = longueur * largeur\n→   return aire", block: true)]
      #v(0.3em)
      #text(size: 14pt, fill: estompe)[les deux lignes semblent alignées]
    ],
    panneau("Le même fichier, tabulation sur 8")[
      #blancs[#raw("def surface(longueur, largeur):\n····aire = longueur * largeur\n→       return aire", block: true)]
      #v(0.3em)
      #text(size: 14pt, fill: manip)[le décalage apparaît]
    ],
  )

  #legende[
    `·` marque un espace, `→` une tabulation, comme l'éditeur les dessine.
    Les octets du fichier sont les mêmes des deux côtés : seul le réglage de
    l'éditeur change.
  ]

  #notes[
    Les deux lignes sont celles de `data/cours1/erreurs/python/surface.py` :
    la cinquième indentée par quatre espaces, la sixième par une tabulation.
    C'est le fichier que la manipulation fera corriger ; le message d'erreur
    s'y lit à ce moment, ne pas le projeter ici.

    Python refuse ce mélange dans une même indentation, et le dit par
    `TabError`. Le message ne parle pas d'espace manquant : il dit que
    l'indentation mélange deux caractères. À l'œil nu, sur un éditeur réglé
    sur 4, rien ne se voit — c'est ce que montre la colonne de gauche.

    Le réglage se lit en bas à droite de l'éditeur, `Spaces: 4`. L'extension
    Python l'impose à 4, convention du langage ; un fichier venu d'ailleurs
    peut être écrit autrement.

    Ne pas montrer ici comment afficher les blancs : la manipulation s'en
    charge, et c'est un geste qui se fait, pas qui se regarde.

    Fins de ligne, à dire en passant : Windows en met deux (`CRLF`), Linux et
    macOS un seul (`LF`). Un même fichier n'a donc pas la même taille selon la
    machine, et une comparaison peut signaler toutes les lignes comme
    modifiées. Repris au cours 2 avec git.

    Le saut de ligne est un caractère comme les autres : « Ce que contient un
    fichier texte », en annexe, le compte sur un poème tenant sur une ligne.
  ]
]
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


#separateur-manip(
  "Le même programme en C++",
  annonce: "Configurer l'éditeur pour un second langage : l'extension, le compilateur, puis la compilation",
  dossier: "data/cours1/hello/cpp/",
)
#d("Installer l'extension C/C++")[
  #annonce[
    Un autre langage demande une autre extension. Celle-ci apporte la
    coloration, la vérification et un bouton d'exécution pour C et C++.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Le geste], [Ce qu'il donne],
    [`Ctrl` + `Maj` + `X`, chercher « C/C++ »],
      [l'extension publiée par Microsoft, à installer],
    [Rouvrir `cpp/bonjour.cpp`],
      [le code se colore, et les fautes d'écriture se soulignent],
  )

  #avertissement[
    L'extension n'apporte pas de compilateur. Elle sait lire le C++, pas le
    traduire : c'est l'objet de la diapositive suivante.
  ]

  #notes[
    C'est l'exemple qui généralise : un éditeur générique se configure langage
    par langage, et le geste est le même que pour Python.

    L'avertissement est écrit dans la documentation de VSCode : « The C/C++
    extension doesn't include a C++ compiler or debugger, since VS Code as an
    editor relies on command-line tools for the development workflow. »
    C'est la confusion la plus coûteuse de la séance.
  ]
]
#d("Installer un compilateur")[
  #annonce[
    Python vient avec l'environnement du module. Un compilateur C++, non :
    Windows n'en fournit aucun.
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
    L'environnement conda ne sert pas qu'à Python : il installe aussi des
    outils. On passe par lui parce qu'il est déjà là, et qu'il évite de
    toucher aux réglages de la machine.
  ]

  #notes[
    À faire avant la séance si possible : quelques minutes, et le réseau de la
    salle n'est pas garanti. À défaut, lancer l'installation au début de la
    manipulation et enchaîner sur autre chose pendant ce temps.

    Le chemin officiel n'est pas celui-là. La documentation de VSCode fait
    installer MinGW-w64 par MSYS2, puis ajouter `C:\msys64\ucrt64\bin` au
    `PATH` de Windows. Il fonctionne, mais il modifie la machine et demande une
    installation de plus ; le module préfère l'environnement conda, déjà
    présent et supprimable d'un seul geste. Le dire si la question vient, et
    surtout si un étudiant arrive avec MSYS2 déjà installé : dans ce cas la
    commande est `g++`, comme sous Linux.

    Le nom de l'exécutable est le piège, à projeter : sous Windows,
    conda-forge installe `x86_64-w64-mingw32-g++.exe`, pas `g++`. C'est le nom
    complet de la cible, et il ne s'invente pas. Relevé dans le contenu du
    paquet `gxx_win-64` ; non confirmé sur une machine Windows, à vérifier
    avant la séance.

    Ne pas employer `m2w64-toolchain`, encore présent dans de vieilles réponses
    en ligne : le paquet s'annonce lui-même obsolète.
  ]
]
#d("Compiler, puis lancer")[
  #annonce[
    Deux commandes au lieu d'une : la première produit un fichier, la seconde
    exécute ce fichier.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [Terminal #sym.arrow.r Nouveau terminal, dans `data/cours1/hello/`],
    [2], [taper `g++ cpp/bonjour.cpp -o cpp/bonjour`, puis Entrée],
    [3], [taper `cpp/bonjour`, puis Entrée],
    [4], [en option : mettre tout `bonjour.cpp` sur une seule ligne, recompiler],
  )

  #legende[
    L'étape 2 n'affiche rien, et c'est normal : elle produit un fichier. Sous
    Windows, la commande est `x86_64-w64-mingw32-g++`, le fichier produit
    s'appelle `cpp\bonjour.exe` et se lance par `.\cpp\bonjour.exe`.
  ]

  #notes[
    Étape 2 : rien ne s'affiche, la question vient. Faire regarder
    l'arborescence à gauche, où `cpp/bonjour` vient d'apparaître. C'est la
    différence avec Python, qui n'a rien laissé.

    Le bouton d'exécution existe aussi pour le C++, « Run C/C++ File » : il
    demande le compilateur au premier lancement et écrit un `tasks.json`. Ne
    pas l'employer en séance, mais savoir répondre.

    Étape 4, facultative : tout `bonjour.cpp` tient sur une ligne —
    `#include <iostream>` doit rester seul, c'est une directive — et le
    programme compile et affiche la même chose. Le compilateur ne voit pas les
    retours à la ligne, seulement les points-virgules et les accolades. Faire
    ensuite tenter la même chose sur un programme Python à boucle : cela
    échoue. C'est « Espaces, tabulations et fins de ligne » démontré.
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
  "Extensions de langage et programmes fautifs",
  annonce: "Installer l'extension d'un langage, puis corriger trois fichiers qui refusent de s'exécuter",
  dossier: "data/cours1/erreurs/",
)

#d("Afficher les caractères invisibles")[
  #annonce[
    Un espace et une tabulation ne se distinguent pas à l'œil. L'éditeur sait
    les dessiner, et dire ce qu'il insère.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Le geste], [Ce qu'il donne],
    [`View` #sym.arrow.r `Render Whitespace` #sym.arrow.r `All`],
      [un point médian par espace, une flèche par tabulation],
    [`Spaces: 4`, dans la barre d'état],
      [ce que la touche de tabulation insère ; cliquer dessus pour le changer],
    [`LF` ou `CRLF`, dans la barre d'état],
      [comment les lignes se terminent : un caractère sous Linux et macOS, deux sous Windows],
    [`Ctrl` + `Maj` + `P`, puis « render whitespace »],
      [la même bascule sans passer par les menus],
  )

  #legende[
    Les intitulés sont ceux de l'interface en anglais, celle qu'on a par
    défaut. En français : Affichage #sym.arrow.r Rendu des espaces #sym.arrow.r Tout.
  ]

  #notes[
    Le faire faire, machine ouverte, avant de projeter la diapositive suivante :
    c'est un geste, pas une explication.

    À laisser activé toute l'année. C'est le seul moyen de voir qu'une
    indentation mélange espaces et tabulations, et cela reviendra au cours 2
    quand git signalera des lignes modifiées qui semblent identiques.

    La barre d'état est en bas à droite. `Spaces: 4` se règle par fichier ;
    l'extension Python la met à 4 d'elle-même, ce qui est la convention du
    langage.

    Les fins de ligne : un fichier n'a pas la même taille selon la machine qui
    l'a écrit. Nommer `LF` et `CRLF` aujourd'hui suffit, le cours 2 y revient.
  ]
]

// Sans capture, cette diapositive n'ajouterait rien au bloc de la précédente.
#if captures-disponibles {
d("Les caractères invisibles, affichés")[
  #annonce[
    Les mêmes lignes, une fois l'affichage des espaces activé : la deuxième est
    indentée par quatre espaces, la troisième par une tabulation.
  ]

  #align(center)[
    #illustration(
      "/illustrations/cours1/vscode_espaces.png",
      none,
      hauteur: hauteur-capture-pleine,
    )
  ]

  #legende[
    Un point par espace, une flèche par tabulation. En bas à droite,
    `Spaces: 4` et `LF`.
  ]

  #notes[
    Faire pointer la ligne 3 par la salle avant de la désigner : c'est la
    seule qui diffère, et elle ne se distingue pas sans cet affichage.

    Le message d'erreur désigne la bonne ligne. Lire le numéro de ligne
    d'une erreur est un réflexe à prendre aujourd'hui.
  ]
]
}
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
    Ouvrir le dossier des programmes fautifs, installer l'extension Python,
    puis rouvrir les fichiers.
  ]

  #tableau(
    columns: (1.1fr, 1fr),
    align: left + horizon,
    [Le geste], [Ce que vous observez],
    [Ouvrir `python/surface.py` dans LibreOffice Writer, puis lui donner une
     police à chasse fixe],
      reponse[les colonnes s'alignent, comme dans l'éditeur],
    [Fichier #sym.arrow.r Ouvrir le dossier, sur `data/cours1/erreurs/`],
      [trois fichiers, deux `.py` et un `.cpp`],
    [Ouvrir `python/surface.py` avant toute installation],
      reponse[le texte est coloré : l'éditeur connaît déjà Python],
    [`Ctrl` + `Maj` + `X`, chercher `ms-python.python`, installer],
      reponse[une ligne se souligne, sans que rien ait été exécuté],
    [Ouvrir `cpp/aire.cpp`],
      reponse[l'éditeur propose l'extension C/C++ correspondante],
  )

  #legende[
    Les trois fichiers sont fautifs volontairement. Travailler sur eux
    directement : ils sont remis en état après la séance.
  ]

  #notes[
    Première ligne : vérifier de leurs mains ce que « Ce que l'éditeur
    ajoute au texte » a montré. Format #sym.arrow.r Caractère, puis une
    police à chasse fixe — Liberation Mono ou DejaVu Sans Mono sont
    présentes partout. L'éditeur fait ce choix d'office.

    Troisième ligne, la surprise voulue : la coloration ne vient pas de
    l'extension, elle est fournie d'origine pour les langages courants. Ce
    que l'extension apporte est la ligne suivante, le soulignement.

    Si la question de l'identifiant revient, enchaîner sur « Extension de
    fichier et extension de VSCode ».

    L'éditeur n'a pas pu être piloté sur le poste de préparation : les
    deux dernières lignes viennent de la documentation de VSCode et
    restent à vérifier en salle, notamment la proposition automatique
    d'extension, qui dépend d'un réglage.

    Poste sans réseau : les extensions ne s'installent pas, la suite se
    fait quand même, sans le soulignement.
  ]
]

#d("Corriger trois programmes")[
  #annonce[
    Chacun des trois fichiers porte une faute d'écriture d'un genre différent.
    Lancer, lire le message, corriger, relancer.
  ]

  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [Fichier], [Ce que dit le message], [La faute],
    [`python/surface.py`],
      [`TabError: inconsistent use of tabs and spaces`, ligne 6],
      reponse[la ligne 6 est indentée par une tabulation, la ligne 5 par des espaces],
    [`python/moyenne.py`],
      [`SyntaxError: expected ':'`, ligne 6],
      reponse[il manque les deux-points à la fin du `for`],
    [`cpp/aire.cpp`],
      [`error: expected ‘,’ or ‘;’ before ‘std’`, ligne 7],
      reponse[il manque le point-virgule à la fin de la ligne 6],
  )

  #legende[
    Messages réels, obtenus avec Python 3.12.14 et g++ 13.3. Une fois corrigés,
    les trois programmes affichent `294.0`, `130.05` et `294`.
  ]

  #notes[
    L'ordre des trois fautes est celui de leur difficulté de lecture ; le
    suivre.

    La première ne se voit pas à l'œil, les deux lignes étant alignées à
    l'écran. C'est là qu'on fait activer l'affichage des espaces,
    Affichage #sym.arrow.r Rendu des espaces #sym.arrow.r Tout. Réglage à
    garder toute l'année.

    La deuxième se voit dans le message, qui nomme le caractère attendu et
    place un accent circonflexe sous l'endroit exact. Faire lire le
    message en entier.

    La troisième désigne la ligne 7 pour une faute ligne 6 : «
    Vérification de l'écriture », vérifiée par eux.

    La vérification demandée n'est pas que le programme affiche le bon
    résultat, mais qu'il n'affiche plus de message.

    Sous Windows sans compilateur, le fichier C++ se lit et se corrige
    mais ne se compile pas.
  ]
]
