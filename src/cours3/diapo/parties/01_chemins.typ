// Partie 1 du cours 3 — les chemins, en Python.
//
// Incluse par `cours3.typ`. Se joue notebook ouvert et suit l'ordre du
// notebook `recette.ipynb` du TD 1a : chaque diapositive porte, par
// `cellule:`, la section à exécuter à ce moment. 
// 
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

// L'ouverture de la partie est commune au TD qui l'accompagne : voir
// `separateur-cours-td` dans `cours3.typ`.

// --------------------------------------------
#d("Le code brut, chemins en dur", cellule: "1 et 2")[
  #annonce[
    Le programme de création de recette, avec des chemins écrits en dur : il
    ne fonctionne que sur un poste. Les fonctions utiles du bloc 1 sont
    utilisées sans détailler leur code, vu dans le second notebook.
  ]

  #code-commente(
    taille-code: 12pt, taille-texte: 12pt,
    ("ingredients = lire_ingredients(\"C:/Users/alice/…/ingredients.csv\")", "lit le CSV"),
    ("ingredients = adapter(ingredients, 4, \"SI\")", "4 personnes, SI"),
    ("with open(\"C:/Users/alice/…/recette.md\", encoding=\"utf-8\") as fichier:", "ouvre la recette"),
    ("    source = fichier.read()", "tout son texte"),
    ("complete = source.replace(\"## Ingrédients\",\n    \"## Ingrédients\\n\\n\" + tableau(ingredients))", "insère le tableau"),
    ("with open(\"C:/Users/alice/…/crepes.md\", \"w\", encoding=\"utf-8\") as fichier:", "ouvre la sortie"),
    ("    fichier.write(complete)", "l'écrit"),
  )

  #avertissement[
    Ces chemins correspondent à ceux d'un poste spécifique. 
    Sur un autre, ou après un déplacement du dossier, les trois lignes sont donc à adapter.
  ]

  #notes[
    Faire exécuter le premier bloc du notebook : on doit obtenir une erreur `FileNotFoundError` sur le premier chemin. 
    Puis faire modifier le deuxième bloc (identique au premier), où chacun adapte avec les chemins de son poste. 
    Ceux-ci sont lus dans la barre d'adresse de l'explorateur, mais il faut remplacer les `\` des chemins windows avec des `/` pour respecter les conventions de python. 
    Le code doit fonctionner (ne pas envoyer d'erreur), mais ne fonctionne toujours que sur un poste.
  ]
]

// --------------------------------------------
#d("Lire le fichier CSV")[
  #annonce[
    `ingredients.csv` donne les quantités pour une personne, une ligne par
    ingrédient. `lire_ingredients` lit le fichier et renvoie une liste
    Python : un tuple (nom, quantité, unité) par ligne.
  ]

  #face-a-face(
    panneau("recettes/crepes/ingredients.csv")[
      #sortie("ingredient,quantite,unite\nFarine,60,g\nLait,125,ml\nŒufs,1,\nSel,1,g\nBeurre fondu,12,g", taille: 12pt)
    ],
    panneau("lire_ingredients(…) renvoie")[
      #sortie("[('Farine', 60.0, 'g'),\n ('Lait', 125.0, 'ml'),\n ('Œufs', 1.0, ''),\n ('Sel', 1.0, 'g'),\n ('Beurre fondu', 12.0, 'g')]", taille: 12pt)
    ],
  )

  #legende[
    La première ligne du fichier, le nom des colonnes, n'est pas dans la
    liste. `float` convertit chaque quantité, lue comme du texte, en nombre.
  ]
]

// --------------------------------------------
#d("Adapter les quantités, écrire le tableau")[
  #annonce[
    `adapter` multiplie chaque quantité par le nombre de personnes ; en
    unités US, il convertit les grammes en onces et les millilitres en
    tasses. `tableau` écrit la liste sous forme de tableau Markdown.
  ]

  #face-a-face(
    panneau("adapter(ingredients, 4, \"US\") renvoie")[
      #sortie("[('Farine', 8.4657…, 'oz'),\n ('Lait', 2.1133…, 'cup'),\n ('Œufs', 4.0, ''),\n ('Sel', 0.1410…, 'oz'),\n ('Beurre fondu', 1.6931…, 'oz')]", taille: 12pt)
    ],
    panneau("tableau(…) renvoie")[
      #sortie("| Ingrédient | Quantité |\n|---|---|\n| Farine | 8.47 oz |\n| Lait | 2.11 cup |\n| Œufs | 4 |\n| Sel | 0.141 oz |\n| Beurre fondu | 1.69 oz |", taille: 12pt)
    ],
  )

  #legende[
    En unités SI, pour quatre personnes : 240 g de farine, 500 ml de lait.
    `tableau` écrit chaque quantité avec trois chiffres significatifs.
  ]

  #notes[
    Les facteurs de conversion sont dans le dictionnaire `FACTEURS` :
    28,3495 g pour une once, 236,588 ml pour une tasse (cup). Les œufs,
    sans unité, ne sont pas convertis.
  ]
]

// --------------------------------------------
#d("Insérer le tableau dans la recette")[
  #annonce[
    Dans `recette.md`, le titre `## Ingrédients` n'est suivi d'aucune ligne.
    `replace` le remplace par le même titre suivi du tableau. Le texte obtenu
    est écrit dans `travail/crepes.md`.
  ]

  #grid(
    columns: (1fr, auto, 1fr, auto, 1.1fr),
    column-gutter: 8pt,
    align: top,
    panneau("recette.md")[
      #sortie("# Crêpes\n\n## Ingrédients\n\n## Préparation", taille: 10.5pt)
    ],
    pad(top: 58pt, text(size: 20pt, fill: accent)[+]),
    panneau("tableau(…)")[
      #sortie("| Ingrédient | Quantité |\n|---|---|\n| Farine | 240 g |\n| Lait | 500 ml |\n| …", taille: 10.5pt)
    ],
    pad(top: 58pt, text(size: 20pt, fill: accent)[→]),
    panneau("travail/crepes.md")[
      #sortie("# Crêpes\n\n## Ingrédients\n\n| Ingrédient | Quantité |\n|---|---|\n| Farine | 240 g |\n| …\n\n## Préparation", taille: 10.5pt)
    ],
  )

  #v(0.2em)
  #code-commente(
    taille-code: 11.5pt, taille-texte: 11.5pt,
    ("complete = source.replace(\"## Ingrédients\", \"## Ingrédients\\n\\n\" + tableau(ingredients))", "le titre, une ligne vide, le tableau"),
  )
]

