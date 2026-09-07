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
    Une bibliothèque en réclame d'autres, qui en réclament d'autres. On demande
    quinze paquets, il s'en installe trois cent cinquante-deux.
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

  #notes[
    Sortie réelle, sur la machine du cours : le même mot `python` désigne deux
    programmes différents selon l'environnement actif.

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
