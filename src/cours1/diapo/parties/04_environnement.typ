// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

// ===================== Environnement de programmation ======================

#separateur(
  "Environnement de programmation",
  annonce: "Le code que le programme emprunte, et l'outil qui l'installe",
)
// ------------------------- Dépendances et environnement -----------------------

#d("Ce qu'un programme emprunte")[
  #annonce[
    Un programme n'écrit pas tout ce qu'il fait. Les lignes `import` désignent
    du code écrit par d'autres, installé sur la machine.
  ]

  #face-a-face(
    panneau("Ce que vous écrivez")[
      ```python
      import numpy as np
      from PIL import Image

      points = np.array(etapes)
      image = Image.new("RGB", (900, 600))
      ```
    ],
    panneau("Ce que cela suppose installé")[
      #tableau(
        entete: false,
        columns: (auto, 1fr),
        align: left + horizon,
        [`numpy`], [calcul sur des tableaux de nombres],
        [`pillow`], [lecture et écriture d'images],
      )
      #v(0.4em)
      #text(size: 13pt, fill: estompe)[
        Deux bibliothèques, soit quelques centaines de milliers de lignes que
        vous n'écrivez pas.
      ]
    ],
  )

  #notes[
    L'image qui marche : une recette qui commence par « prenez une pâte
    brisée ». Vous ne la fabriquez pas, mais il faut qu'elle soit dans le
    placard, et que ce soit la bonne.

    C'est ici qu'on nomme le mot *bibliothèque*, et qu'on écarte
    « librairie », faux ami de *library*.

    Ne pas encore parler d'installation : la diapositive suivante montre ce
    que celle-ci entraîne.
  ]
]
#d("Une bibliothèque en entraîne d'autres")[
  #annonce[
    Une bibliothèque en réclame d'autres, qui en réclament d'autres à leur
    tour. La liste effective ne se tient pas à la main.
  ]

  #chaine(
    ecart: 30pt,
    ("environment.yml", "15 paquets demandés"),
    ("leurs exigences", "pillow en déclare 25, jupyterlab 50"),
    ("l'environnement", "352 paquets installés"),
  )

  #legende[
    Relevé sur l'environnement `info01` du module, avec `conda list`.
  ]

  #notes[
    Le chiffre surprend, et c'est son intérêt : personne ne peut tenir cette
    liste à la main, d'où l'outil qui la résout.

    Conséquence à énoncer : une installation n'est pas reproductible parce
    qu'on se souvient de ce qu'on a tapé, mais parce qu'un fichier la décrit.
    C'est ce que fait `environment.yml`, et c'est ce qui est demandé au rendu.

    Les versions exactes sont dans le fichier produit par
    `conda env export` ; ne pas y entrer aujourd'hui.
  ]
]
#d("Ce qu'une bibliothèque contient vraiment")[
  #annonce[
    Certaines bibliothèques ne sont que du Python. D'autres enveloppent du
    code écrit dans un autre langage, déjà compilé pour votre machine.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Tout en Python], [Une enveloppe autour d'un autre langage],
    [Exemples], [`requests`, `markdown`], [`numpy`, `pillow`],
    [Ce qui est distribué], [du texte, lisible], [du texte, plus un binaire compilé],
    [Selon la machine],
      [le même fichier partout],
      [un fichier par système et par version de Python],
    [Pourquoi], [rien à compiler], [la vitesse, ou une bibliothèque qui existait déjà],
  )

  #legende[
    C'est la deuxième catégorie qui rend l'installation difficile, et qui
    explique l'outil de la diapositive suivante.
  ]

  #notes[
    Le point pratique est la troisième ligne. Une bibliothèque tout en Python
    s'installe partout de la même façon ; une enveloppe doit exister
    précompilée pour Windows, macOS, Linux, et pour chaque version de Python.
    Quand elle n'existe pas, l'installation tente de compiler sur place, ce
    qui échoue faute de compilateur — le message « Microsoft Visual C++ 14.0
    is required » que tout le monde a déjà vu vient de là.

    C'est exactement le problème que conda résout, et c'est pourquoi le module
    l'emploie plutôt que `pip` seul : conda distribue les binaires
    précompilés, et sait aussi installer ce qui n'est pas du Python, comme le
    compilateur C++ de tout à l'heure ou `ffmpeg`.

    Ne pas entrer dans le détail des formats de paquet. Ce qu'il faut retenir
    tient en une phrase : installer une bibliothèque, ce n'est pas toujours
    copier du texte.

    Les quatre exemples sont choisis pour être compris aujourd'hui, sans
    notion préalable. `markdown` convertit en HTML ce qu'ils viennent
    d'écrire à la manipulation précédente, et c'est du Python de bout en
    bout. `pillow` ouvre les `.jpg` et les `.png` de la grille des
    extensions : il ne les décode pas lui-même, il appelle `libjpeg` et
    `libpng`, deux bibliothèques C plus vieilles qu'eux, que personne ne
    réécrira en Python.
  ]
]
#d("Pourquoi isoler un environnement")[
  #annonce[
    Deux projets peuvent réclamer deux versions de la même bibliothèque. Un
    environnement permet aux deux de coexister sur la même machine.
  ]

  ```bash
  $ python -c "import numpy; print(numpy.__version__)"
  1.21.5
  $ conda activate info01
  $ python -c "import numpy; print(numpy.__version__)"
  2.5.2
  ```

  #v(0.4em)
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [Sans environnement], [une seule version par machine, et le projet qui exige l'autre ne tourne plus],
    [Avec un environnement], [un dossier par projet, sa version de Python et ses bibliothèques],
  )

  #legende[
    Sortie réelle, relevée sur la machine du cours : le même mot `python`
    désigne deux programmes différents selon l'environnement actif.
  ]

  #notes[

    C'est la réponse au symptôme le plus fréquent du semestre, le
    `ModuleNotFoundError` sur un paquet « qu'on vient d'installer » : le paquet
    est installé, mais ailleurs que dans l'environnement actif.

    Le réflexe à donner, et à redemander toute l'année : afficher quel Python
    tourne avant de chercher plus loin.
  ]
]
#d("L'outil qui installe un environnement")[
  #annonce[
    `conda` lit la liste des paquets demandés, résout leurs exigences et les
    installe. Il n'a pas de fenêtre : il s'emploie en tapant une commande.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Ce que vous voulez], [Ce que vous tapez],
    [créer l'environnement du module], [`conda env create -f environment.yml`],
    [l'activer dans le terminal courant], [`conda activate info01`],
    [savoir ce qui est installé dedans], [`conda list`],
  )

  #legende[
    Trois commandes pour tout le semestre. La séance 2 revient sur la ligne de
    commande pour elle-même ; ici, elle est un outil.
  ]

  #notes[
    C'est la charnière de la partie, et elle explique pourquoi la ligne de
    commande arrive maintenant plutôt qu'au début de la séance : on ne
    l'apprend pas pour elle-même, on la rencontre parce que l'outil dont on a
    besoin n'existe que sous cette forme.

    Le dire simplement : beaucoup de programmes n'ont pas de fenêtre, parce
    que personne n'en a écrit une. Ce n'est pas un choix d'austérité.

    Les deux diapositives qui suivent donnent le minimum pour lire ces trois
    lignes. Le reste, les chemins, le dossier courant, les motifs comme
    `*.odt`, est au cours 2 ; les diapositives correspondantes sont en annexe
    de ce deck si la salle avance vite.

    Ne pas lancer la création maintenant : elle prend plusieurs minutes et
    c'est la manipulation de la fin de partie.
  ]
]
#d("Les outils qui installent des paquets")[
  #annonce[
    `conda` n'est ni le seul ni le premier. Aucun de ces outils n'a fait
    disparaître les précédents.
  ]

  #frise(
    largeur-etiquette: 152pt, tige: 26pt,
    (2008, "pip", "les bibliothèques Python, depuis PyPI"),
    (2012, "conda", "les paquets, et ce qui n'est pas Python"),
    (2015, "conda-forge", "le dépôt communautaire"),
    (2019, "mamba", "le solveur de conda, réécrit"),
    (2023, "pixi", "l'écosystème conda, repris de zéro"),
    (2024, "uv", "pip et les environnements, réécrits"),
  )

  #legende[
    `pyenv`, né la même année que `conda`, n'est pas sur l'axe : il choisit la
    version de Python et n'installe aucun paquet. Dates de création des dépôts,
    relevées le 8 septembre 2026 par l'API de GitHub.
  ]

  #notes[
    Diapositive de culture, à passer en deux minutes. Elle répond à une
    question qui viendra de toute façon, en cherchant sur le web : « pourquoi
    conda alors que tout le monde dit `pip install` ? »

    Ce qu'il faut dire, et rien de plus. `pip` installe des bibliothèques
    Python et rien d'autre : il ne sait pas installer `ffmpeg` ni un
    compilateur C++, qui ne sont pas du Python. `pyenv` ne fait pas le même
    travail du tout — il choisit quelle version de Python est active, et
    n'installe aucun paquet ; il est ici parce que son nom se confond avec le
    reste. `conda` fait les deux, et c'est pour cela que le module l'emploie.

    Les deux derniers sont récents et écrits en Rust, tous deux pour la même
    raison : la résolution des dépendances est lente, et ils la font en
    quelques secondes. `uv` reprend le monde de `pip`, `pixi` celui de conda.
    Ils sont excellents et ils ne sont pas au programme : le module reste sur
    conda pour n'avoir qu'un outil à enseigner.

    Ne pas laisser croire à une succession où le dernier remplace les autres.
    `pip` a dix-huit ans et reste l'outil le plus employé au monde ; il est
    d'ailleurs installé dans l'environnement du module, et `uv` l'appelle
    encore par-dessous.

    Ce qu'ils doivent retenir tient en une phrase : on ne mélange pas deux
    outils sur le même environnement sans savoir ce qu'on fait, parce qu'aucun
    ne voit ce que l'autre a posé.
  ]
]
#d("D'où viennent les paquets")[
  #annonce[
    Une commande d'installation va chercher le paquet dans un dépôt. Les deux
    que vous croiserez n'y laissent pas entrer la même chose.
  ]

  #face-a-face(
    panneau[PyPI, ce que `pip` installe][
      #block(inset: 11pt, width: 100%, height: 118pt,
             stroke: 0.8pt + estompe.lighten(50%))[
        #set text(size: 15pt)
        #text(size: 30pt, weight: demi-gras)[886 022] #h(5pt) projets
        #v(0.5em)
        Publication immédiate, par qui veut, sans relecture. Un nom libre
        s'obtient en une minute.
      ]
    ],
    panneau[conda-forge, ce que `conda` installe ici][
      #block(inset: 11pt, width: 100%, height: 118pt,
             fill: accent.lighten(93%), stroke: 0.8pt + accent.lighten(50%))[
        #set text(size: 15pt)
        #text(size: 30pt, weight: demi-gras)[29 411] #h(5pt) paquets
        #v(0.5em)
        Chaque paquet a une recette, relue par des humains avant d'entrer, et
        construite pour les trois systèmes.
      ]
    ],
  )

  #legende[
    Projets relevés le 8 septembre 2026 dans l'index de PyPI ; recettes
    conda-forge le même jour, par l'API de GitHub.
  ]

  #notes[
    Les deux dépôts ne rendent pas le même service et il ne faut pas les
    classer en bon et mauvais. PyPI est l'index de référence du monde Python,
    et c'est là que la plupart des bibliothèques paraissent d'abord ; un
    paquet conda-forge est le plus souvent construit à partir des mêmes
    sources, quelques jours plus tard.

    Ce qui change est la porte d'entrée. Sur PyPI, publier est un geste
    immédiat et sans relecture : c'est ce qui en fait la richesse, et c'est
    aussi ce que la diapositive suivante exploite. conda-forge demande une
    recette et une relecture par des humains, ce qui élève la barrière sans
    rien prouver sur le code en amont.

    L'ordre de grandeur est le point à faire remarquer : trente fois plus de
    projets d'un côté. La différence ne tient pas au langage, elle tient à ce
    que conda-forge n'empaquette que ce que quelqu'un a pris la peine de
    proposer.

    Sur le canal `defaults` d'Anaconda, si la question vient : le module
    emploie Miniforge, qui n'installe que depuis conda-forge, parce que les
    conditions d'utilisation du dépôt d'Anaconda demandent une licence payante
    aux organisations au-delà d'une certaine taille. La raison est écrite dans
    `INSTALLATION.md` et n'a pas à être développée en séance.
  ]
]
#d("Ce qu'une installation exécute")[
  #annonce[
    Installer un paquet exécute du code écrit par quelqu'un d'autre, avec vos
    droits. Le nom demandé est la seule chose que vous contrôlez.
  ]

  #align(center)[
    #grid(
      columns: (auto, 120pt, auto),
      align: horizon + center,
      block(inset: (x: 18pt, y: 9pt), stroke: 1pt + accent.lighten(50%),
            fill: accent.lighten(93%))[
        #text(font: police-code, size: 30pt, weight: demi-gras)[requests]
        #v(0.3em)
        #text(size: 14pt, fill: estompe)[la bibliothèque que vous vouliez]
      ],
      text(size: 15pt, fill: estompe)[deux lettres \ inversées],
      block(inset: (x: 18pt, y: 9pt), stroke: 1pt + manip)[
        #text(font: police-code, size: 30pt, weight: demi-gras, fill: manip)[reqeusts]
        #v(0.3em)
        #text(size: 14pt, fill: estompe)[celle que vous avez tapée]
      ],
    )
  ]

  #v(0.4em)
  #bloc-titre("Le réflexe")[
    #set text(size: 17pt)
    Le nom d'un paquet se copie depuis la documentation du projet ; il ne se
    tape pas de mémoire.
  ]

  #legende[
    Sonatype : 454 600 paquets malveillants recensés en 2025, tous dépôts
    confondus (_State of the Software Supply Chain_, 2026).
  ]

  #notes[
    C'est la diapositive la plus importante de la partie pour la suite de leur
    vie professionnelle, et elle tient en une idée : `conda install` et
    `pip install` ne téléchargent pas un document, ils exécutent du code, tout
    de suite, avec les droits de celui qui a tapé la commande.

    Le procédé s'appelle le typosquattage, et il n'a rien de théorique : des
    campagnes de plusieurs centaines de faux paquets ont été relevées sur
    PyPI, calqués sur les noms les plus téléchargés. La commande passe, rien
    ne se voit à l'écran, et le paquet a lu les fichiers du compte pendant son
    installation.

    Le brun de l'encadré de droite n'est pas décoratif : c'est la couleur du
    travail sur machine, employée ici parce que c'est bien la ligne qu'ils
    vont taper.

    Ne pas transformer cela en peur de tout installer. La conclusion est un
    geste, pas une abstention : copier le nom depuis la page du projet. Cela
    coûte trois secondes et supprime la classe entière du problème.

    Un second réflexe, à donner seulement si la salle suit : se méfier d'un
    paquet très récent, très peu téléchargé, dont le nom ressemble à un autre.

    Le sujet est repris au cours 5 avec les secrets. Ici on sème.
  ]
]
#d("Le terminal de l'éditeur de code")[
  #annonce[
    L'éditeur ouvre un terminal dans sa fenêtre, déjà placé dans le dossier du
    projet.
  ]

  #tableau(
    columns: (1.1fr, 1fr),
    align: left + horizon,
    [Le geste], [Ce qu'il règle],
    [Terminal #sym.arrow.r Nouveau terminal], [un terminal dans le dossier ouvert],
    [le sélecteur, à droite du panneau], [l'interpréteur de commandes : PowerShell, bash, zsh],
    [`Ctrl` + `Maj` + `P`, `Python: Select Interpreter`], [l'environnement activé dans chaque nouveau terminal],
    [la barre d'état, en bas], [l'environnement en cours],
  )

  #legende[
    Le dossier du projet est le dossier courant : c'est de lui que partent les
    chemins relatifs des commandes.
  ]

  #notes[
    Ils s'en sont déjà servis sans qu'on le nomme, à la manipulation « hello
    world » : c'est le moment de revenir dessus.

    La troisième ligne est celle qui évite le `ModuleNotFoundError` de la
    diapositive précédente. L'interpréteur choisi ici est celui que l'éditeur
    activera dans chaque nouveau terminal, et la barre d'état permet de le
    vérifier sans rien taper.

    Le terminal intégré n'est pas un autre terminal : c'est le même programme,
    affiché dans la fenêtre de l'éditeur. Le dire, parce que la question vient.

    Les libellés dépendent de la version de VSCode et de la langue de
    l'interface, qui est l'anglais par défaut. Vérifier les intitulés sur le
    poste de démonstration avant la séance.

    Le terminal ouvert hors de l'éditeur, et la façon de l'ouvrir sur chaque
    système, sont en annexe : c'est le cours 2 qui s'en occupe.
  ]
]
#d("L'environnement de développement")[
  #annonce[
    Un environnement réunit une version de Python et les outils choisis, dans
    un dossier isolé que l'on peut recréer ailleurs.
  ]

  ```bash
  conda create -n info01 -c conda-forge python=3.12 \
      jupyterlab numpy pillow pandoc typst ffmpeg imagemagick
  conda activate info01
  ```

  #v(0.5em)
  ```python
  import sys; print(sys.executable)
  ```
  ```
  /home/…/miniforge3/envs/info01/bin/python
  ```

  #legende[Le chemin doit contenir `info01`.]

  #notes[
    Message à marteler : un `ModuleNotFoundError` sur un paquet « qu'on vient
    d'installer » signifie presque toujours que le mauvais environnement est
    actif. Prévoir l'installation en amont ; c'est le point qui déborde.
  ]
]
// --------------------- Manipulation : installer une bibliothèque -------------

