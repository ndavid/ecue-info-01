// Partie 2 du cours 3, seconde moitié — texte et binaire sur des images.
//
// Incluse par `cours3.typ`, après le TD 2b qui fait ouvrir `images.ipynb`.
// Se joue notebook ouvert et suit l'ordre de ce notebook : chaque
// diapositive porte, par `cellule:`, la section à exécuter à ce moment. Les
// nombres cités (tailles, temps) sont ceux d'une exécution réelle du
// notebook ; ils varient d'un poste à l'autre, pas leurs rapports.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

// --------------------------------------------
#d("Le format PGM")[
  #annonce[
    Un fichier PGM est une image en niveaux de gris : un en-tête de trois
    lignes, puis une valeur par pixel, 0 pour le noir. Ses deux variantes ne
    diffèrent que par l'écriture des pixels.
  ]

  #tableau(
    columns: (1fr, 1.1fr, 1.1fr),
    align: left + horizon,
    [], [`P2`, texte], [`P5`, binaire],
    [ligne 1 : le nom du format], [`P2`], [`P5`],
    [ligne 2 : largeur et hauteur], [`4 4`], [`4 4`],
    [ligne 3 : la valeur du blanc, 1 à 65535], [`255`], [`255` ; au-dessus, deux octets par pixel],
    [les pixels, ligne par ligne, de gauche à droite],
      [chaque valeur en chiffres, suivie d'un espace ou d'un retour à la ligne : `0 255 0 255`],
      [chaque valeur sur un octet, sans séparateur : `00 ff 00 ff`],
  )

  #legende[
    L'en-tête est du texte dans les deux variantes. Même famille : PBM
    (`P1`, `P4`), noir ou blanc, 0 ou 1 ; PPM (`P3`, `P6`), trois valeurs par
    pixel. Documentation : netpbm.sourceforge.net/doc/pgm.html.
  ]

  #notes[
    Ne pas ouvrir le notebook pour cette diapositive : elle annonce ce que les
    deux sections suivantes montrent. 
  ]
]

// --------------------------------------------
#d("Image au format texte : PGM P2", cellule: 1, fichier: "images.ipynb")[
  #annonce[
    Le fichier `depart/motif.pgm` est au format `P2`. `read_text()` renvoie
    son contenu sous forme de texte. La bibliothèque Pillow ouvre le même
    fichier comme une image de 4 × 4 pixels.
  ]

  #code-commente(
    taille-code: 13pt, taille-texte: 12.5pt,
    ("motif = Path(\"depart/motif.pgm\")", "le chemin du fichier"),
    ("print(motif.read_text())", "affiche le texte : l'en-tête, puis les seize valeurs des pixels"),
    ("image = Image.open(motif)", "ouvre l'image : `size` vaut `(4, 4)`, `mode` vaut `'L'` (niveaux de gris)"),
    ("image.resize((160, 160), Image.NEAREST)", "agrandit l'image 40 fois, sans lissage"),
  )

  #v(0.3em)
  #face-a-face(
    panneau("depart/motif.pgm, 59 octets")[
      #sortie("P2\n4 4\n255\n0 255 0 255\n255 0 255 0\n0 255 0 255\n255 0 255 0", taille: 10.5pt)
    ],
    panneau("L'image affichée par Pillow, agrandie")[
      #align(center, pixels-gris((
        (0, 255, 0, 255),
        (255, 0, 255, 0),
        (0, 255, 0, 255),
        (255, 0, 255, 0),
      ), cote: 18pt))
    ],
  )

  #notes[
    Dans la section 1, exécuter `read_text()`, puis `Image.open`. Le même
    fichier est lu comme du texte par Python et comme une image par Pillow.

    La cellule `resize` est donnée : elle agrandit l'image pour l'afficher.
    Sans `NEAREST`, Pillow lisse l'image agrandie et les seize pixels
    deviennent un dégradé.
  ]
]

