#import "theme.typ": diapos, page-titre, separateur-module, d, separateur, separateur-manip, separateur-td, annonce, notes, legende, tableau, face-a-face, panneau, question, etiquette, icone-fenetre, icone-engrenage, icone-puce, accent, encre, estompe, manip, gris, demi-gras, police-code

#show: diapos.with(
  titre-court: "Introduction à l'informatique",
  auteur-court: "1re année géomatique",
)

// Boîte d'un schéma en chaîne.
#let bloc(titre, detail, plein: false) = block(
  width: 100%, height: 100%, inset: 12pt,
  fill: if plein { accent.lighten(88%) } else { none },
  stroke: 1pt + accent.lighten(if plein { 40% } else { 65% }),
)[
  #align(center + horizon)[
    #text(size: 19pt, weight: "semibold")[#titre]
    #v(0.25em)
    #text(size: 14pt, fill: estompe)[#detail]
  ]
]

#let fleche = align(horizon + center, text(size: 26pt, fill: accent)[→])

// Une étape d'une chaîne de traitement, plus compacte que `bloc`.
#let etape(titre, detail) = block(
  width: 100%, height: 100%, inset: (x: 8pt, y: 5pt), fill: white,
  stroke: 1pt + accent.lighten(55%),
)[
  #align(center + horizon)[
    #text(size: 16pt, weight: demi-gras)[#titre]
    #if detail != "" [
      #v(0.15em)
      #text(size: 12pt, fill: estompe)[#detail]
    ]
  ]
]

// Une couche du schéma en pile : pictogramme, nom, exemples.
#let couche(icone, titre, exemples, plein: false) = block(
  width: 100%, inset: (x: 14pt, y: 5pt),
  fill: if plein { accent.lighten(90%) } else { none },
  stroke: 1pt + accent.lighten(if plein { 35% } else { 62% }),
)[
  #grid(
    columns: (34pt, auto, 1fr), column-gutter: 14pt, align: horizon,
    icone,
    text(size: 19pt, weight: "semibold")[#titre],
    align(right, text(size: 14pt, fill: estompe)[#exemples]),
  )
]

// Ce qui circule entre deux couches, dans les deux sens.
#let liaison(descendant, montant) = block(width: 100%, inset: (y: 1pt))[
  #grid(
    columns: (1fr, 1fr), column-gutter: 24pt,
    align(right)[
      #text(size: 13.5pt, fill: estompe)[#descendant]
      #h(7pt) #text(size: 18pt, fill: accent)[↓]
    ],
    align(left)[
      #text(size: 18pt, fill: accent)[↑] #h(7pt)
      #text(size: 13.5pt, fill: estompe)[#montant]
    ],
  )
]

// =============================== Introduction ===============================

#separateur-module(
  "Introduction à l'informatique",
  annonce: "Objectifs, contenu et organisation des sept séances du module",
  auteur: "1re année géomatique",
  date: "15 septembre",
)

#d("Objectif du cours")[
  #annonce[
    Consolider ou acquérir les bases informatiques nécessaires aux autres
    enseignements, en particulier ceux de programmation et les TD utilisant
    Python.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
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

  #tableau(
    columns: (1.7fr, 0.8fr, 1fr),
    align: (left + horizon, center + horizon, center + horizon),
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

  #tableau(
    columns: (auto, 1fr, auto),
    align: (center + horizon, left + horizon, center + horizon),
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

#page-titre(
  titre: "Cours 1",
  sous-titre: "Introduction à l'informatique",
  auteur: "1re année géomatique",
  date: "15 septembre",
)

#separateur(
  "Logiciel et formats de fichier",
  annonce: "Première partie du module",
)

#d("Contenu de la séance")[
  #tableau(
    entete: false,
    columns: (auto, 1fr, auto),
    align: (left + horizon, left + horizon, right + horizon),
    [Logiciels et interfaces], [à quoi sert un programme, et comment on le pilote], [30′],
    [Programmation], [du texte écrit au clavier au fichier exécuté], [10′],
    [Fichiers et formats], [des octets, que l'extension ne décrit pas], [40′],
    [Outils de travail], [un éditeur, un environnement, un notebook], [40′],
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

  #tableau(
    columns: (1.1fr, 1fr, 1fr),
    align: left + horizon,
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

// ------------------------------- Vocabulaire --------------------------------

#d("Logiciel, application, app")[
  #annonce[
    « Logiciel » est le terme général. Une application est un logiciel destiné
    à une tâche de l'utilisateur ; « appli » et « app » en sont des
    abréviations, pas d'autres objets.
  ]

  #block(
    width: 100%, inset: (x: 12pt, y: 8pt),
    stroke: 1pt + accent.lighten(50%),
  )[
    #align(center, text(size: 15pt, fill: accent, weight: "semibold")[logiciel])
    #v(0.3em)
    #face-a-face(
      panneau("Logiciel de base")[
        #block(inset: 9pt, width: 100%,
               stroke: 0.8pt + estompe.lighten(50%))[
          #set text(size: 14.5pt)
          Fait fonctionner la machine et donne accès au matériel.
          #v(0.35em)
          #text(fill: estompe)[Windows, macOS, Linux, et les pilotes]
        ]
      ],
      panneau("Logiciel d'application")[
        #block(inset: 9pt, width: 100%, fill: accent.lighten(93%),
               stroke: 0.8pt + accent.lighten(50%))[
          #set text(size: 14.5pt)
          Sert à accomplir une tâche : écrire, cartographier, écouter.
          #v(0.35em)
          #text(fill: estompe)[LibreOffice, Firefox, un lecteur de musique.
          Dit aussi application, appli, app.]
        ]
      ],
    )
  ]

  #legende[
    Sources : _Journal officiel_ du 22/09/2000 ; Grand dictionnaire
    terminologique de l'OQLF.
  ]

  #notes[
    « App » est l'abréviation anglaise d'_application_, répandue par les
    magasins d'applications des téléphones. Le mot ne désigne pas une
    technologie particulière : le même logiciel existe souvent en site web, en
    programme de bureau et en application mobile. Ne pas laisser croire qu'une
    app serait « plus légère » ou « moins un vrai logiciel ».
  ]
]

