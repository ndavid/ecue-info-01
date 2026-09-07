#import "theme.typ": diapos, page-titre, separateur-module, d, separateur, separateur-manip, separateur-td, separateur-reprise, annonce, notes, legende, tableau, face-a-face, panneau, bloc-titre, question, etiquette, icone-fenetre, icone-engrenage, icone-puce, fenetre, illustration, captures-disponibles, reponse, corrige-visible, notes-visibles, accent, encre, estompe, manip, gris, demi-gras, police-code, police-texte

#show: diapos.with(
  titre-court: "Introduction à l'informatique",
  auteur-court: "1re année géomatique",
)

// Boîte d'un schéma en chaîne. `hauteur` reste à `auto` tant qu'on mesure la
// boîte ; `chaine` la rappelle ensuite avec la hauteur commune retenue.
#let bloc(titre, detail, plein: false, hauteur: auto) = block(
  width: 100%, height: hauteur, inset: 12pt,
  fill: if plein { accent.lighten(88%) } else { none },
  stroke: 1pt + accent.lighten(if plein { 40% } else { 65% }),
)[
  #align(center + horizon)[
    #text(size: 19pt, weight: "semibold")[#titre]
    #if detail != "" [
      #v(0.25em)
      #text(size: 14pt, fill: estompe)[#detail]
    ]
  ]
]

#let fleche = align(horizon + center, text(size: 26pt, fill: accent)[→])

// Une étape d'une chaîne de traitement, plus compacte que `bloc`.
#let etape(titre, detail, hauteur: auto) = block(
  width: 100%, height: hauteur, inset: (x: 8pt, y: 5pt), fill: white,
  stroke: 1pt + accent.lighten(55%),
)[
  #align(center + horizon)[
    #text(size: 15pt, weight: demi-gras)[#titre]
    #if detail != "" [
      #v(0.15em)
      #text(size: 11.5pt, fill: estompe)[#detail]
    ]
  ]
]

// Une suite de boîtes reliées par des flèches, toutes à la même hauteur.
//
// Cette hauteur n'est pas écrite à la main : elle est mesurée sur les boîtes,
// à la largeur qu'elles occuperont, puis imposée à toutes. Une valeur fixe
// dépendrait de la police effectivement présente sur le poste, et c'est ainsi
// que le texte débordait des cadres quand Fira Sans manquait.
//
//   #chaine(("raven.c", "le texte écrit"), ("raven.exe", "des instructions"))
//
// `gabarit` choisit entre `etape` (compacte) et `bloc` ; `pleins` donne les
// indices des boîtes à remplir, que seul `bloc` sait faire.
#let chaine(..cellules, gabarit: etape, ecart: 26pt, pleins: ()) = layout(dispo => {
  let items = cellules.pos()
  let n = items.len()
  let largeur = (dispo.width - ecart * (n - 1)) / n
  let boite(i, hauteur) = if gabarit == bloc {
    bloc(..items.at(i), plein: pleins.contains(i), hauteur: hauteur)
  } else {
    gabarit(..items.at(i), hauteur: hauteur)
  }

  context {
    let hauteur = calc.max(
      ..range(n).map(i => measure(boite(i, auto), width: largeur).height),
    )
    let colonnes = ()
    let contenu = ()
    for i in range(n) {
      if i > 0 {
        colonnes.push(ecart)
        contenu.push(fleche)
      }
      colonnes.push(largeur)
      contenu.push(boite(i, hauteur))
    }
    grid(columns: colonnes, rows: hauteur, align: horizon, ..contenu)
  }
})

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

#let hauteur-capture = if notes-visibles { 190pt } else { 235pt }
#let hauteur-terminal = if notes-visibles { 112pt } else { 166pt }
// Pour les diapositives où la capture est seule : elle peut prendre la place.
#let hauteur-capture-pleine = if notes-visibles { 192pt } else { 242pt }

// Sans capture d'écran, cette diapositive n'aurait rien à montrer que le
// schéma de la précédente : elle n'est alors pas produite.
// =============================== Introduction ===============================

