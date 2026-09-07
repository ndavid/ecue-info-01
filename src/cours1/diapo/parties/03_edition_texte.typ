// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

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

  #v(0.4em)
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [Les mots du langage et les fonctions connues], [`for`, `in`, `print`],
    [Les nombres], [`128.4`, `131.0`],
    [Le texte entre guillemets], [`"{altitude:.1f} m"`],
    [Les noms que vous choisissez], [`altitudes`, `altitude`],
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
#d("Vérification de l'écriture")[
  #annonce[
    L'éditeur relit le fichier pendant qu'on l'écrit et souligne ce qui ne
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
      "/data/cours1/illustrations/vscode_espaces.png",
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
#d("Extension de fichier et extension de VSCode")[
  #annonce[
    Le même mot désigne deux choses sans rapport : la fin du nom d'un fichier,
    et un greffon qu'on installe dans l'éditeur.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [L'extension du fichier], [L'extension de l'éditeur],
    [Ce que c'est],
      [la fin du nom, après le dernier point : `.py`, `.cpp`, `.md`],
      [un greffon installé dans VSCode : `ms-python.python`],
    [Dans le fichier],
      [rien : les trois sont du texte, sans marque ni en-tête],
      [rien non plus : elle n'agit que sur l'affichage],
    [Ce qu'elle apporte],
      [une indication de langage, à qui lit le nom],
      [la coloration fine, et la vérification des règles d'écriture],
  )

  #legende[
    Les trois du module : `ms-python.python`, `ms-vscode.cpptools`,
    `ms-toolsai.jupyter`. Panneau Extensions, `Ctrl` + `Maj` + `X`, où l'on
    cherche l'identifiant et jamais le nom affiché.
  ]

  #notes[
    Deux sens pour un mot, et la confusion est réelle : « installe l'extension
    Python » et « le fichier a l'extension `.py` » ne parlent pas de la même
    chose. Le dire une fois explicitement vaut mieux que de laisser chacun
    trancher.

    La colonne de gauche est le point neuf. Un `.py` et un `.cpp` sont des
    fichiers texte, et rien dans leurs octets ne les distingue : pas de marque
    binaire, pas d'en-tête, pas de signature. L'extension est purement
    informative — elle dit ce qu'on peut espérer trouver dedans, elle ne le
    garantit pas. `python bonjour.txt` exécute parfaitement un programme
    Python : la démonstration tient en cinq secondes et se retient.

    C'est aussi ce que la manipulation « Les premiers octets d'un fichier »
    fera constater plus loin dans la partie : les formats texte n'ont aucune
    signature, contrairement au ZIP et au PDF.

    La vérification annoncée à droite porte sur les règles d'écriture, pas sur
    le sens : un programme peut être irréprochable pour l'extension et faire
    exactement le contraire de ce qu'on voulait. C'est la limite à poser, et
    elle prolonge « Les règles d'écriture d'un langage ».

    L'identifiant en chasse fixe est ce qu'il faut chercher dans le panneau :
    les noms affichés se ressemblent tous et plusieurs extensions non
    officielles portent le même titre. Le réflexe vaut au-delà de ce cours.

    L'extension Python installe elle-même Pylance, qui fait la vérification.
    Ne le dire que si quelqu'un remarque qu'une deuxième extension est
    apparue. Identifiants relevés sur le poste de préparation.
  ]
]
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
    [Ouvrir `python/surface.py` dans LibreOffice Writer, puis lui donner une
     police à chasse fixe],
      reponse[les colonnes s'alignent, comme dans l'éditeur],
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
    La première ligne est là pour vérifier de leurs mains ce que « Ce que
    l'éditeur ajoute au texte » a montré : le fichier ne contient aucune
    police, et le même texte s'aligne ou non selon celle qu'on lui donne.
    Format #sym.arrow.r Caractère, puis une police à chasse fixe — Liberation
    Mono ou DejaVu Sans Mono sont présentes partout. Enchaîner en disant que
    l'éditeur fait ce choix d'office, et qu'on n'a donc jamais à y penser.

    La troisième ligne est celle qui surprend, et elle est voulue : la
    coloration ne vient pas de l'extension, elle est fournie d'origine pour
    les langages courants. Ce que l'extension apporte est la ligne suivante,
    le soulignement.

    Enchaîner sur « Extension de fichier et extension de VSCode » si la
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
    La diapositive corrige une impression que la partie a pu laisser jusqu'ici :
    on n'écrit pas que du code dans un éditeur de code. Sur un projet réel, les
    fichiers de réglage et la documentation sont souvent plus nombreux que les
    fichiers de programme.

    `.json` et `.yaml` portent la même chose et se convertissent l'un en
    l'autre ; le premier est celui que les programmes écrivent, le second
    celui que les humains écrivent, parce qu'il accepte des commentaires. Une
    phrase, pas plus.

    Le `README` est nommé dès maintenant parce qu'il est le livrable de fin de
    séance et le premier commit du cours 2.
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
        "/data/cours1/illustrations/page_html_brut.png",
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
    panneau[`raven_style.html` + `style.css`][
      #illustration(
        "/data/cours1/illustrations/page_html_style.png",
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
    Ne pas faire apprendre la liste. Ce qu'il faut faire remarquer est que la
    colonne de gauche se lit déjà : c'est l'intention de Gruber, vue à la
    diapositive précédente, rendue concrète.

    Les deux pièges à signaler, parce qu'ils coûtent une minute chacun. Une
    ligne vide sépare les paragraphes, sans quoi deux lignes consécutives
    n'en font qu'un. Et le dièse veut un espace après lui : `#Titre` ne
    produit pas un titre.

    Sur le lien et l'image : même syntaxe, avec un point d'exclamation devant
    pour l'image. Le chemin de l'image est relatif au fichier `.md`, ce qui
    est l'occasion de rappeler les chemins de la partie 1.

    L'aperçu `Ctrl` + `Maj` + `V` est le moyen de vérifier, et il est côte à
    côte avec `Ctrl` + `K` puis `V`. C'est ce qu'ils emploieront pendant la
    manipulation.
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
    Le point de la diapositive n'est pas la liste mais ce qu'elle permet de
    conclure : pour tout ce qu'on écrira cette année en dehors du code, il n'y
    a rien à installer. C'est le contraste avec Python et C++, qui exigent une
    extension, et il vaut d'être dit ainsi.

    L'aperçu Markdown est à montrer en direct, `Ctrl` + `Maj` + `V` sur le
    fichier de notes du jour : c'est le geste qu'ils emploieront le plus cette
    année.

    La dernière colonne porte la différence de nature : le Markdown se rend
    dans l'éditeur, le HTML dans le navigateur. Les deux diapositives qui
    suivent la manipulation le montrent sur la page du poème.

    Sur JSON et YAML, si la question vient : même principe, mais l'éditeur ne
    les sert pas également. La diapositive est en annexe.
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
    L'intérêt n'est pas de dessiner joli, c'est que le schéma soit du texte :
    il se compare ligne à ligne, il se versionne, et on le corrige sans
    rouvrir un logiciel de dessin. C'est l'argument de toute la partie,
    appliqué à autre chose qu'à de la prose.

    Faire remarquer que le dessin n'est pas dans le fichier. Le `.md` ne
    contient que les six lignes ; les boîtes sont calculées à l'affichage,
    comme la coloration l'était pour le code.

    Le vocabulaire minimal suffit : `flowchart LR` pour un schéma de gauche à
    droite, un identifiant, le texte entre crochets, et `-->` pour une
    flèche. Tout le reste s'invente en lisant la documentation de Mermaid.

    Ne pas ouvrir le catalogue des types de diagrammes. Un organigramme
    aujourd'hui, le reste quand ils en auront besoin — le cours 2 s'en sert
    pour représenter l'historique d'un dépôt git.
  ]
]
#separateur-manip(
  "Formatage HTML et Markdown",
  annonce: "Une page web et sa feuille de style, puis un texte brut mis en forme en Markdown",
)
#d("Mettre en forme une recette")[
  #annonce[
    Un texte brut sans aucune structure, à reprendre en Markdown. Le rendu se
    vérifie à côté, sans quitter l'éditeur.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [ouvrir `data/cours1/markdown/`, puis `recette_a_formater.txt`],
    [2], [l'enregistrer sous `recette.md`, et ouvrir l'aperçu par `Ctrl` + `K` puis `V`],
    [3], [un titre en `#`, deux sous-titres en `##`],
    [4], [les étapes de préparation en liste numérotée],
    [5], [les ingrédients en tableau, depuis `ingredients.csv`],
    [6], [l'ordre des opérations en bloc `mermaid`],
  )

  #legende[
    `recette.md`, dans le même dossier, donne le résultat attendu : ne
    l'ouvrir qu'après avoir essayé.
  ]

  #notes[
    Le texte de départ n'a aucune structure, et c'est voulu : ils doivent la
    décider, pas la recopier. La discussion utile est de savoir ce qui est un
    titre et ce qui est une étape — la mise en forme est une lecture du
    contenu, pas une décoration.

    L'aperçu côte à côte est le geste à installer, `Ctrl` + `K` puis `V`. On
    écrit à gauche, on voit à droite, et on corrige sans rien lancer.

    Étape 5 : le tableau se tape à la main, ou se produit depuis le CSV par
    une extension du catalogue — chercher « CSV to Markdown Table ». Le faire
    à la main la première fois, montrer l'extension ensuite : l'intérêt est de
    voir qu'un tableau Markdown n'est que des barres verticales alignées, et
    que l'alignement n'est même pas obligatoire.

    Étape 6 : le diagramme de la diapositive précédente, avec les deux
    entrées qui se rejoignent. Rien à installer.

    Pour ceux qui vont vite : ajouter une photo par `![](…)`, ce qui rappelle
    les chemins relatifs, et une citation par `>` pour la remarque finale.
  ]
]
// Le rendu attendu, quand la capture est disponible : sans elle, la
// diapositive n'aurait rien à montrer que le texte de la précédente.
#if captures-disponibles {
d("Le résultat attendu")[
  #annonce[
    Un titre, un tableau, une liste numérotée, et le diagramme dessiné à
    partir de ses six lignes de texte.
  ]

  #align(center)[
    #illustration(
      "/data/cours1/illustrations/apercu_recette.png",
      none,
      hauteur: 200pt,
    )
  ]

  #legende[
    Aperçu du `recette.md` du dossier. Le diagramme n'est pas une image : il
    est décrit en six lignes dans le fichier, et dessiné à l'affichage.
  ]

  #notes[
    À projeter après la manipulation, pas avant : c'est le corrigé. Faire
    remarquer que rien ici n'a demandé de logiciel de mise en page, et que le
    fichier source reste lisible tel quel.

    Le diagramme est le point à souligner. Il a la même nature que le reste :
    du texte dans le fichier, une image seulement à l'écran. C'est la
    troisième fois de la séance qu'on rencontre cette distinction, après la
    coloration et les polices.
  ]
]
}
