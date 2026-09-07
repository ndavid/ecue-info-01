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
