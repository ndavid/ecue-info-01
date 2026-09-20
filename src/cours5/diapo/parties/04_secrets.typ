// Cours 5, partie 4 — les secrets de vos programmes. Incluse par `cours5.typ`.
#import "../../../commun/prelude.typ": *
#import "../style.typ": terminal

#separateur(
  "Les secrets de vos programmes",
  annonce: "Un jeton d'API est un mot de passe pour programme : les mêmes menaces, et une parade de plus, le tenir hors du dépôt.",
)

// --------------------------------------------
#d("Ce qui est un secret")[
  #annonce[
    Un secret donne accès à quelque chose. Il ne va ni dans un dépôt, ni
    dans un message, ni dans une capture d'écran.
  ]

  #face-a-face(
    panneau("À garder")[
      #tableau(
        columns: (auto, 1fr),
        align: (left + horizon, left + horizon),
        [Quoi], [Donne accès à],
        [#text(fill: brun, weight: demi-gras)[clé privée SSH]], [vos comptes, vos serveurs],
        [#text(fill: brun, weight: demi-gras)[mot de passe]], [un compte],
        [#text(fill: brun, weight: demi-gras)[jeton d'API]], [un service payant ou limité : clé IGN, clé d'un service d'IA],
        [#text(fill: brun, weight: demi-gras)[fichier `.env`, `config.py`]], [là où sont rangés les trois précédents],
      )
    ],
    panneau("À partager")[
      #tableau(
        columns: (auto, 1fr),
        align: (left + horizon, left + horizon),
        [Quoi], [Pourquoi],
        [#text(fill: attention, weight: demi-gras)[clé publique SSH]], [ne sert à rien sans la privée],
        [#text(fill: attention, weight: demi-gras)[le code]], [c'est ce qu'on rend],
        [#text(fill: attention, weight: demi-gras)[README, `environment.yml`]], [c'est ce qui permet de le relancer],
        [#text(fill: attention, weight: demi-gras)[données publiques]], [orthophotos, BD TOPO],
      )
    ],
  )

  #notes[
    Un jeton d'API est une chaîne que le script envoie au service pour
    s'identifier. Les services de l'IGN, de cartographie ou d'IA en donnent
    un par compte ; la facture ou le quota va sur ce compte.

    Les données personnelles des autres (un CSV de noms et d'adresses) sont
    un cas à part, régi par le RGPD : pas dans un dépôt public non plus.
  ]
]

// --------------------------------------------
#d("Un secret dans un dépôt y reste")[
  #annonce[
    Le commit qui supprime le fichier ne supprime pas le commit qui l'a
    ajouté. `git log -p` affiche les deux.
  ]

  #terminal("Anaconda Prompt", "> git log --oneline
449f325 Supprime la clé du dépôt
856b116 Premier script de carte
> git log -p -- config.py
commit 449f325  Supprime la clé du dépôt
    -CLE_IGN = \"d7f3a9c1e5b24086\"
commit 856b116  Premier script de carte
    +CLE_IGN = \"d7f3a9c1e5b24086\"")

  #legende[
    Sortie réelle, abrégée. En 2025, 28,65 millions de secrets ont été
    ajoutés dans des commits publics sur GitHub ; 64 % de ceux trouvés en 2022
    étaient encore valides en 2026 (GitGuardian, *State of Secrets Sprawl 2026*).
  ]

  #notes[
    Un secret poussé sur une forge publique est copié avant d'être
    supprimé : des programmes lisent les commits publics en continu et
    testent les clés qu'ils y trouvent.

    Le TD 3a rejoue cette sortie. Il est facultatif : la diapositive suffit à
    le montrer.
  ]
]

// --------------------------------------------
#d("Séparer le code et les secrets")[
  #annonce[
    Le code lit le secret dans un fichier que git ignore. Le dépôt contient
    un modèle de ce fichier, sans la valeur.
  ]

  #face-a-face(
    panneau("Dans le dépôt, pour tout le monde")[
      #block(width: 100%, inset: (x: 12pt, y: 10pt), fill: gris)[
        #set text(size: 17pt)
        #raw(block: true, "carte.py            import config
                    cle = config.CLE_IGN
config.example.py   CLE_IGN = \"à remplir\"
.gitignore          config.py
README.md")
      ]
    ],
    panneau("Sur votre poste seulement")[
      #block(width: 100%, inset: (x: 12pt, y: 10pt), stroke: 1.2pt + brun)[
        #set text(size: 17pt)
        #raw(block: true, "config.py           CLE_IGN = \"d7f3a9c1e5b24086\"")
      ]
      #v(0.5em)
      #text(size: 15pt, fill: estompe)[
        Qui clone le dépôt copie `config.example.py` en `config.py` et y met
        sa propre clé. `git status` ne liste jamais `config.py`.
      ]
    ],
  )

  #notes[
    C'est le `.gitignore` du cours 2. Le fichier ignoré peut aussi être un
    `.env` lu par le programme ; le principe est le même.

    Vérifier avant de committer : `git status` ne doit pas lister le fichier
    du secret. Les forges détectent une partie des jetons poussés et
    préviennent ; ne pas compter dessus.
  ]
]

// --------------------------------------------
#d("Si un secret a fui")[
  #annonce[
    Supprimer le fichier ne suffit pas. Le secret est d'abord rendu inutile,
    puis remplacé.
  ]

  #chaine(
    ("Révoquer", "régénérer la clé sur le service qui l'a émise"),
    ("Remplacer", "mettre la nouvelle dans le fichier ignoré"),
    ("Nettoyer", "réécrire l'historique, ou recréer le dépôt"),
    ("Prévenir", "le responsable du projet ou du service"),
    gabarit: bloc, pleins: (0,),
  )

  #legende[
    La première étape passe avant les autres : l'historique a déjà été copié.
  ]

  #notes[
    Réécrire un historique se fait avec `git filter-repo` ; hors programme.
    Sur un petit projet, recréer le dépôt sans le commit fautif est plus
    simple.

    Pour un mot de passe personnel qui a fui, la démarche est la même :
    le changer, d'abord sur le site concerné, puis partout où il était
    réutilisé.
  ]
]

// --------------------------------------------
#d("Mises à jour et sauvegardes")[
  #annonce[
    Une mise à jour ferme une faille connue et publiée. Une sauvegarde
    rend un poste perdu, volé ou chiffré sans conséquence.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [], [Mises à jour], [Sauvegardes],
    [Quoi], [système, navigateur, Anaconda, les applications du téléphone], [ce qui ne se refait pas : documents, données, photos],
    [Quand], [dès qu'elles sont proposées], [régulièrement, en automatique],
    [Règle], [redémarrer quand c'est demandé], [3-2-1 : trois copies, deux supports, une hors du poste],
    [Et le code ?], [`conda update`, de temps en temps], [un dépôt poussé sur la forge est une copie du code ; les données ignorées par git sont à sauvegarder à part],
  )

  #notes[
    Une faille publiée est exploitée dans les jours qui suivent ; une mise à
    jour repoussée laisse la faille ouverte pendant ce temps.

    Pour un étudiant : le dépôt sur la forge sauve le code et le rapport ;
    les données, si elles sont lourdes, sont dans `.gitignore` et donc
    ailleurs. Un disque externe ou l'espace de stockage de l'école suffit.

    Les autres mesures de cybermalveillance.gouv.fr, non traitées ici :
    antivirus (celui de Windows suffit), applications depuis les magasins
    officiels, Wi-Fi public, séparer usage personnel et professionnel.
  ]
]
