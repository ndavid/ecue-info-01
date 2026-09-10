// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-isolation, schema-depots

// ===================== Environnement de programmation ======================

#separateur(
  "Environnement de programmation",
  annonce: "Réutiliser du code existant plutôt que tout réécrire, installer ce dont un programme dépend, et décrire cette installation dans un fichier",
)
// ------------------------- Dépendances et environnement -----------------------

#d("Réutilisation de code existant")[
  #annonce[
    Un programme ne contient pas tout le code qu'il exécute. Ses lignes
    `import` désignent du code publié par d'autres, réutilisé au lieu d'être
    réécrit.
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
    panneau("Ce qu'il réutilise, et qui doit être installé")[
      #tableau(
        entete: false,
        columns: (auto, 1fr),
        align: left + horizon,
        [`numpy`], [calcul sur des tableaux de nombres],
        [`pillow`], [lecture et écriture d'images],
      )
      #v(0.4em)
      #text(size: 13pt, fill: estompe)[
        Deux bibliothèques, soit quelques centaines de milliers de lignes déjà
        écrites, relues et corrigées ailleurs.
      ]
    ],
  )

  #legende[
    Une bibliothèque dont un programme a besoin pour s'exécuter est une
    _dépendance_ de ce programme.
  ]

  #notes[
    Une recette qui commence par « prenez une pâte brisée » : on ne la
    fabrique pas, mais il faut qu'elle soit dans le placard, et que ce soit
    la bonne.

    Nommer *bibliothèque* ; écarter « librairie », faux ami de *library*.
    Nommer *dépendance*, mot employé dans toute la suite de la partie.

    Ce qu'on gagne n'est pas du temps de frappe : du code publié a été
    relu, corrigé et éprouvé par d'autres, ce qu'un programme écrit dans la
    semaine ne peut pas être. Réécrire `pillow` serait refaire trente ans
    de corrections sur les formats d'image.

    L'autre face du même geste vient plus tard dans la partie : ce code
    est réutilisable parce que quelqu'un l'a distribué, et distribuer le
    sien demande de décrire son projet dans un fichier.

    Ne pas parler d'installation : c'est la diapositive suivante.
  ]
]
#d("Dépendances directes et dépendances transitives")[
  #annonce[
    Une dépendance déclare à son tour ses propres dépendances. La relation est
    récursive, et la liste complète se calcule au lieu de s'énumérer.
  ]

  #chaine(
    ecart: 30pt,
    ("environment.yml", "7 dépendances directes"),
    ("ce qu'elles déclarent", "pillow en déclare 14, ffmpeg 53"),
    ("l'environnement obtenu", "293 paquets installés"),
  )

  #legende[
    Relevé le 8 septembre 2026 sur l'`environment.yml` du module : sept paquets
    demandés, 293 installés d'après `conda create --dry-run`. Le dernier nombre
    n'est la somme d'aucun des précédents, les dépendances se recouvrant.
  ]

  #notes[
    Vocabulaire à poser ici, employé toute l'année : les paquets écrits
    dans le fichier sont les dépendances *directes* ; celles qu'ils
    entraînent sont *transitives*. Calculer l'ensemble à partir du fichier
    s'appelle *résoudre* les dépendances.

    Récursif au sens propre : la même règle s'applique à chaque paquet
    atteint, jusqu'à n'en plus trouver de nouveau. Personne ne tient cette
    liste à la main, et c'est ce qui justifie l'outil.

    Le calcul n'est pas qu'un parcours : deux paquets peuvent exiger deux
    versions incompatibles d'un troisième, et l'outil doit trouver un jeu
    de versions qui convienne à tous. Une phrase, pas plus — c'est ce qui
    explique qu'une installation soit lente.

    Les versions exactes retenues sont dans la sortie de
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

  #align(center, schema-isolation())

  #legende[
    Un environnement est un dossier : sa version de Python et ses bibliothèques
    y tiennent, et rien n'en sort.
  ]

  #notes[
    Le faire constater en direct plutôt que de le projeter, la sortie est
    courte et elle a plus de force tapée devant eux :
    `python -c "import numpy; print(numpy.__version__)"` donne une version,
    puis `conda activate info01` et la même commande en donne une autre. Le
    même mot `python` désigne deux programmes différents.

    Sans environnement : une seule version par machine, et le projet qui exige
    l'autre ne tourne plus. Avec : un dossier par projet.

    Réponse au symptôme le plus fréquent du semestre :
    `ModuleNotFoundError` sur un paquet « qu'on vient d'installer ». Le
    paquet est installé, mais hors de l'environnement actif.

    Réflexe à redemander toute l'année : afficher quel Python tourne avant
    de chercher plus loin.
  ]
]
#d("Le fichier de dépendances")[
  #annonce[
    Les dépendances directes d'un projet ne se retiennent pas : elles s'écrivent
    dans un fichier, rangé avec le code, que l'outil d'installation lit.
  ]

  #face-a-face(
    panneau("Le fichier, écrit à la main")[
      ```yaml
      name: info01
      channels:
        - conda-forge
      dependencies:
        - python=3.12
        - jupyterlab
        - numpy
      ```
    ],
    panneau("Ce qu'on en fait")[
      ```bash
      conda env create -f environment.yml
      ```
      #v(0.5em)
      #tableau(
        entete: false,
        columns: (auto, 1fr),
        align: left + horizon,
        [Sur ce poste], [l'environnement décrit est créé],
        [Sur un autre poste], [le même, à partir du même fichier],
        [Dans six mois], [le même, sans se souvenir de rien],
      )
    ],
  )

  #legende[
    Extrait d'`environment.yml`, à la racine du dépôt du module. Le fichier
    n'installe rien : il dit ce qu'il faut installer.
  ]

  #notes[
    La phrase à retenir de la partie : une installation est reproductible
    parce qu'un fichier la décrit, non parce qu'on se souvient de ce qu'on
    a tapé. C'est aussi ce qui est demandé au rendu.

    Le fichier ne contient que les dépendances directes, sept ici : les
    293 autres sont recalculées à chaque création. Écrire la liste
    complète serait la figer, et l'attacher à un système.

    Il se range avec le code et le suit partout : c'est un fichier texte
    de quelques lignes, comme le reste du projet. Le versionner est le
    sujet du cours 2.

    Ce qui manque encore : ce fichier obtenu à la main après coup ne dit
    pas d'où vient chaque paquet ni en quelle version exacte. `conda env
    export` le fait ; ne pas y entrer aujourd'hui.
  ]
]
#d("YAML et TOML")[
  #annonce[
    Deux formats de fichier texte faits pour décrire et non pour calculer : des
    données structurées, écrites par un humain, relues par un programme.
  ]

  #face-a-face(
    panneau[YAML, ici `environment.yml`][
      ```yaml
      name: info01
      channels:
        - conda-forge
      dependencies:
        - python=3.12
        - numpy
      ```
      #text(size: 14pt, fill: estompe)[
        L'indentation porte la structure, le tiret marque un élément de liste.
      ]
    ],
    panneau[TOML, ici `pyproject.toml`][
      ```toml
      [project]
      name = "page-html"
      version = "0.1.0"
      requires-python = ">=3.10"
      dependencies = ["markdown>=3.5"]
      ```
      #text(size: 14pt, fill: estompe)[
        Des sections entre crochets, et une valeur par nom.
      ]
    ],
  )

  #legende[
    Extraits réels des deux fichiers de la manipulation qui suit. Comme `.json`,
    ils décrivent des données ; contrairement à lui, ils acceptent des
    commentaires, ce qui explique qu'un humain les écrive.
  ]

  #notes[
    Deux minutes. Le propos n'est pas la syntaxe : c'est qu'un troisième
    usage du texte apparaît, après le code et la documentation. Décrire.

    Ils les ont déjà croisés à « Les fichiers texte d'un projet », dans la
    ligne `.json`, `.yaml`. Ce sont les mêmes formats, employés ici pour
    déclarer des dépendances.

    On les retrouve hors de Python : réglages d'un outil, description
    d'une chaîne d'intégration, composition de conteneurs. Citer sans
    développer.

    Piège du YAML, à mentionner si quelqu'un tape le fichier : deux
    espaces d'indentation, jamais de tabulation, et l'éditeur le signale.
    C'est « Espaces, tabulations et fins de ligne » qui resurgit.

    Ne pas comparer les deux formats point par point : ce qui compte est
    qu'un projet Python emploie l'un et l'autre pour deux descriptions
    différentes, diapositive suivante.
  ]
]
#d("Ce qu'un projet déclare")[
  #annonce[
    Un projet ne déclare pas que ses dépendances : le même fichier porte son
    nom, sa version et la commande qu'il installe.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: left + horizon,
    [Ce qui est écrit], [Ce que c'est], [Qui le lit],
    [`name`, `version`, `description`], [les métadonnées du projet], [le dépôt, et qui l'installe],
    surligne[`dependencies`],
      surligne[les bibliothèques que le code importe],
      surligne[l'outil d'installation],
    [`requires-python`], [les versions de Python acceptées], [l'outil d'installation],
    [`[project.scripts]`], [la commande créée à l'installation], [le système],
    [`[build-system]`], [l'outil qui fabrique le paquet distribuable], [les outils de construction],
  )

  #legende[
    Contenu réel de `data/cours1/environnement/pyproject.toml`. Aujourd'hui vous
    lisez ce fichier pour installer ; l'écrire est ce qui rend un code
    installable par quelqu'un d'autre.
  ]

  #notes[
    Boucler la partie : le code réutilisé au début de la partie est
    disponible parce que quelqu'un a écrit un fichier de cette forme, puis
    déposé le résultat sur un dépôt. Les deux bouts se rejoignent ici.

    Distribuer n'est pas au programme du jour, et le mot suffit : mettre
    son code à disposition sous une forme qu'une commande installe.
    Fabriquer le paquet est au cours 3, avec `[project.scripts]`.

    La ligne surlignée est celle que la manipulation fait lire avant de
    lancer quoi que ce soit : le projet annonce avoir besoin de
    `markdown`.

    Ne pas détailler `[build-system]` : dire qu'aucun projet ordinaire n'a
    à en changer.

    Diapositive à passer vite si l'horaire déborde ; elle prépare le cours
    3 plus qu'elle ne sert la manipulation du jour.
  ]
]
#d("L'outil qui installe un environnement")[
  #annonce[
    `conda` lit le fichier de dépendances, résout les dépendances transitives et
    installe le tout. Il n'a pas de fenêtre : il s'emploie en tapant une
    commande.
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

  #align(center, schema-depots())

  #legende[
    Les deux ne s'opposent pas : un paquet conda-forge est le plus souvent
    construit à partir de PyPI, quelques jours plus tard. Projets relevés le
    8 septembre 2026 dans l'index de PyPI, recettes conda-forge le même jour.
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
      jupyterlab numpy pillow pandoc ffmpeg imagemagick
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
