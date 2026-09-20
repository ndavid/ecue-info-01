// Partie 2 du cours 3 — texte et binaire, en Python.
//
// Incluse par `cours3.typ`. Se joue notebook ouvert et suit l'ordre de deux
// notebooks : `fichiers.ipynb` (TD 1a, ouvert par le TD 2a), qui explique
// comment le code de la recette ouvre, lit et écrit ses fichiers texte, puis
// `images.ipynb` (TD 2a), qui compare texte et binaire sur des images PGM.
// Chaque diapositive porte, par `cellule:`, la section à exécuter à ce
// moment. Les nombres cités (tailles, temps) sont ceux d'une exécution
// réelle du notebook ; ils varient d'un poste à l'autre, pas leurs rapports.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

// L'ouverture de la partie est commune au TD qui l'accompagne : voir
// `separateur-cours-td` dans `cours3.typ`.

// --------------------------------------------
#d("Ouvrir, lire, fermer", cellule: 1, fichier: "fichiers.ipynb")[
  #annonce[
    `open` rend un objet fichier, avec une position de lecture ; le texte
    s'obtient en le lisant. L'objet s'appelle ici `fichier_ouvert`, le texte
    `texte`.
  ]

  #code-commente(
    taille-code: 13pt, taille-texte: 12.5pt,
    ("fichier_ouvert = open(FICHIER_RECETTE, encoding=\"utf-8\")", "ouvre : un objet fichier, position au début"),
    ("texte = fichier_ouvert.read()", "lit tout, jusqu'à la fin : une seule chaîne"),
    ("fichier_ouvert.read()", "`''` : la position est à la fin"),
    ("fichier_ouvert.close()", "ferme : le fichier est rendu au système"),
    ("fichier_ouvert.read()", "`ValueError` : fichier fermé"),
    ("", ""),
    ("repr(texte[:60])", "les caractères tels qu'ils sont : `\\n` entre les lignes"),
    ("lignes = fichier_ouvert.readlines()", "une liste : une chaîne par ligne, avec son `\\n`"),
  )

  #notes[
    Dans les fonctions utiles du cours 1, l'objet s'appelle `fichier` ; le
    nom `fichier_ouvert` est choisi ici pour ne pas le confondre avec le
    texte lu. Tant que le fichier est ouvert, il est réservé par le
    programme : sous Windows, un autre programme ne peut pas l'effacer ni le
    remplacer.

    `\n` est un caractère comme les autres ; `print` le rend par un saut de
    ligne, `repr` l'écrit. Sous Windows, les fichiers ont souvent `\r\n` ;
    `open` le traduit à la lecture (argument `newline`).
  ]
]