#separateur-module(
  "Introduction à l'informatique",
  annonce: "Objectifs, contenu et organisation du module",
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
    [Demandé dans les autres cours], [(re)vu dans ce module)],
    [« ouvrez le projet fourni »], [travailler dans un éditeur de code, lire une arborescence],
    [« installez Python et numpy »], [créer un environnement et le réinstaller ailleurs],
    [« le script lit `donnees.csv` »], [manipuler des fichiers depuis Python],
    [« rendez votre code »], [versionner avec git, partager un dépôt],
  )

  #notes[
    Ces bases doivent être connues, au moins partiellement, avec les formations au lycée au prépa. 
    Mais il est très important de les maitriser pour ne pas prendre du retard dans les autres cours et pouvoir se focaliser sur le contenu propre de chauqe cours et non perdre du temps lié à un méconnaissance des outils utilisés.
  ]
]
#d("Objectifs du module liés à la programmation")[
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
#d("Les trois compétences du module")[
  #annonce[
    Trois savoir-faire reviennent à chaque séance. Une culture des ordres de
    grandeur s'y ajoute par apartés, pour expliquer pourquoi les outils sont
    faits ainsi.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: 88pt,
    gutter: 12pt,
    bloc("Éditer", "éditeur de code, arborescence de projet"),
    bloc("Versionner", "git : enregistrer, revenir, partager"),
    bloc("Structurer", "README, environnement, ligne de commande"),
  )

  #v(0.6em)
  #block(
    width: 100%, inset: (x: 14pt, y: 9pt), fill: gris,
    stroke: 1pt + accent.lighten(62%),
  )[
    #grid(
      columns: (auto, 1fr), column-gutter: 16pt, align: horizon,
      text(size: 17pt, weight: demi-gras)[Et, par apartés],
      align(right, text(size: 14pt, fill: estompe)[
        ordres de grandeur, sécurité : pourquoi les outils sont faits ainsi
      ]),
    )
  ]

  #notes[
    Les trois blocs sont les fils rouges : chaque séance en reprend au moins
    un, et les deux TD les mobilisent ensemble.

    Le bandeau n'est pas un quatrième domaine, et c'est pour cela qu'il n'a
    pas la même forme. Il désigne ce qui revient en apartés : ce que pèse un
    fichier, ce que coûte un calcul, ce qui circule sur le réseau, ce qu'on ne
    met pas dans un dépôt. La séance 5 lui est consacrée, les autres le
    croisent.

    Dire pourquoi ce registre existe plutôt que de le laisser en liste. Il
    porte le « pourquoi » des gestes demandés : on ne versionne pas du
    binaire, on ne recopie pas une boucle Python là où numpy va cent fois plus
    vite. Ces deux règles ne se retiennent que si l'ordre de grandeur qui les
    justifie a été donné une fois.
  ]
]
#d("Ce que vous avez peut-être déjà vu")[
  #annonce[
    Une bonne part de la première séance reprend des notions déjà au programme
    du lycée. Elles sont rappelées pour que la suite du module parte du même
    point pour tout le monde et ne pas perdre de temps sur ces points dans les autres cours.
  ]

  #tableau(
    columns: (1fr, auto),
    align: (left + horizon, left + horizon),
    [Notion reprise en séance 1], [Où elle a pu être abordée],
    [Le Web, HTML et CSS, adresses de pages], [SNT, seconde],
    [Formats d'image, compression avec et sans perte], [SNT, seconde],
    [Données en tableau, fichiers `.csv`], [SNT, seconde],
    [Binaire, hexadécimal, encodage du texte], [NSI, première],
    [Système d'exploitation, ligne de commande], [NSI, première],
    [Écrire et exécuter un programme Python], [NSI, ou tronc commun en CPGE],
  )

  #legende[
    Programmes de SNT et de NSI : Bulletin officiel spécial n°1 du 22 janvier
    2019. Informatique du tronc commun des CPGE scientifiques.
  ]

  #notes[
    Diapositive à commenter en trente secondes, explique que l'on a conscience que cela peut être des redites pour certains étudiants.

    Formulation qui passe bien : ce qui est reproché aux étudiants dans les
    autres cours n'est pas toujours l'algorithmique, c'est un chemin de
    fichier faux ou un environnement mal installé, une doc peu clair, un code qui
    ne s'installe pas faclement sur un autre ordinateur etc... 
    Ces notions ne sont pas enseignées dans les autres cours, choix de
    les enseigner explicitement plutôt que d'attendre une auto-formation des élèves sur ces points..
  ]
]
#d("Le rythme de la première partie")[
  #annonce[
    La première partie reprend ces notions, et avance donc plus vite que les
    suivantes. C'est la seule de la séance où le rythme est délibérément élevé.
  ]

  #v(0.4em)
  #bloc-titre("Point d'attention")[
    #set text(size: 19pt)
    Si quelque chose n'est pas clair dans cette partie, posez la question
    tout de suite, sans attendre la fin.
    #v(0.5em)
    Tout ce qui suit s'appuie dessus. Une notion laissée de côté aujourd'hui
    se paiera sur les six séances suivantes, et c'est le retard pris au début
    qui est le plus difficile à rattraper.
  ]

  #notes[
    Diapositive courte, mais à ne pas expédier : c'est le contrat de la
    séance, et il vaut la peine de s'arrêter dessus dix secondes de plus que
    le contenu ne le demande.

    Dire les deux moitiés dans cet ordre. D'abord la raison du rythme, qui
    est un choix et non de la précipitation : la partie 1 reprend ce qui a pu
    être vu au lycée, et le temps ainsi gagné va aux manipulations. Ensuite
    la contrepartie, qui est à leur charge.

    Formulation qui fonctionne mieux qu'une invitation générale à poser des
    questions : dire qu'ici, ne pas comprendre est probable et normal, parce
    qu'on va vite exprès. La question n'est donc pas un aveu, c'est ce que le
    rythme suppose.

    Le passage à surveiller en pratique est le vocabulaire de la partie 1 —
    logiciel, application, format, extension, chemin. Ce sont des mots qu'ils
    croient connaître, et c'est là que les malentendus s'installent sans
    bruit.
  ]
]
#d("Organisation : sept séances de deux heures")[
  #annonce[
    Chaque séance alterne des explications courtes et des manipulations faites
    sur votre machine. 2 séances orientées sur des TD plus long et faisant revoir et manipuler les notions vues dans les séances précédentes.
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
#d("Contenu de la séance")[
  #annonce[
    Cinq parties, des notions les plus générales jusqu'à l'installation de
    l'environnement de programmation.
  ]

  #tableau(
    columns: (1fr, auto, auto),
    align: (left + horizon, left + horizon, right + horizon),
    [Partie], [Nature], [Durée],
    [Logiciels et formats de fichier], [cours et manipulation], [25′],
    [Programmation et éditeur de code], [cours et manipulation], [25′],
    [Édition de texte et contenu des fichiers], [cours et manipulation], [30′],
    [Environnement de programmation], [cours et manipulation], [25′],
    [Notebooks], [cours], [10′],
  )

  #legende[
    Durées indicatives ; ce qui n'a pas été traité est repris en annexe.
  ]

  #notes[
    Diapositive d'orientation : on y revient à chaque changement de partie, en
    s'appuyant sur les diapositives de séparation.

    Les diapositives brunes du déroulé sont les manipulations : cinq, dans les
    trois premières parties, l'installation de l'environnement occupant à elle
    seule la quatrième. Annoncer dès maintenant que la séance n'est pas un
    exposé continu.

    L'ordre a une logique à énoncer en une phrase : on décrit d'abord ce qu'est
    un logiciel et ce qu'il manipule, puis comment on en écrit un, puis ce
    qu'un fichier contient vraiment, puis comment on installe de quoi
    travailler, et enfin l'outil qui réunit tout cela.

    Les durées sont le budget visé, pas le contenu du deck, qui est plus large :
    ce qui n'est pas traité part en annexe.
  ]
]
#separateur(
  "Logiciels et formats de fichier",
  annonce: "Première partie du module",
)
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
#d("Le lieu du calcul")[
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
    Devant un service en ligne, deux choses restent à établir : où part le
    fichier déposé, et ce qu'il en reste ensuite.
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
    Ce qu'un programme reçoit et ce qu'il produit sont de deux natures : un
    fichier, qui se conserve, ou un périphérique, qui ne garde rien.
  ]

  #layout(dispo => context {
    let ecart = 34pt
    let largeur = (dispo.width - 2 * ecart) / 3
    let gouttiere = 10pt
    // Entrées et sorties se répondent : mêmes deux natures de chaque côté.
    let entrees = (
      ("Entrée : un fichier", "un relevé GPS, une image"),
      ("Entrée : un périphérique", "clavier, souris, réseau"),
    )
    let sorties = (
      ("Sortie : un fichier", "une image, un tableau, une vidéo"),
      ("Sortie : un périphérique", "écran, son"),
    )
    // Les colonnes latérales portent deux boîtes, celle du milieu une seule :
    // la hauteur commune est celle de la plus haute des trois colonnes.
    let hauteur = calc.max(
      measure(bloc("Traitement", "le programme"), width: largeur).height,
      ..(entrees + sorties).map(
        s => 2 * measure(bloc(..s), width: largeur).height + gouttiere,
      ),
    )
    let colonne(paire) = grid(
      rows: ((hauteur - gouttiere) / 2,) * 2, row-gutter: gouttiere,
      ..paire.map(s => bloc(..s, hauteur: 100%)),
    )
    grid(
      columns: (largeur, ecart, largeur, ecart, largeur),
      rows: hauteur,
      align: horizon,
      colonne(entrees),
      fleche,
      bloc("Traitement", "le programme", plein: true, hauteur: hauteur),
      fleche,
      colonne(sorties),
    )
  })

  #legende[
    Un fichier sert à conserver un résultat et à l'échanger : avec un autre
    logiciel, avec une autre machine, ou avec quelqu'un d'autre.
  ]

  #notes[
    Schéma réutilisé tout le semestre. Les deux colonnes se répondent, et
    c'est ce qu'il faut faire remarquer : un programme ne reçoit pas
    seulement des fichiers, et n'en produit pas seulement.

    Le réflexe à corriger est du côté droit : les étudiants pensent
    spontanément qu'un programme « affiche », et oublient qu'il peut écrire.
    Le module s'intéresse surtout à ce qui laisse un fichier, parce qu'un
    fichier se relit, se compare et se versionne — et surtout parce qu'il est
    ce qui circule d'un logiciel à l'autre.

    Le réseau est mis du côté des périphériques, avec le clavier et la souris.
    Ce n'est pas une approximation : pour le programme, ce sont trois choses
    qu'on lit sans qu'elles restent. Le rapprochement est repris au cours 5.

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
    etiquette(".mp3"), etiquette(".mp4"), etiquette(".jpg"), etiquette(".png"),
    etiquette(".svg"), etiquette(".tif"), etiquette(".pdf"), etiquette(".odt"),
    etiquette(".xlsx"), etiquette(".csv"), etiquette(".zip"), etiquette(".exe"),
    etiquette(".py"), etiquette(".md"), etiquette(".json"), etiquette(".yaml"),
  )

  #notes[
    Interroger la salle, en trois minutes, sans commenter chaque réponse. Les
    deux qui font débat : `.svg` (une image, mais du texte XML) et `.csv` (du
    texte, pas un fichier Excel). Ne pas s'attarder sur `.tif`.

    La dernière ligne est celle du module, et elle est volontairement groupée :
    ce sont les quatre fichiers qu'ils éditeront eux-mêmes. Peu sauront nommer
    `.yaml` ; c'est attendu, la partie suivante y répond.
  ]
]
#d("Reconnaître un format à son extension — réponses")[
  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 9pt,
    etiquette(".mp3", reponse: "son, avec perte"),
    etiquette(".mp4", reponse: "vidéo, la plus courante"),
    etiquette(".jpg", reponse: "photo, avec perte"),
    etiquette(".png", reponse: "image, sans perte"),
    etiquette(".svg", reponse: "image vectorielle : texte"),
    etiquette(".tif", reponse: "image, y compris GeoTIFF"),
    etiquette(".pdf", reponse: "document mis en page"),
    etiquette(".odt", reponse: "LibreOffice, archive ZIP"),
    etiquette(".xlsx", reponse: "Excel, archive ZIP"),
    etiquette(".csv", reponse: "tableau : du texte"),
    etiquette(".zip", reponse: "archive de fichiers"),
    etiquette(".exe", reponse: "programme Windows"),
    etiquette(".py", reponse: "code Python : du texte"),
    etiquette(".md", reponse: "documentation : du texte"),
    etiquette(".json", reponse: "données, réglages : texte"),
    etiquette(".yaml", reponse: "réglages : du texte"),
  )

  #legende[
    Six de ces seize formats sont du texte : ceux qu'on peut ouvrir dans un
    éditeur, comparer ligne à ligne et versionner.
  ]

  #notes[
    Les six formats texte de la grille : `.svg`, `.csv`, `.py`, `.md`, `.json`
    et `.yaml`. Deux autres sont des archives ZIP de XML, `.odt` et `.xlsx`,
    ouvertes en direct plus loin dans la séance.

    Faire compter les six par la salle plutôt que de les énoncer : c'est le
    critère de tout le module, et il vaut d'être trouvé une fois.
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
    [`raven.pdf`], [Fichier #sym.arrow.r Exporter au format PDF], reponse[oui : il se sélectionne et se cherche],
    [`raven.png`], [Fichier #sym.arrow.r Exporter…, type PNG], reponse[non : des pixels, et la première page seulement],
    [`raven.odt`], [le fichier de départ], reponse[oui, et il reste modifiable],
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
    [`raven_odt.pdf`], [un lecteur PDF], reponse[refus : le fichier n'est pas un PDF],
    [`raven_odt.jpg`], [une visionneuse], reponse[refus : _Not a JPEG file: starts with 0x50 0x4b_],
    [`riri.fifi.loulou.odt`], [LibreOffice Writer], reponse[s'ouvre : seule la fin du nom compte],
    [`raven.loulou`], [LibreOffice Writer], reponse[s'ouvre : extension inconnue, le système regarde le contenu],
  )

  #legende[
    #reponse[
      Le système regarde le nom d'abord, et le contenu seulement quand le nom
      ne dit rien.
    ]
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
    l'éditeur de code du cours colore les balises.
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
    `_20_` est le code hexadécimal de l'espace : `Text_20_body` se lit
    « Text body », et `Heading_20_1` « Heading 1 ». Le texte, lui, n'a pas
    bougé — seul le nom du style a changé.
  ]

  #notes[
    `content.xml` fait ici 4 ko sur 21 lignes, dont une de 1 300 caractères :
    lisible au Bloc-notes en activant le retour à la ligne, nettement plus
    confortable dans l'éditeur de code, qui colore et replie les balises.

    Le `_20_` intrigue toujours, et la réponse tient en deux phrases : un nom
    de style est un nom XML, où l'espace est interdit ; ODF encode donc chaque
    caractère interdit par son code hexadécimal entouré de tirets bas, et
    l'espace vaut 20 en hexadécimal. Le nom lisible est rangé à côté, dans
    l'attribut `style:display-name`, et c'est celui que LibreOffice affiche
    dans son panneau des styles.

    Ce n'est donc pas un nom en trois morceaux : c'est « Text body » avec son
    espace encodé. Le rapprochement à faire, s'il aide, est celui du `%20` des
    adresses web, où l'espace est interdit pour la même raison et encodé de la
    même façon. La référence est OpenDocument v1.3, partie 3, sur `style:name`
    et `style:display-name` ; elle est donnée dans le notebook.

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
#d("Ouvrir une page html depuis son disque")[
  #annonce[
    Double-cliquer sur `raven_brut.html` : le navigateur l'ouvre sans réseau.
    L'adresse commence par `file:///`.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Fichier ouvert], [Ce que vous constatez],
    [`raven_brut.html`], reponse[la page s'affiche, l'adresse est un chemin de votre disque],
    [`raven_style.html`], reponse[le même texte, mis en forme : il appelle `style.css`],
    [`style.css`], reponse[changez-y une couleur, revenez au navigateur et rechargez avec `F5`],
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
// ==================== Programmation et éditeur de code =====================

#separateur("Programmation et éditeur de code")
#d("Programmes et applications")[
  #annonce[
    Un programme est un texte d'instructions qui accomplit une tâche ;
    programmer, c'est écrire ce texte. Une application est un programme
    empaqueté pour celui qui s'en sert.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Programme], [Application],
    [Ce qu'on reçoit],
      [le code source, un fichier texte],
      [un produit installé, prêt à l'emploi],
    [Pour l'exécuter],
      [savoir quel outil le lance, et le lui demander],
      [ouvrir la fenêtre],
    [Interface],
      [souvent aucune : le terminal suffit],
      [prévue pour l'utilisateur],
    [Dans ce module],
      [automatiser une tâche, traiter des données],
      [ce qu'on utilise, pas ce qu'on écrit],
  )

  #legende[
    La frontière tient à l'empaquetage et à l'usage, non à la technique : le
    même code, distribué prêt à l'emploi, se présente comme une application.
  ]

  #notes[
    Motiver avant de définir. Renommer 300 photos par leur date prend une
    soirée à la main et quelques secondes par programme ; la deuxième
    exécution ne coûte rien, et une erreur de recopie devient systématique,
    donc repérable. C'est le genre de programme demandé dans ce module : de
    l'automatisation et du traitement de données, pas des applications.

    Trois mots à séparer une fois pour toutes : « programmation » nomme
    l'activité, « programme » son résultat, « application » ce que reçoit
    celui qui s'en sert. Dire que la frontière entre les deux derniers est
    floue plutôt que la laisser deviner : ce n'est pas une catégorie
    technique. Un même code se lance à la main depuis un terminal, puis
    s'empaquette avec une interface et se distribue ; ce qui change est ce
    que reçoit l'utilisateur, et ce qu'il doit savoir pour le faire tourner.

    Reprendre ensuite le schéma entrée → traitement → sortie du début de
    séance : la boîte du milieu est elle aussi un fichier, et la question qui
    ouvre la suite est de savoir comment ce fichier est fabriqué. Les deux
    diapositives suivantes y répondent : d'abord les deux chemins qui mènent
    du texte à l'exécution, puis ce que devient ce texte une fois traduit.
  ]
]
#d("Deux chemins du texte à l'exécution")[
  #annonce[
    Compiler traduit tout le programme une fois pour toutes. Interpréter lit
    et exécute le texte à chaque lancement.
  ]

  #block(width: 100%, fill: gris, inset: (x: 12pt, y: 5pt), below: 0.4em)[
    #text(size: 15pt, fill: estompe, weight: demi-gras)[Compilé]
    #v(0.25em)
    #chaine(
      ("bonjour.cpp", "le texte écrit"),
      ("compilateur", "une fois"),
      ("bonjour.exe", "des instructions"),
      ("résultat", "à chaque lancement"),
    )
  ]

  #block(width: 100%, fill: accent.lighten(92%), inset: (x: 12pt, y: 5pt))[
    #text(size: 15pt, fill: accent, weight: demi-gras)[Interprété]
    #v(0.25em)
    #chaine(
      ("bonjour.py", "le texte écrit"),
      ("interpréteur", "à chaque lancement"),
      ("résultat", "rien sur le disque"),
    )
  ]

  #legende[
    Lancer un programme Python ne crée rien sur le disque, et c'est aussi
    pourquoi il est plus lent.
  ]

  #notes[
    Le schéma dit tout : la chaîne compilée a une étape de plus, mais elle
    n'est faite qu'une fois ; la chaîne interprétée en a une de moins, mais
    elle la refait à chaque exécution.

    Semer ici le facteur ×100 à ×1000 du cours 6 et du TD 7 : `numpy` est
    rapide parce qu'il délègue à du C compilé. Ne pas développer maintenant.

    Les noms de fichiers sont ceux de la manipulation de tout à l'heure : le
    schéma et le geste porteront les mêmes, et le rapprochement se fera tout
    seul. Le dire une fois, ici.

    Question qui vient toujours : « et Java ? ». Répondre en une phrase, les
    deux à la fois, et ne pas s'y engager.
  ]
]
#d("Code source et fichier exécutable")[
  #annonce[
    Au bout de la chaîne compilée, un fichier que le processeur lit et
    qu'aucun humain ne peut lire. Il a pourtant été produit à partir d'un
    texte écrit au clavier.
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

    Le fichier montré est l'exécutable de `python3`, et ce n'est pas un hasard :
    l'interpréteur du chemin de droite est lui-même arrivé au bout du chemin de
    gauche. C'est ce que la diapositive suivante met en place.
  ]
]
#d("La place de l'interpréteur")[
  #annonce[
    Un programme compilé s'adresse directement au système. Un programme
    interprété passe d'abord par l'interpréteur, lui-même un exécutable.
  ]

  #couche(
    icone-fenetre(taille: 30pt), "Programme interprété",
    "bonjour.py, une page web", plein: true,
  )
  #liaison("le texte à exécuter", "le résultat")
  #couche(
    icone-fenetre(taille: 30pt), "Interpréteur",
    "python, le navigateur",
  )
  #liaison("« ouvre ce fichier »", "le contenu")
  #couche(
    icone-engrenage(taille: 30pt), "Système d'exploitation",
    "Windows, macOS, Linux",
  )

  #legende[
    Un programme compilé n'a pas cet étage intermédiaire : `bonjour.exe`
    s'adresse directement au système.
  ]

  #notes[
    Le mot à donner : un interpréteur est un programme comme les autres.
    Celui de Python s'appelle `python`, et c'est son exécutable dont les
    premiers octets viennent d'être montrés, `7f 45 4c 46`.
    Ce qui exécute du texte est soi-même un binaire.

    La conséquence pratique est celle qui compte : pour lancer un programme
    Python, il faut que Python soit installé, alors qu'un exécutable compilé
    se lance seul. C'est ce que la manipulation fera constater, et c'est
    pourquoi la partie « Environnement de programmation » existe.

    Le navigateur est le second exemple, et le plus parlant : il interprète
    trois langages sans que personne ne l'appelle « interpréteur ». Le mot
    désigne un rôle, pas une catégorie de logiciel. Sous les trois couches il
    y a le matériel, comme à la diapositive « Le système d'exploitation ».
  ]
]
#d("L'éditeur de code")[
  #annonce[
    Un éditeur de code réunit trois choses dans une fenêtre : à gauche
    l'arborescence du projet, au centre le texte du programme, en bas un
    terminal pour le lancer.
  ]

  #align(center)[
    #illustration(
      "../../../data/cours1/illustrations/vscode_projet.png",
      fenetre("trajet — Visual Studio Code", hauteur: hauteur-capture)[
        #text(size: 13pt, fill: estompe)[
          à gauche l'arborescence, au centre le code, en bas le terminal
        ]
      ],
      hauteur: hauteur-capture,
    )
  ]

  #legende[
    Le fichier `trajet.png` apparaît dans l'arborescence : il vient d'être
    produit par la commande tapée en bas.
  ]

  #notes[
    Un éditeur de code n'est pas un traitement de texte : il enregistre du
    texte brut, sans mise en forme, et tout ce qu'il ajoute à l'écran (les
    couleurs, les numéros de ligne) est un affichage, pas du contenu.

    Les trois zones suffisent aujourd'hui. Le débogueur, les extensions et
    l'intégration git viennent aux cours 2 et 3.

    VSCode s'affiche en anglais par défaut ; le module ne demande pas de le
    changer.
  ]
]
#d("Les fonctions d'un IDE")[
  #annonce[
    IDE, pour _integrated development environment_, se traduit par
    environnement de développement intégré : un seul logiciel réunit ce qui
    demandait autant d'outils séparés.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [La fonction], [Ce que l'éditeur en fournit],
    [Écrire le code],
      [coloration, indentation, complétion, soulignement des fautes],
    [Le lancer et le tester],
      [un terminal intégré et un bouton d'exécution, sans quitter la fenêtre],
    [Naviguer dans le projet],
      [l'arborescence à gauche, la recherche dans tous les fichiers],
    [Déboguer],
      [exécuter pas à pas, arrêter sur une ligne, lire les variables],
  )

  #legende[
    Un éditeur de texte ordinaire ne fait que la première ligne. C'est
    l'intégration des autres qui fait l'environnement.
  ]

  #notes[
    Le sigle est anglais et le restera : « environnement de développement
    intégré » est la traduction officielle, « EDI » son abréviation, et
    personne ne l'emploie. Le dire une fois pour que le mot lu ailleurs soit
    reconnu.

    Les deuxième et troisième lignes sont celles qui distinguent un IDE d'un
    éditeur de texte, et ce sont elles qu'on va employer aujourd'hui : le
    terminal intégré à la manipulation qui vient, l'arborescence dès qu'on
    ouvre un dossier plutôt qu'un fichier.

    Le débogage est nommé, pas montré : il vient au cours 2, une fois qu'il y
    aura des programmes assez longs pour en avoir besoin. Le panneau git est
    dans la même situation.

    Microsoft présente VSCode comme un éditeur de code plutôt que comme un
    IDE, la différence étant que les fonctions avancées viennent d'extensions
    installées. La frontière est commerciale autant que technique ; ne pas
    s'y attarder si la question ne vient pas.
  ]
]
#d("Lancer un programme depuis l'éditeur")[
  #annonce[
    Le bouton exécute le fichier ouvert, le terminal exécute ce qu'on y tape.
    Le premier est plus rapide, le second est le même partout.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Le bouton d'exécution], [Le terminal intégré],
    [Où le trouver],
      [en haut à droite de l'éditeur],
      [Terminal #sym.arrow.r Nouveau terminal],
    [Sur un `.py`],
      [« Run Python File »],
      [`python bonjour.py`],
    [Sur un `.cpp`],
      [« Run C/C++ File », qui demande le compilateur la première fois],
      [`g++ …`, puis l'exécutable produit],
    [Ce qu'il choisit à votre place],
      [l'interpréteur, réglé par `Ctrl` + `Maj` + `P` #sym.arrow.r « Python: Select Interpreter »],
      [rien : la commande dit tout],
  )

  #legende[
    Le bouton écrit sa commande dans le terminal avant de l'exécuter : elle
    reste lisible, et c'est celle-là qu'il faut savoir écrire.
  ]

  #notes[
    La diapositive répond à une question que la partie laissait ouverte : on a
    dit qu'un IDE sert à lancer et tester, sans jamais montrer par où. Trois
    menus, et c'est tout ce qu'il faut aujourd'hui.

    Le module fait écrire la commande à la main, et il faut dire pourquoi
    plutôt que de l'imposer : elle est identique sur les trois systèmes, elle
    se relit, et c'est elle qu'on enchaînera au cours 2 puis qu'on mettra dans
    un script au cours 3. Le bouton, lui, est différent d'un langage à
    l'autre et masque ce qu'il fait.

    La dernière ligne est celle qui coûte le plus cher si elle est sautée. Le
    bouton exécute avec l'interpréteur sélectionné, qui n'est pas forcément
    celui de l'environnement du module : c'est l'origine du `ModuleNotFoundError`
    « sur un paquet qu'on vient d'installer », annoncé à la partie 4. La
    sélection vaut aussi pour le terminal, que l'extension Python active
    ensuite toute seule.

    Sur le bouton C++ : il existe, il s'appelle « Run C/C++ File », et il
    demande de choisir un compilateur au premier lancement, puis écrit un
    `tasks.json` dans le projet. Ne pas l'employer en séance — cela ajoute un
    fichier de configuration à expliquer — mais savoir répondre à celui qui
    l'aura trouvé.
  ]
]
#separateur-manip(
  "Un hello world en Python et en C++",
  annonce: "Ouvrir les deux projets dans l'éditeur, puis les exécuter depuis son terminal",
)
#d("Lancer les deux programmes")[
  #annonce[
    Six gestes, dans cet ordre. Le terminal de l'éditeur s'ouvre déjà dans le
    dossier du projet : il n'y a aucun chemin à écrire.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [Fichier #sym.arrow.r Ouvrir le dossier, puis choisir `data/cours1/hello/`],
    [2], [`Ctrl` + `Maj` + `P`, « Python: Select Interpreter », choisir `info01`],
    [3], [Terminal #sym.arrow.r Nouveau terminal : il s'ouvre en bas, dans `hello/`],
    [4], [taper `python python/bonjour.py`, puis Entrée],
    [5], [taper `g++ cpp/bonjour.cpp -o cpp/bonjour`, puis Entrée],
    [6], [taper `cpp/bonjour`, puis Entrée],
  )

  #legende[
    L'étape 5 n'affiche rien, et c'est normal : elle produit un fichier.
    Sous Windows, l'exécutable s'appelle `cpp\bonjour.exe` et se lance par
    `.\cpp\bonjour.exe`.
  ]

  #notes[
    Les gestes sont écrits un par un, et il faut les projeter tels quels.
    L'objectif seul ne suffit pas à cette séance : une étape sous-entendue
    est une étape où la moitié de la salle s'arrête sans le dire.

    Le bouton d'exécution fait la même chose que l'étape 4, et il existe aussi
    pour le C++ — c'est la diapositive précédente. Le montrer après, jamais
    avant : c'est la commande écrite à la main qui doit rester, parce qu'elle
    est la même partout et qu'elle se relit.

    L'étape 2 évite le `ModuleNotFoundError` de fin de séance : sans elle, le
    terminal peut ouvrir un autre Python que celui du module. Elle ne coûte
    rien aujourd'hui, où aucune bibliothèque n'est importée, et c'est
    justement pourquoi on la fait maintenant.

    L'étape 5 est celle où l'on attend une question, puisqu'il ne se passe
    rien à l'écran. Faire regarder l'arborescence à gauche plutôt que le
    terminal : le fichier `cpp/bonjour` vient d'y apparaître.

    Sous Windows, `g++` n'est pas fourni : il vient avec MinGW-w64, MSYS2 ou
    le sous-système Windows pour Linux. Prévoir un poste de démonstration si
    personne dans la salle n'en dispose.
  ]
]
#d("Ce que chaque lancement a produit")[
  #annonce[
    Les deux programmes affichent la même phrase. Ce qui les distingue est le
    nombre d'étapes, et ce qui reste sur le disque.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [`python/bonjour.py`], [`cpp/bonjour.cpp`],
    [Nombre d'étapes], reponse[une], reponse[deux : compiler, puis exécuter],
    [Ce qui apparaît dans l'arborescence],
      reponse[rien],
      reponse[`cpp/bonjour`, un exécutable],
    [Taille du fichier source], [121 octets], [230 octets],
    [Taille du fichier produit],
      reponse[aucun fichier],
      reponse[environ 20 000 octets],
  )

  #legende[
    La taille de l'exécutable dépend du compilateur et du système ; le
    rapport à la source, près de cent fois, n'en dépend pas.
  ]

  #notes[
    C'est la diapositive « Deux chemins du texte à l'exécution », faite à la
    main. Y renvoyer explicitement : la chaîne compilée a une étape de plus,
    mais elle ne la refait pas.

    Le rapport de taille est le chiffre à faire dire. L'exécutable embarque
    de quoi tourner sans le compilateur, d'où le facteur cent ; le fichier
    Python, lui, ne peut rien faire sans l'interpréteur, qui est déjà
    installé et qu'on ne compte donc pas.

    Faire ouvrir `cpp/bonjour` dans l'éditeur pour constater qu'il est
    illisible : c'est la diapositive « Code source et fichier exécutable »,
    vérifiée par eux. Ajouter que `python` est un exécutable de la même
    espèce, ce qui referme la diapositive sur l'interpréteur.

    Le terminal est repris pour lui-même à la partie « Environnement de
    programmation », et c'est là que la notion de dossier courant est nommée.
  ]
]
// Le résultat de la manipulation, quand la capture est disponible.
#if captures-disponibles {
d("Les deux exécutions dans l'éditeur")[
  #annonce[
    Le terminal de l'éditeur garde la trace des trois commandes, et
    l'arborescence montre le fichier que la compilation vient de produire.
  ]

  #align(center)[
    #illustration(
      "../../../data/cours1/illustrations/vscode_hello.png",
      none,
      hauteur: hauteur-capture-pleine,
    )
  ]

  #legende[
    `cpp/bonjour` n'existait pas avant la deuxième commande. Le programme
    Python, lui, n'a rien laissé.
  ]

  #notes[
    Trois commandes, deux langages, une seule fenêtre : c'est aussi
    l'argument de l'éditeur de code, montré plutôt qu'énoncé.

    Faire remarquer que la sortie affichée est identique, alors que le chemin
    pour l'obtenir ne l'est pas. C'est le fil de toute la partie.
  ]
]
}
// ================ Édition de texte et contenu des fichiers ==================

