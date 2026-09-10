// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
// Import nominatif, et non `: *` : `schemas.typ` ouvre `cetz.draw`, dont les
// noms (`grid`, `line`, `circle`, `content`…) masqueraient ceux de typst.
#import "../schemas.typ": schema-ou-sexecute

#separateur(
  "Logiciels et formats de fichier",
  annonce: "Ce qu'un logiciel fait, où il s'exécute, notions de base sur la manipulation et rôles des fichiers."
)
// ------------------------------- Vocabulaire --------------------------------

// --------------------------------------------
#d("Logiciel et les termes courants")[
  #annonce[
    Un seul de ces mots est défini officiellement. Les autres sont d'usage
    courant.
  ]

  #bloc-titre("logiciel")[
    #set text(size: 19pt)
    Ensemble des programmes, procédés et règles, et éventuellement de la
    documentation, relatifs au fonctionnement d'un ensemble de traitement de
    données.
  ]

  #v(0.7em)
  #grid(
    columns: (1fr,) * 5, gutter: 12pt,
    ..("application", "app", "webapp", "OS", "driver").map(terme => block(
      width: 100%, inset: (x: 8pt, y: 13pt), fill: gris,
      stroke: 0.8pt + accent.lighten(50%),
    )[
      #align(center, text(size: 19pt, weight: demi-gras)[#terme])
    ]),
  )

  #legende[
    Sources : _Journal officiel_ du 22/09/2000 ; Grand dictionnaire
    terminologique de l'OQLF.
  ]

  #notes[
    Les cinq termes se traitent à l'oral, en demandant à la salle ce que chacun
    désigne et en quoi ils diffèrent. Ne rien écrire de plus à l'écran.

    Ce qu'il faut en tirer : aucun de ces mots n'a de définition arrêtée, et
    tous désignent des logiciels. « App » est l'abréviation anglaise
    d'application, répandue par les magasins d'applications des téléphones ; le
    mot ne désigne pas une technologie particulière, le même logiciel existant
    souvent en site web, en programme de bureau et en application mobile.

    OS et driver ramènent à la vieille partition du vocabulaire officiel :
    logiciel de base, qui fait fonctionner la machine et donne accès au
    matériel (Windows, macOS, Linux, et les pilotes), contre logiciel
    d'application, qui sert à accomplir une tâche (LibreOffice, Firefox, un
    lecteur de musique). La dire, sans l'afficher.

    « Webapp » est repris à la diapositive sur le lieu d'exécution.
  ]
]

// --------------------------------------------
#d("Le système d'exploitation")[
  #annonce[
    Un programme ne s'adresse pas directement au matériel : il passe par le système.
  ]

  #couche(
    icone-fenetre(taille: 26pt), "Vos programmes",
    "LibreOffice, un navigateur, votre script", plein: true,
  )
  #liaison("« ouvre releve.csv »", "le contenu")
  #couche(
    icone-engrenage(taille: 26pt), "Système d'exploitation",
    "Windows, macOS, Linux",
  )
  #liaison("« écris ces octets »", "les octets lus sur le disque")
  #couche(
    icone-puce(taille: 26pt), "Matériel",
    "processeur, mémoire, disque, réseau",
  )

  // Une seule question : le numéro de `question()` ne code plus rien, et la
  // place qu'il prend manque à la troisième couche.
  #block(
    width: 100%, inset: (x: 14pt, y: 7pt), above: 0.5em,
    fill: gris, stroke: (left: 3pt + accent),
  )[
    #text(size: 18pt)[Quel système d'exploitation tourne sur votre téléphone ?]
  ]

  #notes[
    Le système arbitre entre tous les programmes ouverts en même temps : c'est
    lui qui empêche l'un d'écrire dans la mémoire d'un autre. Conséquence
    pratique : les chemins de fichiers ne s'écrivent pas pareil d'un système à
    l'autre et les outils installés diffèrent. Le matériel est repris au
    cours 5.

    La question sert à faire constater que le schéma vaut aussi pour ce qu'ils
    ont en poche. Réponse attendue : Android ou iOS. Ordre de grandeur mondial
    si elle est demandée : environ 70 % Android, 30 % iOS (StatCounter, 2026).
    Éventuellement évoquer le lien entre Linux et Android.
  ]
]

