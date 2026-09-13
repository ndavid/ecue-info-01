// TD 3b du cours 1 — « Installer une bibliothèque et s'en servir ».
//
// Inclus par `cours1.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "3b",
  titre: "Installer une bibliothèque et s'en servir",
  annonce: "Objectif : installer la dépendance qui manque à un programme, puis la déclarer dans le fichier qui décrit l'environnement",
  dossier: "cours1/3b_recette/",
  duree: "12′",
)
#separateur-td(..td)
#d("L'outil d'installation du module")[
  #annonce[
    Le module installe ses outils avec `conda`, depuis le dépôt `conda-forge`.
    L'outil n'a pas de fenêtre : il s'emploie en tapant une commande.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Ce que vous voulez], [Ce que vous tapez],
    [créer un environnement décrit par un fichier], [`conda env create -f environment.yml`],
    [l'activer dans le terminal courant], [`conda activate recette`],
    [savoir ce qui est installé dedans], [`conda list`],
    [y ajouter une bibliothèque], [`conda install -c conda-forge markdown`],
  )

  #legende[
    Quatre commandes pour tout le semestre, et ce sont celles du TD
    qui suit. La séance 2 revient sur la ligne de commande pour
    elle-même ; ici, elle est un outil.
  ]

  #notes[
    Le choix du module, à énoncer une fois : `conda` plutôt que `pip`,
    parce qu'il installe aussi ce qui n'est pas du Python — `ffmpeg`,
    `pandoc`, un compilateur — et `conda-forge` comme dépôt, parce que
    Miniforge n'installe que depuis lui et que les conditions d'Anaconda
    demandent une licence payante aux grandes organisations. Raison écrite
    dans `INSTALLATION.md`.

    La ligne de commande arrive ici parce que l'outil dont on a besoin
    n'existe que sous cette forme, non pour elle-même. Beaucoup de
    programmes n'ont pas de fenêtre, faute que quelqu'un en ait écrit une.

    Les chemins, le dossier courant et les motifs comme `*.odt` sont au
    cours 2 ; les diapositives correspondantes sont en annexe.

    `-c conda-forge` désigne le canal : sur un poste installé avec
    Miniforge il est déjà le défaut, et l'écrire ne coûte rien.
  ]
]
#d("Les deux environnements de la séance")[
  #annonce[
    L'environnement `info01` porte les outils de toute l'année. Le TD
    en crée un second, réduit à Python, pour voir ce qui manque.
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

  #legende[
    Le chemin affiché doit contenir le nom de l'environnement actif : c'est la
    vérification à faire avant toute autre hypothèse.
  ]

  #notes[
    `ModuleNotFoundError` sur un paquet « qu'on vient d'installer »
    signifie presque toujours que le mauvais environnement est actif.
    Prévoir l'installation d'`info01` en amont ; c'est le point qui
    déborde.

    Les deux environnements coexistent sans se voir, comme au schéma
    « Pourquoi isoler un environnement ». On revient dans `info01` à la fin
    du TD.
  ]
]
#d("Un environnement neuf")[
  #annonce[
    On repart d'un environnement qui ne contient que Python, pour voir ce qui
    s'y trouve d'origine et ce qui n'y est pas.
  ]

  #tableau(
    columns: (auto, 1.3fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [Fichier #sym.arrow.r Ouvrir le dossier, sur `cours1/3b_recette/`], [],
    [2], [ouvrir `pyproject.toml` et lire la ligne `dependencies`],
      reponse[le projet déclare avoir besoin de `markdown`],
    [3], [Terminal #sym.arrow.r Nouveau terminal, puis `conda env create -f environment.yml`], [],
    [4], [`conda activate recette`, puis `conda list`],
      reponse[28 paquets, et aucun ne s'appelle `markdown`],
    [5], [`python recette_a_la_main.py`],
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
    connue. Le fichier est là, sa syntaxe est correcte ; c'est la
    dépendance qui manque.

    Le programme lancé ici est celui qui n'a besoin que de `markdown` :
    `recette_avec_tabulate.py` en réclamerait une seconde, et `python -m
    recette` aussi. Les deux sont déclarées dans `pyproject.toml`, et
    `pip install -e .` les installerait toutes les deux d'un coup — à
    montrer si le temps le permet.

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
    [7], [`python recette_a_la_main.py`],
      reponse[`recette.html écrit pour 4 personne(s), en unités SI`],
    [8], [ouvrir la page par l'adresse `file:///` que le programme affiche],
      reponse[la recette mise en page, sans serveur ni réseau],
    [9], [changer une couleur dans `style.css`, enregistrer, `F5`],
      reponse[la page change, et le `.html` n'a pas bougé],
  )

  #legende[
    Sortie réelle dans `cours1/3b_recette/`. Les quantités du tableau sont
    calculées : le `recette.md` du projet n'en contient aucune.
  ]

  #notes[
    Étape 6 : trois paquets s'installent ici, contre un seul de 85 ko avec
    la même commande dans `info01`, où `importlib-metadata` et `zipp`
    étaient déjà présents. C'est « Dépendances directes et transitives »
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
    -m recette`. C'est `[project.scripts]`, sujet du cours 3. Vérifié
    sur la machine de préparation.

    Rendre la main : `conda deactivate`, puis `conda activate info01`.
    L'environnement `recette` peut être supprimé, `conda env remove -n
    recette`.
  ]
]
