// Partie 3 du cours 3 — du notebook au programme en ligne de commande.
//
// Incluse par `cours3.typ`. Contrairement aux parties 1 et 2, l'exposé et le
// TD sont séparés : quatre diapositives d'exposé (ce que change le passage en
// fichier, ce que l'interpréteur exécute, `main`, `argparse`), puis le TD 3a
// (`tds/3a_cli.typ`), qui porte la liste des étapes et le rappel git.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

#separateur(
  "Du notebook au programme",
  annonce: "Le code du notebook dans un fichier .py, lancé depuis un terminal ; ses trois paramètres passées via la ligne de commande",
)

// --------------------------------------------
#d("Le même code, dans un fichier")[
  #annonce[
    Copier dans un script python, fichier `recette.py`, le code des cellules, dans
    leur ordre (dernièere version). 
    `python recette.py` l'exécute en entier.
  ]

  #tableau(
    columns: (1fr, 1fr, 1fr),
    align: left + horizon,
    [], [Notebook], [Script],
    [Afficher], [la dernière expression de la cellule], [`print` ; une expression seule n'affiche rien],
    [Dossier courant], [celui du fichier `.ipynb`], [celui du terminal],
    [Les valeurs (recette, personnes, unités)], [modifiées dans la cellule, puis la cellule relancée], [passées sur la ligne de commande],
  )

  #notes[
    Première ligne : dans un script, une expression seule n'affiche rien ;
    `print` partout où le notebook affichait.

    Deuxième ligne : la diapositive « La racine, lue automatiquement » de la
    partie 1. Dans le TD, le script est lancé depuis le dossier qui contient
    `recettes/`, et `RACINE = Path.cwd()`.

    Troisième ligne : les valeurs en tête de fichier obligent à ouvrir le
    fichier pour les changer. `argparse` permet de les passer sur la ligne
    de commande.
  ]
]

// --------------------------------------------
#d("Ce que l'interpréteur exécute")[
  #annonce[
    Python lit le fichier de haut en bas et exécute chaque instruction. Un
    `def` définit une fonction : son corps n'est pas exécuté à ce moment,
    mais à chaque appel.
  ]

  #code-commente(
    taille-code: 13pt, taille-texte: 12.5pt,
    ("import csv", "exécuté : la bibliothèque est chargée"),
    ("NOM = \"crepes\"", "exécuté : la variable existe"),
    ("", ""),
    ("def tableau(ingredients):", "exécuté : la fonction `tableau` existe"),
    ("    lignes = [\"| Ingrédient | Quantité |\", \"|---|---|\"]", "pas exécuté maintenant"),
    ("    ...", ""),
    ("    return \"\\n\".join(lignes)", ""),
    ("", ""),
    ("table = tableau(ingredients)", "l'appel : le corps de `tableau` s'exécute, puis la ligne suivante"),
  )

  #legende[
    Les fonctions sont écrites avant la première ligne qui les appelle : au
    moment de l'appel, elles existent.
  ]

  #notes[
    C'est la raison de l'ordre du fichier : les fonctions utiles en haut, le
    programme en bas, comme dans le notebook où la cellule des fonctions est
    exécutée en premier.

    Un `import recette` depuis un autre fichier fait la même lecture de haut
    en bas : les `def` définissent les fonctions, et les lignes du programme
    s'exécutent aussi. C'est le problème que la diapositive suivante règle.
  ]
]

// --------------------------------------------
#d("Une fonction main")[
  #annonce[
    Les lignes du programme sont placées dans une fonction `main`. La fin du
    fichier appelle `main` seulement si le fichier est lancé avec
    `python recette.py`.
  ]

  #code-commente(
    taille-code: 13pt, taille-texte: 12.5pt,
    ("def lire_ingredients(chemin):", "les fonctions utiles, sans changement"),
    ("", ""),
    ("def main():", "le programme, dans une fonction"),
    ("    ingredients = lire_ingredients(...)", "les lignes du programme, indentées"),
    ("", ""),
    ("if __name__ == \"__main__\":", "vrai si le fichier est lancé avec `python`"),
    ("    main()", "exécute le programme"),
  )

  #tableau(
    columns: (1fr, auto, auto),
    align: left + horizon,
    [Utilisation du fichier], [`__name__` vaut], [`main()` exécutée],
    [`python recette.py`, dans le terminal], [`"__main__"`], [oui],
    [`import recette`, dans un autre fichier Python], [`"recette"`], [non],
  )

  #notes[
    Le résultat de `python recette.py` est le même qu'avant le passage dans
    `main`.

    `__name__` est une variable que Python définit dans chaque fichier. Avec
    le test, un autre fichier peut importer les fonctions de `recette.py`
    sans exécuter le programme.

    Une commande installée avec `pyproject.toml` appelle aussi `main` :
    `recette = "recette:main"`.
  ]
]

// --------------------------------------------
#d("Les arguments de la ligne de commande")[
  #annonce[
    `argparse`, bibliothèque standard, lit les arguments écrits après le nom
    du script : il les vérifie, les convertit, et construit l'aide de `--help`.
  ]

  #code-commente(
    taille-code: 12pt, taille-texte: 12.5pt,
    ("analyseur = argparse.ArgumentParser()", "l'analyseur des arguments"),
    ("analyseur.add_argument(\"nom\", choices=recettes_disponibles)", "obligatoire ; une valeur de la liste"),
    ("analyseur.add_argument(\"-p\", \"--personnes\", type=int, default=4)", "option ; convertie en entier ; 4 si absente"),
    ("analyseur.add_argument(\"-u\", \"--unites\", choices=(\"SI\", \"US\"))", "option ; deux valeurs possibles"),
    ("options = analyseur.parse_args()", "lit la ligne de commande ; message et arrêt si elle est invalide"),
    ("options.nom, options.personnes, options.unites", "les valeurs lues"),
  )

  #legende[
    Documentation : docs.python.org/fr/3/library/argparse.html.
  ]

  #tableau(
    entete: false,
    columns: (1fr, 1fr),
    align: left + horizon,
    [`python recette.py pate_pizza -p 6 -u US`], [`nom`, puis deux options],
    [`python recette.py gaufres`], [`invalid choice`, et la liste],
    [`python recette.py --help`], [l'aide, depuis les `add_argument`],
  )

  #notes[
    Un argument sans tiret est obligatoire et positionnel ; avec des tirets,
    c'est une option, qui a une valeur par défaut. `type=int` convertit et
    rejette `six`. `choices` rejette ce qui n'est pas dans la liste ; la
    liste des recettes vient de `iterdir()` sur `recettes/`, comme à la
    section 3.4 du notebook.

    Faire lire `--help` : l'aide est produite à partir des `add_argument`,
    sans rien écrire d'autre.
  ]
]