#d("Entrées et sorties d'un logiciel")[
  #annonce[
    Ce qu'un logiciel reçoit et ce qu'il produit sont de deux natures : un
    fichier, qui se conserve, ou un flux vers un périphérique, qui ne garde rien.
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
      measure(bloc("Traitement", "le logiciel"), width: largeur).height,
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
      bloc("Traitement", "le logiciel", plein: true, hauteur: hauteur),
      fleche,
      colonne(sorties),
    )
  })

  #legende[
    Un fichier sert à conserver un résultat et à l'échanger : avec un autre
    logiciel, avec une autre machine, ou avec quelqu'un d'autre.
  ]

  #notes[
    Le module s'intéresse à ce qui laisse un fichier, parce qu'un fichier
    se relit, se compare, se versionne, et surtout circule d'un logiciel
    à l'autre.
    
    Pas de sauvegarde en RAM. 
    
    Le réseau est du côté des périphériques, avec le clavier et la souris
    : pour le logiciel, ce sont trois choses qu'on lit sans qu'elles
    restent.
  ]
]
// ------------------------------ Fichiers -----------------------------------
// --------------------------------------------
#d("Où s'exécute une application web ?")[
  #align(center, schema-ou-sexecute())

  #notes[
    Ce que la diapositive fait remarquer, et qui ne se dit pas tout seul : des
    tâches qui demandaient un logiciel installé se font dans un navigateur, et
    le lieu du calcul, donc celui des fichiers, a changé sans qu'on le dise.

    Presque aucune application web n'est entièrement
    d'un côté. Une messagerie affiche chez vous mais cherche dans vos
    messages sur son serveur. La question utile n'est pas « où est-ce que
    ça tourne ? » mais « qu'est-ce qui part, et quand ? ».

    Le critère de complexité explique les exemples : recadrer une image
    tient dans le navigateur, entraîner ou faire tourner un grand modèle
    non. Il explique aussi les évolutions : ce qui se calculait à distance
    il y a dix ans se calcule parfois en local aujourd'hui.
  ]
]

// --------------------------------------------
#d("Utilisation / utilité d'un fichier")[
  #annonce[
    Un fichier conserve un résultat après l'arrêt du programme : un état de
    travail à reprendre, ou un document final à transmettre.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Ce qu'il permet], [Quand cela vous servira],
    [Conserver un résultat],
      [relire dans une semaine ce que le programme a produit],
    [Passer d'un logiciel à l'autre],
      [le tableau écrit par l'un, ouvert par l'autre],
    [Changer de machine],
      [de votre poste à celui de la salle, et retour],
    [Le remettre à quelqu'un],
      [un rendu, ou le dépôt partagé du cours 2],
  )

  #legende[
    D'où la suite de cette partie : nommer un fichier, reconnaître son type,
    et savoir le désigner par son chemin.
  ]

  #notes[
     c'est le fichier qui reste. Les quatre lignes disent ce que ce
    « rester » permet, toutes vraies dès cette semaine — les trois
    premières aujourd'hui, la quatrième au cours 2.

    Deuxième ligne: un format de fichier
    est ce sur quoi deux logiciels se mettent d'accord sans se connaître.
    La partie 5 y revient.
  ]
]

// --------------------------- Chemins et adresses ----------------------------

// --------------------------------------------
#d("Quizz : vocabulaire associé aux chemins de fichier")[
  #annonce[
    Un chemin dit où trouver un fichier dans l'arborescence des dossiers.
    Plusieurs mots en désignent les parties : dites à quoi chacun correspond
    dans cet exemple.
  ]

  #align(center)[
    #text(font: police-code, size: 25pt, fill: encre)[C:\\Users\\alice\\Documents\\raven.odt]
  ]

  #v(0.5em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Le mot], [Ce qu'il désigne dans l'exemple],
    [la racine, ou le disque], [],
    [un nom de dossier], [],
    [le nom du fichier], [],
    [le chemin du fichier], [],
    [le dossier parent], [],
  )

  #notes[
    Trois minutes, à l'oral, sans commenter chaque réponse : la diapositive
    suivante donne les réponses.

    Racine : le point de départ que la machine connaît. `C:` désigne le
    disque sous Windows ; sous macOS et Linux, la racine est `/`
  ]
]

// --------------------------------------------
#d("Quizz : vocabulaire associé aux chemins de fichier - Réponse")[
  // Le chemin s'écrit d'un seul tenant, sans blanc entre les segments : c'est
  // ainsi qu'il apparaît dans l'explorateur. Les colonnes sont donc mesurées
  // sur les segments eux-mêmes, et les étiquettes, plus larges, sont posées
  // par `place` : elles débordent de leur colonne sans l'élargir.
  #align(center)[
    #context {
      let taille = 25pt
      let segments = (
        (estompe, "C:\\", "la racine, ou le disque"),
        (manip, "Users\\alice\\Documents\\", "trois noms de dossier"),
        (accent, "raven.odt", "le nom du fichier, extension comprise"),
      )
      let morceau(couleur, chaine) = text(
        font: police-code, size: taille, fill: couleur,
        weight: if couleur == manip { demi-gras } else { "regular" },
        chaine,
      )
      grid(
        columns: segments.map(((c, t, _)) => measure(morceau(c, t)).width),
        column-gutter: 0pt,
        row-gutter: 13pt,
        ..segments.map(((c, t, _)) => morceau(c, t)),
        ..segments.map(((c, _, e)) => {
          // L'étiquette est mesurée puis posée à sa largeur naturelle : sans
          // cela, elle se replierait sur la largeur de son segment.
          let etiq = text(size: 14pt, fill: c)[#e]
          box(width: 100%, height: 1.2em)[
            #place(center + top, box(width: measure(etiq).width, etiq))
          ]
        }),
      )
    }
  ]

  #v(0.6em)
  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Le mot], [Ce qu'il désigne dans l'exemple],
    [la racine, ou le disque],
      [#text(fill: estompe)[`C:\`], le point de départ ; `/` sous macOS et Linux],
    [un nom de dossier],
      [#text(fill: manip)[`Users`, `alice`, `Documents`] : trois, du plus large au plus précis],
    [le nom du fichier],
      [`raven.odt`, extension comprise],
    [le chemin du fichier], [tout, de la racine au fichier],
    [le dossier parent],
      [#text(fill: estompe)[`C:\`]#text(fill: manip)[`Users\alice\Documents`], le dossier qui le contient],
  )

  #legende[
    Un chemin se lit de gauche à droite, de la racine au fichier ; chaque
    séparateur descend d'un dossier.
  ]

  #notes[
    Insister sur la dernière ligne : « dossier parent » est le mot des
    messages d'erreur et des fonctions de Python (`Path.parent`). Le cours 3
    s'en sert sans le redéfinir.
  ]
]