#d("Le système d'exploitation")[
  #annonce[
    Un programme ne s'adresse pas au matériel : il passe par le système.
  ]

  #couche(
    icone-fenetre(taille: 30pt), "Vos programmes",
    "LibreOffice, un navigateur, votre script", plein: true,
  )
  #liaison("« ouvre releve.csv »", "le contenu")
  #couche(
    icone-engrenage(taille: 30pt), "Système d'exploitation",
    "Windows, macOS, Linux",
  )
  #liaison("« écris ces octets »", "les octets lus sur le disque")
  #couche(
    icone-puce(taille: 30pt), "Matériel",
    "processeur, mémoire, disque, réseau",
  )

  #notes[
    Le système arbitre entre tous les programmes ouverts en même temps : c'est
    lui qui empêche l'un d'écrire dans la mémoire d'un autre. Conséquence
    pratique : les chemins de fichiers ne s'écrivent pas pareil d'un système à
    l'autre et les outils installés diffèrent. Le matériel est repris au
    cours 5.
  ]
]

#d("Téléphone et application web")[
  #v(0.5em)
  #question(1)[Quel système d'exploitation tourne sur votre téléphone ?]

  #v(0.9em)
  #question(2)[
    Qu'est-ce qu'une application web, une « webapp » ? Citez-en une que vous
    utilisez.
  ]

  #notes[
    Première question, réponse attendue : Android ou iOS. Ordre de grandeur
    mondial, à donner si elle est demandée : environ 70 % Android, 30 % iOS
    (StatCounter, 2026). Personne ne nomme « Linux » alors qu'Android en est
    un : c'est le point à relever.

    Deuxième question : laisser venir les réponses sans corriger. Attendu
    « un site où on fait des choses », « ça marche sans installer ». Les
    exemples viendront seuls (messagerie, documents partagés, retouche
    d'image, cartes). Les deux diapositives suivantes donnent la réponse.

    Enchaînement à préparer : la question n'est pas de vocabulaire. Elle sert
    à faire remarquer que des tâches qui demandaient un logiciel installé se
    font aujourd'hui dans un navigateur, et que le lieu du calcul, donc celui
    des fichiers, a changé sans qu'on le dise.
  ]
]

#d("L'application web")[
  #annonce[
    Une application web fonctionne dans un navigateur, sans installation. Le
    navigateur est devenu la plateforme qui l'exécute.
  ]

  #face-a-face(
    panneau("Application installée")[
      #block(inset: 9pt, width: 100%, height: 108pt,
             stroke: 0.8pt + estompe.lighten(50%))[
        #set text(size: 14.5pt)
        Des fichiers déposés sur votre disque par une installation, lancés par
        le système.
        #v(1fr)
        #text(fill: estompe)[LibreOffice, un lecteur de musique]
      ]
    ],
    panneau("Application web")[
      #block(inset: 9pt, width: 100%, height: 108pt,
             fill: accent.lighten(93%), stroke: 0.8pt + accent.lighten(50%))[
        #set text(size: 14.5pt)
        Du code téléchargé à chaque visite et exécuté par le navigateur, dans
        un environnement isolé.
        #v(1fr)
        #text(fill: estompe)[messagerie, documents partagés, cartes]
      ]
    ],
  )

  #legende[
    Définition : « application fonctionnant dynamiquement avec le concours
    d'un navigateur web », Grand dictionnaire terminologique de l'OQLF.
  ]

  #notes[
    Le navigateur fait ici le travail d'un système d'exploitation : il charge
    du code, l'exécute dans une machine virtuelle, lui donne du stockage et un
    accès réseau, et l'empêche de toucher au reste de la machine. La
    documentation de Mozilla emploie le mot « machine virtuelle » pour le
    moteur qui exécute JavaScript et WebAssembly ; ce dernier tourne à une
    vitesse proche du natif. Une page web n'est donc plus un document : c'est
    un programme qu'on n'installe pas.

    Ne pas entrer dans les technologies. Ce qui compte est la conséquence,
    diapositive suivante.
  ]
]

#d("Où le calcul se fait")[
  #annonce[
    Deux applications web d'apparence identique peuvent calculer à deux
    endroits différents. C'est ce qui décide du sort de vos fichiers.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Calcul dans le navigateur], [Calcul sur un serveur],
    [Votre fichier], [ne quitte pas la machine], [part sur le réseau],
    [Sans connexion], [peut continuer], [s'arrête],
    [Qui calcule], [votre processeur], [celui du service],
    [Exemples], [retouche d'image en ligne], [traduction, IA générative],
  )

  #legende[
    La question à se poser devant un service en ligne : où part le fichier que
    je dépose, et qu'en reste-t-il ensuite ?
  ]

  #notes[
    Rattacher à la manipulation vidéo de la fin de partie : l'outil en ligne
    proposé y annonce que le rendu se fait sur l'appareil, ce qui explique
    qu'il n'ait besoin ni de compte ni de connexion permanente.

    Ne pas ouvrir le dossier des données personnelles maintenant. La phrase
    « ce qu'on dépose quelque part y reste » est semée ici et reprise au
    cours 5 avec les secrets.
  ]
]

#d("Entrées et sorties d'un programme")[
  #annonce[
    Un programme lit des fichiers et en produit d'autres. Mais toutes ses
    sorties ne sont pas des fichiers : l'écran et le son en sont aussi.
  ]

  #grid(
    columns: (1fr, 34pt, 1fr, 34pt, 1.1fr),
    rows: 150pt,
    bloc("Entrée", "un relevé GPS, une image, le clavier"),
    fleche,
    bloc("Traitement", "le programme", plein: true),
    fleche,
    grid(
      rows: (1fr, 1fr), row-gutter: 10pt,
      bloc("Une sortie qui reste", "un fichier : image, tableau, vidéo"),
      bloc("Une sortie qui passe", "un périphérique : écran, son"),
    ),
  )

  #legende[
    La sortie affichée à l'écran ne laisse rien derrière elle ; le fichier,
    si. C'est toute la différence quand il faut recommencer.
  ]

  #notes[
    Schéma réutilisé tout le semestre. Insister sur la sortie de droite : les
    étudiants pensent spontanément qu'un programme « affiche », et oublient
    qu'il peut écrire. Le module s'intéresse surtout à ce qui laisse un
    fichier, parce que c'est ce qui se relit, se compare et se versionne.

    D'où vient le programme lui-même : la question est ouverte ici et traitée
    dans la partie « Programmation ».
  ]
]

// --------------------------- Fichiers et extensions -------------------------

