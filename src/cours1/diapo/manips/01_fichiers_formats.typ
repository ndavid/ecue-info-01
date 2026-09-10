// Manipulation du cours 1 — « Fichiers, formats et extensions ».
//
// Incluse par `cours1.typ`, qui porte les réglages globaux, et compilable
// seule par `outils/compiler_manips.py`, qui en tire la feuille d'instructions
// déposée dans le dossier de données de la manipulation. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *


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