// --------------------------------------------
#d("Les chemins à déclarer", cellule: "3.1 et 3.2")[
  #annonce[
    Le code s'améliore en deux étapes : 
      + utiliser des variables pour les chemins de fichier (python pur). 
      + déduire l'ensemble des chemins à partir d'une seule variable : dossier racine avec `pathlib`.
  ]

  #sortie("1a_recette/                      ← RACINE\n├── depart/\n│   └── recettes/\n│       └── crepes/              ← RECETTE\n│           ├── ingredients.csv  ← FICHIER_INGREDIENTS\n│           └── recette.md       ← FICHIER_RECETTE\n└── travail/                     ← dossier courant\n    ├── recette.ipynb            ← le notebook\n    └── crepes.md                ← FICHIER_SORTIE", taille: 12.5pt)

  #legende[
    Seule la racine est écrite en dur ; les quatre autres chemins sont
    construits à partir d'elle, en suivant l'arborescence.
  ]
]

// --------------------------------------------
#d("pathlib pour déclarer des chemins", cellule: "3.2")[
  #code-commente(
    ("from pathlib import Path", "importe `Path`, la classe des chemins"),
    ("", ""),
    ("RACINE = Path(\"C:/Users/alice/…/1a_recette\")", "la racine, seule valeur écrite en dur"),
    ("RECETTE = RACINE / \"depart\" / \"recettes\" / \"crepes\"", "`/` ajoute un dossier au chemin"),
    ("FICHIER_INGREDIENTS = RECETTE / \"ingredients.csv\"", "le CSV"),
    ("FICHIER_RECETTE = RECETTE / \"recette.md\"", "la recette"),
    ("FICHIER_SORTIE = RACINE / \"travail\" / \"crepes.md\"", "le fichier produit"),
    ("", ""),
    ("ingredients = lire_ingredients(FICHIER_INGREDIENTS)", "le code utilise les variables"),
  )

  #legende[
    Documentation : docs.python.org/fr/3/library/pathlib.html.
  ]

  #notes[
    Un chemin déclaré n'est pas vérifié.

    `pathlib` fait partie de la bibliothèque standard, livrée avec Python,
    comme `csv` : l'import est la seule chose à écrire pour disposer de
    `Path`. 
    `/` entre un `Path` et une chaîne, c'est un opérateur python fourni pas `Pathlib` comme `+` ou `*` pour opérations de math. 
    le chemin s'écrit avec des `/` quel que soit le système, et s'affiche avec des `\` sous Windows.
  ]
]

// --------------------------------------------
#d("La racine, lue automatiquement", cellule: "3.3")[
  #annonce[
    Python connaît le dossier courant, celui d'où partent les chemins
    relatifs. Dans un notebook, c'est le dossier du fichier `.ipynb`, ici
    `travail/` ; la racine du TD est le dossier au-dessus.
  ]

  #code-commente(
    ("Path.cwd()", "le dossier courant : `…/1a_recette/travail`"),
    ("sys.executable", "l'interpréteur Python, ailleurs"),
    ("(Path.cwd() / \"recette.ipynb\").exists()", "`True` : le notebook est bien dans le dossier courant"),
    ("", ""),
    ("Path.cwd().parent", "le dossier au-dessus, en absolu : la racine du TD"),
    ("Path(\"..\") / \"depart\" / \"recettes\"", "le même endroit en relatif, affiché tel qu'écrit : `../depart/recettes`"),
    ("(Path(\"..\") / \"depart\" / \"recettes\").resolve()", "`resolve()` le colle au dossier courant : le chemin absolu"),
    ("", ""),
    ("RACINE = Path.cwd().parent", "plus rien n'est écrit en dur"),
  )

  #notes[
    Le serveur Jupyter démarre le noyau dans le dossier du notebook : c'est
    pour cela que `Path.cwd()` vaut `travail/`, et non le dossier de
    l'interpréteur. `exists()` le fait constater.

    `..` et `parent` désignent le même dossier ; le premier reste relatif
    tant qu'on ne demande pas `resolve()`. Les deux formes s'affichent l'une
    sous l'autre dans le notebook.

    Un script, lui, part du dossier du terminal : c'est le TD 3a.
  ]
]

// --------------------------------------------
#d("Plusieurs recettes : lister un dossier", cellule: "3.4")[
  #annonce[
    Le code actuel ne traite qu'une recette : `crepes`.\
    `depart/recettes/` contient quatre dossiers de recette construits de façon identique : le programme les parcourt, et nomme chaque sortie d'après le nom du dossier.
  ]

  #sortie("1a_recette/                      ← RACINE\n├── depart/\n│   └── recettes/                ← RECETTES\n│       ├── crepes/              ← dossier, à la première itération\n│       │   ├── ingredients.csv\n│       │   └── recette.md\n│       ├── …\n│       └── salade_lentilles/    ← dossier, à la dernière itération\n│           ├── ingredients.csv\n│           └── recette.md\n└── travail/                     ← dossier courant\n    ├── recette.ipynb            ← le notebook\n    ├── crepes.md                ← fichier produit à la première itération\n    ├── …\n    └── salade_lentilles.md      ← fichier produit à la dernière itération", taille: 11pt)
]

// --------------------------------------------
#d("Plusieurs recettes : lister un dossier", cellule: "3.4")[
  #code-commente(
    ("RECETTES = RACINE / \"depart\" / \"recettes\"", "le dossier des recettes"),
    ("for dossier in sorted(RECETTES.iterdir()):", "chaque entrée du dossier, triée"),
    ("    if dossier.is_dir():", "seulement les dossiers"),
    ("        dossier.name", "le nom seul : `crepes`"),
    ("        dossier / \"ingredients.csv\"", "le CSV de cette recette"),
    ("        (RACINE / \"travail\" / dossier.name).with_suffix(\".md\")", "le fichier produit : `crepes.md`"),
    ("        (dossier / \"ingredients.csv\").exists()", "`True` si le fichier est là"),
  )

  #notes[
    `iterdir()` renvoie les entrées sans ordre garanti, d'où `sorted`.
    `is_dir()` écarte un fichier qui traînerait dans `recettes/`, comme
    `CREDITS.md` au TD 3a.

    La dernière cellule est le programme dans la boucle : quatre fichiers
    écrits dans `travail/`. C'est l'argument `nom` du TD 3a qui arrive.
  ]
]

// --------------------------------------------
#d("Les parties d'un chemin", cellule: "3.4")[
  #annonce[
    Les attributs d'un objet `Path` renvoient les parties du chemin : le
    nom du fichier, son extension, le dossier qui le contient. Exemples avec
    `chemin = RECETTES / "crepes" / "recette.md"`.
  ]

  #code-commente(
    ("chemin.name", "le nom du fichier : `recette.md`"),
    ("chemin.stem", "le nom sans l'extension : `recette`"),
    ("chemin.suffix", "l'extension, point compris : `.md`"),
    ("chemin.parent", "le dossier qui le contient : `…/recettes/crepes`"),
    ("chemin.parent.name", "le nom de ce dossier : `crepes`"),
    ("chemin.parts", "toutes les parties du chemin, dans un tuple"),
    ("chemin.relative_to(RACINE)", "le chemin à partir de la racine : `depart/recettes/crepes/recette.md`"),
    ("", ""),
    ("chemin.with_suffix(\".html\")", "même chemin, autre extension : `…/crepes/recette.html`"),
    ("chemin.with_name(\"ingredients.csv\")", "même dossier, autre nom : `…/crepes/ingredients.csv`"),
  )

  #notes[
    Les deux dernières lignes renvoient un nouveau `Path`.

    `with_suffix` remplace l'extension si le nom en a une, l'ajoute sinon :
    `travail/crepes` devient `travail/crepes.md`. Un nom de dossier qui
    contiendrait un point, `pate.pizza`, perdrait `.pizza`
  ]
]

// --------------------------------------------
#d("pandoc dans le terminal", cellule: "4.1")[
  #annonce[
    pandoc convertit `crepes.md`, dans `travail/`, en page HTML. C'est un
    programme : il se lance dans le terminal.
  ]

  #sortie("(base) C:\\Users\\moi> cd Desktop\\cours3\\1a_recette\\travail\n(base) C:\\Users\\moi\\Desktop\\cours3\\1a_recette\\travail> pandoc crepes.md -o crepes.html", taille: 12pt)

  #v(0.4em)
  #code-commente(
    ("pandoc", "le programme"),
    ("crepes.md", "l'entrée : le fichier à lire"),
    ("-o crepes.html", "`--output`, la sortie ; le format suit l'extension"),
  )

  Depuis `cours3/`, entrée et sortie partent de ce dossier :

  #sortie("(base) C:\\Users\\moi\\Desktop\\cours3> pandoc 1a_recette\\travail\\crepes.md -o 1a_recette\\travail\\crepes.html", taille: 12pt)

  #legende[
    Documentation : pandoc.org/MANUAL.html ; exemples : pandoc.org/demos.html.
  ]

  #notes[
    `-o` est le raccourci d'`--output` ; beaucoup de programmes ont `-i`
    pour `--input`, pandoc prend l'entrée sans option.

    Depuis `cours3/`, `-o crepes.html` écrirait la page dans `cours3/`,
    pas à côté de `crepes.md` : chaque chemin part du dossier du terminal.

    Ouvrir `travail/crepes.html` par double-clic : la page, sans style.
  ]
]

// --------------------------------------------
#d("pandoc depuis le notebook : les options une à une", cellule: "4.2")[
  #annonce[
    Une cellule qui commence par `!` passe la ligne au terminal. La même
    commande, une option de plus à chaque fois.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Option ajoutée], [Ce qui change],
    [(aucune)], [un fragment : le contenu, sans `<html>` ni en-tête],
    [`--standalone`], [une page complète ; titre pris sur le nom du fichier],
    [`--metadata title=Crêpes`], [le titre de l'onglet],
    [`--css style.css`], [la feuille de style, copiée à côté de la page],
    [`--toc`], [une table des matières, sur les titres],
    [`-o crepes.docx`, `-t plain`], [Word ; texte sans balise],
    [`pandoc crepes.docx -o retour.md`], [le sens inverse],
  )

  #notes[
    Après chaque cellule, les premiers caractères du fichier produit sont
    affichés : `<h1>` pour le fragment, `<!DOCTYPE html>` pour la page. Ouvrir
    la page dans le navigateur à chaque étape.

    `--list-output-formats` : 76 formats. pandoc lit aussi la plupart
    d'entre eux.
  ]
]

// --------------------------------------------
#d("Où le terminal trouve pandoc", cellule: "4.3")[
  #annonce[
    Le terminal a lancé `pandoc` sans savoir où est le programme : il l'a
    cherché dans les dossiers de la variable `PATH`.
  ]

  #code-commente(
    ("shutil.which(\"pandoc\")", "le chemin absolu trouvé"),
    ("!\"{chemin}\" --version", "le même programme, appelé par ce chemin"),
    ("", ""),
    ("path = os.environ[\"PATH\"]", "la variable : une seule chaîne, tous les dossiers"),
    ("os.pathsep", "le séparateur : `;` sous Windows, `:` ailleurs"),
    ("dossiers = path.split(os.pathsep)", "une liste, un dossier par élément"),
    ("Path(dossier) == Path(chemin).parent", "vrai pour le dossier qui contient pandoc"),
  )

  #legende[
    Une commande « introuvable » est un programme dont le dossier n'est pas
    dans cette liste. `conda activate` modifie `PATH`.
  ]

  #notes[
    Sous Windows, conda range les programmes qui ne sont pas du Python,
    pandoc compris, dans `Library\bin` de l'environnement ; sous Linux et
    macOS dans `bin`. 
    Activer un environnement met ces dossiers en tête de `PATH` : c'est ce qui fait qu'une commande existe dans un environnement et pas dans un autre.

    `{chemin}` dans une ligne `!` : IPython y insère la variable Python.
  ]
]

// --------------------------------------------
#d("Appeler pandoc depuis Python", cellule: "4.4")[
  #annonce[
    `!` n'existe que dans un notebook. Un programme Python appelle une
    commande par la bibliothèque standard : `os.system`, ou `subprocess.run`,
    la forme à retenir.
  ]

  #code-commente(
    ("os.system(\"pandoc crepes.md -o crepes.html\")", "la ligne telle qu'on l'aurait tapée ; renvoie le code de retour, 0 si tout va bien"),
    ("", ""),
    ("subprocess.run([\"pandoc\", \"crepes.md\", \"-o\", \"crepes.html\"],", "le programme, puis chaque argument, en liste"),
    ("               check=True)", "lève une erreur Python si pandoc échoue"),
    ("", ""),
    ("resultat = subprocess.run([\"pandoc\", \"--version\"],", ""),
    ("                          capture_output=True, text=True)", "récupère l'affichage, en chaîne"),
    ("resultat.returncode", "0 : tout s'est bien passé"),
    ("resultat.stdout", "ce que pandoc a affiché"),
  )

  #legende[
    Un `Path` se passe par `str(chemin)` : la commande ne prend que des
    chaînes. C'est la forme du TD 3a.
  ]

  #notes[
    La liste plutôt qu'une chaîne : chaque élément arrive au programme tel
    quel, espaces et accents compris, sans qu'un interpréteur de commandes
    ne le découpe. `os.system` passe par cet interpréteur, et ne renvoie que le
    code de retour ; il sert à montrer que la ligne du terminal et l'appel
    depuis Python sont la même chose.
  ]
]