#d("Fichier, extension et type de fichier")[
  #annonce[
    L'extension est la fin du nom, après le dernier point. Le système s'en
    sert pour choisir le logiciel à lancer ; elle ne dit rien du contenu.
  ]

  #align(center)[
    #grid(
      columns: (auto, auto),
      row-gutter: 13pt,
      align: center,
      text(font: police-code, size: 32pt, fill: estompe)[releve\_2026],
      text(font: police-code, size: 32pt, fill: accent, weight: "bold")[.csv],
      text(size: 14pt, fill: estompe)[le nom, que vous choisissez],
      text(size: 14pt, fill: accent)[l'extension],
    )
  ]

  #v(0.6em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [L'extension], [Ce qu'elle décide],
    [ce qu'elle fait], [le système choisit le logiciel à lancer au double-clic],
    [ce qu'elle ne fait pas], [elle ne modifie aucun octet du fichier],
    [comment on la change], [en renommant le fichier, comme le reste du nom],
  )

  #notes[
    Faire activer l'affichage des extensions dans l'explorateur, sans quoi la
    manipulation qui suit est impossible à suivre : `F2` ne montrerait pas ce
    qu'on renomme.

    État vérifié en 2026 : Windows 11 masque toujours les extensions des types
    connus par défaut, et le réglage se trouve dans Explorateur > Affichage >
    Afficher > Extensions de noms de fichiers. Sous macOS, Finder > Réglages >
    Avancé > « Afficher tous les suffixes de fichiers ». À faire une fois, utile
    tout le semestre.
  ]
]

#d("Reconnaître un format à son extension")[
  #annonce[
    Pour chacune, dites de quel type de contenu il s'agit, et si le fichier
    est lisible dans un éditeur de texte.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 9pt,
    etiquette(".mp3"), etiquette(".flac"), etiquette(".mp4"), etiquette(".mkv"),
    etiquette(".jpg"), etiquette(".png"), etiquette(".svg"), etiquette(".tif"),
    etiquette(".pdf"), etiquette(".odt"), etiquette(".xlsx"), etiquette(".csv"),
    etiquette(".zip"), etiquette(".7z"), etiquette(".py"), etiquette(".exe"),
  )

  #notes[
    Interroger la salle, en trois minutes, sans commenter chaque réponse. Les
    trois qui font débat : `.svg` (une image, mais du texte XML), `.csv` (du
    texte, pas un fichier Excel) et `.7z` (une archive, comme `.zip`, mais
    d'un autre outil). Ne pas s'attarder sur `.tif`.
  ]
]

#d("Reconnaître un format à son extension — réponses")[
  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 9pt,
    etiquette(".mp3", reponse: "son, avec perte"),
    etiquette(".flac", reponse: "son, sans perte"),
    etiquette(".mp4", reponse: "vidéo, la plus courante"),
    etiquette(".mkv", reponse: "vidéo, conteneur libre"),
    etiquette(".jpg", reponse: "photo, avec perte"),
    etiquette(".png", reponse: "image, sans perte"),
    etiquette(".svg", reponse: "image vectorielle : texte"),
    etiquette(".tif", reponse: "image, y compris GeoTIFF"),
    etiquette(".pdf", reponse: "document mis en page"),
    etiquette(".odt", reponse: "LibreOffice, archive ZIP"),
    etiquette(".xlsx", reponse: "Excel, archive ZIP"),
    etiquette(".csv", reponse: "tableau : du texte"),
    etiquette(".zip", reponse: "archive de fichiers"),
    etiquette(".7z", reponse: "archive, compression forte"),
    etiquette(".py", reponse: "code Python : du texte"),
    etiquette(".exe", reponse: "programme Windows"),
  )

  #legende[
    Trois de ces seize formats sont du texte : ceux qu'on peut ouvrir dans un
    éditeur, comparer ligne à ligne et versionner.
  ]

  #notes[
    Les trois formats texte de la grille : `.svg`, `.csv` et `.py`, auxquels
    s'ajoute le `.md` des notes du cours. Deux autres sont des archives ZIP de
    XML, `.odt` et `.xlsx` : ouvert en direct plus loin dans la séance.
  ]
]

// --------------------------- Chemins et adresses ----------------------------

#d("Le chemin d'un fichier")[
  #annonce[
    Un chemin dit où trouver un fichier, en partant d'un point que la machine
    connaît. Chaque partie du chemin réduit la recherche.
  ]

  #align(center)[
    #grid(
      columns: (auto, auto, auto, auto),
      row-gutter: 13pt,
      align: center,
      text(font: police-code, size: 25pt, fill: estompe, "C:\\"),
      text(font: police-code, size: 25pt, fill: estompe, "Users\\alice\\Documents\\"),
      text(font: police-code, size: 25pt, fill: encre, "raven"),
      text(font: police-code, size: 25pt, fill: accent, weight: demi-gras, ".odt"),
      text(size: 14pt, fill: estompe)[le disque],
      text(size: 14pt, fill: estompe)[les dossiers, du plus large au plus précis],
      text(size: 14pt, fill: estompe)[le nom],
      text(size: 14pt, fill: accent)[l'extension],
    )
  ]

  #v(0.6em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Ce qui change d'un système à l'autre], [Exemple],
    [Windows sépare par une barre inversée], [`C:\Users\alice\raven.odt`],
    [macOS et Linux séparent par une barre], [`/home/alice/raven.odt`],
    [Un chemin relatif part du dossier courant], [`genere\raven.odt`],
  )

  #notes[
    Le chemin absolu part du disque, le chemin relatif du dossier où l'on se
    trouve. C'est la distinction qui fera échouer la moitié des scripts au
    cours 3 : « le fichier existe pourtant » signifie presque toujours qu'on
    ne l'a pas cherché depuis le bon dossier.

    Ne pas entrer dans les subtilités de Windows maintenant. Retenir seulement
    que le séparateur diffère, et que Python accepte la barre normale partout.
  ]
]

