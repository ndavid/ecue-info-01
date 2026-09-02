#import "theme.typ": diapos, d, notes, legende, face-a-face, panneau, accent, estompe

#show: diapos.with(
  titre: "Logiciel, programmation et formats de fichier",
  sous-titre: "Cours 1 — Introduction à l'informatique",
  auteur: "1re année géomatique",
  date: "15 septembre",
)

// Boîte d'un schéma en chaîne.
#let bloc(titre, detail, plein: false) = block(
  width: 100%, height: 100%, inset: 12pt, radius: 5pt,
  fill: if plein { accent.lighten(88%) } else { none },
  stroke: 1pt + accent.lighten(if plein { 40% } else { 65% }),
)[
  #align(center)[
    #text(size: 19pt, weight: "semibold")[#titre]
    #v(0.25em)
    #text(size: 14pt, fill: estompe)[#detail]
  ]
]

#let fleche = align(horizon + center, text(size: 26pt, fill: accent)[→])

// ---------------------------------------------------------------------------

#d("La séance répond à quatre questions qui s'enchaînent")[
  #table(
    columns: (auto, 1fr, auto),
    inset: 10pt,
    align: (left + horizon, left + horizon, right + horizon),
    stroke: (x, y) => if y > 0 { (top: 0.5pt + estompe.lighten(50%)) },
    [Qu'est-ce qu'un logiciel ?], [entrée, traitement, sortie], [12′],
    [D'où vient-il ?], [d'un texte écrit par un humain], [10′],
    [Dans quel fichier écrit-on ce texte ?], [formats, extensions, mise en forme], [40′],
    [Avec quels outils ?], [éditeur, environnement, notebook], [43′],
  )

  #notes[
    Annoncer que chaque question naît de la réponse précédente : rien n'est
    introduit sans avoir été rendu nécessaire. Les deux dernières lignes sont
    des manipulations, pas de l'exposé.
  ]
]

#d("Un logiciel transforme des données d'entrée en données de sortie")[
  #grid(
    columns: (1fr, 42pt, 1fr, 42pt, 1fr),
    rows: 108pt,
    bloc("Entrée", "un fichier, un clic, un relevé GPS"),
    fleche,
    bloc("Traitement", "une suite d'instructions", plein: true),
    fleche,
    bloc("Sortie", "un fichier, une image, une action"),
  )

  #notes[
    Schéma réutilisé toute la séance et tout le semestre. Le TD final est
    exactement ce schéma : une image en entrée, un calcul, une image en sortie.
    Ne pas entrer dans l'architecture machine, c'est le cours 5.
  ]
]

#d("Le fichier exécuté est binaire, mais il a été écrit en texte")[
  #face-a-face(
    panneau("Ce qu'a écrit un humain")[
      ```python
      largeur = 1920
      hauteur = 1080
      print(largeur * hauteur)
      ```
    ],
    panneau("Ce que lit le processeur")[
      ```
      7f45 4c46 0201 0100 0000
      0300 3e00 0100 0000 1ef5
      4000 0000 0000 0000 887d
      0000 0000 4000 3800 0c00
      ```
    ],
  )

  #legende[Premiers octets de l'exécutable `python3`, vus en hexadécimal.]

  #notes[
    Faire remarquer `7f 45 4c 46` : c'est « ELF », lisible en ASCII. Un fichier
    binaire n'est pas du bruit, il a une structure — on l'ouvrira nous-mêmes au
    cours 3.
  ]
]

#d("Python lit le texte au fil de l'exécution, C le traduit d'abord")[
  #table(
    columns: (auto, 1fr, 1fr),
    inset: 11pt,
    align: left + horizon,
    stroke: (x, y) => if y > 0 { (top: 0.5pt + estompe.lighten(50%)) },
    [], [Interprété], [Compilé],
    [Ce qui se passe], [le texte est lu et exécuté ligne à ligne],
      [le texte est traduit en binaire une fois pour toutes],
    [Sur le disque], [rien de nouveau], [un exécutable],
    [Exemples], [Python, JavaScript], [C, C++, Rust],
    [Vitesse d'exécution], [lente], [rapide],
  )

  #notes[
    Semer ici le facteur ×100 à ×1000 du cours 6 et du TD 7 : `numpy` est rapide
    parce qu'il délègue à du C compilé. Ne pas développer maintenant.
  ]
]

