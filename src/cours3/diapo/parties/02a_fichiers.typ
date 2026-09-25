// Partie 2 du cours 3, première moitié — lire et écrire des fichiers texte.
//
// Incluse par `cours3.typ`. Se joue notebook ouvert et suit l'ordre de
// `fichiers.ipynb` (TD 2a), qui explique comment le code de la recette
// ouvre, lit et écrit ses fichiers texte. Chaque diapositive porte, par
// `cellule:`, la section à exécuter à ce moment. La seconde moitié de la
// partie, sur les images, est dans `02b_images.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

// L'ouverture de la partie est commune au TD qui l'accompagne : voir
// `separateur-cours-td` dans `cours3.typ`.

// --------------------------------------------
#d("Ouvrir, lire, fermer", cellule: 1, fichier: "fichiers.ipynb")[
  #annonce[
    `open` ouvre le fichier et renvoie un objet qui permet de le lire. La
    méthode `read()` de cet objet renvoie le contenu du fichier. Ici, l'objet
    est nommé `fichier_ouvert` et le contenu lu `texte`.
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

    `\n` est un caractère comme les autres ; `print` l'affiche comme un saut
    de ligne, `repr` l'écrit `\n`. Sous Windows, les fichiers ont souvent `\r\n` ;
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
    Le deuxième argument d'`open` indique le mode d'ouverture du fichier.
    Par défaut, le fichier est ouvert en lecture seule (mode `"r"`).
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
    `read()` et `readlines()` lisent tout le fichier en une fois. On peut
    aussi lire le fichier ligne par ligne avec une boucle `for` : une ligne
    est lue à chaque itération. Pour un gros fichier, cela évite de
    charger tout le contenu en mémoire.
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
// Les sections 5 (CSV) et 6 (raccourcis de pathlib) du notebook se lisent
// après la séance : une seule diapositive en donne le contenu. Les deux
// diapositives qui les détaillaient sont dans l'historique git
// (syllabus v1.5, 24/09/2026).
#d("À lire après la séance : § 5 et 6")[
  #annonce[
    Les deux dernières sections de `fichiers.ipynb` se lisent et s'exécutent
    après la séance. `images.ipynb` et le TD 3a emploient les méthodes de la
    section 6.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [Section], [Contenu], [Ce qui sert ensuite],
    [§ 5 · Le CSV], [découper une ligne aux virgules avec `split`, puis avec la bibliothèque `csv`], [`lire_ingredients` de la recette],
    [§ 6 · Les raccourcis de `pathlib`], [`read_text`, `write_text`, `read_bytes` : ouvrir, lire ou écrire tout le fichier, fermer, en une ligne], [`images.ipynb` (§ 1 et 2) ; le TD 3a],
  )

  #v(0.3em)
  #code-commente(
    ("texte = chemin.read_text(encoding=\"utf-8\")", "le même résultat que `with open(...)` puis `read()`"),
    ("octets = chemin.read_bytes()", "les octets du fichier, sans décodage"),
  )

  #notes[
    Allègement de 2026 (syllabus v1.5) : ces deux sections ne sont plus
    exécutées pendant l'exposé.
    `read_text` et `read_bytes` apparaissent dès la section 1 d'`images.ipynb` :
    montrer ces deux lignes avant de passer au TD 2b.
  ]
]