#d("L'adresse d'une page")[
  #annonce[
    Une adresse web est un chemin de fichier, précédé de la machine sur
    laquelle il faut aller le chercher.
  ]

  #align(center)[
    #grid(
      columns: (auto, auto, auto, auto),
      row-gutter: 13pt,
      align: center,
      text(font: police-code, size: 24pt, fill: estompe, "https://"),
      text(font: police-code, size: 24pt, fill: manip, weight: demi-gras, "www.ensg.eu"),
      text(font: police-code, size: 24pt, fill: encre, "/cours/info01/"),
      text(font: police-code, size: 24pt, fill: accent, weight: demi-gras, "raven.html"),
      text(size: 14pt, fill: estompe)[comment on parle],
      text(size: 14pt, fill: manip)[à quelle machine],
      text(size: 14pt, fill: estompe)[le chemin sur cette machine],
      text(size: 14pt, fill: accent)[le fichier],
    )
  ]

  #v(0.9em)
  #align(center)[
    #block(width: 92%, fill: gris, inset: (x: 12pt, y: 10pt))[
      #set text(size: 16pt)
      #text(font: police-code, size: 15pt, "file:///C:/Users/alice/Documents/raven.html")
      #v(0.3em)
      #text(fill: estompe)[
        La même structure, sans machine distante : le fichier est sur le vôtre.
      ]
    ]
  ]

  #notes[
    C'est la diapositive qui explique pourquoi une page ouverte par double-clic
    affiche `file:///` : aucun serveur, aucun réseau, le navigateur lit un
    fichier du disque. Point repris tout de suite en manipulation, et utile
    tout le semestre.

    Le `///` surprend toujours : après `file:`, la place de la machine est vide,
    puisque c'est la machine locale. On peut le faire remarquer sans le
    développer.
  ]
]

// ------------------------ TD : fichiers et extensions -----------------------

#separateur-manip(
  "Fichiers, formats et extensions",
  annonce: "Sur votre machine. Premier geste : afficher les extensions, que Windows masque par défaut.",
)

#d("Un même document, trois formats")[
  #annonce[
    Ouvrir `data/cours1/genere/raven.odt` dans LibreOffice Writer, puis
    l'enregistrer sous deux autres formes et comparer ce qu'il en reste.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Fichier produit], [Comment], [Le texte est-il encore du texte ?],
    [`raven.pdf`], [Fichier #sym.arrow.r Exporter au format PDF], [oui : il se sélectionne et se cherche],
    [`raven.png`], [Fichier #sym.arrow.r Exporter…, type PNG], [non : des pixels, et la première page seulement],
    [`raven.odt`], [le fichier de départ], [oui, et il reste modifiable],
  )

  #legende[
    Rouvrir les trois dans LibreOffice : le `.png` s'ouvre dans Draw, comme une
    image posée sur une page.
  ]

  #notes[
    L'export en image existe bien depuis Writer, sous Fichier > Exporter, et non
    dans « Enregistrer sous ». C'est le moment de nommer la différence entre une
    page décrite (PDF, texte vectoriel) et une page photographiée (PNG, JPEG).

    Faire remarquer la perte : le PDF garde le texte mais fige la mise en page ;
    l'image perd tout sauf l'apparence. Chaque conversion enlève quelque chose,
    et rien ne la remonte.
  ]
]

#d("Renommer, et voir qui se laisse tromper")[
  #annonce[
    Renommer des copies de `raven.odt` avec `F2`, puis les ouvrir par
    double-clic.
  ]

  #block(width: 100%, fill: gris, inset: (x: 12pt, y: 7pt), below: 0.7em)[
    #set text(size: 15pt)
    #text(weight: demi-gras)[À faire d'abord :] Explorateur
    #sym.arrow.r Affichage #sym.arrow.r Afficher
    #sym.arrow.r Extensions de noms de fichiers.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Nom donné], [Ce que le système propose], [Ce qui se passe],
    [`raven_odt.pdf`], [un lecteur PDF], [refus : le fichier n'est pas un PDF],
    [`raven_odt.jpg`], [une visionneuse], [refus : _Not a JPEG file: starts with 0x50 0x4b_],
    [`riri.fifi.loulou.odt`], [LibreOffice Writer], [s'ouvre : seule la fin du nom compte],
    [`raven.loulou`], [LibreOffice Writer], [s'ouvre : extension inconnue, le système regarde le contenu],
  )

  #legende[
    Le nom d'abord, le contenu seulement quand le nom ne dit rien.
  ]

  #notes[
    `0x50 0x4b` est « PK » : la visionneuse nomme elle-même les octets qu'elle a
    lus. Y revenir à la diapositive « Comment un logiciel reconnaît un fichier ».

    La quatrième ligne est celle qui surprend, et c'est la plus utile : avec une
    extension inventée, le système n'a plus de convention à appliquer, donc il
    se rabat sur les premiers octets. Laisser inventer l'extension par la salle.

    Sous Windows et macOS, activer d'abord l'affichage des extensions, sans quoi
    `F2` ne montre pas ce qu'on renomme.
  ]
]

#d[Un `.odt` est une archive][
  #annonce[
    Renommer `raven.odt` en `raven.zip`, puis l'ouvrir avec le gestionnaire
    d'archives : il s'extrait comme n'importe quelle archive.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Fichier dans l'archive], [Ce qu'il contient],
    [`mimetype`], [une ligne, le type du document],
    [`content.xml`], [le texte, entouré de balises],
    [`styles.xml`], [la mise en forme : polices, couleurs, titres],
    [`meta.xml`], [auteur, dates, nombre de mots],
    [`META-INF/manifest.xml`], [la liste de ce que contient l'archive],
  )

  #legende[
    Six fichiers en tout. `.docx`, `.xlsx` et `.epub` sont construits de la
    même façon.
  ]

  #notes[
    Faire ouvrir `content.xml` dans l'éditeur de texte : le poème est là, en
    clair. C'est aussi la réponse à « pourquoi un `.odt` se versionne mal » :
    le fichier livré est compressé, donc illisible pour `git diff`.

    Ne pas confondre les deux fichiers : le texte est dans `content.xml`, la
    mise en forme dans `styles.xml`. C'est la séparation contenu / présentation
    déjà vue avec HTML et CSS.
  ]
]

