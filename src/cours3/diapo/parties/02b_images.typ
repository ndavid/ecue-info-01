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
#d("Lire un fichier octet par octet", cellule: 3)[
  #annonce[
    Un éditeur hexadécimal affiche trois colonnes : la position, les octets,
    et le caractère quand il y en a un. Six lignes de Python font la même
    chose.
  ]

  ```python
  def hexdump(chemin, n=32, largeur=16):
      donnees = Path(chemin).read_bytes()[:n]
      for debut in range(0, len(donnees), largeur):
          tranche = donnees[debut:debut + largeur]
          texte = "".join(chr(o) if 32 <= o < 127 else "." for o in tranche)
          print(f"{debut:04x}  {tranche.hex(' '):<{largeur * 3}} {texte}")
  ```

  #sortie("0000  50 35 0a 34 20 34 0a 32 35 35 0a 00 ff 00 ff ff  P5.4 4.255......\n0010  00 ff 00 00 ff 00 ff ff 00 ff 00                 ...........", taille: 12.5pt)

  #legende[
    Sans Python : `Format-Hex fichier` dans PowerShell ; l'extension
    « Hex Editor » de VS Code.
  ]

  #notes[
    La fonction est à écrire, ligne à ligne, depuis la diapositive. 

    `32 <= o < 127` : les codes ASCII affichables. 

    Section 3, seconde cellule : `hexdump(motif)` sur la version texte. Tout
    est affichable, à droite on relit le fichier.
  ]
]

// --------------------------------------------
#d("Les premiers octets identifient le format", cellule: 4)[
  #annonce[
    Chaque format commence par une signature. L'extension la rappelle ; le
    programme qui ouvre le fichier lit la signature.
  ]

  #tableau(
    columns: (auto, auto, 1fr, auto),
    align: left + horizon,
    [Hexadécimal], [ASCII], [Format], [Vu au cours],
    [`50 35`], [`P5`], [PGM binaire ; `P2` en texte, `P3` et `P6` en couleur], [aujourd'hui],
    [`42 4d`], [`BM`], [BMP, l'image de Windows, un octet par valeur], [aujourd'hui],
    [`89 50 4e 47`], [`.PNG`], [PNG, compressé sans perte], [aujourd'hui],
    [`ff d8 ff`], [`...`], [JPEG, compressé avec perte], [aujourd'hui],
    [`50 4b 03 04`], [`PK..`], [ZIP, donc aussi `.odt`, `.docx`, `.xlsx`], [TD 1b],
    [`25 50 44 46`], [`%PDF`], [PDF], [cours 1],
    [`4d 5a`], [`MZ`], [un exécutable Windows, `python.exe` compris], [cours 1],
  )

  #notes[
    Dans la colonne ASCII, un point remplace un octet qui n'est pas un
    caractère affichable, comme dans la fonction `hexdump`.

    Section 4 : les élèves écrivent les deux `save` (BMP, PNG) sur le
    modèle de la section 2. La boucle `glob` qui affiche les tailles est
    donnée, puis `hexdump` sur chaque fichier. Les deux signatures sont sur
    la première ligne.

    La ligne ZIP : `.odt` était l'archive du TD 1b, `.docx` en est une
    aussi. Le `.ipynb` n'en est pas une, c'est du JSON, du texte ; le dire si
    quelqu'un le teste.

    `MZ` : `Path(sys.executable).read_bytes()[:2]` le montre, pour qui a le
    temps. Le fichier exécuté est binaire, disait le cours 1 ; le voici.
  ]
]

// --------------------------------------------
#d("Le poids d'une image PGM", cellule: 5)[
  #annonce[
    *La Grande Vague*, 2 000 × 1 344 pixels en niveaux de gris, enregistrée
    en `P5`, en `P2` et en BMP. La taille d'un fichier non compressé se
    calcule : largeur × hauteur × octets par valeur, plus l'en-tête.
  ]

  #tableau(
    columns: (auto, 1fr, auto, auto),
    align: (left + horizon, left + horizon, right + horizon, right + horizon),
    [Fichier], [Calcul], [Octets], [Par pixel],
    [`vague.pgm`, `P5`], [2 000 × 1 344 × 1 octet + 17 octets d'en-tête], [2 688 017], [1,00],
    [`vague.bmp`], [2 000 × 1 344 × 1 octet + 1 078 octets d'en-tête et de palette], [2 689 078], [1,00],
    [`vague_texte.pgm`, `P2`], [un pixel = 1 à 3 chiffres + 1 séparateur = 2 à 4 octets], [10 249 573], [3,81],
  )

  #legende[
    Une image en couleur a trois valeurs par pixel : trois octets par pixel
    en binaire. Les tailles varient d'un poste à l'autre pour le JPEG de
    départ, pas les rapports.
  ]

  #notes[
    Section 5 : `convert("L")` et le premier `save` sont donnés ; les
    élèves écrivent les `save` en PNG et en BMP sur ce modèle. Le JPEG
    (`quality=85`) est donné. La cellule qui écrit la version texte est
    donnée, à exécuter et à lire : c'est la seule qui écrive un fichier
    d'image sans Pillow.

    La ligne `entete = …` est donnée. Les élèves écrivent le calcul
    `largeur * hauteur * 1 + len(entete)` et le comparent à
    `stat().st_size`.

    3,81 octets par pixel en texte : la moyenne des valeurs a trois chiffres,
    plus l'espace. Un pixel à 7 en prendrait deux.
  ]
]