// --------------------------------------------
#d("Le chemin d'un fichier")[
  #annonce[
    Un chemin #text(fill: attention, weight: demi-gras)[absolu] part de la
    racine, un chemin #text(fill: attention, weight: demi-gras)[relatif] du
    dossier où l'on se trouve.
  ]

  #v(0.4em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Windows], [macOS et Linux],
    [Le séparateur de dossiers], [la barre inversée `\`, _backslash_], [la barre `/`, _slash_],
  )

  #v(0.5em)
  #grid(
    columns: (auto, 1fr), column-gutter: 18pt, align: horizon,
    block(inset: (x: 10pt, y: 8pt), fill: gris)[
      #set text(font: police-code, size: 12.5pt)
      #set par(leading: 0.6em)
      C:\\Users\\alice\\ \
      └─ info01\\ \
      #h(0.75em)├─ rapport\\ \
      #h(0.75em)│#h(0.3em)└─ notes.md \
      #h(0.75em)└─ produit\\ \
      #h(2.05em)└─ raven.odt
    ],
    tableau(
      columns: (auto, 1fr, auto),
      align: left + horizon,
      [], [Le chemin de `raven.odt`], [Depuis],
      [Absolu], [`C:\Users\alice\info01\produit\raven.odt`], [la racine],
      [Relatif], [`produit\raven.odt`], [`info01`],
      [Relatif qui remonte], [`..\produit\raven.odt`], [`rapport`],
    ),
  )

  #legende[
    Sous macOS et Linux, l'autre séparateur : `/home/alice/info01/produit/raven.odt`,
    `produit/raven.odt`, `../produit/raven.odt`.
  ]

  #notes[
    Intérêt pour la programmation, on ne connait pas a priori les chemins absolu
    du dossier d'un utilisateur mais on peut connaitre/forcer une arborescence
    relative pour un programme.

    Lire l'arborescence avant le tableau : les trois chemins désignent le
    même fichier, `raven.odt`, et ne diffèrent que par l'endroit d'où on le
    demande. 

    Deux notations à donner en passant, et à écrire au tableau plutôt qu'à
    projeter : deux points désignent le dossier parent, un point le dossier
    courant. Elles s'écrivent pareil sur les trois systèmes, seul le
    séparateur qui les suit change.
  ]
]

// --------------------------------------------
#d("L'adresse d'une page web - URL")[
  #annonce[
    Une adresse web est un chemin de fichier, précédé de la machine sur
    laquelle il faut aller le chercher. On l'appelle une
    #sigle("URL")[#initiale("U")niform #initiale("R")esource #initiale("L")ocator],
    l'adresse qui localise une ressource.
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
    affiche `file:///`.

    Le `///` surprend toujours : après `file:`, la place de la machine est vide,
    puisque c'est la machine locale. On peut le faire remarquer sans le
    développer.
  ]
]
// -------------------------- Extensions et formats ---------------------------
// --------------------------------------------
#d("Fichier, extension et type de fichier")[
  #annonce[
    Le type d'un fichier (texte, vidéo…) est indiqué par son *extension*, la
    fin du nom après le dernier point. Le système s'en sert pour choisir le
    logiciel à lancer, mais elle reste une indication sur le contenu, pas une
    garantie.
  ]

  #align(center)[
    #grid(
      columns: (auto, auto),
      row-gutter: 9pt,
      align: center,
      text(font: police-code, size: 27pt, fill: estompe)[releve\_2026],
      text(font: police-code, size: 27pt, fill: accent, weight: "bold")[.csv],
      text(size: 13pt, fill: estompe)[le nom, que vous choisissez],
      text(size: 13pt, fill: accent)[l'extension],
    )
  ]
  #avertissement[
    Windows masque les extensions qu'il connaît : `raven.odt` s'affiche
    `raven`. Réglage à changer une fois, avant la manipulation.
  ]

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

