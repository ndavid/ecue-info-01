#import "theme.typ": diapos, d, separateur, annonce, notes, legende, face-a-face, panneau, accent, estompe

#show: diapos.with(
  titre: "Introduction à l'informatique",
  sous-titre: "Cours 1",
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

// =============================== Introduction ===============================

#separateur("Le module info01", annonce: "Objectifs, contenu et organisation des sept séances")

#d("Objectif du cours")[
  #annonce[
    Consolider ou acquérir les bases informatiques nécessaires aux autres
    enseignements, en particulier ceux de programmation et les TD utilisant
    Python.
  ]

  #table(
    columns: (1fr, 1fr),
    inset: 8pt,
    align: left + horizon,
    stroke: (x, y) => if y > 0 { (top: 0.5pt + estompe.lighten(50%)) },
    [Demandé dans les autres cours], [Ce qui est enseigné ici],
    [« installez Python et numpy »], [créer un environnement et le réinstaller ailleurs],
    [« ouvrez le projet fourni »], [travailler dans un éditeur de code, lire une arborescence],
    [« rendez votre code »], [versionner avec git, partager un dépôt],
    [« le script lit `donnees.csv` »], [manipuler des fichiers depuis Python],
  )

  #notes[
    Ces gestes sont attendus mais rarement enseignés. C'est le temps perdu
    dessus que le module vise à supprimer.
  ]
]

#d("Objectif pour la programmation")[
  #annonce[
    Maîtriser les bonnes pratiques de gestion d'un projet de code :
    documentation (`README`), organisation des fichiers, et usage des
    bibliothèques permettant d'écrire un programme facile à utiliser et à
    reprendre.
  ]

  #table(
    columns: (1.7fr, 0.8fr, 1fr),
    inset: 10pt,
    align: (left + horizon, center + horizon, center + horizon),
    stroke: (x, y) => if y > 0 { (top: 0.5pt + estompe.lighten(50%)) },
    [], [ce cours], [cours de programmation],
    [Quel algorithme choisir ?], [], [oui],
    [Comment écrire cette boucle ?], [], [oui],
    [Où mettre ce fichier ?], [oui], [],
    [Comment lancer le script ailleurs ?], [oui], [],
  )

  #notes[
    L'algorithmique relève du cours de programmation, qui se déroule en
    parallèle. Ajouter oralement : « retrouver la version qui marchait » relève
    aussi de ce module.
  ]
]

#d("Les quatre domaines abordés")[
  #grid(
    columns: (1fr, 1fr),
    rows: (86pt, 86pt),
    gutter: 14pt,
    bloc("Outils d'édition", "éditeur de code, arborescence de projet"),
    bloc("Versionnement", "git : enregistrer, revenir, partager"),
    bloc("Forme d'un projet", "README, environnement, fichiers, ligne de commande"),
    bloc("Culture générale", "ordres de grandeur, sécurité, outils du terminal"),
  )

  #notes[
    Les trois premiers sont les fils rouges du module. Le quatrième arrive par
    apartés, au fil des séances.
  ]
]

#d("Organisation : sept séances de deux heures")[
  #annonce[
    Chaque séance alterne des explications courtes et des manipulations faites
    sur votre machine.
  ]

  #table(
    columns: (auto, 1fr, auto),
    inset: 8pt,
    align: (center + horizon, left + horizon, center + horizon),
    stroke: (x, y) => if y > 0 { (top: 0.5pt + estompe.lighten(50%)) },
    [], [Sujet], [Type],
    [1], [Logiciel, programmation et formats de fichier], [cours],
    [2], [Ligne de commande et git local], [cours],
    [3], [Binaire, données et construction d'une CLI], [cours],
    [4], [Studio d'automatisation (animation vidéo)], [TD],
    [5], [Matériel, réseau, SSH et secrets], [cours],
    [6], [Forge, git en équipe, outil « trajectoire »], [cours],
    [7], [Benchmark image et rapport], [TD],
  )

  #notes[
    Les deux TD appliquent ce qui précède sur un livrable complet.
  ]
]

// ================================ Séance 1 ==================================

#separateur(
  "Cours 1 — Logiciel, programmation et formats de fichier",
  annonce: "Première partie du module",
)

#d("Contenu de la séance")[
  #table(
    columns: (auto, 1fr, auto),
    inset: 10pt,
    align: (left + horizon, left + horizon, right + horizon),
    stroke: (x, y) => if y > 0 { (top: 0.5pt + estompe.lighten(50%)) },
    [À quoi sert un programme], [faire faire à la machine ce qu'on ferait à la main], [12′],
    [De quoi il est fait], [de fichiers texte, écrits dans un éditeur], [10′],
    [Ce que contient un fichier], [des octets, que l'extension ne décrit pas], [40′],
    [Les outils de travail], [un éditeur, un environnement, un notebook], [43′],
  )

  #notes[
    Chaque point naît du précédent. Les deux dernières lignes sont des
    manipulations, pas de l'exposé.
  ]
]