#d("L'extension ne change pas le contenu du fichier")[
  ```python
  a = Path("raven_une_ligne.txt").read_bytes()
  b = Path("raven_une_ligne.donnees").read_bytes()
  a == b
  ```

  #v(0.5em)
  #align(center, text(size: 30pt, fill: accent, weight: "bold")[True])

  #legende[Deux noms, deux extensions, exactement les mêmes octets.]

  #notes[
    Enchaîner sur la conséquence : une extension peut mentir. Le seul moyen de
    savoir ce que contient un fichier est de regarder ses octets. Faire activer
    l'affichage des extensions dans l'explorateur, une fois pour toutes.
  ]
]

#d("Un fichier texte contient des caractères, pas des lignes")[
  ```python
  brut = Path("raven_une_ligne.txt").read_text(encoding="utf-8")
  print(len(brut), "caractères,", brut.count("\n"), "saut de ligne")
  ```

  #v(0.4em)
  ```
  1341 caractères, 1 saut de ligne
  ```

  #legende[
    Le poème entier tient sur une ligne. Le saut de ligne est un caractère
    comme un autre : s'il n'y en a pas, il n'y a pas de lignes.
  ]

  #notes[
    C'est l'énoncé de la première manipulation : remettre le texte en forme,
    c'est ajouter au fichier une information qu'il ne contenait pas.
  ]
]

#d[Un fichier `.odt` est une archive ZIP de fichiers XML][
  ```python
  with zipfile.ZipFile("raven.odt") as archive:
      print(archive.namelist())
  ```

  #v(0.4em)
  ```
  ['mimetype', 'meta.xml', 'META-INF/manifest.xml', 'content.xml',
   'manifest.rdf', 'styles.xml', 'settings.xml',
   'Configurations2/accelerator/current.xml', 'Thumbnails/thumbnail.png']
  ```

  #legende[`.docx`, `.xlsx` et `.epub` sont construits de la même façon.]

  #notes[
    Faire ouvrir `content.xml` dans l'éditeur : le texte du poème est là,
    entouré de balises de mise en forme. C'est aussi la réponse à « pourquoi un
    `.odt` se versionne mal ».
  ]
]

#d("Le navigateur ignore les sauts de ligne du fichier source")[
  #face-a-face(
    panneau[Fichier `.html`][
      ```html
      <p>Once upon a midnight dreary,
      while I pondered, weak and weary,
      Over many a quaint and curious
      volume of forgotten lore—</p>
      ```
    ],
    panneau("Rendu à l'écran")[
      #block(inset: 10pt, radius: 4pt, stroke: 0.8pt + estompe.lighten(50%))[
        #set text(size: 15pt)
        Once upon a midnight dreary, while I pondered, weak and weary, Over many
        a quaint and curious volume of forgotten lore—
      ]
    ],
  )

  #legende[En HTML, la structure se déclare avec des balises : `<p>`, `<br>`.]

  #notes[
    L'adresse commence par `file://` : aucun serveur, aucun réseau, le
    navigateur lit un fichier local. Point important pour la suite du semestre.
  ]
]