#separateur(
  "Édition de texte et contenu des fichiers",
  annonce: "Ce qu'on édite dans un projet, avec quel outil, et ce que contient vraiment un fichier",
)
#d("Programmation et édition de texte")[
  #annonce[
    Programmer, c'est écrire du texte dans un fichier. Le faire vite et sans
    faute s'apprend, et c'est ce à quoi sert un éditeur de code.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Dans un éditeur de texte ordinaire], [Dans un éditeur de code],
    [une faute de frappe se découvre à l'exécution],
      [elle est soulignée pendant la frappe],
    [on cherche un fichier dans l'explorateur],
      [l'arborescence et la recherche sont dans la fenêtre],
    [on relance le programme dans une autre fenêtre],
      [le terminal est sous le code],
    [une indentation fausse ne se voit pas],
      [les espaces s'affichent],
  )

  #legende[
    La colonne de droite est ce que cette partie détaille, ligne après ligne.
  ]

  #notes[
    L'ouverture de la partie, et son argument : tout ce qui sera produit cette
    année passe par l'édition d'un fichier texte — le programme, ses réglages,
    sa documentation, et jusqu'à ce que git doit ignorer. Ce n'est donc pas un
    détail d'outillage, c'est le geste de base.

    La colonne de gauche n'est pas une caricature : c'est ce que fait
    quelqu'un qui écrit son code dans le Bloc-notes, et plusieurs l'auront
    fait au lycée. Ne pas se moquer, montrer ce que cela coûte.

    Les quatre lignes annoncent le plan de la partie : ce que l'éditeur
    affiche, ce qu'il vérifie, et ce qu'il rend visible. Ils viennent de faire
    la troisième colonne sans le savoir, en lançant leurs deux programmes
    depuis le terminal intégré.
  ]
]
#d("Texte brut et document mis en forme")[
  #annonce[
    Un programme s'écrit dans un éditeur de texte brut. Un traitement de
    texte enregistrerait de la mise en forme, que ni Python ni le compilateur
    ne savent lire.
  ]

  #face-a-face(
    panneau("Enregistré par un éditeur de code")[
      ```python
      print("Bonjour")
      ```
    ],
    panneau("Enregistré par un traitement de texte")[
      ```xml
      <text:p text:style-name="P1">
      print("Bonjour")</text:p>
      ```
    ],
  )

  #legende[
    À droite, le `content.xml` ouvert en début de séance. La seule mise en
    forme qui compte dans un programme est l'indentation, et elle est faite
    d'espaces.
  ]

  #notes[
    La règle, énoncée une fois et sans nuance : on n'écrit jamais de code
    dans Word ni dans LibreOffice. Pas de gras, pas de taille de police, pas
    de style — non parce que ce serait laid, mais parce que rien de tout cela
    n'a d'endroit où être enregistré dans un `.py`.

    Le piège qui coûtera une heure à quelqu'un cette année est plus discret :
    un traitement de texte remplace tout seul les guillemets droits par des
    guillemets typographiques, et le tiret par un tiret cadratin. Le
    programme recopié depuis un document Word refuse alors de s'exécuter, sur
    un message qui ne parle pas de guillemets. Le dire maintenant, et le
    rappeler au premier cas rencontré.

    Rattacher à la manipulation du début de séance : ils ont ouvert le
    `content.xml` d'un `.odt` et vu le texte noyé dans les balises de style.
    C'est exactement ce que recevrait l'interpréteur.

    Le Bloc-notes, lui, enregistre bien du texte brut : il conviendrait, mais
    il ne rend aucun des services énumérés à la partie précédente.
  ]
]
#d("Ce que l'éditeur ajoute au texte")[
  #annonce[
    Le fichier ne contient que des caractères. Le même texte, dans deux
    polices : à gauche, les colonnes s'alignent.
  ]

  #face-a-face(
    panneau("Chasse fixe (éditeur de code)")[
      #raw("aire  = 12\ntotal = 480", block: true)
    ],
    // Le même texte, à la même taille, dans la police du corps : seules les
    // largeurs de caractère changent, et l'alignement se perd.
    panneau("Chasse proportionnelle (traitement de texte)")[
      #{
        show raw: set text(font: police-texte)
        raw("aire  = 12\ntotal = 480", block: true)
      }
    ],
  )

  #v(0.5em)
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [Affiché, absent du fichier], [les couleurs, les numéros de ligne, la police],
    [Présent dans le fichier], [l'indentation, qui en Python délimite le bloc],
  )

  #legende[
    Tout ce que l'éditeur ajoute est calculé à la lecture, et n'est jamais
    enregistré.
  ]

  #notes[
    Culture : un éditeur de code emploie toujours une police à *chasse fixe*,
    où toutes les lettres occupent la même largeur, alors qu'un traitement de
    texte emploie une police *proportionnelle*, où le `i` est plus étroit que
    le `m`. Le petit exemple le montre : à droite, les deux `=` ne sont plus
    alignés alors que le texte est identique.

    L'intérêt n'est pas esthétique. Une chasse fixe rend les espaces
    comptables : trois espaces se distinguent de quatre, et une tabulation se
    repère. C'est exactement ce dont Python a besoin.

    Faire le lien avec LibreOffice, manipulé en début de séance : on y choisit
    une police pour la mise en page, ici on la subit pour une raison
    technique. Le mot vient de l'imprimerie, où la chasse est la largeur d'un
    caractère.

    Ne pas confondre l'indentation, qui est dans le fichier et compte, avec la
    coloration, qui n'y est pas. C'est le sens de la dernière colonne.
  ]
]
#d("Les règles d'écriture d'un langage")[
  #annonce[
    Un langage de programmation a une grammaire, appliquée à la lettre. Elle a
    beaucoup moins d'exceptions que l'orthographe, et c'est ce qui permet à un
    logiciel de la vérifier à votre place.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [L'orthographe du français], [La grammaire d'un langage],
    [Les règles],
      [nombreuses, et souvent affaire d'usage],
      [peu nombreuses, et écrites noir sur blanc],
    [Les exceptions], [à apprendre une par une], [presque aucune],
    [Qui tranche], [l'usage, parfois personne], [l'interpréteur, sans appel],
    [Une faute], [le lecteur comprend quand même], [le programme s'arrête],
  )

  #legende[
    Les diapositives suivantes montrent ce que l'éditeur tire de ces règles :
    la couleur, puis le soulignement.
  ]

  #notes[
    La comparaison avec l'orthographe est là pour désamorcer une inquiétude,
    et il faut la formuler dans ce sens : un langage de programmation
    s'apprend plus vite qu'une langue, parce qu'il a peu de règles et presque
    pas d'exceptions. Ce qui est dur n'est pas la syntaxe, c'est de savoir
    quoi écrire — et cela relève du cours de programmation.

    La contrepartie est la dernière ligne : la machine n'interprète pas les
    intentions. Une virgule oubliée arrête tout, là où un lecteur humain
    aurait rétabli le sens sans y penser. C'est déroutant au début et cela ne
    l'est plus ensuite.

    C'est aussi ce qui rend la vérification automatique possible. On ne peut
    pas écrire un logiciel qui corrige un texte français de façon sûre ; on
    peut en écrire un qui vérifie un programme, et c'est exactement ce que
    fait l'extension installée tout à l'heure.
  ]
]
// La coloration est ici le sujet de la diapositive, et non un ornement : c'est
// la seule du deck où une couleur autre que les trois du thème est légitime.
// Le bloc de gauche est écrit sans langage déclaré, ce qui suffit à l'obtenir
// en noir ; celui de droite déclare `python` et typst le colore.
#d("Coloration syntaxique")[
  #annonce[
    Chaque langage a ses règles d'écriture. Un éditeur de code les connaît et
    donne une couleur à chaque catégorie de mot.
  ]

  #face-a-face(
    panneau("Dans un éditeur de texte")[
      #raw(
        "altitudes = [128.4, 131.0, 127.6]\nfor altitude in altitudes:\n    print(f\"{altitude:.1f} m\")",
        block: true,
      )
    ],
    panneau("Dans un éditeur de code")[
      ```python
      altitudes = [128.4, 131.0, 127.6]
      for altitude in altitudes:
          print(f"{altitude:.1f} m")
      ```
    ],
  )

  #legende[
    Le fichier est le même des deux côtés. La couleur est calculée à la
    lecture, comme les numéros de ligne.
  ]

  #notes[
    Faire nommer par la salle ce que la couleur distingue avant de le dire :
    les mots du langage, les nombres, le texte entre guillemets, les noms
    choisis par celui qui écrit. Quatre catégories, quatre traitements.

    L'intérêt n'est pas le confort. Un mot-clé mal orthographié perd sa
    couleur, et cela se voit avant d'exécuter quoi que ce soit. C'est le
    premier des deux services rendus, le second étant la vérification, deux
    diapositives plus loin.

    Rattacher à la diapositive précédente : la couleur est un affichage, elle
    n'est pas dans le fichier. Ouvrir le même fichier dans le Bloc-notes le
    montre en une seconde.
  ]
]
#d("Les extensions de l'éditeur")[
  #annonce[
    VSCode colore seul les langages les plus courants. Une extension y
    ajoute la vérification de l'écriture, la complétion et le lancement du
    programme.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Langage], [Extension], [Ce qu'elle ajoute à la coloration],
    [Python], [`ms-python.python`], [vérification, complétion, lancement du fichier],
    [C++], [`ms-vscode.cpptools`], [vérification, complétion, compilation et débogage],
    [Notebooks], [`ms-toolsai.jupyter`], [exécution des cellules dans l'éditeur],
  )

  #legende[
    Panneau Extensions, `Ctrl` + `Maj` + `X`. Ces identifiants sont ceux du
    catalogue de VSCode ; un autre IDE rend les mêmes services sous d'autres
    noms, parfois sans rien installer.
  ]

  #notes[
    Les trois extensions du module, et rien de plus aujourd'hui : celle de
    Python sert dès cette séance, celle de C++ à la manipulation qui suit,
    celle de Jupyter à la dernière partie.

    L'identifiant en chasse fixe est ce qu'il faut chercher dans le panneau :
    les noms affichés se ressemblent tous et plusieurs extensions non
    officielles portent le même titre. C'est le réflexe à donner, et il vaut
    au-delà de ce cours.

    L'extension Python installe elle-même Pylance, qui fait la vérification.
    Ne pas entrer dans le détail ; le dire seulement si quelqu'un remarque
    qu'une deuxième extension est apparue.

    Identifiants relevés sur le poste de préparation. Le catalogue est le même
    sur les trois systèmes.
  ]
]
#d("Vérification de l'écriture")[
  #annonce[
    L'extension relit le fichier pendant qu'on l'écrit et souligne ce qui ne
    respecte pas les règles du langage. Le compilateur, lui, ne répond
    qu'au lancement.
  ]

  ```cpp
  double longueur = 24.5;
  double largeur = 12.0
  std::cout << longueur * largeur << std::endl;
  ```

  #v(0.3em)
  ```console
  $ g++ cpp/aire.cpp -o cpp/aire
  cpp/aire.cpp:7:5: error: expected ‘,’ or ‘;’ before ‘std’
      7 |     std::cout << longueur * largeur << std::endl;
        |     ^~~
  ```

  #legende[
    Extrait de `cpp/aire.cpp`, lignes 5 à 7. Le point-virgule manque à la
    ligne 6 ; g++ 11.4 désigne la ligne 7.
  ]

  #notes[
    La comparaison qui fait comprendre : un correcteur orthographique souligne
    le mot pendant qu'on tape, il n'attend pas qu'on imprime la page.

    Le décalage de ligne est le point à faire retenir. Un compilateur signale
    l'endroit où il ne peut plus continuer, pas l'endroit de la faute : ici il
    lit `12.0`, attend la fin de l'instruction, trouve `std` et proteste. Lire
    le message, puis remonter d'une ligne, est un réflexe qui servira tout le
    semestre.

    C'est aussi l'argument de l'extension : elle signale la faute au bon
    endroit, et sans rien lancer.

    Le fichier est `data/cours1/erreurs/cpp/aire.cpp`, corrigé à la
    manipulation qui suit.
  ]
]
#d("Espaces, tabulations et fins de ligne")[
  #annonce[
    Un espace et une tabulation sont deux caractères différents. Python refuse
    qu'on mélange les deux dans une même indentation.
  ]

  ```console
  $ python python/surface.py
    File "…/data/cours1/erreurs/python/surface.py", line 6
      return aire
  TabError: inconsistent use of tabs and spaces in indentation
  ```

  #v(0.35em)
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [Voir les caractères invisibles], [Affichage #sym.arrow.r Rendu des espaces #sym.arrow.r Tout : un point par espace, une flèche par tabulation],
    [Lire la barre d'état], [`Spaces: 4` dit ce qu'insère la touche de tabulation ; `LF` ou `CRLF` dit comment les lignes se terminent],
  )

  #legende[
    Sortie réelle sur `data/cours1/erreurs/python/surface.py`, chemin abrégé.
    Les lignes 5 et 6 sont indentées pareil à l'écran, différemment dans le
    fichier.
  ]

  #notes[
    Erreur qui coûtera des heures au semestre si elle n'est pas nommée
    maintenant : le message ne dit pas « il manque un espace », il dit que
    l'indentation mélange deux caractères. À l'œil, rien ne se voit.

    Faire activer l'affichage des espaces sur les postes, tout de suite. C'est
    le seul moyen de voir la différence, et cela reste utile toute l'année.

    Sur les fins de ligne : Windows termine ses lignes par deux caractères
    (`CRLF`), Linux et macOS par un seul (`LF`). Un même fichier n'a donc pas
    la même taille selon la machine qui l'a écrit, et un diff peut signaler
    toutes les lignes comme modifiées alors qu'aucune ne l'est. Le point est
    repris au cours 2 avec git ; aujourd'hui il suffit de savoir où l'éditeur
    l'affiche.

    Annoncer le rapprochement : le saut de ligne est un caractère comme les
    autres, ce que la manipulation « Un texte, quatre formes » montrera plus
     loin dans cette partie, sur un poème tenant tout entier sur une ligne.
  ]
]
// Sans capture, cette diapositive n'ajouterait rien au bloc de la précédente.
#if captures-disponibles {
d("Les caractères invisibles, affichés")[
  #annonce[
    Les mêmes lignes, une fois l'affichage des espaces activé : la deuxième est
    indentée par quatre espaces, la troisième par une tabulation.
  ]

  #align(center)[
    #illustration(
      "../../../data/cours1/illustrations/vscode_espaces.png",
      none,
      hauteur: hauteur-capture-pleine,
    )
  ]

  #legende[
    Un point par espace, une flèche par tabulation. En bas à droite,
    `Spaces: 4` et `LF`.
  ]

  #notes[
    Faire pointer la ligne 3 par la salle avant de la désigner : c'est la seule
    qui diffère, et elle ne se distingue pas sans cet affichage.

    Le message d'erreur du terminal désigne la bonne ligne. Insister : lire le
    numéro de ligne d'une erreur est un réflexe à prendre aujourd'hui.
  ]
]
}
#separateur-manip(
  "Extensions de langage et programmes fautifs",
  annonce: "Installer l'extension d'un langage, puis corriger trois fichiers qui refusent de s'exécuter",
)