// --------------------------------------------
#d("Reconnaître un format à son extension")[
  #annonce[
    Pour chacune de ces extensions, dites de quel type de contenu il s'agit, et si le fichier
    est lisible dans un éditeur de texte.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 9pt,
    etiquette(".mp3"), etiquette(".mp4"), etiquette(".jpg"), etiquette(".png"),
    etiquette(".svg"), etiquette(".tif"), etiquette(".pdf"), etiquette(".odt"),
    etiquette(".xlsx"), etiquette(".csv"), etiquette(".zip"), etiquette(".exe"),
    etiquette(".py", couleur: attention), etiquette(".md", couleur: attention),
    etiquette(".json", couleur: attention), etiquette(".yaml", couleur: attention),
  )

  #notes[
    Interroger la salle, en trois minutes, sans commenter chaque réponse. Les
    deux qui peuvent faire débat : `.svg` (une image, mais du texte XML) et `.csv` (du
    texte, pas un fichier Excel). Ne pas s'attarder sur `.tif`.

    La dernière ligne est celle du module, et elle est volontairement groupée :
    ce sont les quatre fichiers qu'ils éditeront eux-mêmes. Probable que les étudiants
    ne les connaissent pas.
  ]
]

// --------------------------------------------
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
    etiquette(".py", reponse: "code Python : du texte", couleur: attention),
    etiquette(".md", reponse: "documentation : du texte", couleur: attention),
    etiquette(".json", reponse: "données, réglages : texte", couleur: attention),
    etiquette(".yaml", reponse: "réglages : du texte", couleur: attention),
  )

  #legende[
    Six de ces seize formats sont du texte : ceux qu'on peut ouvrir dans un
    éditeur, comparer ligne à ligne et versionner. En bleu, les quatre que vous
    écrirez vous-mêmes dans ce module.
  ]

  #notes[
    Les six formats texte de la grille : `.svg`, `.csv`, `.py`, `.md`, `.json`
    et `.yaml`. Deux autres sont des archives ZIP de XML, `.odt` et `.xlsx`,
    ouvertes en direct plus loin dans la séance.
  ]
]

// --------------------------- Texte et binaire -------------------------------
// --------------------------------------------
#d("Fichier texte et fichier binaire")[
  #annonce[
    Tout fichier est une suite d'octets. Un fichier *texte* est celui dont les
    octets se lisent un à un comme des caractères, par une table d'encodage.
    Les autres sont dits *binaires*.
  ]

  #face-a-face(
    panneau("raven_une_ligne.txt")[
      #block(width: 100%, inset: (x: 10pt, y: 10pt), fill: gris)[
        #octets(
          ("4F", "6E", "63", "65", "20", "75", "70", "6F"),
          ("O", "n", "c", "e", "␣", "u", "p", "o"),
        )
      ]
      #v(0.35em)
      #text(size: 14pt, fill: estompe)[
        chaque octet est un caractère, et leur suite fait le poème
      ]
    ],
    panneau("une tuile de carte, en PNG")[
      #block(width: 100%, inset: (x: 10pt, y: 10pt), fill: gris)[
        #octets(
          ("89", "50", "4E", "47", "0D", "0A", "1A", "0A"),
          (none, "P", "N", "G", none, none, none, none),
        )
      ]
      #v(0.35em)
      #text(size: 14pt, fill: estompe)[
        trois octets font `PNG` ; les autres ne désignent aucun caractère
      ]
    ],
  )

  #legende[
    Octets réels, relevés sur les fichiers du cours. La différence n'est pas
    dans les octets : elle est dans la façon dont le logiciel les lit.
  ]

  #notes[
    Insister sur le sens de « binaire » : ce n'est pas que le fichier soit
    écrit en binaire, ils le sont tous. C'est qu'il n'est pas fait pour être
    lu caractère par caractère.

    Conséquence, déjà rencontrée en annexe sur le `.odt` : ce qui est du
    texte se compare ligne à ligne, se corrige à la main et se versionne. Ce
    qui est binaire, non.

    Les `0D 0A` de droite sont un hasard utile : ce sont aussi les deux
    caractères de fin de ligne sous Windows. Ne pas s'y arrêter aujourd'hui.

    Rappel du tableau des extensions : six formats sur seize étaient du
    texte. C'est la même distinction, vue par le contenu au lieu du nom.
  ]
]

// --------------------------------------------
#d("Un octet, 256 valeurs, une table")[
  #annonce[
    Les bits se comptent par groupes de huit. Ce groupe est un *octet*, et il
    prend 256 valeurs différentes. Une table d'encodage dit quel caractère
    chaque valeur désigne.
  ]

  #chaine(
    ecart: 24pt,
    ("Huit bits", "01010010"),
    ("Une valeur", "82 sur 256 possibles"),
    ("Un caractère", "R, par la table ASCII"),
  )

  #v(0.5em)
  #avertissement[
    ASCII est la table historique : 128 caractères, l'anglais sans accents.
    Aujourd'hui les fichiers sont en UTF-8, qui garde ces valeurs et code les
    autres caractères sur plusieurs octets : `é` en occupe deux, `C3 A9`.
  ]

  #legende[
    2#super[8] = 256. C'est aussi pourquoi une valeur d'octet s'écrit avec deux
    chiffres hexadécimaux, ce que le cours 3 reprendra.
  ]

  #notes[
    Ne pas faire calculer : donner 2 puissance 8, et passer. Le binaire est
    ouvert pour de bon au cours 3, avec les images ; aujourd'hui il ne sert
    qu'à rendre la table crédible.

    L'intuition à laisser : « texte » veut dire « octets plus une table de
    correspondance ». Un fichier écrit avec une table et relu avec une autre
    donne des caractères abîmés — l'origine des accents cassés que tout le
    monde a déjà vus, et un sujet du cours 2 avec git.

    Si la question vient sur UTF-8 : les 128 valeurs d'ASCII y gardent leur
    sens, ce qui fait qu'un fichier anglais est identique dans les deux
    tables. Les autres caractères prennent de deux à quatre octets.

    Ne pas dire « ASCII » pour parler d'un fichier texte d'aujourd'hui : le
    mot traîne dans beaucoup de documentations, il est faux depuis vingt ans.
  ]
]