// --------------------------------------------
#d("La même image en binaire", cellule: 2)[
  #annonce[
    Pillow enregistre le `.pgm` en `P5`. Le fichier texte est lui aussi une
    suite d'octets : un par caractère, selon le code ASCII.
  ]

  #code-commente(
    taille-code: 12.5pt, taille-texte: 12pt,
    ("image.save(TRAVAIL / \"motif.pgm\")", "Pillow écrit la variante `P5`"),
    ("octets = (TRAVAIL / \"motif.pgm\").read_bytes()", "lu comme des octets : `b'P5\\n4 4\\n255\\n\\x00\\xff…'`"),
    ("octets.hex(\" \")", "les mêmes octets, en hexadécimal"),
    ("motif.read_bytes()[:23].hex(\" \")", "les 23 premiers octets du fichier texte"),
  )

  #v(0.3em)
  #text(size: 12.5pt, fill: estompe, weight: demi-gras)[`P2`, 59 octets : l'en-tête et la première ligne de pixels]
  #v(0.2em)
  #align(center, octets(
    ("50", "32", "0a", "34", "20", "34", "0a", "32", "35", "35", "0a", "30", "20", "32", "35", "35", "20", "30", "20", "32", "35", "35", "0a"),
    ("P", "2", "↵", "4", "␣", "4", "↵", "2", "5", "5", "↵", "0", "␣", "2", "5", "5", "␣", "0", "␣", "2", "5", "5", "↵"),
    taille: 11pt,
  ))
  #v(0.4em)
  #text(size: 12.5pt, fill: estompe, weight: demi-gras)[`P5`, 27 octets : l'en-tête et les seize pixels]
  #v(0.2em)
  #align(center, octets(
    ("50", "35", "0a", "34", "20", "34", "0a", "32", "35", "35", "0a", "00", "ff", "00", "ff", "ff", "00", "ff", "00", "00", "ff", "00", "ff", "ff", "00", "ff", "00"),
    ("P", "5", "↵", "4", "␣", "4", "↵", "2", "5", "5", "↵", none, none, none, none, none, none, none, none, none, none, none, none, none, none, none, none),
    taille: 11pt,
  ))

  #legende[
    En `P2`, `255` prend quatre octets : trois chiffres et un espace. En
    `P5`, un octet, `ff`.
  ]

  #notes[
    Section 2 : `image.save(TRAVAIL / "motif.pgm")` puis `read_bytes()`. Le
    `b'…'` affiché mélange des caractères et des `\xff` : c'est la façon dont
    Python montre des octets. `.hex(" ")` les met tous sur le même plan.

    Faire compter : 11 + 16 = 27. L'en-tête est du texte à l'intérieur d'un
    fichier binaire ; c'est le cas de presque tous les formats.
  ]
]

// --------------------------------------------
// Les sections 3 à 6 du notebook se lisent après la séance : une seule
// diapositive en donne le contenu. Les cinq diapositives qui les
// détaillaient sont dans l'historique git (syllabus v1.5, 24/09/2026) ; les
// sections 5 et 6 sont reprises au projet 7.
#d("À lire après la séance : § 3 à 6")[
  #annonce[
    Les sections 3 à 6 d'`images.ipynb` se lisent et s'exécutent après la
    séance. La séance reprend à la section 7.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Section], [Contenu],
    [§ 3 · Lire un fichier octet par octet], [une fonction `hexdump` de six lignes : position, octets en hexadécimal, caractère],
    [§ 4 · Trois formats réels pour la même image], [les premiers octets d'un fichier (la signature) indiquent son format : `P5`, `BM`, `\x89PNG`],
    [§ 5 · Une vraie image, en quatre formats], [la taille d'une image non compressée se calcule (largeur × hauteur × octets par valeur) ; PNG et JPEG compressent],
    [§ 6 · Le temps de lecture], [lire les pixels depuis le fichier `P2` prend beaucoup plus longtemps que depuis le fichier `P5`],
  )

  #notes[
    Allègement de 2026 (syllabus v1.5). Les sections 5 et 6 (poids,
    compression, temps de lecture) sont reprises au projet 7, sur les
    images de l'animation.
  ]
]