#separateur-manip(
  "Installer une bibliothèque et s'en servir",
  annonce: "Un environnement neuf, un programme qui ne tourne pas, et la ligne qui le répare",
)
#d("Un environnement neuf")[
  #annonce[
    On repart d'un environnement qui ne contient que Python, pour voir ce qui
    s'y trouve d'origine et ce qui n'y est pas.
  ]

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [Fichier #sym.arrow.r Ouvrir le dossier, sur `data/cours1/environnement/`], [],
    [2], [ouvrir `pyproject.toml` et lire la ligne `dependencies`],
      reponse[le projet déclare avoir besoin de `markdown`],
    [3], [Terminal #sym.arrow.r Nouveau terminal, puis `conda env create -f environment.yml`], [],
    [4], [`conda activate recette`, puis `conda list`],
      reponse[28 paquets, et aucun ne s'appelle `markdown`],
    [5], [`python -m page_html`],
      reponse[`ModuleNotFoundError: No module named 'markdown'`],
  )

  #legende[
    Relevé sur la machine de préparation : la création prend une dizaine de
    secondes, l'index des paquets étant déjà en cache.
  ]

  #notes[
    Le point de la diapositive est l'étape 4, et il faut la faire lire à voix
    haute. Un environnement « Python seul » n'est pas vide : il contient
    28 paquets, dont une douzaine de bibliothèques C — `openssl`, `sqlite`,
    `zlib` — sans lesquelles l'interpréteur ne démarre pas. `pip`,
    `setuptools` et `wheel` y sont aussi, et c'est la raison pour laquelle
    `pip install` marche dans un environnement conda sans qu'on l'ait
    installé.

    Ce qui n'y est pas est tout aussi instructif : ni `numpy`, ni `jupyterlab`,
    ni `markdown`. Rien de ce que fait un programme utile.

    L'étape 2 est la nouveauté. `pyproject.toml` est au projet ce
    qu'`environment.yml` est à l'environnement : un fichier qui décrit ce qu'il
    faut avoir. Faire remarquer qu'on a donc lu, avant de lancer quoi que ce
    soit, que le programme réclamerait `markdown`.

    L'étape 5 ne se saute pas. C'est la seule fois de la séance où ils voient
    `ModuleNotFoundError` dans des conditions où la cause est connue d'avance :
    le message annoncé deux fois depuis la partie 2 devient une chose qui leur
    est arrivée. Le fichier est là, il se lit, sa syntaxe est correcte — c'est
    le code qu'il emprunte qui manque.

    `python -m page_html` lance un paquet plutôt qu'un fichier. Une phrase
    suffit : le dossier `page_html/` porte un nom de paquet, et `-m` demande à
    Python de l'exécuter. C'est ce que `pyproject.toml` décrit.

    Libellés de menu non vérifiés sur un poste Windows.
  ]
]
#d("L'installation, et ce qu'elle ajoute")[
  #annonce[
    Une seule commande, et le même programme, inchangé, passe. C'est le geste
    de toute la partie.
  ]

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [6], [`conda install -c conda-forge markdown`, puis répondre `y`],
      reponse[trois paquets : `markdown`, `importlib-metadata`, `zipp`],
    [7], [`python -m page_html`],
      reponse[`recette.md -> recette.html, 1282 octets`],
    [8], [ouvrir la page par l'adresse `file:///` que le programme affiche],
      reponse[la recette mise en page, sans serveur ni réseau],
    [9], [changer une couleur dans `style.css`, enregistrer, `F5`],
      reponse[la page change, et le `.html` n'a pas bougé],
  )

  #legende[
    Sortie réelle dans `data/cours1/environnement/`. Le `recette.md` converti
    est celui que vous avez écrit à la partie précédente.
  ]

  #notes[
    Le chiffre à faire dire à l'étape 6, et il vaut la comparaison : ici trois
    paquets s'installent, alors que la même commande dans `info01` n'en
    installe qu'un seul, de 85 ko. `importlib-metadata` et `zipp` y étaient
    déjà, tirés par autre chose. C'est « Une bibliothèque en entraîne
    d'autres » vérifié par eux, et la démonstration que ce qui est déjà là ne
    se réinstalle pas.

    Trois choses de la séance se referment à l'étape 8, et il vaut de les
    nommer une par une. Le `recette.md` est celui qu'ils ont écrit une
    demi-heure plus tôt. La page sépare le contenu de la présentation, comme
    les deux pages du poème de la partie 1. Elle s'ouvre par une adresse
    `file:///`, sans serveur.

    La question à poser avant de répondre : pourquoi le diagramme n'est-il pas
    dessiné ? Le bloc `mermaid` arrive dans la page sous la forme de ses six
    lignes de texte. Mermaid est un service de l'aperçu de l'éditeur, pas du
    HTML : le navigateur reçoit du texte et affiche du texte. C'est la
    distinction tenue toute la séance entre ce qu'un fichier contient et ce
    qu'un logiciel en affiche, déjà rencontrée avec la coloration syntaxique
    et avec la chasse fixe.

    Prévoir le cas du poste sans réseau : l'installation échoue et la suite ne
    se fait pas. Projeter le résultat, et faire la diapositive suivante quand
    même — elle ne demande que d'éditer un fichier.
  ]
]
#d("Écrire ce qu'on vient d'installer")[
  #annonce[
    Une installation faite à la main ne se retrouve pas. Elle se note dans le
    fichier qui décrit l'environnement, et redevient reproductible.
  ]

  #face-a-face(
    panneau("Avant")[
      ```yaml
      name: recette
      channels:
        - conda-forge
      dependencies:
        - python=3.12
      ```
    ],
    panneau("Après, ligne ajoutée à la main")[
      ```yaml
      name: recette
      channels:
        - conda-forge
      dependencies:
        - python=3.12
        - markdown
      ```
    ],
  )

  #v(0.4em)
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`conda env update -f environment.yml`],
      reponse[rien ne s'installe : c'était déjà fait],
    [sur une machine neuve], reponse[`conda env create` installe les deux d'un coup],
  )

  #legende[
    `environment.yml` décrit l'environnement, `pyproject.toml` décrit le
    projet. Aucun des deux n'installe : ils disent ce qu'il faut installer.
  ]

  #notes[
    C'est la diapositive qui referme la partie, et elle vaut les deux minutes
    qu'elle prend. La phrase à dire, qui a été annoncée à la deuxième
    diapositive sans être démontrée : une installation n'est pas reproductible
    parce qu'on se souvient de ce qu'on a tapé, elle l'est parce qu'un fichier
    la décrit.

    Faire le geste devant eux plutôt que de l'énoncer : une ligne ajoutée,
    quatre caractères d'indentation, et l'environnement se recrée ailleurs.

    Ne pas laisser croire que l'un remplace l'autre. `environment.yml` dit de
    quoi la machine a besoin, y compris ce qui n'est pas du Python ;
    `pyproject.toml` dit de quoi le code a besoin, et rien d'autre. Les deux
    coexistent dans la plupart des projets, et c'est le cas ici.

    Pour ceux qui vont vite, et seulement pour eux : `pip install -e .` dans
    l'environnement installe le projet lui-même, après quoi la commande
    `page-html` existe et fait la même chose que `python -m page_html`. C'est
    la section `[project.scripts]` de `pyproject.toml`, et c'est le sujet du
    cours 3. Vérifié sur la machine de préparation.

    Rendre la main ensuite : `conda deactivate`, puis `conda activate info01`
    pour la suite de la séance. L'environnement `recette` peut être supprimé,
    `conda env remove -n recette`, ou gardé — il pèse peu.
  ]
]