#d("Installer l'extension d'un langage")[
  #annonce[
    Ouvrir le dossier des programmes fautifs, installer l'extension Python,
    puis rouvrir les fichiers.
  ]

  #tableau(
    columns: (1.1fr, 1fr),
    align: left + horizon,
    [Le geste], [Ce que vous observez],
    [Fichier #sym.arrow.r Ouvrir le dossier, sur `data/cours1/erreurs/`],
      [trois fichiers, deux `.py` et un `.cpp`],
    [Ouvrir `python/surface.py` avant toute installation],
      reponse[le texte est coloré : l'éditeur connaît déjà Python],
    [`Ctrl` + `Maj` + `X`, chercher `ms-python.python`, installer],
      reponse[une ligne se souligne, sans que rien ait été exécuté],
    [Ouvrir `cpp/aire.cpp`],
      reponse[l'éditeur propose l'extension C/C++ correspondante],
  )

  #legende[
    Les trois fichiers sont fautifs volontairement. Travailler sur eux
    directement : ils sont remis en état après la séance.
  ]

  #notes[
    La deuxième ligne est celle qui surprend, et elle est voulue : la
    coloration ne vient pas de l'extension, elle est fournie d'origine pour
    les langages courants. Ce que l'extension apporte est la ligne suivante,
    le soulignement.

    Enchaîner sur la diapositive « Les extensions de l'éditeur » si la
    question de l'identifiant revient : c'est lui qu'on cherche, pas le nom
    affiché.

    L'éditeur n'a pas pu être piloté sur le poste de préparation : le
    comportement des deux dernières lignes vient de la documentation de
    VSCode et reste à vérifier sur les postes de la salle, notamment la
    proposition automatique d'extension, qui dépend d'un réglage.

    Prévoir le cas du poste sans réseau : les extensions ne s'installent pas,
    et la suite de la manipulation se fait quand même, sans le soulignement.
  ]
]

