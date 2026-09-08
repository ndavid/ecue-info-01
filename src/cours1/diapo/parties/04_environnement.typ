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
    Une recette qui commence par « prenez une pâte brisée » : vous ne la
    fabriquez pas, mais il faut qu'elle soit dans le placard, et que ce
    soit la bonne.

    Nommer *bibliothèque* ; écarter « librairie », faux ami de *library*.

    Ne pas parler d'installation : c'est la diapositive suivante.
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
    Personne ne tient cette liste à la main : c'est ce qui justifie
    l'outil.

    Une installation est reproductible parce qu'un fichier la décrit, non
    parce qu'on se souvient de ce qu'on a tapé. C'est le rôle
    d'`environment.yml`, et ce qui est demandé au rendu.

    Les versions exactes sont dans la sortie de `conda env export` ; ne
    pas y entrer aujourd'hui.
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
    Troisième ligne : une bibliothèque tout en Python s'installe partout
    de la même façon ; une enveloppe doit exister précompilée par système
    et par version de Python. À défaut, l'installation compile sur place
    et échoue faute de compilateur — d'où « Microsoft Visual C++ 14.0 is
    required ».

    C'est ce que conda résout, et pourquoi le module l'emploie plutôt que
    `pip` seul : il distribue des binaires précompilés, et installe aussi
    ce qui n'est pas du Python, `ffmpeg` ou un compilateur C++.

    Ne pas détailler les formats de paquet.

    `markdown` convertit la recette de la manipulation précédente, en
    Python de bout en bout. `pillow` ne décode pas les images lui-même :
    il appelle `libjpeg` et `libpng`, écrites en C.
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
    Réponse au symptôme le plus fréquent du semestre :
    `ModuleNotFoundError` sur un paquet « qu'on vient d'installer ». Le
    paquet est installé, mais hors de l'environnement actif.

    Réflexe à redemander toute l'année : afficher quel Python tourne avant
    de chercher plus loin.
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
    La ligne de commande arrive ici parce que l'outil dont on a besoin
    n'existe que sous cette forme, non pour elle-même. Beaucoup de
    programmes n'ont pas de fenêtre, faute que quelqu'un en ait écrit une.

    Les deux diapositives suivantes donnent de quoi lire ces trois lignes.
    Les chemins, le dossier courant et les motifs comme `*.odt` sont au
    cours 2 ; les diapositives correspondantes sont en annexe.

    Ne pas lancer la création maintenant : plusieurs minutes, et c'est la
    manipulation de fin de partie.
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
    Deux minutes. Elle répond à « pourquoi conda alors que tout le monde
    dit `pip install` ? », question qui vient du web de toute façon.

    `pip` n'installe que des bibliothèques Python : ni `ffmpeg`, ni un
    compilateur C++. `pyenv` ne fait pas ce travail — il choisit la
    version de Python active et n'installe aucun paquet ; il figure ici
    parce que son nom prête à confusion. `conda` fait les deux.

    `uv` et `pixi`, récents et écrits en Rust, résolvent les dépendances
    en quelques secondes : `uv` du côté de `pip`, `pixi` de celui de
    conda. Hors programme, le module s'en tenant à un seul outil.

    Pas de succession où le dernier remplace les autres : `pip` a dix-huit
    ans, reste le plus employé, est installé dans l'environnement du
    module, et `uv` l'appelle encore par-dessous.

    À retenir : on ne mélange pas deux outils sur un même environnement,
    aucun ne voyant ce que l'autre a posé.
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
    Ne pas classer les deux dépôts en bon et mauvais. PyPI est l'index de
    référence du monde Python, où la plupart des bibliothèques paraissent
    d'abord ; un paquet conda-forge en est le plus souvent construit
    quelques jours plus tard.

    Ce qui change est la porte d'entrée. Publier sur PyPI est immédiat et
    sans relecture, ce qui fait sa richesse et ce qu'exploite la
    diapositive suivante ; conda-forge demande une recette et une
    relecture humaine, ce qui élève la barrière sans rien prouver sur le
    code en amont.

    Trente fois plus de projets d'un côté : conda-forge n'empaquette que
    ce que quelqu'un a proposé.

    Si la question du canal `defaults` vient : Miniforge n'installe que
    depuis conda-forge, les conditions d'Anaconda demandant une licence
    payante aux grandes organisations. Raison écrite dans
    `INSTALLATION.md`.
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
    `conda install` et `pip install` n'apportent pas un document : ils
    exécutent du code, tout de suite, avec les droits de qui a tapé la
    commande.

    Le procédé s'appelle le typosquattage. Des campagnes de plusieurs
    centaines de faux paquets ont été relevées sur PyPI, calqués sur les
    noms les plus téléchargés. La commande passe, rien ne s'affiche, et le
    paquet a lu les fichiers du compte pendant l'installation.

    Ne pas en faire une peur d'installer : la conclusion est un geste,
    copier le nom depuis la page du projet.

    Second réflexe, si la salle suit : se méfier d'un paquet très récent,
    très peu téléchargé, au nom proche d'un autre.

    Repris au cours 5 avec les secrets.
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
    Ils s'en sont servis à la manipulation « hello world » sans qu'on le
    nomme.

    La troisième ligne évite le `ModuleNotFoundError` de la diapositive
    précédente : l'interpréteur choisi est celui que l'éditeur active dans
    chaque nouveau terminal, et la barre d'état le vérifie sans rien
    taper.

    Le terminal intégré est le même programme, affiché dans la fenêtre de
    l'éditeur. Le dire, la question vient.

    Libellés dépendants de la version de VSCode et de la langue de
    l'interface, anglaise par défaut : à vérifier sur le poste de
    démonstration.

    Ouvrir un terminal hors de l'éditeur est en annexe, et au cours 2.
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
    `ModuleNotFoundError` sur un paquet « qu'on vient d'installer »
    signifie presque toujours que le mauvais environnement est actif.
    Prévoir l'installation en amont ; c'est le point qui déborde.
  ]
]
// --------------------- Manipulation : installer une bibliothèque -------------