#d[`content.xml`, avant et après][
  #annonce[
    Ouvrir `content.xml` avec un éditeur de texte : le Bloc-notes suffit,
    l'éditeur de code du cours colore les balises. Une seule chose change.
  ]

  #face-a-face(
    panneau("Avant")[
      #block(width: 100%, fill: gris, inset: (x: 10pt, y: 10pt))[
        #set text(font: police-code, size: 13pt)
        #raw("<text:p text:style-name=")#text(fill: manip, weight: demi-gras)[#raw("\"Text_20_body\"")]#raw(">") \
        #raw("Once upon a midnight dreary,") \
        #raw("while I pondered, weak and weary,")
      ]
      #v(0.4em)
      #text(size: 14pt, fill: estompe)[un paragraphe ordinaire]
    ],
    panneau("Après")[
      #block(width: 100%, fill: gris, inset: (x: 10pt, y: 10pt))[
        #set text(font: police-code, size: 13pt)
        #raw("<text:p text:style-name=")#text(fill: manip, weight: demi-gras)[#raw("\"Heading_20_1\"")]#raw(">") \
        #raw("Once upon a midnight dreary,") \
        #raw("while I pondered, weak and weary,")
      ]
      #v(0.4em)
      #text(size: 14pt, fill: manip)[le même texte, devenu un titre]
    ],
  )

  #legende[
    Le texte n'a pas bougé : seul le nom du style a changé. Le contenu et sa
    mise en forme sont bien deux choses distinctes.
  ]

  #notes[
    `content.xml` fait ici 4 ko sur 21 lignes, dont une de 1 300 caractères :
    lisible au Bloc-notes en activant le retour à la ligne, nettement plus
    confortable dans l'éditeur de code, qui colore et replie les balises.

    Sur la couleur, question fréquente : ODF n'accepte pas de nom de couleur.
    Vérifié, `fo:color="red"` est ignoré et le titre reste noir ; il faut
    `fo:color="#c0392b"`. C'est l'occasion de dire ce qu'est un code
    hexadécimal, deux chiffres par composante rouge, verte et bleue. CSS, lui,
    accepte les deux écritures : on le verra à la manipulation suivante.
  ]
]

#d("Modifier un document sans logiciel de bureautique")[
  #annonce[
    Éditer les fichiers extraits, recompresser, renommer en `.odt` : LibreOffice
    rouvre le document modifié.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Étape], [Ce que vous faites],
    [changer le texte], [dans `content.xml`, remplacer `>The Raven<` par `>Le Corbeau<`],
    [changer la taille], [dans `styles.xml`, sur `Heading_20_1`, passer `fo:font-size` de `115%` à `220%`],
    [changer un style], [dans `content.xml`, remplacer `Text_20_body` par `Heading_20_1` sur un paragraphe],
    [recompresser], [sélectionner les six fichiers, pas le dossier, et les compresser],
    [renommer], [`.zip` #sym.arrow.r `.odt`, puis ouvrir],
  )

  #legende[
    Le titre s'affiche en rouge et le poème a changé de nom, sans qu'aucun
    traitement de texte soit intervenu.
  ]

  #notes[
    Le piège à annoncer avant qu'il ne se produise : si l'on compresse le
    dossier au lieu de son contenu, les chemins dans l'archive deviennent
    `extrait/content.xml` et LibreOffice refuse d'ouvrir, avec « source file
    could not be loaded ». C'est l'erreur que tout le monde fait une fois.

    Un format ouvert et documenté se manipule avec des outils quelconques.
    C'est l'argument à retenir, plus que la manipulation elle-même.
  ]
]

#d("Ouvrir une page depuis son disque")[
  #annonce[
    Double-cliquer sur `raven_brut.html` : le navigateur l'ouvre sans réseau.
    L'adresse commence par `file:///`.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Fichier ouvert], [Ce que vous constatez],
    [`raven_brut.html`], [la page s'affiche, l'adresse est un chemin de votre disque],
    [`raven_style.html`], [le même texte, mis en forme : il appelle `style.css`],
    [`style.css`], [changez-y une couleur, revenez au navigateur et rechargez avec `F5`],
  )

  #legende[
    Le fichier `.html` est identique dans les deux cas. Seule la ligne
    `<link rel="stylesheet" href="style.css">` les distingue.
  ]

  #notes[
    Même leçon que l'archive `.odt`, sur un format que les étudiants
    reverront : le contenu dans un fichier, la présentation dans un autre, et
    on change l'un sans toucher l'autre.

    Pour la couleur, CSS accepte `color: crimson` aussi bien que
    `color: #c0392b` — contrairement à ODF. Faire essayer les deux.

    Fichiers dans `data/cours1/genere/`. Si `style.css` n'est pas dans le même
    dossier que le `.html`, la page s'affiche sans mise en forme : bonne
    occasion de reparler des chemins relatifs.
  ]
]

// ================= Interface graphique et ligne de commande =================

#separateur(
  "Interface graphique et ligne de commande",
  annonce: "Deux façons de piloter le même logiciel, et ce qu'il en reste",
)



#d("Ligne de commande et interface graphique")[
  #annonce[
    Deux façons de dire à un logiciel quoi faire. Ce qui les sépare n'est pas
    la difficulté.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Interface graphique], [Ligne de commande],
    [Ce que vous faites], [vous désignez ce que vous voyez], [vous nommez ce que vous voulez],
    [Ce qui est proposé], [ce que les menus contiennent], [tout ce que le programme accepte],
    [Pour dix fichiers], [dix fois les mêmes gestes], [la même ligne, une fois],
    [Ce qui en reste], [rien], [la commande, qui est le mode d'emploi],
    [Dire à quelqu'un quoi faire], [décrire des clics], [envoyer la ligne],
  )

  #legende[
    Aucune des deux n'est meilleure. Elles ne rendent pas le même service.
  ]

  #notes[
    Le point à faire passer : le mode graphique montre ce qui est possible,
    la ligne de commande suppose qu'on le sache déjà. C'est pour cela qu'on
    explore au clic et qu'on répète au clavier.

    Contre-exemple à donner si la salle penche trop d'un côté : personne ne
    retouche une photo au terminal, et personne ne renomme trois cents
    fichiers à la souris.

    La ligne suivante du tableau est celle qui compte pour le module :
    « ce qui en reste ». Elle prépare git au cours 2 et les scripts au
    cours 3.
  ]
]