// ------------------------ TD : fichiers et extensions -----------------------
// --------------------------------------------
#separateur-manip(
  "Fichiers, formats et extensions",
  dossier: "data/cours1/produit/",
)
#d("Un même document, trois formats")[
  #annonce[
    Ouvrir `data/cours1/produit/raven.odt` dans LibreOffice Writer, puis
    l'enregistrer sous deux autres formes et comparer ce qu'il en reste.
  ]

  #avertissement[
    Sur votre machine. Premier geste : afficher les extensions, que Windows
    masque par défaut. Explorateur #sym.arrow.r Affichage #sym.arrow.r Afficher
    #sym.arrow.r Extensions de noms de fichiers.
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
    l'image perd tout sauf l'apparence.
  ]
]

// --------------------------------------------
#d("Renommer une extension, et voir l'incidence pour leur ouverture")[
  #annonce[
    Renommer des copies de `raven.odt` avec `F2`, puis les ouvrir par
    double-clic.
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
    `0x50 0x4b` est « PK » : la visionneuse nomme elle-même les octets
    qu'elle a lus. Y revenir à « Comment un logiciel reconnaît un fichier
    ».

    La quatrième ligne surprend et c'est la plus utile : avec une
    extension inventée, le système n'a plus de convention à appliquer et
    se rabat sur les premiers octets. Laisser la salle inventer
    l'extension.

    Sous Windows et macOS, activer d'abord l'affichage des extensions,
    sans quoi `F2` ne montre pas ce qu'on renomme.
  ]
]

// --------------------------------------------
#d[`.odt` un format qui est une archive de plusieurs fichiers][
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
    Faire ouvrir `content.xml` dans l'éditeur : le poème est là, en clair.
    C'est aussi la réponse à « pourquoi un `.odt` se versionne mal » : le
    fichier livré est compressé, donc illisible pour `git diff`.

    Le texte est dans `content.xml`, la mise en forme dans `styles.xml` :
    la séparation contenu / présentation déjà vue avec HTML et CSS.
  ]
]

// --------------------------------------------
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
    Le texte n'a pas bougé : seul le nom du style a changé. Ce que `_20_` vient
    faire dans ce nom est la dernière diapositive de la partie.
  ]

  #notes[
    `content.xml` fait ici 4 ko sur 21 lignes, dont une de 1 300
    caractères : lisible au Bloc-notes en activant le retour à la ligne,
    plus confortable dans l'éditeur de code, qui colore et replie les
    balises.

    Le `_20_` intrigue toujours. Un nom de style est un nom XML, où
    l'espace est interdit ; ODF encode chaque caractère interdit par son
    code hexadécimal entouré de tirets bas, et l'espace vaut 20. Ce n'est
    donc pas un nom en trois morceaux, c'est « Text body ». Le nom lisible
    est dans l'attribut `style:display-name`, celui que LibreOffice
    affiche. Rapprochement utile : le `%20` des adresses web, même
    interdiction, même encodage. Référence OpenDocument v1.3 partie 3,
    donnée dans le notebook.

    Sur la couleur : ODF n'accepte pas de nom de couleur. Vérifié,
    `fo:color="red"` est ignoré et le titre reste noir ; il faut
    `fo:color="#c0392b"`. Occasion de dire ce qu'est un code hexadécimal,
    deux chiffres par composante. CSS accepte les deux écritures, on le
    verra à la manipulation suivante.
  ]
]

// --------------------------------------------
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

// --------------------------------------------
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

    Fichiers dans `data/cours1/produit/`. Si `style.css` n'est pas dans le même
    dossier que le `.html`, la page s'affiche sans mise en forme : bonne
    occasion de reparler des chemins relatifs.
  ]
]