#d("Corriger trois programmes")[
  #annonce[
    Chacun des trois fichiers porte une faute d'écriture d'un genre différent.
    Lancer, lire le message, corriger, relancer.
  ]

  #tableau(
    columns: (auto, 1.2fr, 1fr),
    align: left + horizon,
    [Fichier], [Ce que dit le message], [La faute],
    [`python/surface.py`],
      [`TabError: inconsistent use of tabs and spaces`, ligne 6],
      reponse[la ligne 6 est indentée par une tabulation, la ligne 5 par des espaces],
    [`python/moyenne.py`],
      [`SyntaxError: expected ':'`, ligne 6],
      reponse[il manque les deux-points à la fin du `for`],
    [`cpp/aire.cpp`],
      [`error: expected ‘,’ or ‘;’ before ‘std’`, ligne 7],
      reponse[il manque le point-virgule à la fin de la ligne 6],
  )

  #legende[
    Messages réels, obtenus avec Python 3.12 et g++ 11.4. Une fois corrigés,
    les trois programmes affichent `294.0`, `130.05` et `294`.
  ]

  #notes[
    L'ordre des trois fautes est celui de leur difficulté de lecture, et il
    faut le suivre.

    La première ne se voit pas à l'œil : les deux lignes sont alignées à
    l'écran. C'est là qu'on fait activer l'affichage des espaces, Affichage
    #sym.arrow.r Rendu des espaces #sym.arrow.r Tout, et la flèche apparaît.
    Réglage à garder toute l'année.

    La deuxième se voit dans le message, qui nomme le caractère attendu et
    place un accent circonflexe sous l'endroit exact. Faire lire le message
    en entier plutôt que la seule dernière ligne.

    La troisième désigne la ligne 7 pour une faute ligne 6 : c'est la
    diapositive « Vérification de l'écriture », vérifiée par eux.

    La vérification demandée n'est pas que le programme affiche le bon
    résultat, mais qu'il n'affiche plus de message. C'est la définition de
    « ça marche » à ce stade, et elle suffit aujourd'hui.

    Sous Windows sans compilateur, le fichier C++ se lit et se corrige mais ne
    se compile pas : le soulignement de l'éditeur reste la seule vérification.
  ]
]
#separateur-reprise(
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
    [`.json`, `.yaml`], [les réglages, des données structurées], [un programme],
    [`.csv`], [des données en tableau], [un programme, un tableur],
    [`.md`], [la documentation, les notes, le `README`], [un humain],
  )

  #legende[
    Tous s'ouvrent dans l'éditeur, se comparent ligne à ligne et se
    versionnent. Un fichier GeoJSON est un `.json`, et rien d'autre.
  ]

  #notes[
    La diapositive corrige une impression que la partie a pu laisser jusqu'ici :
    on n'écrit pas que du code dans un éditeur de code. Sur un projet réel, les
    fichiers de réglage et la documentation sont souvent plus nombreux que les
    fichiers de programme.

    `.json` et `.yaml` portent la même chose et se convertissent l'un en
    l'autre ; le premier est celui que les programmes écrivent, le second
    celui que les humains écrivent, parce qu'il accepte des commentaires. Une
    phrase, pas plus.

    L'accroche géomatique est à donner ici : un GeoJSON exporté d'uMap ou de
    QGIS est un fichier `.json` ordinaire, qui s'ouvre dans l'éditeur et se
    lit. C'est le fichier de l'annexe « Une vidéo, deux chemins ».

    Le `README` est nommé dès maintenant parce qu'il est le livrable de fin de
    séance et le premier commit du cours 2.
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
    Markdown est annoncé le 15 mars 2004 par John Gruber sur son site Daring
    Fireball. Aaron Swartz en est l'unique bêta-testeur et discute la syntaxe ;
    les titres en `#` viennent d'atx, son propre format. L'inspiration
    revendiquée est le courriel en texte brut, où l'on encadrait déjà d'astérisques
    ce qu'on voulait mettre en valeur.

    L'intention à faire entendre, parce qu'elle n'est pas évidente : Markdown
    n'est pas un HTML simplifié pour ceux qui n'y arriveraient pas. Sa
    contrainte de départ est que la source reste lisible sans conversion. Tout
    le reste en découle, y compris ce qu'il ne sait pas faire.

    Depuis 2014, CommonMark en fixe une spécification et une suite de tests,
    les implémentations divergeant sur les cas limites. Ne le dire que si
    quelqu'un signale qu'un même fichier ne rend pas pareil partout.
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
    La ligne qui décide est la dernière, et les trois colonnes ne s'opposent
    pas : elles répondent à trois besoins qu'on a tour à tour dans la même
    semaine.

    Le piège à désamorcer tout de suite, sans quoi ils retournent à
    LibreOffice : « mon rapport doit être en PDF » n'est pas un argument
    contre Markdown, puisque `pandoc` produit le PDF depuis le `.md`. Ce qu'on
    perd est le contrôle fin de la mise en page, ce qu'on gagne est de pouvoir
    relire, comparer et versionner. C'est l'arbitrage, il faut le nommer.

    Le `.txt` n'est pas un format inférieur : c'est celui des sorties de
    programme et des relevés, où toute structure serait une gêne. Le poème du
    début de séance en est un.
  ]
]
#d("Markdown, JSON et YAML dans l'éditeur")[
  #annonce[
    Les trois s'éditent sans rien installer, mais l'éditeur ne les sert pas
    également : deux sont complets d'origine, le troisième ne l'est pas.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Format], [Fourni d'origine], [Ce qu'une extension ajoute],
    [`.md`],
      [coloration, aperçu `Ctrl` + `Maj` + `V`, plan du document, liens vérifiés],
      [du confort, rien d'essentiel],
    [`.json`],
      [coloration, pliage, formatage, vérification par schéma],
      [rien, le plus souvent],
    [`.yaml`],
      [la coloration, et rien de plus],
      [la vérification par schéma, `redhat.vscode-yaml`],
  )

  #legende[
    Relevé dans les extensions livrées avec VSCode :
    `markdown-language-features` et `json-language-features` y sont,
    `yaml-language-features` n'existe pas.
  ]

  #notes[
    La diapositive répond à la question posée deux fois depuis le début de la
    partie : quand faut-il installer une extension ? La réponse n'est pas
    « toujours », et elle se vérifie plutôt qu'elle ne se croit.

    L'aperçu Markdown est à montrer en direct, `Ctrl` + `Maj` + `V` sur le
    fichier de notes du jour : c'est le geste qu'ils emploieront le plus cette
    année, et il ne demande rien à installer.

    Le contraste avec « Les extensions de l'éditeur », vue plus haut dans
    cette partie, est le point : Python et C++ en exigent une, Markdown et
    JSON n'en ont pas besoin, YAML en tire un service précis et limité. Trois
    cas, trois réponses.

    Vérifié sur le poste de préparation en listant le dossier des extensions
    fournies avec l'éditeur. Le catalogue est le même sur les trois systèmes.
  ]
]
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
#separateur-manip(
  "Les premiers octets d'un fichier",
  annonce: "Ouvrir le mini-projet formats/ dans l'éditeur, et l'exécuter",
)

