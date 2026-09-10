// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas_notebooks.typ": schema-notebook, schema-client-serveur, schema-trois-serveurs, schema-deux-clients

// ================================ Notebooks ================================

#separateur(
  "Notebooks",
  annonce: "Écrire, exécuter et garder du code dans un même document",
)
#d("Programmation littérale")[
  #annonce[
    Le texte, le code et son résultat tiennent dans un seul document.
  ]

  #align(center, schema-notebook())

  #legende[
    Trois sortes de blocs, dans l'ordre où on les écrit. Le terme est de Donald
    Knuth, 1984.
  ]

  #notes[
    L'idée à faire passer, et la seule : ailleurs, le code est dans un
    fichier, l'explication dans un autre, et le résultat nulle part. Ici
    les trois sont au même endroit, et dans l'ordre du raisonnement.

    Le bloc de texte s'écrit en Markdown — celui de la partie précédente,
    sans rien de neuf à apprendre.

    Le résultat est enregistré dans le document : rouvert demain, il
    affiche encore ce que le code a produit aujourd'hui. C'est ce qui rend
    un notebook lisible sans l'exécuter, et ce qui le fait mal se
    versionner, diapositive suivante.

    Knuth : « Considérons les programmes comme des œuvres de littérature ».
    Une phrase, sans développer ; c'est le nom de l'idée qui sert, pas son
    histoire.

    Ce qu'un notebook n'est pas : un moyen de livrer un outil. On y
    explore et on y explique ; ce qui doit tourner tout seul devient un
    script, au cours 3.
  ]
]
#d("Le bloc de texte : du Markdown")[
  #annonce[
    Le bloc de texte s'écrit en Markdown, et s'affiche mis en forme.
  ]

  #face-a-face(
    panneau("Ce qu'on tape dans le bloc")[
      ```markdown
      # Longueur d'un trajet

      Les points du trajet sont donnés en
      **coordonnées projetées**, en mètres.
      ```
    ],
    panneau("Ce que le notebook affiche")[
      #v(0.4em)
      #text(size: 24pt, weight: demi-gras)[Longueur d'un trajet]
      #v(0.5em)
      #text(size: 16pt)[
        Les points du trajet sont donnés en #strong[coordonnées projetées],
        en mètres.
      ]
    ],
  )

  #legende[
    Le `#` fait un titre, les deux astérisques mettent en gras : rien de neuf
    depuis la manipulation Markdown.
  ]

  #notes[
    Rien à apprendre ici, et c'est le propos : le Markdown écrit une demi-
    heure plus tôt sert tel quel dans un notebook. Le dire, puis passer.

    Le bloc bascule entre les deux états : `Maj` + `Entrée` affiche la mise
    en forme, un double clic revient au texte source. C'est la même
    alternance que l'aperçu de l'éditeur.

    Un bloc de texte ne s'exécute pas au sens du code : il n'y a pas de
    noyau derrière, seulement une mise en forme. Le numéro `[1]` n'apparaît
    donc que sur les blocs de code.
  ]
]
#d("Un notebook dans JupyterLab")[
  #annonce[
    Les trois sortes de blocs dans une vraie fenêtre.
  ]

  #align(center)[
    #if captures-disponibles {
      box(stroke: 1pt + accent.lighten(55%),
          image("/illustrations/cours1/notebook_jupyterlab.png", width: 88%))
    } else {
      scale(78%, reflow: true, schema-notebook())
    }
  ]

  #legende[
    Capture réelle. Le code y calcule la longueur d'un trajet de quatre points.
  ]

  #notes[
    Montrer où sont les trois blocs de la diapositive précédente, dans
    l'ordre : le titre et la phrase en haut, la cellule de code au milieu
    avec son `[1]`, la sortie juste en dessous, puis le texte qui commente
    le résultat.

    Le `[1]` est le rang d'exécution, pas le rang dans le document. Une
    cellule relancée passe à `[2]` : c'est ce qui trahit un notebook
    exécuté dans le désordre.

    À droite en haut, le nom du noyau, `Python 3 (ipykernel)`. C'est ce
    qu'on choisit à l'ouverture, et le sujet de la manipulation.

    À gauche, l'arborescence : un notebook est un fichier dans un dossier,
    comme le reste.
  ]
]
#d("Le client et le serveur d'un notebook")[
  #annonce[
    Un notebook est une application web : un client qui affiche, un serveur qui
    exécute.
  ]

  #align(center, schema-client-serveur())

  #legende[
    Changer de client ne change pas le noyau : JupyterLab et l'éditeur de code
    ouvrent le même fichier et parlent au même serveur.
  ]

  #notes[
    Reprendre le schéma de la première partie : là-bas le serveur était
    ailleurs, ici il est sur la même machine. Le navigateur ne sait pas
    faire la différence, et c'est pourquoi l'adresse ressemble à une
    adresse de site.

    Le noyau est le processus Python qui exécute et qui retient. La
    démonstration en trois gestes : `x = 10`, puis `print(x * 2)` → 20 ;
    modifier la première cellule en `x = 3` sans l'exécuter, la seconde
    affiche toujours 20 ; puis Restart & Run All. Réflexe avant tout
    partage.

    VSCode est un client comme JupyterLab : il ouvre le même fichier et
    parle au même noyau. C'est le sens de la question « choisir le noyau »
    qu'il pose à l'ouverture, et la manipulation le vérifie.

    Le jeton dans l'adresse `localhost:8888/lab?token=…` est un mot de
    passe à usage unique, qui empêche qu'un autre poste du réseau exécute
    du code. Une phrase ; repris au cours 5.

    JupyterLite n'a pas de serveur : le noyau y est compilé en
    WebAssembly et tourne dans l'onglet. Utile pour ouvrir un notebook en
    dix secondes, sans compte ni installation ; pas pour travailler, tous
    les paquets n'y étant pas. Colab, à l'inverse, exige un compte et
    exécute sur ses serveurs.
  ]
]
#d("Les trois emplacements du serveur")[
  #annonce[
    Client et serveur sont deux rôles, pas deux machines.
  ]

  #align(center, schema-trois-serveurs())

  #legende[
    Seul le premier cas fait sortir quelque chose de votre machine. Dans le
    troisième, le noyau Python est exécuté par le navigateur lui-même.
  ]

  #notes[
    C'est « Où s'exécute une application web » repris sur un cas précis :
    la question utile n'est pas « est-ce que ça tourne chez moi ? » mais
    « qu'est-ce qui sort, et quand ? ».

    Premier cas : le code part sur une machine qu'on ne possède pas. Colab
    exige un compte, et ce qu'on y dépose part sur les serveurs de
    Google. Pratique pour dépanner, pas pour rendre un travail.

    Deuxième cas, celui du module : `jupyter lab` démarre un serveur sur
    leur poste, et l'adresse `localhost:8888` en est la preuve. Le jeton
    dans l'adresse est un mot de passe à usage unique, qui empêche qu'un
    autre poste du réseau exécute du code. Repris au cours 5.

    Troisième cas, à relier à « La place de l'interpréteur » : le
    navigateur y figurait déjà comme interpréteur, à côté de `python`.
    JupyterLite ne fait que pousser cela plus loin — le noyau Python y est
    compilé en WebAssembly et tourne dans l'onglet, si bien qu'il n'y a
    plus de serveur du tout. Un navigateur est devenu assez complet pour
    faire tourner un interpréteur Python.

    Sa limite, à dire pour qu'ils ne s'y installent pas : tous les paquets
    n'y sont pas, et ce qu'on y dépose vit dans le navigateur. Il sert à
    ouvrir un notebook en dix secondes, sans compte ni installation.
  ]
]
#d("Les clients d'un notebook")[
  #annonce[
    Le même fichier s'ouvre par plusieurs clients. Tous ont besoin du même
    noyau.
  ]

  #align(center, schema-deux-clients())

  #legende[
    L'éditeur de code n'a pas besoin de `jupyterlab` : il démarre `ipykernel`
    lui-même. `ipykernel` est le noyau Python ; il en existe pour d'autres
    langages, et le nom _Jupyter_ vient de Julia, Python et R.
  ]

  #notes[
    Le point pratique, et il sert dès la manipulation : un environnement
    ouvert dans l'éditeur n'a besoin que d'`ipykernel`. C'est pourquoi
    l'environnement `analyse` de tout à l'heure n'a pas `jupyterlab` et
    fonctionne quand même.

    L'éditeur parle directement au noyau, sans passer par un serveur — la
    documentation de l'extension le dit : « vous n'avez pas besoin
    d'installer jupyter dans l'environnement, seul `ipykernel` est
    nécessaire ». Il sait aussi se connecter à un serveur existant, en
    collant son adresse ; c'est le premier cas du schéma précédent.

    Les langages, pour information et sans y insister : le noyau décide du
    langage, pas le format de fichier. Il existe des noyaux pour R
    (`IRkernel`), Julia (`IJulia`), C++, et le `kernel.json` porte une
    ligne `language` qui dit lequel. Le projet s'appelait IPython jusqu'en
    2014.

    Ne pas en faire une invitation à changer de langage : le module reste
    en Python.
  ]
]