// --------------------------------------------
#d("with : ouvrir et fermer", cellule: 2, fichier: "fichiers.ipynb")[
  #annonce[
    Le bloc `with` ouvre le fichier à l'entrée et le ferme à la sortie, y
    compris si une erreur survient dans le bloc. C'est la forme à employer.
  ]

  #code-commente(
    ("with open(FICHIER_RECETTE, encoding=\"utf-8\") as fichier_ouvert:", "ouvert, disponible sous le nom `fichier_ouvert`"),
    ("    texte = fichier_ouvert.read()", "tout ce qui se fait fichier ouvert est indenté"),
    ("", ""),
    ("print(fichier_ouvert.closed)", "`True` : à la sortie du bloc, déjà fermé"),
  )

  #notes[
    Le `as fichier_ouvert` donne le nom ; le bloc indenté est la durée
    d'ouverture. Pas de `close()` à écrire.

    C'est la forme des fonctions utiles, `with open(chemin, …) as
    fichier:`, qu'on peut maintenant relire.
  ]
]

// --------------------------------------------
#d("Les modes d'ouverture", cellule: 3, fichier: "fichiers.ipynb")[
  #annonce[
    Le deuxième argument d'`open` dit ce qu'on va faire du fichier. Sans
    lui, c'est la lecture.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr, 1fr),
    align: left + horizon,
    [Mode], [Ce qu'il fait], [Fichier absent], [Fichier présent],
    [`"r"`], [lire (défaut)], [erreur], [lu],
    [`"w"`], [écrire], [créé], [vidé, puis réécrit],
    [`"a"`], [ajouter à la fin], [créé], [conservé, complété],
    [`"x"`], [créer et écrire], [créé], [erreur],
    [`"rb"`, `"wb"`], [octets, sans `encoding`], [], [notebook des images],
  )

  #avertissement[
    Sans `encoding="utf-8"`, Python prend l'encodage du système, `cp1252`
    sous Windows : « é » écrit en UTF-8 se lit « Ã© ».
  ]

  #notes[
    Les cellules écrivent `essai.txt` en `"w"`, le complètent en `"a"`, le
    remplacent en `"w"`, puis deux erreurs : `"r"` sur un fichier absent,
    `"x"` sur un fichier présent. La dernière force `encoding="cp1252"`
    pour montrer ce qui arrive quand on oublie l'argument.
  ]
]

// --------------------------------------------
#d("Lire ligne par ligne", cellule: 4, fichier: "fichiers.ipynb")[
  #annonce[
    `read()` et `readlines()` lisent tout le fichier d'un coup. Avec `for`,
    une ligne est lue à chaque tour de boucle ; la suivante n'est pas encore
    en mémoire.
  ]

  #code-commente(
    taille-code: 13pt, taille-texte: 12.5pt,
    ("with open(FICHIER_INGREDIENTS, encoding=\"utf-8\") as fichier_ouvert:", ""),
    ("    for ligne in fichier_ouvert:", "une ligne à la fois, avec son `\\n`"),
    ("        print(repr(ligne))", "`'nom,quantite,unite\\n'`, puis chaque ingrédient"),
    ("", ""),
    ("with open(FICHIER_RECETTE, encoding=\"utf-8\") as fichier_ouvert:", ""),
    ("    numero = 0", ""),
    ("    for ligne in fichier_ouvert:", ""),
    ("        numero = numero + 1", "compte les lignes lues"),
    ("        print(numero, ligne.strip())", "`strip()` enlève le `\\n`"),
    ("        if numero == 3:", ""),
    ("            break", "sort de la boucle : la suite n'est pas lue"),
  )

  #notes[
    La lecture ligne par ligne sert pour un fichier plus gros que la
    mémoire, ou dont on ne veut que le début. Pour un fichier de quelques
    lignes, `read()` suffit.
  ]
]

// --------------------------------------------
#d("Le CSV", cellule: 5, fichier: "fichiers.ipynb")[
  #annonce[
    Une ligne du CSV est une chaîne : elle se découpe aux virgules, à la
    main ou avec la bibliothèque `csv`.
  ]

  #code-commente(
    ("ligne.strip().split(\",\")", "sans le `\\n`, coupée aux virgules : une liste de trois chaînes"),
    ("", ""),
    ("lecteur = csv.reader(fichier_ouvert)", "le découpage fait par la bibliothèque, guillemets compris"),
    ("next(lecteur)", "la ligne d'en-tête, laissée de côté"),
    ("for nom, quantite, unite in lecteur:", "chaque ligne, déjà découpée en trois variables"),
  )

  #legende[
    C'est `lire_ingredients`, ligne à ligne. Documentation :
    docs.python.org/fr/3/library/csv.html.
  ]

  #notes[
    `split` suffit ici ; `csv` traite en plus une virgule entre guillemets,
    ce qui arrive dès qu'un champ est du texte libre.
  ]
]

// --------------------------------------------
#d("Les raccourcis de pathlib", cellule: 6, fichier: "fichiers.ipynb")[
  #annonce[
    Ouvrir, lire tout, fermer : un `Path` le fait en une ligne.
  ]

  #tableau(
    columns: (1fr, 1fr),
    align: left + horizon,
    [Avec `open`], [Avec `pathlib`],
    [`with open(chemin, encoding="utf-8") as fichier_ouvert:` #linebreak() `texte = fichier_ouvert.read()`], [`texte = chemin.read_text(encoding="utf-8")`],
    [`with open(chemin, "w", encoding="utf-8") as fichier_ouvert:` #linebreak() `fichier_ouvert.write(texte)`], [`chemin.write_text(texte, encoding="utf-8")`],
    [`with open(chemin, "rb") as fichier_ouvert:` #linebreak() `octets = fichier_ouvert.read()`], [`octets = chemin.read_bytes()`],
  )

  #legende[
    `for ligne in fichier_ouvert` garde son intérêt pour un fichier trop gros
    pour la mémoire, ou qu'on arrête de lire en route.
  ]

  #notes[
    La dernière cellule réécrit le programme de la recette avec `read_text`
    et `write_text` : deux lignes à la place de deux blocs `with`. C'est la
    forme du TD 3a.
  ]
]

// --------------------------------------------
#d("Le second notebook : images.ipynb")[
  #annonce[
    Le fichier texte est vu. Pour le comparer à un fichier binaire sur des
    données qui ne sont pas du texte (des nombres, pas des phrases), la
    suite prend des images au format PGM, qui existe dans les deux variantes.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [panneau de gauche de JupyterLab : remonter jusqu'à `cours3/`, entrer dans `2a_images/`],
      reponse[`images.ipynb`, `depart/`, `travail/` vide],
    [2], [double-cliquer sur `images.ipynb`],
      reponse[un troisième onglet ; les deux premiers restent ouverts],
    [3], [ouvrir aussi `depart/motif.pgm` par un double-clic dans le panneau],
      reponse[JupyterLab l'ouvre comme un fichier texte : c'en est un],
  )

  #legende[
    `depart/` contient trois images : le motif de seize pixels, *La Grande
    Vague* de Hokusai, et un émoji. Tout ce que le notebook fabrique va dans
    `travail/`.
  ]

  #notes[
    L'étape 3 montre un fichier d'image qui s'ouvre comme du texte. La
    diapositive suivante dit ce qu'il contient.

    Les images sont libres : Twemoji est en CC BY, la Vague vient du
    Metropolitan Museum en CC0. `depart/CREDITS.md` le dit.
  ]
]

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
    Ne pas ouvrir le notebook pour cette diapositive : elle dit ce que les
    deux sections suivantes font constater. Le choix du format : rien à
    décompresser, l'en-tête se lit, et Pillow lit et écrit les deux
    variantes.
  ]
]

// --------------------------------------------
#d("Un fichier texte qui est une image", cellule: 1, fichier: "images.ipynb")[
  #annonce[
    `depart/motif.pgm` est en `P2`. Lu par `read_text`, c'est du texte ;
    ouvert par Pillow, c'est une image de 4 × 4 pixels.
  ]

  #code-commente(
    taille-code: 13pt, taille-texte: 12.5pt,
    ("motif = Path(\"depart/motif.pgm\")", "le chemin du fichier"),
    ("print(motif.read_text())", "lu comme du texte : l'en-tête et seize nombres"),
    ("image = Image.open(motif)", "lu par Pillow : une image ; `size` `(4, 4)`, `mode` `'L'`, gris"),
    ("image.resize((160, 160), Image.NEAREST)", "agrandie 40 fois, sans lissage"),
  )

  #v(0.3em)
  #face-a-face(
    panneau("depart/motif.pgm, 59 octets")[
      #sortie("P2\n4 4\n255\n0 255 0 255\n255 0 255 0\n0 255 0 255\n255 0 255 0", taille: 10.5pt)
    ],
    panneau("Ce que Pillow en affiche, agrandi")[
      #align(center, pixels-gris((
        (0, 255, 0, 255),
        (255, 0, 255, 0),
        (0, 255, 0, 255),
        (255, 0, 255, 0),
      ), cote: 18pt))
    ],
  )

  #notes[
    Section 1 : `read_text()` d'abord, `Image.open` ensuite. Le même fichier
    lu par deux programmes : l'un y voit des caractères, l'autre une image.

    La cellule à compléter : `resize((160, 160), Image.NEAREST)`. Sans
    `NEAREST`, Pillow lisse et les seize pixels deviennent un dégradé.
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
    La fonction est à écrire, ligne à ligne, depuis la diapositive. Ce
    qu'elle apprend : un fichier est une suite d'octets, et n'importe lequel
    se lit ainsi, image, PDF, exécutable.

    `32 <= o < 127` : les codes ASCII affichables. Le point remplace le
    reste, comme dans tout éditeur hexadécimal.

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
    columns: (auto, 1fr, auto),
    align: left + horizon,
    [Premiers octets], [Format], [Vu au cours],
    [`50 35` · `P5`], [PGM binaire ; `P2` en texte, `P3` et `P6` en couleur], [aujourd'hui],
    [`42 4d` · `BM`], [BMP, l'image de Windows, un octet par valeur], [aujourd'hui],
    [`89 50 4e 47` · `.PNG`], [PNG, compressé sans perte], [aujourd'hui],
    [`ff d8 ff`], [JPEG, compressé avec perte], [aujourd'hui],
    [`50 4b 03 04` · `PK`], [ZIP, donc aussi `.odt`, `.docx`, `.xlsx`], [TD 1b],
    [`25 50 44 46` · `%PDF`], [PDF], [cours 1],
    [`4d 5a` · `MZ`], [un exécutable Windows, `python.exe` compris], [cours 1],
  )

  #notes[
    Section 4 : le motif enregistré en BMP et en PNG, puis `hexdump` sur
    chacun. Les deux signatures sont sur la première ligne.

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
    Section 5 : la conversion en gris et les quatre `save` sont une cellule à
    compléter ; la version texte est une boucle à écrire, l'en-tête puis une
    ligne de nombres par ligne de pixels. C'est la plus longue cellule du
    notebook, et la seule qui écrive un fichier d'image sans Pillow.

    La cellule suivante fait le calcul : `largeur * hauteur * 1 +
    len(entete)`, et compare à `stat().st_size`.

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
    [Fichier], [`Image.open(…).load()`], [Ce que le programme fait],
    [`vague_texte.pgm`], [1 270 ms], [reconnaître et convertir 2,7 millions de nombres écrits en chiffres],
    [`vague.pgm`], [0,4 ms], [copier 2,7 millions d'octets : chacun est déjà la valeur],
    [`vague.png`], [31 ms], [décompresser],
    [`vague.jpg`], [11 ms], [décompresser, avec un calcul différent],
  )

  #legende[
    Mesures sur un poste ; sur un autre les valeurs changent, pas leurs
    rapports. Relancer la même cellule donne un temps plus court : le
    système garde en mémoire ce qu'il vient de lire.
  ]

  #notes[
    Quatre cellules `%timeit -r 3 -n 1`, une par fichier. Le texte prend
    plus d'une seconde, sensible à l'œil ; le binaire est instantané.

    L'explication tient en une phrase par ligne, celle de la troisième
    colonne. En texte, `255` est trois caractères à lire, à reconnaître
    comme un nombre, à convertir ; en binaire, `ff` est déjà le nombre.

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
