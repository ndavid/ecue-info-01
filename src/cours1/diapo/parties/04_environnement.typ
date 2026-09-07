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
#d("Ligne de commande et interface graphique")[
  #annonce[
    Deux façons de dire à un logiciel quoi faire, comparées sur cinq points.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Interface graphique], [Ligne de commande],
    [Ce que vous faites], [vous désignez ce que vous voyez], [vous nommez ce que vous voulez],
    [Ce qui est proposé], [ce que les menus contiennent], [tout ce que le programme accepte],
    [Pour dix fichiers], [dix fois les mêmes gestes], [la même ligne, une fois],
    [Ce qui en reste], [rien], [la commande, qui est le mode d'emploi],
    [Dire à quelqu'un quoi faire], [décrire des clics], [envoyer la ligne],
  )

  #legende[
    Les deux interfaces ne rendent pas le même service ; aucune ne remplace
    l'autre.
  ]

  #notes[
    Le point à faire passer : le mode graphique montre ce qui est possible,
    la ligne de commande suppose qu'on le sache déjà. C'est pour cela qu'on
    explore au clic et qu'on répète au clavier.

    Contre-exemple à donner si la salle penche trop d'un côté : personne ne
    retouche une photo au terminal, et personne ne renomme trois cents
    fichiers à la souris.

    La ligne suivante du tableau est celle qui compte pour le module :
    « ce qui en reste ». Elle prépare git au cours 2 et les scripts au
    cours 3.
  ]
]
#d("Anatomie d'une commande")[
  #annonce[
    Une commande se lit toujours dans le même ordre.
  ]

  #align(center)[
    #grid(
      columns: (auto, auto, auto),
      row-gutter: 8pt, column-gutter: 20pt,
      align: center,
      text(font: police-code, size: 23pt, fill: accent, weight: demi-gras, "soffice"),
      text(font: police-code, size: 23pt, fill: manip, weight: demi-gras, "--convert-to pdf"),
      text(font: police-code, size: 23pt, fill: encre, "raven.odt"),
      text(size: 14pt, fill: accent)[le programme],
      text(size: 14pt, fill: manip)[l'option : la tâche demandée],
      text(size: 14pt, fill: estompe)[l'argument : le fichier traité],
    )
  ]

  #v(0.3em)
  #tableau(
    columns: (auto, 1.1fr, 1fr),
    align: left + horizon,
    [Ce qu'on tape], [Ce que c'est], [Le geste équivalent, à la souris],
    [`soffice`],
    [LibreOffice lui-même, sous le nom de son programme],
    [ouvrir `raven.odt` dans Writer],
    [`--convert-to pdf`],
    [une option, à ses deux tirets : la tâche demandée],
    [le menu Fichier → Exporter au format PDF],
    [`raven.odt`],
    [un argument, sans tiret : le fichier traité],
    [le document ouvert dans la fenêtre],
  )

  #notes[
    Le même logiciel des deux côtés, et le même PDF produit.

    Faire le lien explicitement avec la manipulation de la première partie :
    ils ont exporté `raven.odt` en PDF en cliquant dans LibreOffice. `soffice` n'est
    pas un autre outil, c'est le même, appelé par son nom.

    Le nom surprend toujours : il vient de StarOffice, l'ancêtre de la suite.
    Le dire en une phrase et passer, l'anecdote n'a pas d'intérêt en soi.

    La lecture option / argument est ce qu'il faut retenir : c'est la grille de
    lecture de toutes les commandes du semestre, et elle rend une page d'aide
    utilisable. Le cours 3 construit une commande de cette forme avec
    `argparse`.

    Ne pas taper la commande maintenant : c'est la manipulation qui suit.
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
#d("Python en interactif")[
  #annonce[
    Taper `python` sans nom de fichier ouvre une session interactive : chaque
    ligne est lue, exécutée, et son résultat affiché aussitôt.
  ]

  ```console
  $ python
  Python 3.12.14 | packaged by conda-forge | (main, Sep  1 2026) [GCC 14.4.0]
  >>> from octets import entete, en_hexadecimal
  >>> entete("../genere/raven.odt")
  b'PK\x03\x04'
  >>> en_hexadecimal(entete("../genere/raven.pdf"))
  '25 50 44 46'
  >>> exit()
  ```

  #legende[
    Session réelle, dans `data/cours1/formats/`. Le résultat s'affiche sans
    `print` : c'est propre à la session interactive.
  ]

  #notes[
    Deux façons d'exécuter du Python, et elles ne servent pas à la même chose.
    Un script se lance en entier et se relance à l'identique ; une session
    interactive s'essaie ligne à ligne et ne laisse rien.

    Faire remarquer les trois chevrons : c'est l'invite de Python, et non
    celle du terminal. Confondre les deux est l'erreur de début de semestre,
    et elle produit `SyntaxError` quand on tape une commande du système dans
    Python.

    On y entre par `python`, on en sort par `exit()` ou `Ctrl` + `D`. Le
    dire tout de suite : on ne devine pas comment sortir.

    Le module réutilise ici son propre script, importé comme une bibliothèque.
    C'est la diapositive « Ce qu'un programme emprunte », vue de l'autre côté :
    le code de quelqu'un d'autre, c'était aussi du code écrit par eux il y a
    dix minutes.

    Amorce de la partie suivante : un notebook est cette session interactive,
    avec le texte conservé autour.
  ]
]
