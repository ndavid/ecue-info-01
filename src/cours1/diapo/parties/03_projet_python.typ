// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-isolation, schema-depots, schema-diamant, schema-chemin

// ======================== Structure d'un projet Python ======================

#separateur(
  "Structure d'un projet Python",
  annonce: "Ce qu'un projet contient en plus du code : les bibliothèques dont il dépend, les fichiers qui les déclarent, et sa documentation",
)
// ------------------------- Dépendances et environnement -----------------------

#d("Dépendances directes et transitives")[
  #annonce[
    Une ligne `import` désigne du code publié par d'autres. Chaque bibliothèque
    réclame à son tour les siennes.
  ]

  ```python
  import numpy as np
  from PIL import Image
  ```

  #v(0.5em)

  #chaine(
    ecart: 30pt,
    ("environment.yml", "7 dépendances directes"),
    ("ce qu'elles déclarent", "pillow en déclare 14, ffmpeg 53"),
    ("l'environnement obtenu", "293 paquets installés"),
  )

  #legende[
    Une bibliothèque dont un programme a besoin pour s'exécuter est une
    _dépendance_ ; celles qu'elle entraîne à son tour sont _transitives_.
    Relevé le 8 septembre 2026 : sept paquets demandés, 293 installés d'après
    `conda create --dry-run`.
  ]

  #notes[
    Deux mots à poser, employés toute l'année : les paquets écrits dans le
    fichier sont les dépendances *directes*, celles qu'ils entraînent sont
    *transitives*. Calculer l'ensemble à partir du fichier s'appelle
    *résoudre* les dépendances.

    Écarter « librairie », faux ami de *library*.

    Ce qu'on gagne à réutiliser n'est pas du temps de frappe : du code
    publié a été relu, corrigé et éprouvé par d'autres, ce qu'un programme
    écrit dans la semaine ne peut pas être. Réécrire `pillow` serait
    refaire trente ans de corrections sur les formats d'image.

    Une recette qui commence par « prenez une pâte brisée » : on ne la
    fabrique pas, mais il faut qu'elle soit dans le placard, et que ce
    soit la bonne.

    Récursif au sens propre : la même règle s'applique à chaque paquet
    atteint, jusqu'à n'en plus trouver de nouveau. Le dernier nombre n'est
    la somme d'aucun des précédents, les dépendances se recouvrant.
    Personne ne tient cette liste à la main, et c'est ce qui justifie
    l'outil.

    L'autre face du même geste vient plus tard dans la partie : ce code
    est réutilisable parce que quelqu'un l'a distribué, et distribuer le
    sien demande de décrire son projet dans un fichier.

    Ne pas parler d'installation ici : c'est la suite de la partie.
  ]
]
#d("Résoudre les dépendances")[
  #align(center, schema-diamant())

  #legende[
    Exigences réelles, lues dans l'environnement `recette` de la manipulation
    qui suit. `libgcc` y est réclamé par seize paquets, et une seule version en
    est installée.
  ]

  #notes[
    C'est ce qui distingue une résolution d'un parcours du graphe : il ne
    suffit pas de suivre les flèches, il faut choisir une version par
    paquet, et le même paquet n'apparaît qu'une fois dans l'environnement.

    Ici les trois exigences se recouvrent, et `libgcc 16.2.0` convient à
    toutes. Si l'une d'elles disait `libgcc <15`, aucune version ne
    conviendrait, et `conda` refuserait de créer l'environnement plutôt
    que d'en fabriquer un cassé. C'est aussi ce qui explique qu'une
    installation soit lente.

    Ne pas dire « conflit » comme si c'était une panne : c'est le cas
    ordinaire, et il se règle presque toujours seul.

    Le nom `libgcc` peut surprendre dans un environnement Python : c'est la
    bibliothèque d'exécution du compilateur C, et l'interpréteur lui-même
    est écrit en C. Diapositive « Ce qu'une bibliothèque contient
    vraiment ».
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
#d("Ce que l'activation d'un environnement change")[
  #annonce[
    Activer un environnement n'installe rien et ne déplace rien : cela pose un
    dossier de plus en tête de la liste où le terminal cherche les commandes.
  ]

  #align(center, schema-chemin())

  #legende[
    Chemins relevés sur un poste, avant et après `conda activate`. La liste
    parcourue est celle de la variable `PATH`.
  ]

  #notes[
    La diapositive répond à la question qui revient tout le semestre :
    « pourquoi `python` n'est pas le même selon le terminal ? ». Le mot
    `python` ne désigne pas un programme, mais le premier fichier de ce nom
    trouvé dans la liste.

    Conséquence immédiate, à énoncer : `conda install` pose le paquet dans
    l'environnement actif, et un terminal ouvert avant l'activation ne le
    verra pas. C'est le `ModuleNotFoundError` de la diapositive précédente,
    vu par son mécanisme.

    Deuxième conséquence : désactiver ne désinstalle rien, cela retire le
    dossier de la tête de la liste.

    Sous Windows, la liste est la même variable, les dossiers s'y séparent
    par un point-virgule et non par un deux-points. Ne pas s'y attarder.

    `PATH` est repris au cours 2, avec les chemins et le dossier courant ;
    ici, seul l'ordre de parcours compte.
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
// ---------------------- La documentation du projet --------------------------