#separateur-manip(
  "Installer une bibliothèque et s'en servir",
  annonce: "Un environnement neuf, un programme qui ne tourne pas, et la ligne qui le répare",
  dossier: "data/cours1/environnement/",
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
    Étape 4, à faire lire à voix haute : un environnement « Python seul »
    n'est pas vide, il contient 28 paquets, dont une douzaine de
    bibliothèques C — `openssl`, `sqlite`, `zlib` — sans lesquelles
    l'interpréteur ne démarre pas. `pip`, `setuptools` et `wheel` y sont
    aussi, d'où `pip install` qui fonctionne dans un environnement conda
    sans qu'on l'ait installé.

    Ce qui n'y est pas : ni `numpy`, ni `jupyterlab`, ni `markdown`.

    Étape 2 : `pyproject.toml` est au projet ce qu'`environment.yml` est à
    l'environnement. On a donc lu, avant de rien lancer, que le programme
    réclamerait `markdown`.

    Étape 5, à ne pas sauter : le `ModuleNotFoundError` annoncé deux fois
    depuis la partie 2 leur arrive dans des conditions où la cause est
    connue. Le fichier est là, sa syntaxe est correcte ; c'est le code
    emprunté qui manque.

    `python -m page_html` lance un paquet et non un fichier : le dossier
    `page_html/` porte un nom de paquet, `-m` demande à Python de
    l'exécuter.

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
    Étape 6 : trois paquets s'installent ici, contre un seul de 85 ko avec
    la même commande dans `info01`, où `importlib-metadata` et `zipp`
    étaient déjà présents. C'est « Une bibliothèque en entraîne d'autres »
    vérifié par eux, et la preuve que ce qui est là ne se réinstalle pas.

    Étape 8, trois renvois : le `recette.md` est celui qu'ils ont écrit
    une demi-heure plus tôt ; la page sépare contenu et présentation,
    comme les deux pages du poème de la partie 1 ; elle s'ouvre en
    `file:///`, sans serveur.

    Poser la question avant de répondre : pourquoi le diagramme n'est-il
    pas dessiné ? Le bloc `mermaid` arrive dans la page sous forme de six
    lignes de texte. Mermaid est un service de l'aperçu de l'éditeur, pas
    du HTML.

    Poste sans réseau : l'installation échoue. Projeter le résultat et
    faire la diapositive suivante, qui ne demande que d'éditer un fichier.
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
    La phrase annoncée à la deuxième diapositive, démontrée ici : une
    installation est reproductible parce qu'un fichier la décrit, non
    parce qu'on se souvient de ce qu'on a tapé.

    Faire le geste devant eux : une ligne ajoutée, quatre caractères
    d'indentation, l'environnement se recrée ailleurs.

    Les deux fichiers ne se remplacent pas. `environment.yml` dit de quoi
    la machine a besoin, y compris ce qui n'est pas du Python ;
    `pyproject.toml` de quoi le code a besoin. Les deux coexistent ici
    comme dans la plupart des projets.

    Pour ceux qui vont vite : `pip install -e .` installe le projet lui-
    même, et la commande `page-html` existe alors, équivalente à `python
    -m page_html`. C'est `[project.scripts]`, sujet du cours 3. Vérifié
    sur la machine de préparation.

    Rendre la main : `conda deactivate`, puis `conda activate info01`.
    L'environnement `recette` peut être supprimé, `conda env remove -n
    recette`.
  ]
]