#d("Une feuille de style change l'apparence sans toucher au contenu")[
  #face-a-face(
    panneau[`raven_brut.html`][
      #block(inset: 10pt, radius: 4pt, stroke: 0.8pt + estompe.lighten(50%), width: 100%)[
        #set text(size: 13pt, font: ("DejaVu Serif", "Libertinus Serif"))
        #text(size: 17pt, weight: "bold")[The Raven] \
        Edgar Allan Poe (1845) \
        #v(0.2em)
        Once upon a midnight dreary, while I pondered, weak and weary…
      ]
    ],
    panneau[`raven_style.html` + `style.css`][
      #block(inset: 10pt, radius: 4pt, fill: rgb("#faf8f4"), stroke: 0.8pt + rgb("#ddd8cd"), width: 100%)[
        #set text(size: 13pt, fill: rgb("#2b2b2b"))
        #text(size: 17pt, weight: "bold")[The Raven] \
        #text(style: "italic", fill: rgb("#6b6b6b"))[Edgar Allan Poe (1845)]
        #v(0.3em)
        Once upon a midnight dreary, \
        while I pondered, weak and weary,
      ]
    ],
  )

  #legende[Le fichier `.html` est identique dans les deux cas ; seule la ligne `<link rel="stylesheet">` diffère.]

  #notes[
    Faire éditer `style.css` et recharger avec F5. Même principe que le Markdown
    d'un README, et que la séparation code / configuration qu'ils reverront
    partout.
  ]
]

#d("Un environnement conda fige les outils du module")[
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

#d("Dans un notebook, l'état vit dans le noyau, pas dans le fichier")[
  #grid(
    columns: (1fr, 88pt, 1fr),
    rows: 110pt,
    bloc("Interface", "navigateur ou VSCode, affiche"),
    align(horizon + center)[
      #text(size: 20pt, fill: accent)[→] \
      #text(size: 13pt, fill: estompe)[code] \
      #v(0.2em)
      #text(size: 20pt, fill: accent)[←] \
      #text(size: 13pt, fill: estompe)[résultats]
    ],
    bloc("Noyau", "un processus Python, calcule et retient", plein: true),
  )

  #notes[
    Démonstration en direct : `x = 10`, puis `print(x * 2)` → 20. Modifier la
    première cellule en `x = 3` sans l'exécuter : la seconde affiche toujours
    20. Puis Restart & Run All. Conclure sur le réflexe avant tout partage.
  ]
]

#d[Un `.ipynb` enregistre ses résultats, un fichier MyST ne les enregistre pas][
  #table(
    columns: (1fr, auto, auto),
    inset: 11pt,
    align: (left + horizon, center + horizon, center + horizon),
    stroke: (x, y) => if y > 0 { (top: 0.5pt + estompe.lighten(50%)) },
    [Même modification : `1920` → `3840`], [`.ipynb`], [MyST `.md`],
    [Lignes modifiées dans le `diff`], [44], [2],
    [Taille du fichier], [17,6 ko], [11,5 ko],
  )

  #legende[
    Mesuré sur la page « Environnement Python » de ce cours. Le `.ipynb`
    contient aussi les résultats, qui changent à chaque exécution.
  ]

  #notes[
    Boucler explicitement : même contenu, deux formats — la question du début de
    séance, appliquée à leur propre travail. Et transition vers le cours 2 :
    c'est pour cette raison que le texte se versionne bien.
  ]
]

#d("Ce qu'il faut retenir de cette séance")[
  #table(
    columns: (auto, 1fr),
    inset: 10pt,
    align: left + horizon,
    stroke: (x, y) => if y > 0 { (top: 0.5pt + estompe.lighten(50%)) },
    [Un logiciel], [transforme une entrée en sortie ; son traitement part d'un texte],
    [Une extension], [nomme le fichier, elle ne dit pas ce qu'il contient],
    [Un format], [décide de ce qu'on peut relire, comparer et versionner],
    [Un environnement], [rend l'outillage reproductible d'un poste à l'autre],
    [Un notebook], [exécute dans un noyau, qui garde l'état entre les cellules],
  )

  #notes[
    Enchaîner sur le dépôt de notes : chacun écrit les notes du jour en
    Markdown. Git arrive au cours 2 ; aujourd'hui, seulement le fichier.
  ]
]