#d("Comment un logiciel reconnaît un fichier")[
  #annonce[
    Le système choisit le logiciel d'après le nom. Le logiciel, lui, ouvre le
    fichier et lit ses premiers octets.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Fichier lu], [Premiers octets], [Ce qu'ils signent],
    [`raven_une_ligne.txt`], [`4F 6E 63 65` #h(6pt) `Once`],
      reponse[aucune signature : un fichier texte n'en porte pas],
    [`raven_une_ligne.donnees`], [`4F 6E 63 65` #h(6pt) `Once`],
      reponse[les mêmes octets que la ligne précédente],
    [`raven.odt`], [`50 4B 03 04` #h(6pt) `PK`],
      reponse[une archive ZIP, donc un `.odt`],
    [`raven.pdf`], [`25 50 44 46` #h(6pt) `%PDF`],
      reponse[un document PDF],
  )

  #legende[
    Sortie réelle de `python octets.py`, dans `data/cours1/formats/`. Ces
    octets de tête s'appellent des nombres magiques.
  ]

  #notes[
    Faire ouvrir le dossier `formats/` dans l'éditeur et lancer le script au
    terminal : c'est exactement le geste de la manipulation « hello world »,
    refait sur un programme qui sert à quelque chose.

    Faire lire les quarante lignes du script avant de le lancer. Il tient en
    trois fonctions, dont une qui compare le début du fichier à un
    dictionnaire de signatures. Rien d'autre.

    Les deux premières lignes sont le cœur : deux extensions, les mêmes
    octets. C'est la diapositive « Extension et contenu », vue autrement.

    Les fichiers texte n'ont aucune signature, et c'est une information, pas
    un manque : rien dans un fichier texte ne dit de quoi il est fait. C'est
    au logiciel qui l'ouvre de décider, et c'est pourquoi `file` se trompe
    parfois.

    `PK` sont les initiales de Phil Katz, l'auteur du format ZIP. Une phrase,
    pas plus, elle fait retenir le reste.

    `raven.pdf` est celui qu'ils ont produit eux-mêmes en première partie. Si
    l'export n'a pas été fait, le script écrit `introuvable` et continue.
  ]
]

#d("Deux extensions échangées")[
  #annonce[
    Deux copies dont on échange les extensions gardent leurs octets. C'est le
    contenu que le logiciel lit, pas le nom.
  ]

  ```bash
  cp ../genere/raven.odt ../genere/raven_odt.pdf
  cp ../genere/raven.pdf ../genere/raven_pdf.odt
  python octets.py ../genere/raven_odt.pdf ../genere/raven_pdf.odt
  ```

  #v(0.3em)
  ```
  raven_odt.pdf     50 4B 03 04  PK..   archive ZIP, donc .odt, .docx, .xlsx ou .epub
  raven_pdf.odt     25 50 44 46  %PDF   document PDF
  ```

  #legende[
    Sortie réelle. Sous Windows, `copy` remplace `cp`. Le double-clic, lui,
    échoue : le système lance le logiciel que le nom désigne.
  ]

  #notes[
    Faire essayer le double-clic sur `raven_odt.pdf` avant de lancer le
    script : le lecteur PDF s'ouvre et refuse le fichier. Deux étages de
    décision, et ils se contredisent — c'est tout le propos.

    Le message d'erreur de la visionneuse nomme parfois les octets qu'elle a
    lus, `0x50 0x4b`. Le rapprocher de la colonne du tableau précédent.

    La manipulation complète, avec LibreOffice et l'explorateur, est en annexe
    sous le titre « Échanger deux extensions ». Ces deux lignes en donnent le
    résultat sans le temps qu'elle demande.
  ]
]
// ===================== Environnement de programmation ======================

#separateur(
  "Environnement de programmation",
  annonce: "Le code que le programme emprunte, et l'outil qui l'installe",
)
// ------------------------- Dépendances et environnement -----------------------

