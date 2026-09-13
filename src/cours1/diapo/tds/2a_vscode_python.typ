// TD 2a du cours 1 — « Configurer l'éditeur de code, et lancer un programme ».
//
// Inclus par `cours1.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": capture-ide

#let td = (
  numero: "2a",
  titre: "Configurer l'éditeur de code, et lancer un programme",
  annonce: "Lancer VS Code, le relier à l'environnement Python du module, puis exécuter un programme de trois façons : en entier, ligne à ligne, pas à pas",
  dossier: "cours1/2a_vscode_python/",
  duree: "25′",
)
#separateur-td(..td)
#d("Visual Studio Code")[
  #align(center, capture-ide(hauteur: 330pt))

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

#d("Lancer VS Code depuis Anaconda")[
  #annonce[
    Sur les postes de la salle, VS Code se lance depuis Anaconda Navigator :
    il part alors dans l'environnement choisi, sans rien configurer.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Le geste], [Ce que vous observez],
    [1], [menu Démarrer #sym.arrow.r Anaconda Navigator], [la page d'accueil, une tuile par application],
    [2], [en haut, la liste déroulante des environnements : choisir `info01`], reponse[les tuiles se rechargent pour cet environnement],
    [3], [tuile VS Code #sym.arrow.r Launch], reponse[VS Code s'ouvre ; en bas à droite, la barre d'état nomme `info01`],
    [4], [Terminal #sym.arrow.r Nouveau terminal, taper `python --version`], reponse[le Python de `info01`, sans message d'erreur],
  )

  #legende[
    L'autre chemin, VS Code lancé depuis le bureau, marche aussi — mais son
    terminal demande un réglage, plus loin dans ce TD.
  ]

  #notes[
    Doc Anaconda, « Visual Studio Code » : « launch the application from
    Navigator 1.9.12 or later by clicking the VS Code tile on the Home
    page » ; « it will automatically use the Python interpreter in the
    currently selected environment ». D'où l'étape 2 avant l'étape 3 : lancé
    depuis `base`, VS Code arrive dans `base`.

    Ce que la doc ne dit pas, et qui est à vérifier sur un poste de la salle
    avant la séance : l'étape 4. Navigator lance VS Code avec les variables
    de l'environnement choisi ; le terminal intégré en hérite, et `python`
    devrait être le bon sans qu'aucun script d'activation ne tourne. Si
    PowerShell affiche quand même une erreur `activate.ps1`, appliquer le
    réglage de la diapositive « VS Code hors Anaconda ».

    L'extension Python n'est pas installée par Navigator : c'est l'objet de
    la diapositive suivante. Sur un poste où elle l'est déjà, la barre
    d'état nomme l'interpréteur dès l'ouverture.

    Ne pas ouvrir Spyder ni Jupyter depuis Navigator aujourd'hui : une
    application, un TD.
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

    C'est ce que le TD 5a, « Les premiers octets d'un fichier », fait
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
    Ouvrir le dossier du TD, puis installer l'extension Python :
    c'est elle qui fera tout ce qui suit.
  ]

  #tableau(
    columns: (1.1fr, 1fr),
    align: left + horizon,
    [Le geste], [Ce que vous observez],
    [Fichier #sym.arrow.r Ouvrir le dossier, sur `cours1/2a_vscode_python/`],
      [deux programmes, `bonjour.py` et `altitudes.py`, et un `README.md`],
    [Ouvrir `bonjour.py` avant toute installation],
      reponse[le texte est déjà coloré : l'éditeur connaît Python de naissance],
    [`Ctrl` + `Maj` + `X`, chercher `ms-python.python`, installer],
      reponse[Pylance et le débogueur s'installent avec, et la barre d'état
              propose un interpréteur],
  )

  #legende[
    Une extension s'installe une fois pour toutes : elle sera là aux séances
    suivantes, et pour les autres cours.
  ]

  #notes[
    C'est le premier geste de la séance sur l'éditeur, et il sert partout
    ensuite : le choix de l'interpréteur, le lancement, le débogueur pas à
    pas, et le TD des programmes fautifs en fin de partie.

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
    car la suite du TD en dépend cette fois.
  ]
]
#d("La palette de commandes et les réglages")[
  #annonce[
    Tout ce que VS Code sait faire est une commande, qu'on trouve en tapant
    son nom ; tout ce qui se règle est un réglage, qu'on trouve de même.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [], [Raccourci], [Ce qu'on y fait],
    [La palette de commandes], [`Ctrl` + `Maj` + `P`], [taper le début d'un nom : « Python: Select Interpreter », « Developer: Reload Window »],
    [Les réglages], [`Ctrl` + `,`], [chercher un mot : « default profile », « render whitespace » ; chaque réglage a un nom `a.b.c`],
    [Les extensions], [`Ctrl` + `Maj` + `X`], [chercher un identifiant : `ms-python.python`],
    [Le terminal], [`Ctrl` + `ù`, ou menu Terminal], [ouvrir, masquer, rouvrir],
    [Le fichier `settings.json`], [palette, « Open User Settings (JSON) »], [les mêmes réglages, écrits en texte],
  )

  #legende[
    Les réglages ont deux niveaux : *User*, pour vous sur ce poste, et
    *Workspace*, rangé avec le projet dans `.vscode/settings.json`. Les intitulés
    sont ceux de l'interface en anglais.
  ]

  #notes[
    La palette est le geste qui rend l'éditeur apprenable : on n'a pas à
    savoir où est un menu, on tape ce qu'on veut. Toutes les consignes du
    module passent par elle, à commencer par le choix de l'interpréteur.

    Les réglages sont des fichiers texte, `settings.json` : c'est ce qui
    permet de donner un réglage par écrit — diapositive « VS Code hors
    Anaconda » — et de le versionner avec un projet quand il est au niveau
    Workspace. Ouvrir le JSON une fois devant eux, sans y écrire.

    `Ctrl` + `ù` est le raccourci du terminal sur un clavier français
    (#raw("Ctrl+`") sur un clavier américain) : à vérifier sur les postes,
    le menu Terminal fait la même chose.

    « Developer: Reload Window » sert quand une extension vient d'être
    installée ou un réglage changé et que rien ne bouge : c'est la doc
    Anaconda elle-même qui le conseille pour un environnement qui
    n'apparaît pas dans la liste.
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
    `conda activate` — à condition que le terminal s'y prête, c'est la
    diapositive suivante.

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
#d("VS Code hors Anaconda : changer de terminal")[
  #annonce[
    Lancé depuis le bureau, VS Code ouvre un terminal PowerShell, qui refuse le
    script d'activation. Sans droits d'administrateur, on lui donne le terminal
    de l'Anaconda Prompt.
  ]

  #block(width: 100%, inset: (x: 10pt, y: 6pt), fill: gris)[
    #set text(size: 13pt)
    #raw("… \\activate.ps1 cannot be loaded because running scripts is disabled on this system.")
  ]

  #v(0.2em)
  #text(size: 14pt, fill: estompe)[Palette, « Open User Settings (JSON) », puis ajouter :]
  #block(width: 100%, inset: (x: 10pt, y: 7pt), fill: gris,
         stroke: 0.8pt + gris.darken(15%))[
    #set text(size: 15.5pt)
    #raw(lang: "json", "\"terminal.integrated.profiles.windows\": {\n  \"Anaconda Prompt\": {\n    \"path\": \"C:\\\\Windows\\\\System32\\\\cmd.exe\",\n    \"args\": [\"/K\", \"C:\\\\ProgramData\\\\anaconda3\\\\Scripts\\\\activate.bat\", \"C:\\\\ProgramData\\\\anaconda3\"]\n  }\n},\n\"terminal.integrated.defaultProfile.windows\": \"Anaconda Prompt\"")
  ]

  #legende[
    Les chemins d'Anaconda sont ceux du raccourci « Anaconda Prompt » : clic
    droit #sym.arrow.r Propriétés #sym.arrow.r Cible. Puis ouvrir un nouveau
    terminal : l'invite commence par `(base)`, puis `(info01)`.
  ]

  #notes[
    Le message vient de la stratégie d'exécution de PowerShell, `Restricted`
    par défaut sous Windows. L'issue vscode-python #2559 en fait le tour, et
    ses solutions ont chacune une condition : `Set-ExecutionPolicy
    RemoteSigned -Scope CurrentUser` marche sans droits d'administrateur,
    sauf si une stratégie de groupe fixe la politique, ce qui est le cas
    probable en salle ; un profil PowerShell lancé avec `-ExecutionPolicy
    ByPass` et `conda-hook.ps1` (dernier message utile du fil) est dans le
    même cas ; le mécanisme d'activation par variables d'environnement de
    l'extension (#11039, par défaut depuis fin 2023) n'exécute aucun script,
    mais la version installée sur les postes a montré l'erreur. D'où `cmd` :
    `activate.bat` n'est pas soumis à la stratégie, c'est ce que fait le
    raccourci Anaconda Prompt, et c'est la solution que les promotions
    précédentes avaient trouvée.

    Le chemin `C:\ProgramData\anaconda3` vaut pour une installation
    « tous les utilisateurs » ; une installation personnelle est dans
    `C:\Users\<nom>\anaconda3`. Ne pas le deviner : le lire dans la cible
    du raccourci, qui contient la ligne complète à recopier.

    À faire une fois par poste, au niveau User. Les guillemets et les
    doubles barres obliques inverses sont ceux du format JSON, à recopier
    tels quels ; si `settings.json` contient déjà des réglages, ajouter
    ceux-ci avant l'accolade finale, séparés par une virgule.

    Variante plus simple si `conda` répond déjà dans un `cmd` ordinaire du
    poste : `"terminal.integrated.defaultProfile.windows": "Command Prompt"`
    suffit. Essayer d'abord celle-là.

    Sous macOS et Linux, rien de tout cela : le terminal de l'éditeur est
    un shell ordinaire, et l'activation ne pose pas de problème.
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
    [1], [Fichier #sym.arrow.r Ouvrir le dossier, puis choisir `cours1/2a_vscode_python/`],
    [2], [`Ctrl` + `Maj` + `P`, « Python: Select Interpreter », choisir `info01`],
    [3], [Terminal #sym.arrow.r Nouveau terminal : il s'ouvre en bas, dans `2a_vscode_python/`, l'invite commence par `(info01)`],
    [4], [taper `python bonjour.py`, puis Entrée],
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
    rien sur le disque. C'est vérifié pour de bon au TD 2c, facultatif,
    quand le C++ produira un fichier.

    Le bouton exécute avec l'interpréteur sélectionné, pas forcément celui du
    module : c'est l'origine du `ModuleNotFoundError` annoncé à la partie 3. Le
    montrer après le terminal, jamais avant.
  ]
]
#d("Le programme du TD")[
  #annonce[
    Six lignes qui calculent une moyenne d'altitudes, sans rien emprunter à
    personne. Il tient à l'écran, et son résultat se vérifie de tête.
  ]

  #face-a-face(
    panneau[`altitudes.py`][
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
      $ python altitudes.py
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
    Dans le même terminal, taper `python` sans nom de fichier ouvre une session
    interactive : chaque ligne est lue, exécutée, et son résultat affiché
    aussitôt.
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
#d("En option : sans VS Code, depuis l'Anaconda Prompt")[
  #annonce[
    L'éditeur n'est qu'une fenêtre autour du terminal. Tout ce qui précède se
    refait dans l'Anaconda Prompt seul, pour le voir.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut taper], [Ce que vous observez],
    [1], [menu Démarrer #sym.arrow.r Anaconda Prompt], [l'invite commence par `(base)`],
    [2], [`conda activate info01`], reponse[l'invite commence par `(info01)`],
    [3], [`cd `, puis glisser le dossier `2a_vscode_python` dans la fenêtre, Entrée], reponse[le chemin collé apparaît dans l'invite],
    [4], [`python bonjour.py`], reponse[la même phrase que dans l'éditeur],
    [5], [`python`, les lignes de la session interactive, `exit()`], reponse[le même `129.0`],
  )

  #legende[
    Ce que VS Code faisait à votre place : activer l'environnement (2) et se
    placer dans le dossier (3).
  ]

  #notes[
    Facultatif, pour ceux qui ont fini, ou pour un poste où VS Code résiste.
    L'intérêt est de faire voir que l'éditeur n'ajoute rien à l'exécution :
    le terminal intégré et l'Anaconda Prompt lancent le même `python`.

    Étape 3 : glisser un dossier depuis l'explorateur dans la fenêtre du
    terminal colle son chemin complet, entre guillemets s'il contient un
    espace. C'est le moyen le plus sûr de ne pas taper un chemin faux ;
    `cd` pour lui-même est au cours 2. Sous Windows, `cd /d` si le dossier
    est sur un autre disque que `C:`.

    Étape 2 : c'est le `conda activate` que l'éditeur tape à leur place, et
    l'invite `(info01)` est la preuve. Sous macOS et Linux, un terminal
    ordinaire remplace l'Anaconda Prompt.
  ]
]
#d("Exécuter pas à pas : poser un arrêt, puis lancer")[
  #annonce[
    Le débogueur arrête le programme sur une ligne choisie et laisse regarder
    les variables, sans rien ajouter au code. D'abord l'arrêt, puis le
    lancement.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Le geste], [Ce que vous observez],
    [1], [ouvrir `altitudes.py`, cliquer dans la marge à gauche du numéro de la ligne 4], [un point rouge : le programme s'y arrêtera],
    [2], [`F5`], [en haut, VS Code demande quoi déboguer],
    [3], [choisir « Python Debugger », puis « Python File »], reponse[le programme démarre et s'arrête ligne 4, surlignée en jaune],
    [4], [regarder à gauche, panneau Run and Debug (`Ctrl` + `Maj` + `D`)], reponse[Variables : `altitudes`, `total` à `0` ; la barre de boutons en haut],
  )

  #legende[
    La question de l'étape 2 ne vient qu'au premier lancement : ne rien créer
    d'autre, ne pas enregistrer de configuration. Le point rouge est un réglage
    de l'éditeur, le fichier n'a pas changé.
  ]

  #notes[
    Les deux premières façons montrent le début et la fin ; celle-ci
    montre le milieu, ligne par ligne. Réflexe à installer : on ne sème
    pas des `print`, on pose un point d'arrêt.

    Ligne 4 est choisie exprès, c'est le corps de la boucle : l'arrêt se
    répète trois fois et `total` change sous leurs yeux.

    Étape 3 : l'extension propose « Python File », « Module », « Django »…
    Le premier. Si VS Code propose de créer `launch.json`, refuser : c'est
    pour plus tard. Étape 4 : le panneau s'ouvre de lui-même au premier
    arrêt ; le raccourci sert quand il a été fermé.

    Raccourcis par défaut, relevés dans la documentation de VSCode et non
    sur les postes : vérifier que personne n'a un jeu modifié.
  ]
]
#d("Exécuter pas à pas : avancer et lire les variables")[
  #annonce[
    Une ligne à la fois, avec `F10`. À chaque arrêt, prédire la valeur de
    `total` avant de la lire.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Bouton], [Touche], [Ce qu'il fait],
    [Continue], [`F5`], [reprend jusqu'au prochain arrêt, ou jusqu'à la fin],
    [Step Over], [`F10`], [exécute la ligne surlignée et s'arrête à la suivante],
    [Step Into], [`F11`], [entre dans la fonction appelée — pas aujourd'hui],
    [Restart], [`Ctrl` + `Maj` + `F5`], [recommence du début],
    [Stop], [`Maj` + `F5`], [arrête le programme],
  )

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Le geste], [Ce que vous observez],
    [5], [`F10`, trois fois, en regardant Variables], reponse[`total` : `128.4`, puis `259.4`, puis `387.0`],
    [6], [`F5`], reponse[le programme finit : `moyenne : 129.0 m` dans le terminal],
  )

  #notes[
    Faire prédire la valeur avant chaque `F10` : c'est le seul moment du
    TD où ils calculent, et c'est ce qui rend la boucle réelle.

    La ligne surlignée est celle qui va s'exécuter, pas celle qui vient de
    l'être : la confusion est fréquente à la première lecture de `total`.

    Ne pas aller plus loin : `F11` entre dans les fonctions appelées et
    perd tout le monde. Le débogage pour lui-même est au cours 2.

    Après l'étape 6 le point rouge est toujours là : un second `F5`
    recommence et s'y arrête. Le faire remarquer, puis cliquer sur le point
    pour l'enlever.
  ]
]
