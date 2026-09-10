// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-isolation, schema-depots, schema-diamant, schema-chemin

// ======================== Structure d'un projet Python ======================

#separateur(
  "Structure d'un projet Python",
  annonce: "Ce qu'un projet contient en plus du code : sa documentation, les bibliothèques dont il dépend, et les fichiers qui déclarent les unes et les autres",
)
// ---------------------- La documentation du projet --------------------------

#d("Les fichiers texte d'un projet")[
  #annonce[
    Le code n'est pas le seul texte d'un projet. Ses réglages et sa
    documentation s'écrivent aussi en texte, dans le même éditeur.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: left + horizon,
    [Fichier], [Ce qu'il porte], [Qui le lit],
    [`.py`], [les instructions du programme], [l'interpréteur],
    surligne[`.md`],
      surligne[la documentation, les notes, le `README`],
      surligne[un humain],
    [`.toml`, `.yml`], [les réglages du projet et ses dépendances], [un outil],
    [`.csv`], [un petit jeu d'essai, pour vérifier que le programme marche], [un programme],
  )

  #avertissement[
    Les données de travail ne sont pas des fichiers du projet. Elles sont sotcker ailleur
    et le programme doit pouvoir y acceder via des chemins de fichiers. Un projet peut 
    contenir des données pour le tester (légères)
  ]

  #notes[
    On n'écrit pas que du code dans un éditeur de code : sur un projet réel,
    les fichiers de réglage et la documentation sont souvent plus nombreux
    que les fichiers de programme.

    L'avertissement est la règle qui compte pour le cours 2 : un dépôt
    n'avale pas les données. Un `.csv` de dix lignes qui sert à essayer le
    programme, oui ; le relevé de trois cents mégaoctets, non, et une image
    ou un `.xlsx` encore moins — ils ne se comparent pas ligne à ligne et
    alourdissent l'historique pour toujours.

    Où vont les données, alors : à côté du projet, dans un dossier que le
    programme reçoit en paramètre. C'est ce que fait `make_data.py` du
    module, et ce que le TD du cours 7 demandera.

    Le `README` est nommé dès maintenant : livrable de fin de séance, et
    premier commit du cours 2.
  ]
]
#d("Le format de la documentation")[
  #annonce[
    Un `.txt` n'a aucune mise en forme, un `.odt` en a mais son format se prête
    mal aux outils du code. Markdown tient le milieu : des signes dans le texte,
    que l'éditeur sait rendre.
  ]

  #face-a-face(
    panneau[Ce qu'on écrit, `README.md`][
      #set text(size: 14pt)
      #raw(
        "# Trajet\n\nTrace le trajet de la gare à l'école.\n\n## Lancer\n\n    python trajet.py\n\nLe résultat est *trajet.png*.",
        block: true, lang: "md",
      )
    ],
    panneau("Ce que l'aperçu montre")[
      #block(width: 100%, inset: (x: 10pt, y: 7pt), stroke: 0.8pt + estompe.lighten(50%))[
        #text(size: 17pt, weight: "bold")[Trajet]
        #v(0.3em)
        #set text(size: 13.5pt)
        Trace le trajet de la gare à l'école.
        #v(0.35em)
        #text(size: 15pt, weight: "bold")[Lancer]
        #v(0.25em)
        #block(fill: gris, inset: (x: 7pt, y: 5pt), width: 100%)[
          #text(font: police-code, size: 12pt)[python trajet.py]
        ]
        #v(0.25em)
        Le résultat est #emph[trajet.png].
      ]
    ],
  )

  #legende[
    Moins de possibilités qu'un traitement de texte. En échange : l'éditeur, la
    comparaison ligne à ligne, le versionnement, et une conversion quand il en
    faut une.
  ]

  #notes[
    Le piège à désamorcer, sans quoi ils retournent à LibreOffice : « mon
    rapport doit être en PDF » n'est pas un argument contre Markdown,
    `pandoc` produisant le PDF depuis le `.md`. On perd le contrôle fin de
    la mise en page, on gagne de pouvoir relire, comparer et versionner.

    Le `.txt` n'est pas inférieur : c'est le format des sorties de programme
    et des relevés, où toute structure gênerait.

    Quatre signes suffisent pour un `README` : `#` pour un titre, une ligne
    vide entre deux paragraphes, quatre espaces pour du code, des étoiles
    pour l'emphase. La syntaxe complète est la diapositive suivante.
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
      # Crêpes

      *1 heure de repos.*

      1. Mélanger la farine
      2. Casser les **œufs**
      ```
    ],
    panneau[Le même contenu en HTML][
      ```html
      <h1>Crêpes</h1>
      <p><em>1 heure de repos.</em></p>
      <ol><li>Mélanger la farine</li>
      <li>Casser les <strong>œufs</strong>
      </li></ol>
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