#d("Programmes et applications")[
  #annonce[
    Un programme exécute une tâche répétitive plus vite qu'à la main, et de la
    même façon à chaque exécution.
  ]

  #table(
    columns: (1.1fr, 1fr, 1fr),
    inset: 11pt,
    align: left + horizon,
    stroke: (x, y) => if y > 0 { (top: 0.5pt + estompe.lighten(50%)) },
    [Renommer 300 photos par date], [À la main], [Par programme],
    [Durée], [une soirée], [quelques secondes],
    [Deuxième exécution], [à refaire entièrement], [identique, sans effort],
    [Erreur de recopie], [invisible], [systématique, donc repérable],
  )

  #notes[
    Une application est un programme muni d'une interface ; beaucoup de
    programmes n'en ont pas et se lancent depuis un terminal.
  ]
]

#d("Le système d'exploitation")[
  #annonce[
    Un programme ne s'adresse pas directement au matériel : il demande au
    système d'ouvrir un fichier, de réserver de la mémoire ou d'accéder au
    réseau.
  ]

  #grid(
    columns: 1fr,
    rows: (56pt, 56pt, 56pt),
    gutter: 9pt,
    bloc("Votre programme", "ouvre un fichier, réserve de la mémoire", plein: true),
    bloc("Système d'exploitation", "Windows, macOS, Linux : arbitre et donne accès"),
    bloc("Matériel", "processeur, mémoire, disque, réseau"),
  )

  #notes[
    Conséquence pratique : les chemins de fichiers ne s'écrivent pas pareil et
    les outils installés diffèrent. Le matériel est repris au cours 5.
  ]
]

#d("Entrées, sorties et code source")[
  #annonce[
    Un programme lit des fichiers et en produit d'autres. Son code est
    lui-même un fichier texte.
  ]

  #grid(
    columns: (1fr, 42pt, 1fr, 42pt, 1fr),
    rows: 92pt,
    bloc("Entrée", "relevé GPS, image, tableau de mesures"),
    fleche,
    bloc("Traitement", "le code, lui aussi un fichier texte", plein: true),
    fleche,
    bloc("Sortie", "un fichier, un affichage"),
  )

  #legende[
    Trois fichiers en jeu : les données d'entrée, le résultat, et le code.
  ]

  #notes[
    C'est la raison pour laquelle le module commence par les fichiers et non par
    le langage.
  ]
]

#d("Trois compétences préalables")[
  #table(
    columns: (auto, 1fr, auto),
    inset: 11pt,
    align: left + horizon,
    stroke: (x, y) => if y > 0 { (top: 0.5pt + estompe.lighten(50%)) },
    [Fichiers et dossiers], [ce qu'un fichier contient, ce qu'une extension signifie], [séances 1 et 3],
    [Édition de code], [ce qui distingue un éditeur d'un traitement de texte], [séance 1],
    [Environnement], [installer Python, et décrire l'installation pour la reproduire], [séance 1],
  )

  #notes[
    Annoncer l'ordre : la suite observe un même texte sous quatre formes de
    fichier, puis on installe l'environnement.
  ]
]

// ---------------------------------------------------------------------------

#d("Code source et fichier exécutable")[
  #annonce[
    Le fichier que le processeur exécute est illisible pour un humain. Il a
    pourtant été produit à partir d'un texte écrit au clavier.
  ]

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

#d("Langages interprétés et langages compilés")[
  #annonce[
    Deux façons de passer du texte à l'exécution. Python relève de la
    première.
  ]

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

#d("Extension et contenu")[
  #annonce[
    L'extension indique au système quel logiciel proposer. Elle n'agit pas
    sur les octets du fichier.
  ]

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

#d("Ce que contient un fichier texte")[
  #annonce[
    Un fichier texte contient des caractères. Le saut de ligne en est un :
    sans lui, le texte n'est pas découpé.
  ]

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

#d[Structure d'un fichier `.odt`][
  #annonce[
    Un document LibreOffice est une archive ZIP contenant des fichiers XML.
    Les formats `.docx`, `.xlsx` et `.epub` sont construits de même.
  ]

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

#d("Structure d'une page HTML")[
  #annonce[
    Le navigateur ignore les sauts de ligne du fichier source. La structure
    se déclare avec des balises.
  ]

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

#d("Contenu et présentation")[
  #annonce[
    Le contenu est dans le fichier `.html`, la présentation dans un fichier
    `.css` distinct. L'un change sans l'autre.
  ]

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

#d("Interface et noyau d'un notebook")[
  #annonce[
    L'interface affiche le texte et les résultats. Le noyau exécute le code
    et conserve les variables entre les cellules.
  ]

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

#d("Deux formats de notebook")[
  #annonce[
    Un `.ipynb` enregistre les résultats dans le fichier. Un fichier MyST ne
    garde que le code, et les résultats sont recalculés.
  ]

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

#d("À retenir")[
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