#d("Ce que « facile à utiliser » veut dire")[
  #annonce[
    L'expérience utilisateur désigne les perceptions et réactions qui
    résultent de l'usage d'un produit. Ses critères ne vont pas tous dans le
    même sens.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Critère], [Mode graphique], [Mode texte],
    [Apprentissage], [on explore les menus], [il faut la connaître],
    [Efficacité, une fois su], [un geste par fichier], [une ligne pour trois cents],
    [Mémorisation], [on reconnaît], [on doit se rappeler],
    [Erreurs], [annulation possible], [une faute de frappe suffit],
    [Trace laissée], [aucune], [la commande elle-même],
  )

  #legende[Définition : norme ISO 9241-210 ; critères d'après Jakob Nielsen.]

  #notes[
    L'interface n'est qu'une partie de l'expérience : un logiciel très joli
    qui perd le travail de l'utilisateur a une mauvaise UX. Utile à dire à des
    étudiants qui produiront eux-mêmes des outils au cours 6 et au TD 7.
  ]
]

#d("Le terminal")[
  #annonce[
    Un terminal est une fenêtre où l'on tape des commandes et où le programme
    répond par du texte. Rien d'autre.
  ]

  #align(center)[
    #grid(
      columns: (auto, auto, auto),
      row-gutter: 12pt, column-gutter: 14pt,
      align: center,
      text(font: police-code, size: 23pt, fill: accent, weight: demi-gras, "soffice"),
      text(font: police-code, size: 23pt, fill: manip, weight: demi-gras, "--convert-to pdf"),
      text(font: police-code, size: 23pt, fill: encre, "raven.odt"),
      text(size: 14pt, fill: accent)[le programme],
      text(size: 14pt, fill: manip)[les options],
      text(size: 14pt, fill: estompe)[ce sur quoi il travaille],
    )
  ]

  #v(0.7em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Système], [Comment l'ouvrir],
    [Windows 11], [clic droit sur le bouton Démarrer, ou `Win`+`X`, puis Terminal. Depuis un dossier : clic droit, « Ouvrir dans le terminal »],
    [macOS], [Applications, Utilitaires, Terminal],
    [Linux], [`Ctrl`+`Alt`+`T` sur la plupart des bureaux],
  )

  #notes[
    Sous Windows 11, Terminal est l'application par défaut ; elle ouvre
    PowerShell. L'ancienne « Invite de commandes » reste disponible dans le
    même onglet déroulant. Ne pas entrer dans la différence entre les deux
    aujourd'hui : elle est traitée au cours 2.

    Le terminal s'ouvre toujours dans un dossier, affiché avant l'invite.
    C'est le « dossier courant » des chemins relatifs vus tout à l'heure, et
    la source de la moitié des erreurs de début de semestre. Le clic droit
    « Ouvrir dans le terminal » depuis le bon dossier évite le problème.

    Une commande se lit toujours pareil : le programme, puis ce qu'on lui
    demande, puis ce sur quoi il travaille.
  ]
]

// --------------------- TD : piloter un logiciel au clavier -------------------

#separateur-manip(
  "Le même geste, à la souris et au clavier",
  annonce: "Convertir un document des deux façons, puis regarder ce qu'un logiciel lit vraiment",
)

#d("Mode graphique et mode texte")[
  #annonce[
    La même conversion, faite de deux façons. Le fichier produit est
    identique ; ce qui diffère est ce qu'il en reste après.
  ]

  #face-a-face(
    panneau("En cliquant")[
      #block(inset: 10pt, width: 100%, height: 92pt,
             stroke: 0.8pt + estompe.lighten(50%))[
        #set text(size: 15pt)
        LibreOffice Writer
        #v(0.3em)
        Fichier #sym.arrow.r Exporter au format PDF…
        #v(0.3em)
        choisir le dossier, cliquer sur #emph[Exporter]
      ]
    ],
    panneau("En tapant")[
      #block(inset: 10pt, width: 100%, height: 92pt,
             fill: accent.lighten(94%), stroke: 0.8pt + accent.lighten(50%))[
        ```bash
        soffice --headless \
          --convert-to pdf raven.odt
        ```
        #v(1fr)
        #text(size: 13pt, fill: estompe)[
          la même ligne convertit trois cents documents
        ]
      ]
    ],
  )

  #legende[
    Le fichier produit est le même. La commande, elle, se recopie dans un
    message et se relance sur trois cents documents.
  ]

  #notes[
    Ne pas opposer les deux modes en bien et mal : le graphique est supérieur
    pour explorer et pour ce qui se juge à l'œil, le texte pour répéter et
    transmettre. Le module enseigne le second parce que c'est celui qui manque.

    La commande telle qu'elle est écrite ici ne fonctionne que sous Linux.
    C'est l'objet de la diapositive suivante, et il vaut mieux le dire avant
    que quelqu'un ne l'essaie.
  ]

]

#d("La même commande, trois systèmes")[
  #annonce[
    LibreOffice n'est ajouté au `PATH` par aucun installeur. Sous Windows et
    macOS, il faut donner son chemin complet.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Système], [Ce qu'il faut taper],
    [Linux], [`soffice --headless --convert-to pdf raven.odt`],
    [macOS], [`/Applications/LibreOffice.app/Contents/MacOS/soffice --headless …`],
    [Windows], [`& "C:\Program Files\LibreOffice\program\soffice.com" --headless …`],
  )

  #legende[
    Sous Windows, c'est `soffice.com` et non `soffice.exe` : seule la version
    console attend la fin de la conversion. Le `&` est nécessaire parce que
    PowerShell prendrait sinon le chemin entre guillemets pour du texte.
  ]

  #notes[
    Trois pièges, dans l'ordre où ils se présentent : le `PATH`, le choix
    entre `soffice.com` et `soffice.exe` que demande la documentation
    officielle, et l'opérateur d'appel de PowerShell.

    Honnêteté nécessaire : seule la ligne Linux a été exécutée. Celles de
    Windows et macOS viennent de la documentation LibreOffice et n'ont pas
    été vérifiées sur ces systèmes. Les tester avant la séance.

    Repli si cela dérape sur quelques postes : `pandoc raven.odt -o raven.pdf`
    dans l'environnement `info01`, qui lui est dans le `PATH` sur les trois
    systèmes une fois `conda activate` fait. Même démonstration, sans le
    problème de chemin.
  ]
]

