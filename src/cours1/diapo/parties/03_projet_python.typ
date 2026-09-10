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

#d("Librairie : illustration de l'intérêt")[
  #annonce[
    Ecrire un programme qui convertit markdown en html peut être complexe avec seulement les
    fonctions fournies par l'interpréteur python. 
    Des librairies permettent de faire cela plus facilement. On ré-utilise du code fait par 
    d'autres personnes.
  ]

  #face-a-face(
    panneau("Ce qu'il faudrait reconnaitre sans bibliothèque")[
      #tableau(
        entete: false,
        columns: (auto, 1fr),
        align: left + horizon,
        [`#`], [un titre, et son niveau],
        [`-`, `1.`], [des listes, imbriquées ou non],
        [`|`], [des tableaux, alignés ou non],
        [`*`], [l'emphase, sauf dans du code],
        [`[…](…)`], [des liens, et leurs parenthèses],
      )
      #v(0.3em)
      #text(size: 13.5pt, fill: estompe)[
        et les combinaisons des cinq
      ]
    ],
    panneau("Avec la bibliothèque")[
      ```python
      import markdown

      html = markdown.markdown(source)
      ```
      #v(0.4em)
      ```
      <h1>Trajet</h1>
      <p>Trace le trajet de la gare
      ```
    ],
  )

  #legende[
    Sortie réelle. `markdown` 3.10.3 compte 33 fichiers et 8 480 lignes de
    Python, relevés le 10 septembre 2026 : dix-huit ans de cas particuliers,
    signalés par des utilisateurs et corrigés un par un.
  ]

  #notes[
    Le motif n'est plus de gagner du temps de frappe, c'est de faire ce
    qu'on ne saurait pas faire dans la semaine. Faire lire la colonne de
    gauche à voix haute : chaque ligne est un analyseur à écrire.

    C'est la ligne `import markdown` de la manipulation qui suit, sur le
    fichier qu'ils auront écrit eux-mêmes.
  ]
]
#d("Une bibliothèque ou un convertisseur tout fait")[
  #annonce[
    Un programme de conversion existe déjà, `pandoc`, et fait très bien la
    même chose. La bibliothèque, elle, se règle depuis le code.
  ]

  #face-a-face(
    panneau("Le tableau de la recette, converti tel quel")[
      ```python
      html = markdown.markdown(source)
      ```
      #v(0.3em)
      ```
      <p>| Ingrédient | Quantité |
      |---|---|
      | Farine | 250 g |
      ```
    ],
    panneau("Le même, en demandant les tableaux")[
      ```python
      html = markdown.markdown(source,
                               extensions=["tables"])
      ```
      #v(0.3em)
      ```
      <table>
      <thead>
      <tr><th>Ingrédient</th><th>Quantité</th></tr>
      ```
    ],
  )

  #legende[
    Sorties réelles sur le `recette.md` de la manipulation. Le tableau reste
    du texte brut à gauche ; à droite, un argument de plus le rend en vrai
    tableau HTML.
  ]

  #notes[
    La question vient toujours : « pourquoi ne pas lancer `pandoc` ? »
    Réponse honnête : pour une conversion unique, `pandoc` suffit et
    demande moins. La bibliothèque sert quand la conversion est une étape
    d'un programme — quand il faut choisir ce qui est traduit, l'insérer
    dans une page à soi, ou refaire l'opération sur cent fichiers.

    C'est aussi la différence entre un outil qu'on installe et du code
    qu'on appelle : le premier fait ce qu'il fait, le second se règle.

    Ne pas détailler les extensions : `tables` suffit à faire voir le
    principe. La manipulation qui suit s'en sert.
  ]
]
#d("Le programme de la manipulation")[
  #annonce[
    Deux calculs, écrits comme des fonctions : le nombre de convives, et le
    système d'unités.
  ]

  #set text(size: 19pt)
  ```python
  def pour_personnes(ingredients, personnes):
      resultat = []
      for nom, quantite, unite in ingredients:
          resultat.append((nom, quantite * personnes, unite))
      return resultat


  def convertir(quantite, unite):
      if unite == "g":
          return quantite / 28.3495, "oz"      # une once vaut 28,3495 g
      if unite == "ml":
          return quantite / 236.588, "cup"     # une cup vaut 236,588 ml
      return quantite, unite
  ```

  #legende[
    Code réel du projet. Un ingrédient est un triplet, son nom, sa quantité et
    son unité, lu dans `ingredients.csv` : `Farine,60,g` pour une personne. Ce
    qui se compte, les œufs, n'a pas d'unité et ressort inchangé.
  ]

  #notes[
    Deux fonctions séparées parce qu'elles répondent à deux questions
    différentes, et qu'on peut vouloir l'une sans l'autre. C'est aussi ce
    qui permet de les essayer une par une dans l'interpréteur.

    Ce que ce code n'installe pas : convertir des unités ne vaut pas une
    bibliothèque. `pint` existe et le fait très bien, à l'échelle de la
    physique ; deux facteurs et un dictionnaire suffisent ici. La
    bibliothèque se justifie pour le Markdown, huit mille lignes, pas pour
    diviser par 28,3495. C'est l'arbitrage de la partie, en un exemple.

    Le tableau n'est pas dans `recette.md` : il est calculé, puis inséré
    sous le titre « Ingrédients ». Le même fichier sert donc pour deux
    personnes et pour douze, en grammes ou en onces.

    `i | {…}` fabrique un dictionnaire neuf : la ligne de départ n'est pas
    modifiée. Ne pas s'y arrêter, c'est du cours 3.
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
