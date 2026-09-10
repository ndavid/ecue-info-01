// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

// ================ Markdown et les autres fichiers texte =====================

#separateur(
  "Markdown et les autres fichiers texte",
  annonce: "Ce qu'on édite dans un projet, en dehors du code",
)
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
      #block(inset: 10pt, stroke: 0.8pt + estompe.lighten(50%))[
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
      #illustration(
        "/illustrations/cours1/page_html_brut.png",
        block(inset: 10pt, stroke: 0.8pt + estompe.lighten(50%), width: 100%)[
          #set text(size: 13pt, font: ("DejaVu Serif", "Libertinus Serif"))
          #text(size: 17pt, weight: "bold")[The Raven] \
          Edgar Allan Poe (1845) \
          #v(0.2em)
          Once upon a midnight dreary, while I pondered, weak and weary…
        ],
        hauteur: 150pt,
      )
    ],
    // Le repli dessiné reprend les couleurs de `style.css` : ici la couleur est
    // le sujet de la diapositive, puisque c'est ce que la feuille de style
    // ajoute. C'est la seconde et dernière exception aux trois couleurs du
    // thème, après la coloration syntaxique.
    panneau[`raven_style.html` + `style.css`][
      #illustration(
        "/illustrations/cours1/page_html_style.png",
        block(inset: 10pt, fill: rgb("#faf8f4"), stroke: 0.8pt + rgb("#ddd8cd"), width: 100%)[
          #set text(size: 13pt, fill: rgb("#2b2b2b"))
          #text(size: 17pt, weight: "bold")[The Raven] \
          #text(style: "italic", fill: rgb("#6b6b6b"))[Edgar Allan Poe (1845)]
          #v(0.3em)
          Once upon a midnight dreary, \
          while I pondered, weak and weary,
        ],
        hauteur: 150pt,
      )
    ],
  )

  #legende[Le fichier `.html` est identique dans les deux cas ; seule la ligne `<link rel="stylesheet">` diffère.]

  #notes[
    Faire éditer `style.css` et recharger avec F5. Même principe que le Markdown
    d'un README, et que la séparation code / configuration qu'ils reverront
    partout.
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
#d("Markdown et HTML dans l'éditeur")[
  #annonce[
    Les deux s'éditent sans rien installer : VSCode connaît d'origine le
    Markdown, le HTML et le CSS, et sait en montrer le rendu.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Format], [Fourni d'origine], [Où voir le rendu],
    [`.md`],
      [coloration, plan du document, complétion et vérification des liens],
      [dans l'éditeur, `Ctrl` + `Maj` + `V`],
    [`.html`, `.css`],
      [coloration, complétion des balises et des propriétés],
      [dans le navigateur, par une adresse `file:///`],
  )

  #legende[
    Relevé dans les extensions livrées avec VSCode :
    `markdown-language-features`, `html-language-features` et
    `css-language-features` y sont toutes les trois.
  ]

  #notes[
    La conclusion à tirer : pour tout ce qu'on écrira cette année en
    dehors du code, il n'y a rien à installer. C'est le contraste avec
    Python et C++, qui exigent une extension.

    Montrer l'aperçu Markdown en direct, `Ctrl` + `Maj` + `V` sur le
    fichier de notes du jour : c'est le geste le plus employé de l'année.

    Dernière colonne, différence de nature : le Markdown se rend dans
    l'éditeur, le HTML dans le navigateur. Les deux diapositives après la
    manipulation le montrent sur la page du poème.

    JSON et YAML, si la question vient : même principe, mais l'éditeur ne
    les sert pas également. Diapositive en annexe.
  ]
]
#d("Un diagramme écrit en texte")[
  #annonce[
    Un schéma se décrit aussi en texte. Six lignes dans un bloc `mermaid`, et
    l'aperçu dessine les boîtes et les flèches.
  ]

  #face-a-face(
    panneau("Ce qu'on écrit")[
      #raw(
        "```mermaid\nflowchart LR\n  A[Pâte] --> B[Repos, 1 h]\n  B --> C[Cuisson]\n```",
        block: true,
      )
    ],
    panneau("Ce qui s'affiche")[
      #v(0.6em)
      #chaine(
        ("Pâte", ""),
        ("Repos, 1 h", ""),
        ("Cuisson", ""),
      )
    ],
  )

  #legende[
    Rien à installer : depuis la version 1.121, VSCode rend les diagrammes
    Mermaid dans l'aperçu Markdown d'origine. Vérifié sur le poste de
    préparation, où `mermaid-markdown-features` est livré avec l'éditeur.
  ]

  #notes[
    L'intérêt n'est pas de dessiner joli mais que le schéma soit du texte
    : il se compare ligne à ligne, se versionne, et se corrige sans
    rouvrir un logiciel de dessin.

    Faire remarquer que le dessin n'est pas dans le fichier : le `.md` ne
    contient que six lignes, les boîtes sont calculées à l'affichage,
    comme la coloration l'était pour le code.

    Le vocabulaire minimal suffit : `flowchart LR`, un identifiant, le
    texte entre crochets, `-->` pour une flèche.

    Ne pas ouvrir le catalogue des types de diagrammes. Le cours 2 s'en
    sert pour représenter l'historique d'un dépôt git.
  ]
]
