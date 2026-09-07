// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

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
