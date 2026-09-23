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
    Le programme de création de recette "chemin en dur". (contre) exemple de code : non portable et difficile à adapter. 
    Les fonctions utiles du bloc 1 seront vu plus tard en détail.
    Pour l'instant on va se concentrer sur comment améliorer la gestion de chemins de fichier.
  ]

  #code-commente(
    taille-code: 12.5pt,
    ("ingredients = lire_ingredients(\"C:/Users/alice/…/ingredients.csv\")", "lit le CSV"),
    ("ingredients = adapter(ingredients, 4, \"SI\")", "quatre personnes, unités SI"),
    ("with open(\"C:/Users/alice/…/recette.md\", encoding=\"utf-8\") as fichier:", "ouvre la recette"),
    ("    source = fichier.read()", "tout son texte"),
    ("complete = source.replace(\"## Ingrédients\",\n    \"## Ingrédients\\n\\n\" + tableau(ingredients))", "insère le tableau"),
    ("with open(\"C:/Users/alice/…/crepes.md\", \"w\", encoding=\"utf-8\") as fichier:", "ouvre la sortie, en écriture"),
    ("    fichier.write(complete)", "l'écrit"),
  )

  #avertissement[
    Ces chemins correspondent à ceux d'un poste spécifique. 
    Sur un autre, ou après un déplacement du dossier, les trois lignes sont donc à adapter.
  ]

  #notes[
    Faire exécuter le prmeier bloc du notebook : on doit obtenir une erreur `FileNotFoundError` sur le premier chemin. 
    Puis faire modifier le deuxième bloc (identique au premier), où chacun adapte avec les chemins de son poste. 
    Ceux-ci sont lus dans la barre d'adresse de l'explorateur, mais il faut remplacer les `\` des chemins windows avec des `/` pour respecter les conventions de python. 
    Le code doit fonctionner (ne pas envoyer d'erreur), mais ne fonctionne toujours que sur un poste.
  ]
]

// --------------------------------------------
#d("pathlib pour déclarer des chemins", cellule: "3.1 et 3.2")[
  #annonce[
    Le code s'améliore en deux étapes : 
      + utiliser des variables pour les chemins de fichier (python pur). 
      + déduire l'ensemble des chemins à partir d'une seule variable : dossier racine avec `pathlib`.
  ]

  #code-commente(
    ("from pathlib import Path", "importe `Path`, la classe qui représente un chemin"),
    ("", ""),
    ("RACINE = Path(\"C:/Users/alice/…/1a_recette\")", "déclare la racine : la seule valeur restante écrite en dur"),
    ("RECETTE = RACINE / \"depart\" / \"recettes\" / \"crepes\"", "`/` ajoute un dossier ou un fichier au chemin"),
    ("FICHIER_INGREDIENTS = RECETTE / \"ingredients.csv\"", "le CSV"),
    ("FICHIER_RECETTE = RECETTE / \"recette.md\"", "la recette"),
    ("FICHIER_SORTIE = RACINE / \"travail\" / \"crepes.md\"", "le fichier produit"),
    ("", ""),
    ("ingredients = lire_ingredients(FICHIER_INGREDIENTS)", "le code, avec les variables à la place des chemins"),
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
    Le code traite `crepes`. `depart/recettes/` contient quatre dossiers
    construits de façon identique : le programme les parcourt, et nomme chaque sortie
    d'après le dossier.
  ]

  #code-commente(
    ("RECETTES = RACINE / \"depart\" / \"recettes\"", "le dossier des recettes"),
    ("for dossier in sorted(RECETTES.iterdir()):", "chaque entrée du dossier, triée"),
    ("    if dossier.is_dir():", "seulement les dossiers"),
    ("        dossier.name", "le nom seul : `crepes`"),
    ("        dossier / \"ingredients.csv\"", "le CSV de cette recette"),
    ("        (RACINE / \"travail\" / dossier.name).with_suffix(\".md\")", "le fichier produit, nommé d'après le dossier"),
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
    Un `Path` donne ses morceaux sans découper de chaîne. Exemple sur
    `chemin = RECETTES / "crepes" / "recette.md"`.
  ]

  #code-commente(
    ("chemin.name", "le dernier morceau : `recette.md`"),
    ("chemin.stem", "le nom sans l'extension : `recette`"),
    ("chemin.suffix", "l'extension, point compris : `.md`"),
    ("chemin.parent", "le dossier qui le contient : `…/recettes/crepes`"),
    ("chemin.parent.name", "le nom de ce dossier : `crepes`"),
    ("chemin.parts", "tous les morceaux, dans un tuple"),
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