#d("Ce qu'un programme emprunte")[
  #annonce[
    Un programme n'écrit pas tout ce qu'il fait. Les lignes `import` désignent
    du code écrit par d'autres, installé sur la machine.
  ]

  #face-a-face(
    panneau("Ce que vous écrivez")[
      ```python
      import numpy as np
      from PIL import Image

      points = np.array(etapes)
      image = Image.new("RGB", (900, 600))
      ```
    ],
    panneau("Ce que cela suppose installé")[
      #tableau(
        entete: false,
        columns: (auto, 1fr),
        align: left + horizon,
        [`numpy`], [calcul sur des tableaux de nombres],
        [`pillow`], [lecture et écriture d'images],
      )
      #v(0.4em)
      #text(size: 13pt, fill: estompe)[
        Deux bibliothèques, soit quelques centaines de milliers de lignes que
        vous n'écrivez pas.
      ]
    ],
  )

  #notes[
    L'image qui marche : une recette qui commence par « prenez une pâte
    brisée ». Vous ne la fabriquez pas, mais il faut qu'elle soit dans le
    placard, et que ce soit la bonne.

    C'est ici qu'on nomme le mot *bibliothèque*, et qu'on écarte
    « librairie », faux ami de *library*.

    Ne pas encore parler d'installation : la diapositive suivante montre ce
    que celle-ci entraîne.
  ]
]
#d("Une bibliothèque en entraîne d'autres")[
  #annonce[
    Une bibliothèque en réclame d'autres, qui en réclament d'autres. On demande
    quinze paquets, il s'en installe trois cent cinquante-deux.
  ]

  #chaine(
    ecart: 30pt,
    ("environment.yml", "15 paquets demandés"),
    ("leurs exigences", "pillow en déclare 25, jupyterlab 50"),
    ("l'environnement", "352 paquets installés"),
  )

  #legende[
    Relevé sur l'environnement `info01` du module, avec `conda list`.
  ]

  #notes[
    Le chiffre surprend, et c'est son intérêt : personne ne peut tenir cette
    liste à la main, d'où l'outil qui la résout.

    Conséquence à énoncer : une installation n'est pas reproductible parce
    qu'on se souvient de ce qu'on a tapé, mais parce qu'un fichier la décrit.
    C'est ce que fait `environment.yml`, et c'est ce qui est demandé au rendu.

    Les versions exactes sont dans le fichier produit par
    `conda env export` ; ne pas y entrer aujourd'hui.
  ]
]
#d("Pourquoi isoler un environnement")[
  #annonce[
    Deux projets peuvent réclamer deux versions de la même bibliothèque. Un
    environnement permet aux deux de coexister sur la même machine.
  ]

  ```bash
  $ python -c "import numpy; print(numpy.__version__)"
  1.21.5
  $ conda activate info01
  $ python -c "import numpy; print(numpy.__version__)"
  2.5.2
  ```

  #v(0.4em)
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [Sans environnement], [une seule version par machine, et le projet qui exige l'autre ne tourne plus],
    [Avec un environnement], [un dossier par projet, sa version de Python et ses bibliothèques],
  )

  #notes[
    Sortie réelle, sur la machine du cours : le même mot `python` désigne deux
    programmes différents selon l'environnement actif.

    C'est la réponse au symptôme le plus fréquent du semestre, le
    `ModuleNotFoundError` sur un paquet « qu'on vient d'installer » : le paquet
    est installé, mais ailleurs que dans l'environnement actif.

    Le réflexe à donner, et à redemander toute l'année : afficher quel Python
    tourne avant de chercher plus loin.
  ]
]
#d("L'outil qui installe un environnement")[
  #annonce[
    `conda` lit la liste des paquets demandés, résout leurs exigences et les
    installe. Il n'a pas de fenêtre : il s'emploie en tapant une commande.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Ce que vous voulez], [Ce que vous tapez],
    [créer l'environnement du module], [`conda env create -f environment.yml`],
    [l'activer dans le terminal courant], [`conda activate info01`],
    [savoir ce qui est installé dedans], [`conda list`],
  )

  #legende[
    Trois commandes pour tout le semestre. La séance 2 revient sur la ligne de
    commande pour elle-même ; ici, elle est un outil.
  ]

  #notes[
    C'est la charnière de la partie, et elle explique pourquoi la ligne de
    commande arrive maintenant plutôt qu'au début de la séance : on ne
    l'apprend pas pour elle-même, on la rencontre parce que l'outil dont on a
    besoin n'existe que sous cette forme.

    Le dire simplement : beaucoup de programmes n'ont pas de fenêtre, parce
    que personne n'en a écrit une. Ce n'est pas un choix d'austérité.

    Les deux diapositives qui suivent donnent le minimum pour lire ces trois
    lignes. Le reste, les chemins, le dossier courant, les motifs comme
    `*.odt`, est au cours 2 ; les diapositives correspondantes sont en annexe
    de ce deck si la salle avance vite.

    Ne pas lancer la création maintenant : elle prend plusieurs minutes et
    c'est la manipulation de la fin de partie.
  ]
]
#d("Ligne de commande et interface graphique")[
  #annonce[
    Deux façons de dire à un logiciel quoi faire, comparées sur cinq points.
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
    Les deux interfaces ne rendent pas le même service ; aucune ne remplace
    l'autre.
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
#d("Anatomie d'une commande")[
  #annonce[
    Une commande se lit toujours dans le même ordre.
  ]

  #align(center)[
    #grid(
      columns: (auto, auto, auto),
      row-gutter: 8pt, column-gutter: 20pt,
      align: center,
      text(font: police-code, size: 23pt, fill: accent, weight: demi-gras, "soffice"),
      text(font: police-code, size: 23pt, fill: manip, weight: demi-gras, "--convert-to pdf"),
      text(font: police-code, size: 23pt, fill: encre, "raven.odt"),
      text(size: 14pt, fill: accent)[le programme],
      text(size: 14pt, fill: manip)[l'option : la tâche demandée],
      text(size: 14pt, fill: estompe)[l'argument : le fichier traité],
    )
  ]

  #v(0.3em)
  #tableau(
    columns: (auto, 1.1fr, 1fr),
    align: left + horizon,
    [Ce qu'on tape], [Ce que c'est], [Le geste équivalent, à la souris],
    [`soffice`],
    [LibreOffice lui-même, sous le nom de son programme],
    [ouvrir `raven.odt` dans Writer],
    [`--convert-to pdf`],
    [une option, à ses deux tirets : la tâche demandée],
    [le menu Fichier → Exporter au format PDF],
    [`raven.odt`],
    [un argument, sans tiret : le fichier traité],
    [le document ouvert dans la fenêtre],
  )

  #notes[
    Le même logiciel des deux côtés, et le même PDF produit.

    Faire le lien explicitement avec la manipulation de la première partie :
    ils ont exporté `raven.odt` en PDF en cliquant dans LibreOffice. `soffice` n'est
    pas un autre outil, c'est le même, appelé par son nom.

    Le nom surprend toujours : il vient de StarOffice, l'ancêtre de la suite.
    Le dire en une phrase et passer, l'anecdote n'a pas d'intérêt en soi.

    La lecture option / argument est ce qu'il faut retenir : c'est la grille de
    lecture de toutes les commandes du semestre, et elle rend une page d'aide
    utilisable. Le cours 3 construit une commande de cette forme avec
    `argparse`.

    Ne pas taper la commande maintenant : c'est la manipulation qui suit.
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
    Ils s'en sont déjà servis sans qu'on le nomme, à la manipulation « hello
    world » : c'est le moment de revenir dessus.

    La troisième ligne est celle qui évite le `ModuleNotFoundError` de la
    diapositive précédente. L'interpréteur choisi ici est celui que l'éditeur
    activera dans chaque nouveau terminal, et la barre d'état permet de le
    vérifier sans rien taper.

    Le terminal intégré n'est pas un autre terminal : c'est le même programme,
    affiché dans la fenêtre de l'éditeur. Le dire, parce que la question vient.

    Les libellés dépendent de la version de VSCode et de la langue de
    l'interface, qui est l'anglais par défaut. Vérifier les intitulés sur le
    poste de démonstration avant la séance.

    Le terminal ouvert hors de l'éditeur, et la façon de l'ouvrir sur chaque
    système, sont en annexe : c'est le cours 2 qui s'en occupe.
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
#d("Python en interactif")[
  #annonce[
    Taper `python` sans nom de fichier ouvre une session interactive : chaque
    ligne est lue, exécutée, et son résultat affiché aussitôt.
  ]

  ```console
  $ python
  Python 3.12.14 | packaged by conda-forge | (main, Sep  1 2026) [GCC 14.4.0]
  >>> from octets import entete, en_hexadecimal
  >>> entete("../genere/raven.odt")
  b'PK\x03\x04'
  >>> en_hexadecimal(entete("../genere/raven.pdf"))
  '25 50 44 46'
  >>> exit()
  ```

  #legende[
    Session réelle, dans `data/cours1/formats/`. Le résultat s'affiche sans
    `print` : c'est propre à la session interactive.
  ]

  #notes[
    Deux façons d'exécuter du Python, et elles ne servent pas à la même chose.
    Un script se lance en entier et se relance à l'identique ; une session
    interactive s'essaie ligne à ligne et ne laisse rien.

    Faire remarquer les trois chevrons : c'est l'invite de Python, et non
    celle du terminal. Confondre les deux est l'erreur de début de semestre,
    et elle produit `SyntaxError` quand on tape une commande du système dans
    Python.

    On y entre par `python`, on en sort par `exit()` ou `Ctrl` + `D`. Le
    dire tout de suite : on ne devine pas comment sortir.

    Le module réutilise ici son propre script, importé comme une bibliothèque.
    C'est la diapositive « Ce qu'un programme emprunte », vue de l'autre côté :
    le code de quelqu'un d'autre, c'était aussi du code écrit par eux il y a
    dix minutes.

    Amorce de la partie suivante : un notebook est cette session interactive,
    avec le texte conservé autour.
  ]
]
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
// ================================== Annexes =================================

#separateur(
  "Annexes",
  annonce: "Manipulations non traitées en séance, gardées pour référence",
)
// ---------------- Annexe : interface graphique et ligne de commande ---------

#separateur(
  "Interface graphique et ligne de commande",
  annonce: "Diapositives non traitées en séance, reprises au cours 2",
)
#d("Désigner un fichier, ou les décrire tous")[
  #annonce[
    À la souris, on désigne les fichiers un par un. Dans une commande, on les
    décrit : `*.odt` se lit « tous ceux dont le nom finit par `.odt` ».
  ]

  ```console
  $ soffice --headless --convert-to pdf  <les fichiers à convertir>
  ```

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Un fichier], [Vingt fichiers],
    [Ce qu'on écrit à la fin], [`raven.odt`], [`*.odt`],
    [Durée mesurée], [1,4 s], [2,1 s],
    [À la souris], [quatre gestes], [quatre-vingts gestes],
  )

  #legende[
    Vingt fois le travail pour sept dixièmes de seconde de plus : le programme
    ne démarre qu'une fois. Mesuré sur les fichiers du cours ; les quatre
    gestes sont ceux du menu montré deux diapositives plus loin.
  ]

  #notes[
    C'est la diapositive qui justifie tout le reste de la partie. Y passer du
    temps.

    L'étoile est le seul caractère qui change entre les deux colonnes, et à
    partir de là la ligne ne changera plus : elle vaut pour trois cents
    fichiers comme pour vingt. C'est ce qu'aucune suite de clics ne sait
    faire, parce qu'un clic désigne un objet et un seul.

    La différence de fond est là, et elle n'est pas une question de
    difficulté : à la souris on *montre* des objets déjà à l'écran ; au
    clavier on *décrit* un ensemble, y compris des fichiers qu'on n'a pas
    ouverts, qu'on ne voit pas, ou qui n'existent pas encore.

    Ne pas commenter le nom `soffice` ni `--headless` : ils sont repris à la
    diapositive « Anatomie d'une commande ».

    Si la question vient : oui, les explorateurs de fichiers savent
    sélectionner par motif, et non, ils ne savent pas enchaîner l'opération
    suivante sur le résultat.
  ]
]
#d("Quand l'une, quand l'autre")[
  #annonce[
    Aucune des deux ne remplace l'autre. Ce qui décide n'est pas le goût, mais
    la tâche.
  ]

  #tableau(
    columns: (1fr, auto),
    align: left + horizon,
    [Ce que vous avez à faire], [Ce qui convient],
    [ajuster à l'œil : recadrer, choisir une couleur], [la souris],
    [explorer un logiciel que vous ne connaissez pas], [les menus],
    [une seule fois, sur un seul fichier], [la souris],
    [le même geste sur trois cents fichiers], [la commande],
    [refaire dans six mois exactement la même chose], [la commande],
    [expliquer à quelqu'un ce que vous avez fait], [la commande],
  )

  #legende[
    Les trois premières lignes ont en commun qu'on ne saurait pas dire à
    l'avance ce qu'on veut ; les trois dernières, qu'on le sait déjà.
  ]

  #notes[
    Tableau à laisser lire, puis à résumer en une phrase : on clique pour
    chercher, on tape pour répéter.

    Contre-exemple à donner si la salle penche trop d'un côté : personne ne
    retouche une photo au terminal, et personne ne renomme trois cents
    fichiers à la souris. Les deux dérives existent, et la seconde coûte plus
    cher parce qu'elle ne se voit pas.

    Les trois dernières lignes annoncent la suite du module : la commande qui
    se relance, c'est le script du cours 3 ; la commande qui se transmet,
    c'est le dépôt du cours 2.

    La distinction souvent citée en ergonomie éclaire le tableau : une
    interface graphique fonctionne par *reconnaissance*, on voit et on
    choisit ; une ligne de commande par *rappel*, il faut savoir avant de
    taper. Elle est reprise deux diapositives plus loin, chiffrée.
  ]
]
// Hauteur des captures : la version annotée réserve le bas de la page aux
// notes, et une image qui n'y tient pas repousse la diapositive sur une page
// de suite. Chaque capture a donc deux tailles.
#if captures-disponibles {
d("Le menu d'exportation de LibreOffice")[
  #annonce[
    Les quatre gestes comptés précédemment, ce sont ceux-ci : Fichier,
    Exporter vers, Exporter au format PDF, puis la boîte d'enregistrement.
  ]

  #align(center)[
    #illustration(
      "../../../data/cours1/illustrations/libreoffice_export_pdf.png",
      none,
      hauteur: hauteur-capture-pleine,
    )
  ]

  #legende[
    LibreOffice 25.2 : trois niveaux, vingt-quatre entrées dans le seul menu
    Fichier.
  ]

  #notes[
    Laisser la salle chercher l'entrée des yeux avant de la désigner : c'est
    l'argument de la diapositive, et il se démontre mieux qu'il ne s'énonce.

    Le rapprochement avec la ligne de commande se fait ici sans le dire : la
    commande ne se cherche pas, elle s'écrit, mais encore faut-il la connaître.
    C'est exactement la première ligne du tableau qui suit.

    Le chemin exact change d'une version à l'autre, et c'est aussi ce qui rend
    une consigne écrite en gestes fragile.
  ]
]
}
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
    [Efficacité, une fois apprise], [un geste par fichier], [une ligne pour trois cents],
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
    répond par du texte. Le voici à l'ouverture, sur deux systèmes.
  ]

  #grid(
    columns: (2.2fr, 1fr), column-gutter: 24pt, align: top,
    panneau("Windows 11 — Windows PowerShell")[
      #illustration(
        "../../../data/cours1/illustrations/terminal_windows_powershell.jpg",
        fenetre("Windows PowerShell", code: true)[
          #text(fill: accent, weight: demi-gras)[PS C:\\Users\\alice\> ]
        ],
        largeur: 100%,
      )
    ],
    panneau("Linux — GNOME Terminal")[
      #illustration(
        "../../../data/cours1/illustrations/terminal_linux_gnome.png",
        fenetre("alice@portable: ~", code: true)[
          #text(fill: accent, weight: demi-gras)[\[alice\@portable ~\]\$ ]
        ],
        hauteur: hauteur-terminal,
      )
    ],
  )

  #legende[
    Une fenêtre vide, un dossier, un signe qui marque la fin de l'invite.
    Copies d'écran de la documentation de Windows PowerShell
    (_used with permission from Microsoft_) et de celle de GNOME Terminal
    (CC BY-SA 3.0).
  ]

  #notes[
    Faire relever ce que les deux fenêtres ont en commun avant ce qui les
    distingue : un dossier affiché, un signe qui termine l'invite (`>` ou `$`),
    un curseur. Tout le reste est du décor, y compris les couleurs.

    Les deux invites nomment un utilisateur et un dossier : `C:\\Users\\mike`
    d'un côté, `~` de l'autre, qui est l'abréviation du dossier personnel. Le
    rapprocher des chemins vus en première partie.

    Le bandeau de copyright de PowerShell est ce que la fenêtre affiche à
    l'ouverture ; ne pas s'y arrêter.
  ]
]
#d("Ouvrir un terminal")[
  #annonce[
    Le terminal s'ouvre dans un dossier, qu'il affiche avant l'invite : c'est
    le dossier courant, celui d'où partent les chemins relatifs.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Système], [Comment l'ouvrir],
    [Windows 11], [clic droit sur le bouton Démarrer, ou `Win`+`X`, puis Terminal. Depuis un dossier : clic droit, « Ouvrir dans le terminal »],
    [macOS], [Applications, Utilitaires, Terminal],
    [Linux], [`Ctrl`+`Alt`+`T` sur la plupart des bureaux],
  )

  #legende[
    Depuis un éditeur de code, un terminal s'ouvre aussi dans la fenêtre, déjà
    placé dans le dossier du projet.
  ]

  #notes[
    Sous Windows 11, Terminal est l'application par défaut ; elle ouvre
    PowerShell. L'ancienne « Invite de commandes » reste disponible dans le
    même onglet déroulant. Ne pas entrer dans la différence entre les deux
    aujourd'hui : elle est traitée au cours 2.

    Le dossier courant est la source de la moitié des erreurs de début de
    semestre. Le clic droit « Ouvrir dans le terminal » depuis le bon dossier
    évite le problème, et c'est le geste à faire prendre dès aujourd'hui.

    Faire ouvrir un terminal maintenant, à tout le monde, avant de continuer :
    il servira dans quelques diapositives.
  ]
]
// --------------------- TD : piloter un logiciel au clavier -------------------

