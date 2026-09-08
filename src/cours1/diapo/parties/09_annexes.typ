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

    Faire le lien avec la manipulation de la première partie : ils ont
    exporté `raven.odt` en PDF en cliquant dans LibreOffice. `soffice`
    n'est pas un autre outil, c'est le même appelé par son nom. Le nom
    vient de StarOffice ; une phrase, et passer.

    La lecture option / argument est la grille de lecture de toutes les
    commandes du semestre, et elle rend une page d'aide utilisable. Le
    cours 3 construit une commande de cette forme avec `argparse`.

    Ne pas taper la commande maintenant : c'est la manipulation qui suit.
  ]
]
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
    Y passer du temps : c'est ce qui justifie le reste de la partie.

    L'étoile est le seul caractère qui change entre les deux colonnes, et
    la ligne ne changera plus : elle vaut pour trois cents fichiers comme
    pour vingt. Aucune suite de clics ne sait le faire, un clic désignant
    un objet et un seul.

    À la souris on montre des objets déjà à l'écran ; au clavier on décrit
    un ensemble, y compris des fichiers qu'on ne voit pas ou qui
    n'existent pas encore.

    Ne pas commenter `soffice` ni `--headless` : ils sont repris à «
    Anatomie d'une commande ».

    Si la question vient : oui, les explorateurs savent sélectionner par
    motif ; non, ils ne savent pas enchaîner l'opération suivante sur le
    résultat.
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
    Laisser lire, puis résumer en une phrase : on clique pour chercher, on
    tape pour répéter.

    Contre-exemple si la salle penche trop d'un côté : personne ne
    retouche une photo au terminal, personne ne renomme trois cents
    fichiers à la souris. La seconde dérive coûte plus cher parce qu'elle
    ne se voit pas.

    Les trois dernières lignes annoncent la suite : la commande qui se
    relance est le script du cours 3, celle qui se transmet le dépôt du
    cours 2.

    Distinction d'ergonomie qui éclaire le tableau : le graphique
    fonctionne par reconnaissance, la ligne de commande par rappel.
    Reprise deux diapositives plus loin, chiffrée.
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
      "/illustrations/cours1/libreoffice_export_pdf.png",
      none,
      hauteur: hauteur-capture-pleine,
    )
  ]

  #legende[
    LibreOffice 25.2 : trois niveaux, vingt-quatre entrées dans le seul menu
    Fichier.
  ]

  #notes[
    Laisser la salle chercher l'entrée des yeux avant de la désigner :
    c'est l'argument de la diapositive, et il se démontre mieux qu'il ne
    s'énonce.

    Le rapprochement avec la ligne de commande se fait ici sans le dire :
    la commande ne se cherche pas, elle s'écrit, mais encore faut-il la
    connaître. C'est exactement la première ligne du tableau qui suit.

    Le chemin exact change d'une version à l'autre, et c'est aussi ce qui
    rend une consigne écrite en gestes fragile.
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
        "/illustrations/cours1/terminal_windows_powershell.jpg",
        fenetre("Windows PowerShell", code: true)[
          #text(fill: accent, weight: demi-gras)[PS C:\\Users\\alice\> ]
        ],
        largeur: 100%,
      )
    ],
    panneau("Linux — GNOME Terminal")[
      #illustration(
        "/illustrations/cours1/terminal_linux_gnome.png",
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
  dossier: "data/cours1/produit/",
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
    Trois pièges, dans l'ordre : le `PATH`, le choix de `soffice.com`
    plutôt que `soffice.exe` que demande la documentation officielle, et
    l'opérateur d'appel de PowerShell.

    Seule la ligne Linux a été exécutée. Celles de Windows et macOS
    viennent de la documentation LibreOffice : les tester avant la séance.

    Repli si cela dérape : `pandoc raven.odt -o raven.pdf` dans
    l'environnement `info01`, qui est dans le `PATH` sur les trois
    systèmes une fois `conda activate` fait.
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
    Annexe : la démonstration se fait en séance avec `octets.py`, qui vaut
    sur les trois systèmes. Celle-ci sert si la salle veut le voir au
    terminal, et au cours 2.

    `Format-Hex` remplace `head` et `xxd` à lui seul, affichant
    l'hexadécimal et le texte côte à côte. Son paramètre `-Count` n'existe
    qu'à partir de PowerShell 6.2, absent du 5.1 livré avec Windows, d'où
    `Select-Object -First 1`, qui prend la première ligne de seize octets
    et marche dans les deux versions.

    Windows ne fournit pas d'équivalent de `file` : c'est la diapositive
    suivante, facultative.

    Les lignes PowerShell viennent de la documentation Microsoft et n'ont
    pas pu être exécutées ici : à vérifier avant la séance. Les valeurs
    d'octets sont mesurées.
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
  dossier: "data/cours1/produit/",
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
  dossier: "data/cours1/trajet/",
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
    Ouvrir `anime.sh` si la salle le demande, sans le commenter ligne à
    ligne. Ce qui compte est la forme : quatre blocs numérotés, un par
    fichier produit.

    Deux outils, tous deux en ligne de commande : ImageMagick pour
    dessiner sur la carte, ffmpeg pour assembler. Ce sont ceux du TD 4,
    qui reprend cette chaîne.

    Le `.srt` est du texte, lisible et modifiable : le livrable est
    binaire, la source ne l'est pas.

    « Et si je veux changer la police des sous-titres ? » : c'est une
    option de la dernière ligne, ne pas y entrer.
  ]
]