// --------------------------------------------
#d("Un espace dans le nom d'un fichier")[
  #annonce[
    Renommer `raven_brut.html` en `raven brut.html`, l'ouvrir par double-clic,
    puis regarder l'adresse que le navigateur affiche.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Étape], [Ce que vous constatez],
    [renommer avec `F2`],
      [l'explorateur accepte l'espace et l'affiche tel quel],
    [ouvrir par double-clic],
      reponse[la page s'affiche comme avant : le nom n'a rien changé au contenu],
    [lire l'adresse],
      reponse[`file:///.../raven%20brut.html`, l'espace y est écrit `%20`],
    [copier l'adresse, la coller dans l'éditeur],
      reponse[`%20` s'y retrouve, même si la barre du navigateur montrait un espace],
  )

  #legende[
    Une adresse ne peut pas contenir d'espace : le navigateur le remplace par
    `%20`, le code du caractère espace.
  ]

  #notes[
    Vérifié sur cette machine : quel que soit ce qui est tapé, le navigateur
    ramène l'adresse à `file:///.../raven%20brut.html`. L'affichage dans la
    barre, lui, dépend du navigateur et de sa version, certains y montrant
    l'espace. D'où la dernière ligne : l'adresse copiée, elle, porte toujours
    `%20`. À essayer une fois sur un poste de la salle avant la séance.

    Ne pas ouvrir le dossier des caractères permis dans un nom de fichier.
    Retenir : un espace dans un nom passe partout aujourd'hui, mais il se
    paiera en ligne de commande au cours 3, où il faudra des guillemets.
  ]
]

// --------------------------------------------
#d("Le même espace dans un nom de style")[
  #annonce[
    Un nom de style suit la même règle : LibreOffice affiche un nom lisible, et
    `content.xml` écrit l'espace `_20_`.
  ]

  // Le volet des styles, à gauche, et ce que `content.xml` écrit à leur place.
  // Une ligne par style : la répétition fait voir la règle mieux qu'un seul
  // exemple commenté.
  #v(0.2em)
  #align(center)[
    #let ligne(nom, interne) = (
      block(width: 100%, inset: (x: 12pt, y: 7pt), fill: gris,
            stroke: (bottom: 0.8pt + gris.darken(12%)))[
        #text(size: 16pt)[#nom]
      ],
      align(horizon + center, text(size: 20pt, fill: accent)[→]),
      align(horizon, text(font: police-code, size: 16pt, fill: manip,
                          weight: demi-gras)[#interne]),
    )
    #grid(
      columns: (215pt, auto, auto),
      column-gutter: 16pt,
      row-gutter: 0pt,
      align: left,
      block(width: 100%, inset: (x: 12pt, y: 6pt), fill: accent)[
        #text(size: 14pt, fill: white, weight: demi-gras)[Styles]
      ],
      [], align(horizon, text(size: 14pt, fill: estompe)[dans `content.xml`]),
      ..ligne("Corps de texte", "Text_20_body"),
      ..ligne("Titre 1", "Heading_20_1"),
      ..ligne("Titre 2", "Heading_20_2"),
    )
  ]

  #v(0.6em)
  #tableau(
    columns: (auto, 1fr, auto),
    align: left + horizon,
    [], [Ce qui interdit l'espace], [L'espace s'y écrit],
    [Une adresse web], [la syntaxe des URL], [`%20`],
    [Un nom de style ODF], [la syntaxe des noms XML], [`_20_`],
  )

  #legende[
    20 est le code du caractère espace. Les deux l'écrivent parce que les deux
    l'interdisent, chacun avec sa marque.
  ]

  #notes[
    Boucler la partie ici : c'est le `_20_` aperçu dans `content.xml`, et
    l'étudiant vient de produire le `%20` lui-même en renommant un fichier.

    Le nom lisible est dans l'attribut `style:display-name` ; c'est lui que
    LibreOffice affiche, traduit en français dans l'interface. La chaîne
    montre donc deux passages : la traduction, puis l'encodage.

    Référence OpenDocument v1.3 partie 3 pour l'encodage des noms, donnée
    dans le notebook. Ne pas la citer à l'oral.

    Le code hexadécimal lui-même est au cours 3 : dire « le code du
    caractère espace » et rien de plus.
  ]
]