#d("Le navigateur en ligne de commande")[
  #annonce[
    Le navigateur aussi se pilote sans fenêtre. C'est son moteur de rendu que
    l'on appelle, le même qui affiche la page à l'écran.
  ]

  #tableau(
    columns: (auto, 1fr, auto),
    align: left + horizon,
    [Ce que l'on veut], [La commande], [Résultat obtenu],
    [la page en PDF],
      [`chromium --headless --no-pdf-header-footer --print-to-pdf=page.pdf file://…`],
      [texte sélectionnable],
    [la page en image],
      [`chromium --headless --screenshot=page.png --window-size=900,1200 file://…`],
      [900 × 1200 pixels],
    [avec Firefox],
      [`firefox --headless --screenshot page.png --window-size 900,1200 file://…`],
      [image seulement],
  )

  #legende[
    Même logiciel, même moteur de rendu : seule l'interface disparaît. Firefox
    ne sait pas produire de PDF de cette façon, Chromium si.
  ]

  #notes[
    Ces trois lignes ont été exécutées et vérifiées. Deux détails à connaître
    avant de les lancer en séance. Sans `--no-pdf-header-footer`, Chromium
    ajoute la date et l'adresse en haut et en bas de chaque page. Et Firefox
    refuse de démarrer si une autre fenêtre est déjà ouverte : il faut alors
    lui donner un profil à part avec `--profile`.

    Le rapprochement à faire avec la conversion LibreOffice : dans les deux
    cas, un logiciel que l'on connaît par ses fenêtres accepte aussi d'être
    appelé par son nom. Une interface graphique n'est qu'une façade posée sur
    un programme.
  ]
]

#d("Binaire, hexadécimal et encodage du texte")[
  #annonce[
    Un fichier est une suite d'octets. Un octet vaut de 0 à 255, et s'écrit
    avec deux chiffres hexadécimaux. Le texte n'échappe pas à la règle : une
    table associe chaque caractère à un ou plusieurs octets.
  ]

  #tableau(
    columns: (auto, auto, auto, 1fr),
    align: left + horizon,
    [Caractère], [Valeur], [En hexadécimal], [Remarque],
    [`P`], [80], [`50`], [un octet, comme tout l'ASCII],
    [`K`], [75], [`4B`], [au-delà de 9, on compte avec A à F],
    [`é`], [195 et 169], [`C3 A9`], [deux octets en UTF-8, l'encodage d'aujourd'hui],
  )

  #legende[
    L'hexadécimal ne change rien au fichier : c'est une façon d'écrire les
    octets, plus lisible que 8 chiffres binaires par octet.
  ]

  #notes[
    Le minimum utile ici, rien de plus : le binaire est ouvert pour de bon au
    cours 3. Ce qu'il faut retenir aujourd'hui est qu'un octet et son écriture
    hexadécimale sont la même chose, et que « texte » veut dire « octets plus
    une table de correspondance ».

    Conséquence à semer pour le cours 2 : un fichier écrit avec une table et
    relu avec une autre donne des caractères abîmés. C'est l'origine des
    accents cassés que tout le monde a déjà vus.

    `P` vaut 80 et `K` vaut 75 : c'est ce qui produit les deux lettres lisibles
    en tête d'un ZIP, diapositive suivante.
  ]
]

#d("Comment un logiciel reconnaît un fichier")[
  #annonce[
    Le système choisit le logiciel d'après le nom. Le logiciel, lui, lit les
    premiers octets du fichier.
  ]

  ```console
  $ head -c 8 test_odt.pdf | xxd
  00000000: 504b 0304 1400 0208    PK......

  $ head -c 8 test_pdf.odt | xxd
  00000000: 2550 4446 2d31 2e37    %PDF-1.7

  $ file test_odt.pdf test_pdf.odt
  test_odt.pdf: OpenDocument Text
  test_pdf.odt: PDF document, version 1.7, 1 page(s)
  ```

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Sous Windows], [ni `head` ni `xxd`, mais PowerShell fait les deux],
    [les premiers octets], [`Format-Hex raven.odt | Select-Object -First 1`],
  )

  #notes[
    Ces octets de tête s'appellent des nombres magiques. La commande `file`
    ne fait que les comparer à un catalogue. Ne pas développer : le format
    binaire est ouvert en hexadécimal au cours 3.

    `PK` signe une archive ZIP, donc un `.odt` ; `%PDF` signe un PDF. Windows
    ne fournit en revanche aucun équivalent de `file`, qui déduit le type du
    contenu.

    Sur l'équivalent Windows : `head` et `xxd` n'existent pas, et `Format-Hex`
    remplace les deux à la fois puisqu'il affiche l'hexadécimal et le texte
    côte à côte. Son paramètre `-Count` n'est apparu qu'avec PowerShell 6.2,
    donc pas dans le PowerShell 5.1 livré avec Windows : d'où le passage par
    `Select-Object -First 1`, qui prend la première ligne de seize octets et
    fonctionne dans les deux versions. Ces lignes viennent de la documentation
    Microsoft et n'ont pas pu être exécutées ici, faute de Windows : à
    vérifier avant la séance.

    Annoncer que le même phénomène se reverra dans la partie programmation :
    les premiers octets de l'exécutable `python3` se lisent « ELF ». Et la
    manipulation qui produit ces fichiers est en annexe, si le temps le
    permet.
  ]
]// -------------------------------- Interfaces --------------------------------

#separateur-td(
  "Une vidéo, deux chemins",
  mention: "Bonus — pour aller plus loin",
  annonce: "La même vidéo produite en cliquant, puis en une commande, pour ceux qui vont vite",
)

#d("Le trajet de la gare à l'école")[
  #annonce[
    Produire la même vidéo, le trajet de la gare à l'école en cinq étapes
    commentées, en assemblant des applications puis en une seule commande.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [En cliquant], [En tapant],
    [Ce que vous faites],
      [tracer le trajet, monter et sous-titrer dans un éditeur vidéo],
      [écrire les étapes dans `etapes.csv`, lancer `anime.sh`],
    [Applications utilisées], [quatre], [une],
    [Corriger une étape], [refaire le montage], [modifier une ligne, relancer],
  )

  #legende[
    Le résultat est le même `trajet.mp4` : la différence porte sur la deuxième
    exécution.
  ]

  #notes[
    Faire faire le chemin « clic » à une moitié de la salle et le chemin
    « commande » à l'autre, puis échanger les constats. Préparer la carte et
    le fichier d'étapes en amont : voir la fiche de préparation
    `syllabus/cours/1_formats_et_environnement/manip_video_trajet.md`.
  ]
]

// =============================== Programmation ==============================

#separateur(
  "Outils de programmation : IDE et environnement",
  annonce: "Du texte écrit au clavier au programme qui tourne, et l'outillage pour y arriver",
)