#d("Les fichiers texte d'un projet")[
  #annonce[
    Le code n'est pas le seul texte d'un projet. Les réglages, les données et
    la documentation s'écrivent aussi en texte, dans le même éditeur.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: left + horizon,
    [Fichier], [Ce qu'il porte], [Qui le lit],
    [`.py`], [les instructions du programme], [l'interpréteur],
    [`.csv`], [des données en tableau], [un programme, un tableur],
    surligne[`.md`],
      surligne[la documentation, les notes, le `README`],
      surligne[un humain],
    [`.json`, `.yaml`], [les réglages, des données structurées], [un programme],
  )

  #legende[
    Tous s'ouvrent dans l'éditeur, se comparent ligne à ligne et se
    versionnent. C'est le `.md` qui occupe la suite de cette partie : c'est
    celui que vous écrirez le plus tôt et le plus souvent.
  ]

  #notes[
    On n'écrit pas que du code dans un éditeur de code : sur un projet
    réel, les fichiers de réglage et la documentation sont souvent plus
    nombreux que les fichiers de programme.

    `.json` et `.yaml` portent la même chose et se convertissent l'un en
    l'autre ; le premier est écrit par les programmes, le second par les
    humains, parce qu'il accepte des commentaires. Une phrase, pas plus.

    Le `README` est nommé dès maintenant : livrable de fin de séance, et
    premier commit du cours 2.
  ]
]
#d("Trois façons d'écrire un document")[
  #annonce[
    Le choix se fait sur ce qu'on veut pouvoir faire ensuite : relire,
    comparer, ou mettre en page.
  ]

  #tableau(
    columns: (1.1fr, 0.9fr, 1fr, 1fr),
    align: left + horizon,
    [], [`.txt`], [`.md`], [`.odt`, `.docx`],
    [Titres, listes, emphase], [aucun], [dans le texte], [dans des balises],
    [Lisible sans logiciel], [oui], [oui], [non],
    [Se compare ligne à ligne], [oui], [oui], [non],
    [Mise en page fine], [non], [non], [oui],
    [Quand l'employer],
      [une note jetable, la sortie d'un programme],
      [`README`, notes, doc d'un projet],
      [un rapport à rendre, une charte imposée],
  )

  #legende[
    Markdown se convertit vers les autres, `pandoc notes.md -o notes.pdf` au
    cours 2 : le choix n'engage pas le rendu final.
  ]

  #notes[
    Les trois colonnes ne s'opposent pas : elles répondent à trois besoins
    qu'on a tour à tour dans la même semaine.

    Piège à désamorcer, sans quoi ils retournent à LibreOffice : « mon
    rapport doit être en PDF » n'est pas un argument contre Markdown,
    `pandoc` produisant le PDF depuis le `.md`. On perd le contrôle fin de
    la mise en page, on gagne de pouvoir relire, comparer et versionner.
    Nommer l'arbitrage.

    Le `.txt` n'est pas inférieur : c'est le format des sorties de
    programme et des relevés, où toute structure gênerait. Le poème du
    début de séance en est un.
  ]
]
#d("L'intention de Markdown")[
  #annonce[
    John Gruber, 2004 : un format de texte facile à lire et à écrire,
    convertible en HTML, et publiable tel quel sans avoir l'air balisé.
  ]

  #face-a-face(
    panneau[Le fichier `.md`][
      ```markdown
      # The Raven

      Poème d'*Edgar Allan Poe*, 1845.

      - publié en janvier
      - 108 vers
      ```
    ],
    panneau[Le même contenu en HTML][
      ```html
      <h1>The Raven</h1>
      <p>Poème d'<em>Edgar Allan
      Poe</em>, 1845.</p>
      <ul><li>publié en janvier</li>
      <li>108 vers</li></ul>
      ```
    ],
  )

  #legende[
    Les deux produisent le même affichage. Celui de gauche se lit sans être
    converti, et c'est très exactement le but que Gruber s'était fixé.
  ]

  #notes[
    Markdown est annoncé le 15 mars 2004 par John Gruber sur Daring
    Fireball. Aaron Swartz en est l'unique bêta-testeur ; les titres en
    `#` viennent d'atx, son propre format. L'inspiration revendiquée est
    le courriel en texte brut.

    L'intention, qui n'est pas évidente : Markdown n'est pas un HTML
    simplifié pour ceux qui n'y arriveraient pas. Sa contrainte de départ
    est que la source reste lisible sans conversion, et tout le reste en
    découle, y compris ce qu'il ne sait pas faire.

    Depuis 2014, CommonMark en fixe une spécification et une suite de
    tests. Ne le dire que si quelqu'un signale qu'un fichier ne rend pas
    pareil partout.
  ]
]
#d("La syntaxe de Markdown")[
  #annonce[
    Une dizaine de marques suffisent, et chacune se lit telle quelle : le
    dièse annonce un titre, le tiret une puce, les astérisques une emphase.
  ]

  #face-a-face(
    panneau("Ce qu'on écrit")[
      ```markdown
      # Un titre
      ## Un sous-titre

      Du texte, de l'*emphase*,
      du **gras**.

      - une puce
      1. une étape

      [un lien](https://typst.app)
      ![une photo](poele.jpg)
      ```
    ],
    panneau("Ce qui s'affiche")[
      #block(inset: 9pt, stroke: 0.8pt + estompe.lighten(50%), width: 100%)[
        #set text(size: 13pt)
        #text(size: 19pt, weight: "bold")[Un titre] \
        #text(size: 15pt, weight: "bold")[Un sous-titre]
        #v(0.3em)
        Du texte, de l'#text(style: "italic")[emphase], du
        #text(weight: "bold")[gras].
        #v(0.3em)
        • une puce \
        1. une étape
        #v(0.3em)
        #text(fill: accent)[#underline[un lien]] \
        #text(fill: estompe)[▭ une photo]
      ]
    ],
  )

  #legende[
    Un tableau s'écrit avec des barres verticales, un bloc de code entre
    trois accents graves. Le reste s'apprend en le lisant.
  ]

  #notes[
    Ne pas faire apprendre la liste. Ce qui compte est que la colonne de
    gauche se lise déjà : l'intention de Gruber rendue concrète.

    Deux pièges, une minute chacun. Une ligne vide sépare les paragraphes,
    sans quoi deux lignes consécutives n'en font qu'un. Le dièse veut un
    espace : `#Titre` ne produit pas un titre.

    Lien et image : même syntaxe, un point d'exclamation devant pour
    l'image. Le chemin de l'image est relatif au `.md`, occasion de
    rappeler les chemins de la partie 1.

    L'aperçu est `Ctrl` + `Maj` + `V`, côte à côte avec `Ctrl` + `K` puis
    `V`.
  ]
]