// ------------------ Les bibliothèques dont le projet dépend -----------------

#d("Ce que le programme fabrique")[
  #annonce[
    Deux fichiers d'entrée, une page de recette en sortie, mise à l'échelle
    demandée et dans les unités demandées.
  ]

  #grid(
    columns: (auto, auto, auto, auto, 1fr),
    column-gutter: 11pt,
    align: horizon,
    // Les deux entrées, avec un extrait de leur contenu réel.
    grid(
      rows: 2, row-gutter: 9pt,
      block(width: 158pt, inset: (x: 9pt, y: 7pt), fill: gris,
            stroke: 0.8pt + gris.darken(15%))[
        #text(font: police-code, size: 12pt, weight: demi-gras)[ingredients.csv]
        #v(0.3em)
        #set text(font: police-code, size: 10.5pt, fill: estompe)
        #set par(leading: 0.55em)
        ingredient,quantite,unite \
        Farine,60,g \
        Lait,125,ml
      ],
      block(width: 158pt, inset: (x: 9pt, y: 7pt), fill: gris,
            stroke: 0.8pt + gris.darken(15%))[
        #text(font: police-code, size: 12pt, weight: demi-gras)[recette.md]
        #v(0.3em)
        #set text(font: police-code, size: 10.5pt, fill: estompe)
        #set par(leading: 0.55em)
        \# Crêpes \
        \*10 minutes de préparation.\* \
        … \
        \#\# Ingrédients
      ],
    ),
    fleche,
    block(width: 152pt, inset: (x: 10pt, y: 9pt), fill: accent.lighten(92%),
          stroke: 0.8pt + accent.lighten(55%))[
      #set text(size: 13pt)
      Multiplier les quantités, les convertir, et poser le tableau sous le
      titre qui l'annonce.
    ],
    fleche,
    // La sortie, où l'on retrouve les mêmes lignes.
    block(width: 100%, inset: (x: 11pt, y: 9pt),
          stroke: 0.8pt + estompe.lighten(50%))[
      #text(size: 16pt, weight: "bold")[Crêpes]
      #v(0.2em)
      #text(size: 12pt, style: "italic", fill: estompe)[10 minutes de préparation.]
      #v(0.2em)
      #text(size: 12pt, fill: estompe)[…]
      #v(0.25em)
      #text(size: 14pt, weight: "bold")[Ingrédients]
      #v(0.2em)
      #set text(size: 12pt)
      #tableau(
        columns: (1fr, auto),
        align: left + horizon,
        [Ingrédient], [Quantité],
        [Farine], [240 g],
        [Lait], [500 ml],
      )
    ],
  )

  #legende[
    Pour quatre personnes : les 60 g du fichier en font 240. Le tableau de
    droite n'existe dans aucun des deux fichiers d'entrée, il est calculé.
  ]

  #notes[
    Poser le besoin avant le code : une recette s'écrit pour un nombre de
    convives, et se relit dans le système d'unités du lecteur. Les
    quantités du fichier valent pour une personne ; tout le reste se
    calcule.

    Faire remarquer que `recette.md` ne contient pas de tableau, seulement
    le titre « Ingrédients ». C'est ce qui permet au même fichier de servir
    pour deux personnes comme pour douze.

    Les cinq noms de la boîte du milieu sont l'ordre du programme, et
    l'ordre des deux diapositives qui suivent : ce que fait chaque
    fonction, puis d'où elle vient.

    Ce que la bibliothèque apporte, en une phrase : reconnaître les titres,
    les listes, les tableaux, l'emphase et les liens d'un texte Markdown,
    et leurs combinaisons. Huit mille lignes que personne n'écrit dans la
    semaine — c'est l'argument de la partie, et il ne vaut pas pour les
    conversions d'unités, qui tiennent en deux divisions.
  ]
]
#d("D'où vient chaque ligne du programme")[
  #annonce[
    Le programme entier, et l'origine de chaque appel. Deux lignes seulement
    demandent une bibliothèque à installer.
  ]

  #set text(size: 16pt)
  ```python
  import markdown                                           # installée
  from tabulate import tabulate                             # installée
  from recette import adapter, en_table, lire_ingredients   # le projet

  ingredients = lire_ingredients(ICI / "ingredients.csv")   # le projet
  ingredients = adapter(ingredients, PERSONNES, UNITES)     # le projet
  lignes = en_table(ingredients)                            # le projet

  tableau = tabulate(lignes, headers=EN_TETE)               # installée
  source = (ICI / "recette.md").read_text(encoding="utf-8") # avec Python
  source = source.replace("## Ingrédients", tableau)        # Python seul

  corps = markdown.markdown(source, extensions=["tables"])  # installée
  page = GABARIT.format(titre="Crêpes", corps=corps)        # Python seul
  sortie.write_text(page, encoding="utf-8")                 # avec Python
  ```

  #legende[
    Deux lignes seulement demandent une bibliothèque installée. `source.replace`
    est resserrée ici : elle garde le titre.
  ]

  #notes[
    Reprendre ligne à ligne, sans s'attarder :

    1. `lire_ingredients` ouvre le CSV et rend une liste de triplets, avec
    des nombres et non du texte.
    2. `adapter` multiplie par le nombre de convives, puis convertit si on
    demande les unités américaines.
    3. `en_table` fabrique les lignes à afficher : c'est là que les nombres
    redeviennent du texte.
    4. `tabulate` en fait un tableau Markdown. C'est la ligne qu'on sait
    écrire soi-même, et l'autre fichier du projet le fait.
    5. `read_text` lit la recette. `pathlib` est livrée avec Python : rien
    à installer, mais c'est bien une bibliothèque.
    6. `replace` pose le tableau sous le titre. Une méthode des chaînes,
    donc du langage lui-même.
    7. `markdown.markdown` convertit en HTML. C'est la ligne qu'on ne
    saurait pas écrire : huit mille lignes derrière elle.
    8. `format` remplit le gabarit de la page. Du langage, encore.
    9. `write_text` écrit le fichier, et la page est prête.

    La leçon tient dans le décompte : sur neuf lignes, deux dépendent d'une
    installation. C'est peu, et c'est pourtant ce qui décide qu'un
    programme marche ou non sur une autre machine. D'où le fichier qui les
    déclare.

    Distinguer les trois origines : le code du projet, qu'on écrit et qu'on
    versionne ; la bibliothèque standard, qui vient avec l'interpréteur ;
    les bibliothèques installées, qui manquent tant qu'on ne les a pas
    demandées. Seules les dernières produisent un `ModuleNotFoundError`.
  ]
]
#d("Deux sortes de bibliothèques")[
  #annonce[
    Certaines viennent avec Python et s'importent sans rien faire. Les autres
    doivent être installées avant que la ligne `import` passe.
  ]

  #face-a-face(
    panneau("Livrées avec Python")[
      ```python
      import math
      print(math.sqrt(2))
      ```
      ```
      1.4142135623730951
      ```
      #text(size: 14pt, fill: estompe)[
        `math`, `csv`, `pathlib`, `json` : environ deux cents modules,
        installés en même temps que l'interpréteur.
      ]
    ],
    panneau("Publiées par d'autres")[
      ```python
      import numpy
      ```
      ```
      ModuleNotFoundError:
      No module named 'numpy'
      ```
      #text(size: 14pt, fill: estompe)[
        `numpy`, `pillow`, `markdown` : il faut les installer, et savoir
        lesquelles.
      ]
    ],
  )

  #legende[
    Sorties réelles dans un environnement réduit à Python. C'est la colonne de
    droite qui rend nécessaire tout ce qui suit : installer, puis décrire ce
    qu'on a installé.
  ]

  #notes[
    Diapositive charnière : tout le reste de la partie répond à la colonne
    de droite. Y revenir si la salle décroche sur les fichiers de
    description.

    La bibliothèque livrée avec Python s'appelle la *bibliothèque
    standard*. Elle explique pourquoi `import csv` a marché deux
    diapositives plus tôt sans qu'on installe quoi que ce soit.

    Le message d'erreur est le même que celui de la partie 2 et que celui
    de la manipulation à venir. Troisième rencontre, et cette fois la
    cause est nommée : la bibliothèque n'est pas dans l'environnement
    actif.

    Ne pas dire que la bibliothèque standard suffit : ni `numpy`, ni
    `pillow`, ni `pandas` n'en font partie, et c'est là que sont les
    outils du métier.
  ]
]
#d("Installation de bibliothèques : les dépendances")[
  #annonce[
    Une bibliothèque en réclame d'autres. Les installer demande d'abord la
    liste complète, puis une version par paquet qui convienne à tous.
  ]

  #grid(
    columns: (0.72fr, 1.28fr), column-gutter: 26pt, align: horizon,
    chaine-verticale(
      ("les bibliothèques utilisées", "numpy, pillow, pandoc, ffmpeg… 7 en tout"),
      ("ce qu'elles déclarent", "pillow en déclare 14, ffmpeg 53"),
      ("l'environnement obtenu", "293 paquets installés"),
    ),
    align(center, scale(72%, reflow: true, schema-diamant())),
  )

  #legende[
    À gauche : les paquets écrits dans le fichier sont les dépendances
    _directes_, celles qu'ils entraînent sont _transitives_. À droite :
    `pillow` et ses deux dépendances réclament le même `libzlib`, dont une
    seule version sera installée. Sept bibliothèques demandées, 293 paquets
    installés, relevés les 8 et 10 septembre 2026.
  ]

  #notes[
    Deux temps, et deux moitiés de diapositive. À gauche, la liste : la
    relation est récursive, la même règle s'appliquant à chaque paquet
    atteint jusqu'à n'en plus trouver de nouveau. Le dernier nombre n'est
    la somme d'aucun des précédents, les dépendances se recouvrant.
    Personne ne tient cette liste à la main, et c'est ce qui justifie
    l'outil.

    À droite, le choix : calculer l'ensemble à partir du fichier s'appelle
    *résoudre* les dépendances, et ce n'est pas un simple parcours du
    graphe. Il faut choisir une version par paquet, le même paquet
    n'apparaissant qu'une fois dans l'environnement.

    Ici les deux exigences se recouvrent, et `libzlib 1.3.2` convient aux
    deux. Si l'une disait `libzlib <1.3`, aucune version ne conviendrait,
    et `conda` refuserait de créer l'environnement plutôt que d'en
    fabriquer un cassé. C'est aussi ce qui explique qu'une installation
    soit lente.

    Ne pas dire « conflit » comme si c'était une panne : c'est le cas
    ordinaire, et il se règle presque toujours seul.

    Écarter « librairie », faux ami de *library*.

    Les noms en `lib…` peuvent surprendre dans un environnement Python :
    `libtiff`, `openjpeg` et `libzlib` ne sont pas écrits en Python. Une
    bibliothèque d'images enveloppe du code C déjà compilé, et ce sont ces
    morceaux-là qui rendent l'installation difficile.
  ]
]
#d("Le numéro de version d'une dépendance")[
  #annonce[
    D'une version à l'autre, une bibliothèque gagne des fonctions et en retire
    d'autres. Le même code ne passe donc pas partout.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Le code], [avec `numpy` 1.26.4], [avec `numpy` 2.5.2],
    [`np.trapezoid([0, 1, 2])`],
      [`AttributeError: module 'numpy' has no attribute 'trapezoid'`],
      [`2.0`],
    [`np.NaN`],
      [`nan`],
      [`AttributeError: np.NaN was removed in the NumPy 2.0 release`],
  )

  #v(0.5em)
  #align(center)[
    #text(size: 17pt)[
      La valeur n'a pas disparu. En 1.26, `np.nan`, `np.NaN` et `np.NAN`
      désignent la même chose ; la version 2.0 n'en garde qu'une.
    ]
  ]

  #legende[
    Sorties réelles, relevées le 10 septembre 2026 dans deux environnements.
    D'où deux exigences opposées : `numpy>=2` pour la première ligne,
    `numpy<2` pour la seconde tant que le code n'est pas repris.
  ]

  #notes[
    La diapositive répond à la question qui vient toujours : pourquoi ne
    pas prendre la dernière version de tout ?

    Première ligne, le motif de monter : `trapezoid` n'existe pas avant
    numpy 2.0. Un projet qui l'emploie exige au moins cette version, et
    c'est le cas ordinaire — on veut ce qui a été ajouté et corrigé.

    Seconde ligne, le motif de ne pas monter : `np.NaN` a disparu dans la
    même version. Le code qui l'emploie s'arrête, et la reprise a un coût,
    parfois sur des milliers de lignes. D'où des projets qui restent
    volontairement sur une version ancienne.

    Pourquoi retirer quelque chose qui marchait ? Ici, rien n'est perdu :
    `np.nan` reste, et seules ses orthographes en double partent. NumPy 1.26
    acceptait trois façons d'écrire « pas un nombre » et cinq d'écrire
    « l'infini » — `np.inf`, `np.Inf`, `np.Infinity`, `np.infty`, `np.PINF`.
    La version 2.0 n'en garde qu'une de chaque, pour qu'il n'y ait qu'une
    façon d'écrire chaque chose.

    C'est le motif ordinaire d'un retrait : non pas supprimer une
    possibilité, mais cesser d'en offrir plusieurs pour la même. Le coût est
    quand même réel, puisqu'il tombe sur le code déjà écrit.

    Le second message d'erreur est exemplaire : il dit ce qui a été retiré,
    dans quelle version, et par quoi le remplacer. Tous ne le font pas.

    Le mot à poser : une dépendance ne se déclare pas par un nom seul, mais
    par un nom et une exigence de version. C'est ce que porte la ligne
    `dependencies` du fichier, diapositives suivantes.

    Ne pas entrer dans la numérotation sémantique : le cours 3 y revient
    quand ils publieront quelque chose.
  ]
]
#d("Environnement : un moyen de gérer les conflits de dépendances")[
  #annonce[
    Un projet suit `numpy 1.26`, l'autre `numpy 2.1` : installées ensemble, la
    seconde chasse la première. D'où un dossier par projet, un *environnement*.
  ]

  #align(center, scale(92%, reflow: true, schema-isolation()))

  #legende[
    Les deux versions coexistent sans se croiser, et le Python du système n'est
    pas touché.
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
#d("Comment installer des librairies python")[
  #annonce[
    Plusieurs outils existent et l'ecosytème évolue encore. Ici on utilisera `conda`.
    Vocabulaire : en python librairie est appelée package.
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
#d("Créer un environnement avec conda")[
  #annonce[
    `conda` fait les deux. Soit on compose l'environnement commande par
    commande, soit un fichier le décrit et une seule commande le recrée.
  ]

  #face-a-face(
    panneau("Composer un environnement")[
      ```bash
      conda create -n info01 \
          -c conda-forge python=3.12

      conda install -n info01 \
          -c conda-forge numpy pillow

      conda activate info01
      ```
      #text(size: 14pt, fill: estompe)[
        `-n` nomme l'environnement visé, `conda activate` y entre.
      ]
    ],
    panneau("Recréer un environnement décrit")[
      ```bash
      conda env create -f environment.yml

      conda activate info01
      ```
      #v(0.4em)
      ```yaml
      name: info01
      channels:
        - conda-forge
      dependencies:
        - python=3.12
        - numpy
        - pillow
      ```
    ],
  )

  #legende[
    Le même environnement des deux façons. `-c conda-forge` désigne le dépôt
    d'où viennent les paquets.
  ]

  #notes[
    Deux gestes, et un seul outil. À gauche, on tape ; à droite, on lit un
    fichier que quelqu'un a écrit — le plus souvent soi-même, la semaine
    d'avant.

    `-n info01` nomme l'environnement visé sans y entrer. Entrer dedans,
    c'est `conda activate`, diapositive suivante : le distinguer ici évite
    la confusion la plus fréquente.

    L'environnement du module s'installe par la colonne de droite, le
    fichier étant à la racine du dépôt. La colonne de gauche est ce
    qu'ils feront pour leur propre projet.

    Ne pas lancer la création maintenant : plusieurs minutes, et c'est la
    manipulation de fin de partie.

    Le fichier n'installe rien : il dit ce qu'il faut installer. Pourquoi
    l'écrire plutôt que retaper les commandes est la diapositive
    « Déclarer des dépendances ».
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
#d("Déclarer des dépendances")[
  #annonce[
    Ce qu'on a tapé ne se retrouve pas. Écrit dans un fichier rangé avec le
    code, cela se refait ailleurs et plus tard.
  ]

  #face-a-face(
    panneau("Installé à la main")[
      ```bash
      conda install -n info01 \
          -c conda-forge numpy pillow
      ```
      #v(0.3em)
      #text(size: 15pt, fill: estompe)[
        La commande a marché, et rien n'en garde trace. Sur un autre poste, il
        faut se souvenir de ce qu'on avait tapé.
      ]
    ],
    panneau("Déclaré dans le fichier")[
      ```yaml
      dependencies:
        - python=3.12
        - numpy
        - pillow
      ```
      #v(0.3em)
      #text(size: 15pt, fill: estompe)[
        Le fichier suit le code partout, et `conda env create` refait le même
        environnement : ici, ailleurs, dans six mois.
      ]
    ],
  )

  #legende[
    Le fichier ne porte que les dépendances directes, sept pour le module : les
    293 autres sont recalculées à chaque création.
  ]

  #notes[
    La phrase à retenir de la partie : une installation est reproductible
    parce qu'un fichier la décrit, non parce qu'on se souvient de ce qu'on
    a tapé. C'est aussi ce qui est demandé au rendu.

    Écrire la liste complète des 293 serait la figer, et l'attacher à un
    système : les paquets compilés ne sont pas les mêmes sous Windows et
    sous Linux.

    Le fichier se range avec le code et le suit partout : c'est un fichier
    texte de quelques lignes, comme le reste du projet. Le versionner est
    le sujet du cours 2.

    Ce qui manque encore : ce fichier écrit à la main ne dit pas d'où vient
    chaque paquet ni en quelle version exacte. `conda env export` le fait ;
    ne pas y entrer aujourd'hui.

    Dernière étape de la manipulation : ajouter la ligne oubliée au
    fichier, et constater que rien ne s'installe puisque c'était déjà fait.
  ]
]
#d("Projet : déclaration des informations & métadonnées")[
  #annonce[
    Un projet se décrit dans un fichier texte : son nom, sa version, et ce
    dont son code a besoin.
  ]

  #face-a-face(
    panneau[`pyproject.toml`, à la racine du projet][
      ```toml
      [project]
      name = "recette"
      version = "0.1.0"
      requires-python = ">=3.10"
      dependencies = ["markdown>=3.5"]

      [project.scripts]
      recette = "recette.__main__:main"
      ```
    ],
    panneau("Ce que chaque ligne déclare")[
      #tableau(
        columns: (auto, 1fr),
        align: left + horizon,
        [Ce qui est écrit], [Ce que c'est],
        [`name`, `version`], [les métadonnées],
        surligne[`dependencies`], surligne[ce que le code importe],
        [`requires-python`], [les versions de Python],
        [`[project.scripts]`], [la commande installée],
      )
    ],
  )

  #legende[
    Contenu réel de `pyproject.toml`, écrit en TOML : des sections entre
    crochets, une valeur par nom. `environment.yml` est en YAML, où
    l'indentation porte la structure.
  ]

  #notes[
    Deux fichiers, deux descriptions, et il faut les distinguer :
    `environment.yml` dit de quoi la *machine* a besoin, y compris ce qui
    n'est pas du Python ; `pyproject.toml` dit de quoi le *code* a besoin.
    Les deux coexistent dans la plupart des projets, et dans celui de la
    manipulation.

    C'est un troisième usage du texte, après le code et la documentation :
    décrire. Ils ont croisé `.json` et `.yaml` à « Les fichiers texte d'un
    projet » ; ce sont les mêmes formats, employés ici pour déclarer. Comme
    `.json`, YAML et TOML décrivent des données ; contrairement à lui, ils
    acceptent des commentaires, ce qui explique qu'un humain les écrive. On
    les retrouve hors de Python : réglages d'un outil, description d'une
    chaîne d'intégration, composition de conteneurs.

    Piège du YAML, à mentionner si quelqu'un tape le fichier : deux espaces
    d'indentation, jamais de tabulation, et l'éditeur le signale. C'est
    « Espaces, tabulations et fins de ligne » qui resurgit.

    La ligne surlignée est celle que la manipulation fait lire avant de
    lancer quoi que ce soit : le projet annonce avoir besoin de `markdown`.

    Boucler la partie : le code réutilisé au début est disponible parce que
    quelqu'un a écrit un fichier de cette forme, puis déposé le résultat sur
    un dépôt. Fabriquer le paquet est au cours 3, avec `[project.scripts]`.

    Ne pas détailler `[build-system]`, absent de l'extrait : aucun projet
    ordinaire n'a à en changer.
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