#d("D'où vient le programme lui-même")[
  #annonce[
    Le schéma du début de séance laissait une question ouverte : la boîte du
    milieu, le programme, est elle aussi un fichier. Reste à savoir d'où il
    vient.
  ]

  #grid(
    columns: (1fr, 34pt, 1fr, 34pt, 1fr),
    rows: 96pt,
    bloc("Entrée", "un relevé GPS, une image, le clavier"),
    fleche,
    bloc("Traitement", "le programme", plein: true),
    fleche,
    bloc("Sortie", "un fichier, un écran, du son"),
  )

  #v(0.5em)
  #align(center)[
    #text(size: 19pt, fill: manip, weight: demi-gras)[
      Cette boîte-là, comment est-elle fabriquée ?
    ]
  ]

  #notes[
    Reprendre littéralement le schéma vu en début de séance, pour que la
    partie s'ouvre sur une question déjà posée plutôt que sur un sujet neuf.

    La réponse tient en deux temps : un humain écrit du texte, puis quelque
    chose transforme ce texte en instructions exécutables. Les deux
    diapositives suivantes traitent l'un puis l'autre.
  ]
]

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

#d("Deux chemins du texte à l'exécution")[
  #annonce[
    Compiler traduit tout le programme une fois pour toutes. Interpréter lit
    et exécute le texte à chaque lancement.
  ]

  #block(width: 100%, fill: gris, inset: (x: 12pt, y: 7pt), below: 0.6em)[
    #text(size: 15pt, fill: estompe, weight: demi-gras)[Compilé]
    #v(0.4em)
    #grid(
      columns: (1fr, 26pt, 1fr, 26pt, 1fr, 26pt, 1fr),
      rows: 40pt,
      align: horizon,
      etape("raven.c", "le texte écrit"),
      fleche,
      etape("compilateur", "une fois"),
      fleche,
      etape("raven.exe", "des instructions"),
      fleche,
      etape("résultat", "à chaque lancement"),
    )
  ]

  #block(width: 100%, fill: accent.lighten(92%), inset: (x: 12pt, y: 7pt))[
    #text(size: 15pt, fill: accent, weight: demi-gras)[Interprété]
    #v(0.4em)
    #grid(
      columns: (1fr, 26pt, 1fr, 26pt, 1fr),
      rows: 40pt,
      align: horizon,
      etape("raven.py", "le texte écrit"),
      fleche,
      etape("interpréteur", "à chaque lancement"),
      fleche,
      etape("résultat", ""),
    )
  ]

  #legende[
    Lancer un programme Python ne crée rien sur le disque : le texte est relu
    à chaque fois, et c'est aussi pourquoi il est plus lent.
  ]

  #notes[
    Le schéma dit tout : la chaîne compilée a une étape de plus, mais elle
    n'est faite qu'une fois ; la chaîne interprétée en a une de moins, mais
    elle la refait à chaque exécution.

    Semer ici le facteur ×100 à ×1000 du cours 6 et du TD 7 : `numpy` est
    rapide parce qu'il délègue à du C compilé. Ne pas développer maintenant.

    Question qui vient toujours : « et Java ? ». Répondre en une phrase, les
    deux à la fois, et ne pas s'y engager.
  ]
]

#d("Trois compétences préalables")[
  #tableau(
    entete: false,
    columns: (auto, 1fr, auto),
    align: left + horizon,
    [Fichiers et dossiers], [ce qu'un fichier contient, ce qu'une extension signifie], [séances 1 et 3],
    [Édition de code], [ce qui distingue un éditeur d'un traitement de texte], [séance 1],
    [Environnement], [installer Python, et décrire l'installation pour la reproduire], [séance 1],
  )

  #notes[
    Annoncer l'ordre : la suite observe un même texte sous quatre formes de
    fichier, puis on installe l'environnement.
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

// ========================= Formats de fichier et outils =====================

#separateur(
  "Formats de fichier",
  annonce: "Un même texte sous quatre formes",
)

#separateur-manip(
  "Un texte, quatre formes",
  annonce: "Le même poème en .txt, en .odt, en .html, puis avec une feuille de style",
)

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
      #block(inset: 10pt, stroke: 0.8pt + estompe.lighten(50%), width: 100%)[
        #set text(size: 13pt, font: ("DejaVu Serif", "Libertinus Serif"))
        #text(size: 17pt, weight: "bold")[The Raven] \
        Edgar Allan Poe (1845) \
        #v(0.2em)
        Once upon a midnight dreary, while I pondered, weak and weary…
      ]
    ],
    panneau[`raven_style.html` + `style.css`][
      #block(inset: 10pt, fill: rgb("#faf8f4"), stroke: 0.8pt + rgb("#ddd8cd"), width: 100%)[
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

// ================================== Annexes =================================

#separateur(
  "Annexes",
  annonce: "Manipulations non traitées en séance, gardées pour référence",
)

#separateur-manip(
  "Échanger deux extensions",
  annonce: "Sur votre machine, avec LibreOffice et l'explorateur de fichiers",
)

#d("Convertir, renommer, essayer d'ouvrir")[
  #annonce[
    Convertir `raven.odt` en PDF, échanger les extensions des copies, puis
    essayer de les ouvrir.
  ]

  ```bash
  soffice --headless --convert-to pdf raven.odt   # ou Fichier > Exporter…
  cp raven.odt test_odt.pdf     # un ODT qui se présente en PDF
  cp raven.pdf test_pdf.odt     # un PDF qui se présente en ODT
  cp raven.odt test_odt.odt.pdf # une extension ajoutée à l'extension
  ```

  #v(0.35em)
  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Fichier ouvert], [Avec], [Résultat observé],
    [`test_odt.pdf`], [lecteur PDF], [refus : « May not be a PDF file »],
    [`test_odt.pdf`], [LibreOffice], [s'ouvre dans Writer, texte intact],
    [`test_pdf.odt`], [LibreOffice], [s'ouvre dans Draw, pas dans Writer],
    [`test_odt.odt.pdf`], [lecteur PDF], [même refus : seule la fin du nom compte],
  )

  #notes[
    Le résultat qui surprend est la deuxième ligne : LibreOffice ouvre
    correctement un fichier dont l'extension ment. Poser la question à la
    salle avant de répondre. La réponse est la diapositive « Comment un
    logiciel reconnaît un fichier », dans le corps de la séance.
  ]
]