#separateur-manip(
  "Comparaison interface graphique et ligne de commande",
  annonce: "Convertir raven.odt en PDF de deux façons, sur votre machine",
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
#d("Le même test en PowerShell")[
  #annonce[
    Les mêmes octets de tête, relevés au terminal plutôt qu'avec le script
    Python de la troisième partie.
  ]

  ```powershell
  PS> Format-Hex -Path test_odt.pdf | Select-Object -First 1
  PS> Format-Hex -Path test_pdf.odt | Select-Object -First 1
  ```

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr, 1.3fr),
    align: left + horizon,
    [Fichier ouvert], [Premiers octets], [Ce qu'ils signent],
    [`test_odt.pdf`], reponse[`50 4B 03 04` #h(6pt) `PK`], reponse[une archive ZIP, donc un `.odt`],
    [`test_pdf.odt`], reponse[`25 50 44 46` #h(6pt) `%PDF`], reponse[un PDF],
  )

  #legende[
    Ces octets de tête s'appellent des nombres magiques. Ils ne dépendent pas
    du système : les valeurs ci-dessus ont été relevées sur les fichiers du
    cours.
  ]

  #notes[
    Diapositive d'annexe : la démonstration se fait en séance avec
    `octets.py`, qui vaut sur les trois systèmes. Celle-ci sert si la salle
    veut le voir au terminal, et au cours 2.

    `Format-Hex` remplace à lui seul `head` et `xxd` : il affiche
    l'hexadécimal et le texte côte à côte. Son paramètre `-Count` n'est
    apparu qu'avec PowerShell 6.2, donc pas dans le PowerShell 5.1 livré avec
    Windows, d'où le passage par `Select-Object -First 1`, qui prend la
    première ligne de seize octets et marche dans les deux versions.

    `PK` sont les initiales de Phil Katz, l'auteur du format ZIP. Anecdote à
    donner en une phrase, elle fait retenir le reste.

    Windows ne fournit pas d'équivalent de `file`, qui déduit le type du
    contenu : c'est la diapositive suivante, et elle est facultative.

    Les lignes PowerShell viennent de la documentation Microsoft et n'ont pas
    pu être exécutées ici, faute de Windows : à vérifier avant la séance. Les
    valeurs d'octets, elles, sont mesurées.
  ]
]
#d("Le même test sous Linux et macOS")[
  #annonce[
    Les deux commandes se remplacent par trois, dont une qui nomme le format
    au lieu d'en afficher les octets.
  ]

  ```console
  $ head -c 8 test_odt.pdf | xxd
  00000000: 504b 0304 1400 0208    PK......

  $ head -c 8 test_pdf.odt | xxd
  00000000: 2550 4446 2d31 2e36    %PDF-1.6

  $ file test_odt.pdf test_pdf.odt
  test_odt.pdf: OpenDocument Text
  test_pdf.odt: PDF document, version 1.6, 1 pages
  ```

  #legende[
    `head` prend les huit premiers octets, `xxd` les affiche, `file` les
    compare à un catalogue de signatures et répond par un nom de format.
  ]

  #notes[
    Diapositive facultative : la sauter si la salle est entièrement sous
    Windows. Elle vaut surtout pour `file`, dont Windows n'a pas d'équivalent
    et qui montre que reconnaître un format est un travail de bibliothèque, pas
    de devinette.

    Sortie réelle, obtenue sur les fichiers du cours. Le numéro de version du
    PDF dépend de la version de LibreOffice qui l'a produit.

    Le même phénomène se reverra dans la partie programmation : les premiers
    octets de l'exécutable `python3` se lisent « ELF ». Et la manipulation qui
    produit ces fichiers est en annexe, si le temps le permet.
  ]
]// -------------------------------- Interfaces --------------------------------
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
    [`test_odt.pdf`], [lecteur PDF], reponse[refus : « May not be a PDF file »],
    [`test_odt.pdf`], [LibreOffice], reponse[s'ouvre dans Writer, texte intact],
    [`test_pdf.odt`], [LibreOffice], reponse[s'ouvre dans Draw, pas dans Writer],
    [`test_odt.odt.pdf`], [lecteur PDF], reponse[même refus : seule la fin du nom compte],
  )

  #notes[
    Le résultat qui surprend est la deuxième ligne : LibreOffice ouvre
    correctement un fichier dont l'extension ment. Poser la question à la
    salle avant de répondre. La réponse est la diapositive « Comment un
    logiciel reconnaît un fichier », dans le corps de la séance.
  ]
]
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

    Le fond de carte est distribué avec les supports, et n'est pas à
    retélécharger : le serveur de tuiles d'OpenStreetMap est un service
    bénévole dont les conditions d'usage interdisent le téléchargement en
    masse. Trente étudiants ne doivent pas le solliciter en même temps.
  ]
]
#d("Le fichier qui décrit le trajet")[
  #annonce[
    Le trajet n'est pas dessiné dans un logiciel : il est écrit dans un
    fichier texte de six lignes, une par étape.
  ]

  ```csv
  numero,duree,x,y,texte
  0,0,398,248,Sortie de la gare de Noisy-Champs
  1,4,410,360,1. Sortir côté Cité Descartes et descendre vers le Mail Descartes
  2,4,600,372,2. Prendre le Mail Descartes vers l'est
  3,4,615,570,3. Descendre jusqu'à l'avenue Blaise Pascal
  ```

  #v(0.3em)
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`duree`], [combien de secondes l'étape reste à l'écran],
    [`x`, `y`], [le point d'arrivée, en pixels sur le fond de carte],
    [`texte`], [le sous-titre affiché pendant l'étape],
  )

  #legende[
    Extrait de `data/cours1/trajet/etapes.csv`. Corriger une étape, c'est
    corriger une ligne.
  ]

  #notes[
    C'est ici que la manipulation rejoint le reste de la séance : le livrable
    est une vidéo, mais ce qui se relit, se compare et se corrige est un
    fichier texte de quelques lignes.

    Le rapprocher explicitement du `.csv` de la grille des extensions et du
    `content.xml` de l'archive `.odt` : trois fois le même constat, le contenu
    utile est du texte.

    Un tracé dessiné à la souris dans uMap, exporté en GeoJSON, se convertit
    en ce fichier par `python carte.py trajet.geojson`. À mentionner sans le
    faire : c'est le pont entre les deux chemins.
  ]
]
#d("Ce que la commande enchaîne")[
  #annonce[
    La commande unique n'est pas magique : elle fait à la suite les quatre
    gestes qu'on ferait à la main, et chaque étape produit un fichier que la
    suivante consomme.
  ]

  #chaine(
    ecart: 22pt,
    ("etapes.csv", "le trajet, en texte"),
    ("etape_01.png…", "une image par étape, tracée par ImageMagick"),
    ("trajet.srt", "les sous-titres, aux mêmes durées"),
    ("trajet.mp4", "le montage, assemblé par ffmpeg"),
  )

  #legende[
    Les quatre étapes sont les quatre parties d'`anime.sh`. Rien n'y est caché :
    c'est un fichier texte de quarante lignes.
  ]

  #notes[
    Ouvrir `anime.sh` à l'écran si la salle le demande, sans le commenter ligne
    à ligne. Ce qui compte est la forme : quatre blocs numérotés, un par
    fichier produit.

    Deux outils seulement, tous deux pilotés en ligne de commande :
    ImageMagick pour dessiner sur la carte, ffmpeg pour assembler. Ce sont
    ceux du TD 4, qui reprend exactement cette chaîne.

    Le format `.srt` est du texte, lisible et modifiable : encore un cas où le
    livrable est binaire mais la source ne l'est pas.

    Question qui vient : « et si je veux changer la police des sous-titres ? »
    Répondre que c'est une option de la dernière ligne, et ne pas y entrer.
  ]
]
