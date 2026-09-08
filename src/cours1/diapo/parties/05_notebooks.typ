// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

// ================================ Notebooks ================================

#separateur(
  "Notebooks",
  annonce: "Écrire, exécuter et garder du code dans un même document",
)
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
#d("Trois façons d'ouvrir un notebook")[
  #annonce[
    Le même fichier `.ipynb` s'ouvre de trois façons. Ce qui change n'est pas
    le notebook, c'est l'endroit où tourne le noyau.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Comment], [Ce que vous lancez], [Où tourne le noyau],
    [Dans l'éditeur de code], [le `.ipynb` ouvert dans VSCode], [sur votre machine],
    [JupyterLab en local], [`jupyter lab` dans un terminal], [sur votre machine],
    [Dans le navigateur], [JupyterLite, une adresse à ouvrir], [dans l'onglet, chez vous],
  )

  #v(0.3em)
  ```console
  $ jupyter lab
  [I ServerApp] Serving notebooks from local directory: /home/alice/projets
  [I ServerApp] http://localhost:8888/lab?token=7882e00fbc72e4…
  ```

  #legende[
    Sortie réelle : la deuxième façon est bien une application web, mais le
    serveur est le vôtre.
  ]

  #notes[
    Faire lire la dernière ligne : `jupyter lab` démarre un serveur web
    sur la machine de l'étudiant, le navigateur n'étant que l'interface.
    C'est l'application web de la première partie, avec le calcul de leur
    côté.

    Le jeton dans l'adresse est un mot de passe à usage unique, qui
    empêche qu'un autre poste du réseau exécute du code. Une phrase ;
    repris au cours 5.

    `Serving notebooks from local directory` désigne le dossier courant :
    le notebook ne voit que ce qui est dessous.

    La troisième ligne referme « Le lieu du calcul » de la première partie
    : JupyterLite n'a pas de serveur, le noyau Python y est compilé en
    WebAssembly et tourne dans l'onglet, si bien que rien ne part sur le
    réseau. Un service en ligne où le calcul se fait chez vous.

    Ne pas le proposer comme environnement de travail : tous les paquets
    n'y sont pas, et ce qu'on y dépose vit dans le navigateur. Il sert à
    ouvrir un notebook en dix secondes, sans compte ni installation.

    Colab et consorts exigent un compte, et ce qu'on y dépose part sur
    leurs serveurs. Pratique pour dépanner, pas pour rendre un travail.
  ]
]
#d("Deux formats de notebook")[
  #annonce[
    Un `.ipynb` enregistre les résultats dans le fichier. Un fichier MyST ne
    garde que le code, et les résultats sont recalculés.
  ]

  #tableau(
    columns: (1fr, auto, auto),
    align: (left + horizon, center + horizon, center + horizon),
    [Même modification : `1920` → `3840`], [`.ipynb`], [MyST `.md`],
    [Lignes modifiées dans le `diff`], [23], [2],
    [Taille du fichier], [17,3 ko], [11,3 ko],
  )

  #legende[
    Mesuré sur la page « Environnement Python » de ce cours, le `.ipynb` ayant
    été exécuté : il contient aussi les résultats, qui changent à chaque
    exécution.
  ]

  #notes[
    Boucler explicitement : même contenu, deux formats — la question du début de
    séance, appliquée à leur propre travail. Et transition vers le cours 2 :
    c'est pour cette raison que le texte se versionne bien.
  ]
]
#d("Quand un notebook, quand un script")[
  #annonce[
    Un notebook sert à comprendre et à montrer, un script à refaire. Le même
    code passe souvent de l'un à l'autre.
  ]

  #tableau(
    columns: (1fr, 1fr, 1fr),
    align: left + horizon,
    [], [Notebook], [Script `.py`],
    [Ce qu'on y cherche], [explorer, expliquer, montrer], [refaire, automatiser],
    [Exécution], [cellule par cellule, l'état reste], [du début à la fin],
    [Le résultat], [dans le document, avec le texte qui l'explique], [à l'écran ou dans un fichier],
    [Se relance seul], [non], [oui],
    [Se partage comme outil], [mal : il faut le noyau, et le bon ordre], [bien : une commande],
  )

  #legende[
    On explore dans un notebook, on livre un script. Ce passage est le sujet
    du cours 3.
  ]

  #notes[
    Sans cette diapositive, ils savent lancer un notebook sans savoir
    quand en ouvrir un.

    Le cas d'usage se reconnaît : on ouvre un notebook parce qu'on ne sait
    pas encore ce qu'on cherche. On essaie, on regarde, on garde le
    commentaire à côté du résultat. Le jour où cela marche et doit tourner
    chaque semaine sans surveillance, cela devient un script — cours 3.

    Dernière ligne : un notebook donné à quelqu'un d'autre demande le bon
    noyau, les bonnes bibliothèques et des cellules exécutées dans l'ordre
    ; un script se donne avec une ligne de commande. C'est aussi pourquoi
    le `.ipynb` se versionne mal.

    Ne pas opposer les deux : ce sont deux moments du même travail.
  ]
]
#d("À retenir")[
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [Un logiciel], [transforme une entrée en sortie ; son traitement part d'un texte],
    [Une application], [est un logiciel destiné à une tâche ; « app » en est l'abréviation],
    [Une interface], [décide de ce qu'il reste du travail, pas de ce qu'il produit],
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
#separateur-manip(
  "Le notebook du cours, ouvert de trois façons",
  annonce: "Dans le navigateur sans rien installer, dans l'éditeur, puis dans JupyterLab",
  dossier: "src/cours1/notebook/",
)
#d("Ouvrir le même notebook, trois fois")[
  #annonce[
    `04_premiers_octets.ipynb` lit les premiers octets d'un fichier et en
    déduit le format. Le même fichier, ouvert de trois façons.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Le geste], [Ce qu'on observe],
    [Dans le navigateur],
      [ouvrir #link("https://jupyter.org/try-jupyter/lab/")[jupyter.org/try-jupyter], y déposer le fichier],
      reponse[aucun compte, aucune installation, et le calcul se fait chez vous],
    [Dans l'éditeur],
      [ouvrir le `.ipynb`, choisir le noyau `info01`],
      reponse[les cellules s'exécutent par `Maj` + `Entrée`],
    [Dans JupyterLab],
      [`jupyter lab` au terminal, puis le fichier dans l'arborescence],
      reponse[une adresse `localhost`, donc un serveur qui est le vôtre],
  )

  #legende[
    Le notebook est produit depuis un fichier MyST par
    `python outils/construire_notebooks.py`. Le premier chargement de
    JupyterLite prend une dizaine de secondes.
  ]

  #notes[
    L'ordre est celui de l'engagement croissant : rien à installer, puis
    l'éditeur qu'ils ont déjà, puis un serveur qu'ils lancent eux-mêmes.
    Si le réseau de la salle est mauvais, sauter la première et la montrer
    au tableau.

    Le contenu du notebook n'est pas neuf : c'est la lecture des premiers
    octets, passée en annexe des diapositives parce qu'elle se prête mieux
    à un notebook qu'à une projection. Ils y retrouvent le `50 4B 03 04`
    du `.odt` et l'absence de signature des fichiers texte, en
    l'exécutant.

    Faire attendre la dernière cellule : elle copie le `.odt` sous un nom
    en `.pdf`, relit les octets, et montre que le nom ment. C'est « Deux
    extensions échangées » faite par eux, en trois lignes.

    Le noyau à choisir dans l'éditeur est la même question que
    l'interpréteur de la partie 2, et la même réponse : `info01`.

    Le fichier source est en MyST, donc du texte, donc comparable ligne à
    ligne : « Deux formats de notebook » vérifié sur le support qu'ils ont
    sous les yeux.
  ]
]