// --------------------------------------------
#d("La table ASCII, caractère par caractère")[
  #annonce[
    Les 95 caractères affichables d'ASCII et leur valeur, lue en hexadécimal :
    le rang donne le premier chiffre, la colonne le second. `R` est ainsi à la
    ligne `5_` et dans la colonne `2`, soit `52`.
  ]

  #align(center)[
    #block(inset: (x: 16pt, y: 13pt), fill: gris)[
      #grid(
        columns: 17,
        column-gutter: 11pt,
        row-gutter: 9pt,
    [],
    align(center, text(size: 15pt, fill: estompe)[0]),
    align(center, text(size: 15pt, fill: estompe)[1]),
    align(center, text(size: 15pt, fill: estompe)[2]),
    align(center, text(size: 15pt, fill: estompe)[3]),
    align(center, text(size: 15pt, fill: estompe)[4]),
    align(center, text(size: 15pt, fill: estompe)[5]),
    align(center, text(size: 15pt, fill: estompe)[6]),
    align(center, text(size: 15pt, fill: estompe)[7]),
    align(center, text(size: 15pt, fill: estompe)[8]),
    align(center, text(size: 15pt, fill: estompe)[9]),
    align(center, text(size: 15pt, fill: estompe)[A]),
    align(center, text(size: 15pt, fill: estompe)[B]),
    align(center, text(size: 15pt, fill: estompe)[C]),
    align(center, text(size: 15pt, fill: estompe)[D]),
    align(center, text(size: 15pt, fill: estompe)[E]),
    align(center, text(size: 15pt, fill: estompe)[F]),
    align(center, text(size: 15pt, fill: estompe)[2\_]),
    align(center, text(font: police-code, size: 21pt)[#"␣"]),
    align(center, text(font: police-code, size: 21pt)[#"!"]),
    align(center, text(font: police-code, size: 21pt)[#"\""]),
    align(center, text(font: police-code, size: 21pt)[#"#"]),
    align(center, text(font: police-code, size: 21pt)[#"$"]),
    align(center, text(font: police-code, size: 21pt)[#"%"]),
    align(center, text(font: police-code, size: 21pt)[#"&"]),
    align(center, text(font: police-code, size: 21pt)[#"'"]),
    align(center, text(font: police-code, size: 21pt)[#"("]),
    align(center, text(font: police-code, size: 21pt)[#")"]),
    align(center, text(font: police-code, size: 21pt)[#"*"]),
    align(center, text(font: police-code, size: 21pt)[#"+"]),
    align(center, text(font: police-code, size: 21pt)[#","]),
    align(center, text(font: police-code, size: 21pt)[#"-"]),
    align(center, text(font: police-code, size: 21pt)[#"."]),
    align(center, text(font: police-code, size: 21pt)[#"/"]),
    align(center, text(size: 15pt, fill: estompe)[3\_]),
    align(center, text(font: police-code, size: 21pt)[#"0"]),
    align(center, text(font: police-code, size: 21pt)[#"1"]),
    align(center, text(font: police-code, size: 21pt)[#"2"]),
    align(center, text(font: police-code, size: 21pt)[#"3"]),
    align(center, text(font: police-code, size: 21pt)[#"4"]),
    align(center, text(font: police-code, size: 21pt)[#"5"]),
    align(center, text(font: police-code, size: 21pt)[#"6"]),
    align(center, text(font: police-code, size: 21pt)[#"7"]),
    align(center, text(font: police-code, size: 21pt)[#"8"]),
    align(center, text(font: police-code, size: 21pt)[#"9"]),
    align(center, text(font: police-code, size: 21pt)[#":"]),
    align(center, text(font: police-code, size: 21pt)[#";"]),
    align(center, text(font: police-code, size: 21pt)[#"<"]),
    align(center, text(font: police-code, size: 21pt)[#"="]),
    align(center, text(font: police-code, size: 21pt)[#">"]),
    align(center, text(font: police-code, size: 21pt)[#"?"]),
    align(center, text(size: 15pt, fill: estompe)[4\_]),
    align(center, text(font: police-code, size: 21pt)[#"@"]),
    align(center, text(font: police-code, size: 21pt)[#"A"]),
    align(center, text(font: police-code, size: 21pt)[#"B"]),
    align(center, text(font: police-code, size: 21pt)[#"C"]),
    align(center, text(font: police-code, size: 21pt)[#"D"]),
    align(center, text(font: police-code, size: 21pt)[#"E"]),
    align(center, text(font: police-code, size: 21pt)[#"F"]),
    align(center, text(font: police-code, size: 21pt)[#"G"]),
    align(center, text(font: police-code, size: 21pt)[#"H"]),
    align(center, text(font: police-code, size: 21pt)[#"I"]),
    align(center, text(font: police-code, size: 21pt)[#"J"]),
    align(center, text(font: police-code, size: 21pt)[#"K"]),
    align(center, text(font: police-code, size: 21pt)[#"L"]),
    align(center, text(font: police-code, size: 21pt)[#"M"]),
    align(center, text(font: police-code, size: 21pt)[#"N"]),
    align(center, text(font: police-code, size: 21pt)[#"O"]),
    align(center, text(size: 15pt, fill: estompe)[5\_]),
    align(center, text(font: police-code, size: 21pt)[#"P"]),
    align(center, text(font: police-code, size: 21pt)[#"Q"]),
    align(center, text(font: police-code, size: 21pt)[#"R"]),
    align(center, text(font: police-code, size: 21pt)[#"S"]),
    align(center, text(font: police-code, size: 21pt)[#"T"]),
    align(center, text(font: police-code, size: 21pt)[#"U"]),
    align(center, text(font: police-code, size: 21pt)[#"V"]),
    align(center, text(font: police-code, size: 21pt)[#"W"]),
    align(center, text(font: police-code, size: 21pt)[#"X"]),
    align(center, text(font: police-code, size: 21pt)[#"Y"]),
    align(center, text(font: police-code, size: 21pt)[#"Z"]),
    align(center, text(font: police-code, size: 21pt)[#"["]),
    align(center, text(font: police-code, size: 21pt)[#"\\"]),
    align(center, text(font: police-code, size: 21pt)[#"]"]),
    align(center, text(font: police-code, size: 21pt)[#"^"]),
    align(center, text(font: police-code, size: 21pt)[#"_"]),
    align(center, text(size: 15pt, fill: estompe)[6\_]),
    align(center, text(font: police-code, size: 21pt)[#"`"]),
    align(center, text(font: police-code, size: 21pt)[#"a"]),
    align(center, text(font: police-code, size: 21pt)[#"b"]),
    align(center, text(font: police-code, size: 21pt)[#"c"]),
    align(center, text(font: police-code, size: 21pt)[#"d"]),
    align(center, text(font: police-code, size: 21pt)[#"e"]),
    align(center, text(font: police-code, size: 21pt)[#"f"]),
    align(center, text(font: police-code, size: 21pt)[#"g"]),
    align(center, text(font: police-code, size: 21pt)[#"h"]),
    align(center, text(font: police-code, size: 21pt)[#"i"]),
    align(center, text(font: police-code, size: 21pt)[#"j"]),
    align(center, text(font: police-code, size: 21pt)[#"k"]),
    align(center, text(font: police-code, size: 21pt)[#"l"]),
    align(center, text(font: police-code, size: 21pt)[#"m"]),
    align(center, text(font: police-code, size: 21pt)[#"n"]),
    align(center, text(font: police-code, size: 21pt)[#"o"]),
    align(center, text(size: 15pt, fill: estompe)[7\_]),
    align(center, text(font: police-code, size: 21pt)[#"p"]),
    align(center, text(font: police-code, size: 21pt)[#"q"]),
    align(center, text(font: police-code, size: 21pt)[#"r"]),
    align(center, text(font: police-code, size: 21pt)[#"s"]),
    align(center, text(font: police-code, size: 21pt)[#"t"]),
    align(center, text(font: police-code, size: 21pt)[#"u"]),
    align(center, text(font: police-code, size: 21pt)[#"v"]),
    align(center, text(font: police-code, size: 21pt)[#"w"]),
    align(center, text(font: police-code, size: 21pt)[#"x"]),
    align(center, text(font: police-code, size: 21pt)[#"y"]),
    align(center, text(font: police-code, size: 21pt)[#"z"]),
    align(center, text(font: police-code, size: 21pt)[#"{"]),
    align(center, text(font: police-code, size: 21pt)[#"|"]),
    align(center, text(font: police-code, size: 21pt)[#"}"]),
    align(center, text(font: police-code, size: 21pt)[#"~"]),
    align(center, text(font: police-code, size: 21pt, fill: estompe)[·]),
      )
    ]
  ]

  #legende[
    Les valeurs de `00` à `1F` ne sont pas des caractères affichables : ce sont
    des commandes, dont le saut de ligne `0A`. `7F` non plus. Les majuscules
    commencent à `41`, les minuscules `20` plus loin, à `61`.
  ]

  #notes[
    Ne pas la lire ligne à ligne : elle est là pour être consultée pendant la
    manipulation qui suit, et pour que « une table d'encodage » cesse d'être
    une abstraction.

    Trois lectures à faire faire, pas plus : `R` en `52`, l'espace en `20`,
    et le passage de `A` à `a` en ajoutant `20`.

    UTF-8 reprend ces 95 valeurs à l'identique : cette table reste vraie
    pour tout ce qui s'écrit sans accent.
  ]
]

#d("Ouvrir chaque fichier avec le Bloc-notes")[
  #annonce[
    Le Bloc-notes n'affiche rien d'autre que des caractères : il lit chaque
    octet et montre le caractère correspondant. Il permet donc de voir de quoi
    un fichier est fait.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Fichier ouvert], [Ce que vous constatez],
    [`raven_une_ligne.txt`], reponse[le poème, lisible en entier],
    [`style.css`], reponse[des règles de mise en forme, lisibles elles aussi],
    [`raven_brut.html`], reponse[le texte et ses balises : du texte, malgré l'extension],
    [`raven.odt`], reponse[`PK` en tête, puis du charabia : une archive, donc binaire],
    [une tuile `.png`], reponse[`PNG` en tête, puis rien de lisible],
  )

  #avertissement[
    Ne rien enregistrer, et fermer sans sauver : un `.odt` ou un `.png`
    réenregistré par le Bloc-notes est détruit.
  ]

  #notes[
    Clic droit #sym.arrow.r Ouvrir avec #sym.arrow.r Bloc-notes. Sous macOS et
    Linux, l'éditeur de texte du système refuse souvent les fichiers non
    texte : le faire alors en démonstration depuis le poste enseignant.

    Les deux règles du Bloc-notes, à dire avant : il affiche un caractère par
    octet, selon un encodage qu'il devine, et il n'interprète rien d'autre —
    ni image, ni mise en forme. Ce qui n'a pas de caractère correspondant
    apparaît en carré ou en signe étrange.

    Choisir de petits fichiers : ceux du dossier font de 0,5 à 20 ko. Un
    fichier de plusieurs mégaoctets fige l'affichage sans rien apprendre.

    Le `PK` et le `PNG` viennent d'être vus sur la diapositive des octets. Les
    faire retrouver par la salle plutôt que les désigner.

    Faire le lien avec l'extension : `raven_brut.html` est du texte, `.odt`
    n'en est pas, et le nom ne le disait pas.
  ]
]
