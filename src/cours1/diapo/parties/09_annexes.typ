// Partie du cours 1 — incluse par `cours1.typ`, qui porte les réglages
// globaux. Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

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
      "/data/cours1/illustrations/libreoffice_export_pdf.png",
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
        "/data/cours1/illustrations/terminal_windows_powershell.jpg",
        fenetre("Windows PowerShell", code: true)[
          #text(fill: accent, weight: demi-gras)[PS C:\\Users\\alice\> ]
        ],
        largeur: 100%,
      )
    ],
    panneau("Linux — GNOME Terminal")[
      #illustration(
        "/data/cours1/illustrations/terminal_linux_gnome.png",
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