// --------------------------------------------
#d("ASCII et UTF-8", cellule: 7)[
  #annonce[
    Un caractère est un nombre. ASCII en définit 128, sur un octet chacun :
    lettres sans accent, chiffres, ponctuation. UTF-8 garde ces 128 octets
    et écrit tous les autres caractères sur deux, trois ou quatre octets.
  ]

  #face-a-face(
    panneau("Quatre caractères")[
      #tableau(
        columns: (auto, auto, 1fr),
        align: (center + horizon, left + horizon, left + horizon),
        [Caractère], [ASCII], [UTF-8],
        [`a`], [`61`], [`61`],
        [`é`], [—], [`c3 a9`],
        [`œ`], [—], [`c5 93`],
        [`😀`], [—], [`f0 9f 98 80`],
      )
    ],
    panneau("Un mot, avec et sans ligature")[
      #tableau(
        columns: (auto, auto, 1fr),
        align: (left + horizon, center + horizon, left + horizon),
        [Mot], [`len`], [UTF-8],
        [`œuf`], [3], [`c5 93 75 66`, 4 octets],
        [`oeuf`], [4], [`6f 65 75 66`, 4 octets],
      )
    ],
  )

  #v(0.3em)
  #code-commente(
    taille-code: 12.5pt, taille-texte: 12pt,
    ("\"œuf\".encode(\"utf-8\").hex(\" \")", "les octets : `len` compte les caractères, `encode` les octets"),
    ("\"œ\".encode(\"ascii\")", "`UnicodeEncodeError` : pas de code ASCII pour `œ`"),
  )

  #legende[
    `œ` manque aussi en ISO 8859-1, l'encodage des textes français avant
    UTF-8 : d'où « oeuf » dans les fichiers anciens.
  ]

  #notes[
    Section 7 : la boucle sur les quatre caractères est à compléter ; `len`
    vaut 1 quatre fois, les octets vont de un à quatre. C'est la réponse au
    `Ã©` de la partie texte : `é` écrit en deux octets UTF-8, relus en
    cp1252, donne deux caractères.

    UTF-8 est ce qu'on écrit dans `encoding=`. Les autres encodages
    existent ; ne pas les détailler.
  ]
]

// --------------------------------------------
#d("Des noms de lieux", cellule: 7)[
  #annonce[
    Des noms de communes portent des caractères hors ASCII. Pour les écrire
    tels quels sur une carte, le fichier qui les porte est en UTF-8, et le
    programme qui le lit écrit `encoding="utf-8"`.
  ]

  #tableau(
    columns: (1.3fr, auto, 1fr, auto),
    align: (left + horizon, center + horizon, left + horizon, right + horizon),
    [Commune], [Lettre], [Ce qu'un fichier ASCII peut écrire], [Octets UTF-8],
    [Œuilly (Aisne ; Marne)], [`Œ`], [Oeuilly], [7 pour 6 caractères],
    [Plœuc-L'Hermitage (Côtes-d'Armor)], [`œ`], [Ploeuc-L'Hermitage], [18 pour 17],
    [L'Haÿ-les-Roses (Val-de-Marne)], [`ÿ`], [L'Hay-les-Roses], [16 pour 15],
    [Aÿ-Champagne (Marne)], [`ÿ`], [Ay-Champagne], [13 pour 12],
  )

  #legende[
    La dernière cellule du notebook compte, pour chaque nom, les caractères
    et les octets.
  ]

  #notes[
    Le lien avec le métier : les toponymes sont des données, et ils passent
    par des fichiers. Un CSV de communes lu sans `encoding="utf-8"` sur un
    poste Windows donne « PlÅ“uc » ; le même écrit en ASCII a perdu la
    lettre. Les deux erreurs se voient sur la carte.
  ]
]