// ------------- Annexe : formats de fichier, octets et signatures ------------

#separateur(
  "Formats de fichier, octets et signatures",
  annonce: "Sorties de la partie « édition de texte », gardées pour référence",
)
#d("JSON et YAML dans l'éditeur")[
  #annonce[
    Les deux portent les mêmes réglages et se convertissent l'un en l'autre,
    mais l'éditeur ne les sert pas également.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Format], [Fourni d'origine], [Ce qu'une extension ajoute],
    [`.json`],
      [coloration, pliage, formatage, vérification par schéma],
      [rien, le plus souvent],
    [`.yaml`],
      [la coloration, et rien de plus],
      [la vérification par schéma, `redhat.vscode-yaml`],
  )

  #legende[
    Relevé dans les extensions livrées avec VSCode : `json-language-features`
    y est, `yaml-language-features` n'existe pas.
  ]

  #notes[
    Sortie de la séance : le sujet n'est pas assez employé au cours 1 pour
    valoir une diapositive projetée. Elle sert si quelqu'un demande pourquoi
    un `.yaml` n'est pas vérifié comme un `.json`.

    Le contraste avec les extensions de langage reste le propos : Python et
    C++ en exigent une, Markdown, HTML, CSS et JSON n'en ont pas besoin, YAML
    en tire un service précis et limité.
  ]
]
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
   'manifest.rdf', 'styles.xml']
  ```

  #legende[
    Sortie réelle sur le `raven.odt` du cours, produit par pandoc : six
    fichiers. Un document enregistré par LibreOffice en porte davantage, dont
    ses réglages de fenêtre et une vignette. `.docx`, `.xlsx` et `.epub` sont
    construits de la même façon.
  ]

  #notes[
    Faire ouvrir `content.xml` dans l'éditeur : le texte du poème est là,
    entouré de balises de mise en forme. C'est aussi la réponse à « pourquoi un
    `.odt` se versionne mal ».
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
  dossier: "data/cours1/formats/",
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
    Faire ouvrir le dossier `formats/` dans l'éditeur et lancer le script
    au terminal : c'est le geste de la manipulation « hello world »,
    refait sur un programme utile.

    Faire lire les quarante lignes avant de lancer : trois fonctions, dont
    une qui compare le début du fichier à un dictionnaire de signatures.

    Les deux premières lignes sont le cœur : deux extensions, les mêmes
    octets. Ils retrouvent « Extension et contenu ».

    Les fichiers texte n'ont aucune signature, et c'est une information :
    rien dans un fichier texte ne dit de quoi il est fait. C'est au
    logiciel qui l'ouvre de décider, d'où les erreurs de `file`.

    `PK` sont les initiales de Phil Katz, auteur du format ZIP.

    `raven.pdf` est celui qu'ils ont produit en première partie. Sans
    l'export, le script écrit `introuvable` et continue.
  ]
]

#d("Deux extensions échangées")[
  #annonce[
    Deux copies dont on échange les extensions gardent leurs octets. C'est le
    contenu que le logiciel lit, pas le nom.
  ]

  ```bash
  cp ../produit/raven.odt ../produit/raven_odt.pdf
  cp ../produit/raven.pdf ../produit/raven_pdf.odt
  python octets.py ../produit/raven_odt.pdf ../produit/raven_pdf.odt
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