// --------------------------------------------
#d("La compression", cellule: 5)[
  #annonce[
    Compresser, c'est écrire une répétition une fois, avec le nombre de fois,
    au lieu de répéter la valeur. PNG compresse sans perte : les pixels relus
    sont ceux de départ. JPEG compresse avec perte.
  ]

  #face-a-face(
    panneau("Seize pixels, seize valeurs")[
      #grid(
        columns: (auto, 1fr), column-gutter: 14pt, align: horizon,
        pixels-gris((
          (0, 0, 0, 0),
          (0, 255, 255, 0),
          (0, 255, 255, 0),
          (0, 0, 0, 0),
        ), cote: 16pt),
        [
          #set text(size: 13pt)
          `0 0 0 0 0 255 255 0 0 255 255 0 0 0 0 0`

          #v(0.3em)
          Compressé, dix nombres :\
          `5×0  2×255  2×0  2×255  5×0`

          #v(0.3em)
          Ou, la ligne 3 recopiant la ligne 2 :\
          `5×0  2×255  2×0  « les 4 d'avant »  4×0`
        ],
      )
    ],
    panneau("La Vague, 2 688 000 pixels")[
      #tableau(
        columns: (auto, auto, 1fr),
        align: (left + horizon, right + horizon, left + horizon),
        [Fichier], [Octets], [],
        [`vague.pgm`], [2 688 017], [brut],
        [`vague.png`], [1 840 096], [sans perte],
        [`vague.jpg`], [779 252], [avec perte, qualité 85],
      )
    ],
  )

  #legende[
    PNG emploie l'algorithme des fichiers ZIP, deflate ; `zlib.compress` sur
    les pixels bruts donne 2 199 594 octets. PNG fait moins parce qu'il écrit
    d'abord chaque ligne en différences avec la voisine.
  ]

  #notes[
    La cellule `zlib.compress(donnees)` est dans la section 5, après le
    calcul de taille. Le principe à faire passer : une valeur répétée, ou
    une suite déjà vue, s'écrit une fois. Le nom deflate et LZ77 ne sont pas
    à retenir.

    JPEG : le taux dépend de l'image et de la qualité demandée, 85 ici. Ce
    chiffre bouge d'une image à l'autre ; les autres, non.
  ]
]

// --------------------------------------------
#d("Le temps de lecture", cellule: 6)[
  #annonce[
    `%timeit` chronomètre une cellule. Lire les pixels depuis le fichier
    texte prend mille fois plus longtemps que depuis le binaire.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: (left + horizon, right + horizon, left + horizon),
    [Fichier], [`Image.open(…).load()`], [Ce que Pillow fait pour lire les pixels],
    [`vague_texte.pgm`], [1 270 ms], [lire 2,7 millions de nombres écrits en chiffres et les convertir en entiers],
    [`vague.pgm`], [0,4 ms], [copier 2,7 millions d'octets : chaque octet est la valeur d'un pixel, sans conversion],
    [`vague.png`], [31 ms], [décompresser les pixels (algorithme deflate, sans perte)],
    [`vague.jpg`], [11 ms], [décompresser les pixels (algorithme JPEG, avec perte)],
  )

  #legende[
    Mesures sur un poste ; sur un autre les valeurs changent, pas leurs
    rapports. Relancer la même cellule donne un temps plus court : le
    système garde en mémoire ce qu'il vient de lire.
  ]

  #notes[
    Quatre cellules `%timeit -r 3 -n 1`, une par fichier. La lecture du
    texte prend plus d'une seconde ; celle du binaire, moins d'une
    milliseconde.

    En texte, la valeur 255 est écrite avec trois caractères, `2`, `5` et
    `5`, que Pillow lit puis convertit en entier. En binaire, elle est
    écrite dans un seul octet, `ff`, qui est directement l'entier 255.

    PNG et JPEG : plus petits sur le disque, plus longs à relire que le
    binaire brut, parce qu'il faut calculer les pixels. Le choix d'un format
    est un compromis entre place et temps ; le cours 5 y revient avec les
    ordres de grandeur.

    Le cache, en légende : à mentionner, pas à développer. Le premier
    `%timeit` lit sur le disque, les suivants en mémoire.
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
