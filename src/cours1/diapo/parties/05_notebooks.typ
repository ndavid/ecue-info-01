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
    [Un service en ligne], [une adresse fournie par le service], [sur son serveur],
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
    La ligne à faire lire est la dernière : `jupyter lab` démarre un serveur
    web sur la machine de l'étudiant, et le navigateur n'est que l'interface.
    C'est l'application web de la première partie, avec le calcul de leur côté.

    Le jeton dans l'adresse est un mot de passe à usage unique, qui empêche
    qu'un autre poste du réseau ouvre le notebook et exécute du code. Le dire
    en une phrase ; le sujet revient au cours 5 avec les secrets.

    `Serving notebooks from local directory` désigne le dossier courant : le
    notebook ne voit que ce qui est dessous. Encore les chemins relatifs.

    Sur les services en ligne : ce qu'on y dépose y reste, et l'environnement
    n'est pas celui qu'ils ont installé. Pratique pour dépanner, pas pour
    rendre un travail.
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
    La diapositive répond à la question que la partie ne posait pas : à quoi
    un notebook sert-il mieux qu'un fichier `.py` ? Sans elle, ils savent en
    lancer un sans savoir quand en ouvrir un.

    Le cas d'usage à décrire, parce qu'il se reconnaît : on ouvre un notebook
    parce qu'on ne sait pas encore ce qu'on cherche. On essaie, on regarde, on
    garde le commentaire à côté du résultat. Le jour où cela marche et doit
    tourner chaque semaine sans surveillance, cela devient un script — et
    c'est le cours 3.

    La ligne qui surprend est la dernière. Un notebook donné à quelqu'un
    d'autre demande le bon noyau, les bonnes bibliothèques et que les cellules
    soient exécutées dans l'ordre ; un script se donne avec une ligne de
    commande. Rattacher à la diapositive précédente : c'est aussi pourquoi le
    `.ipynb` se versionne mal.

    Ne pas opposer les deux. Le notebook n'est pas un brouillon honteux et le
    script n'est pas la version sérieuse : ce sont deux moments du même
    travail.
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
