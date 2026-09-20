// Partie 3 du cours 3 — du notebook au programme en ligne de commande.
//
// Incluse par `cours3.typ`. Contrairement aux parties 1 et 2, l'exposé et le
// TD sont séparés : cinq diapositives d'exposé (ce que change le passage en
// fichier, ce que l'interpréteur exécute, `main`, `argparse`, le rappel des
// commandes git), puis le TD 3a, pas à pas. Un fichier inclus n'hérite pas
// des imports de son appelant.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

#separateur(
  "Du notebook au programme",
  annonce: "Le code du notebook dans un fichier .py, lancé au terminal ; ses trois valeurs passées sur la ligne de commande",
)

// --------------------------------------------
#d("Le même code, dans un fichier")[
  #annonce[
    Un script est un fichier `.py` qui contient le code des cellules, dans
    leur ordre. `python recette.py` l'exécute en entier.
  ]

  #tableau(
    columns: (1fr, 1fr, 1fr),
    align: left + horizon,
    [], [Notebook], [Script],
    [Afficher], [la dernière expression de la cellule], [`print` ; une expression seule n'affiche rien],
    [Dossier courant], [celui du fichier `.ipynb`], [celui du terminal],
    [Les valeurs (recette, personnes, unités)], [modifiées dans la cellule, puis la cellule relancée], [passées sur la ligne de commande],
  )

  #legende[
    Le TD 3a construit `recette.py` à partir des cellules du notebook du
    TD 1a, dans `travail/`, en cinq étapes et autant de commits.
  ]

  #notes[
    Première ligne : dans un script, une expression seule n'affiche rien ;
    `print` partout où le notebook affichait.

    Deuxième ligne : la diapositive « La racine, lue automatiquement » de la
    partie 1. Dans le TD, le script est lancé depuis le dossier qui contient
    `recettes/`, et `RACINE = Path.cwd()`.

    Troisième ligne : les valeurs en tête de fichier obligent à ouvrir le
    fichier pour les changer. `argparse` les met sur la ligne de commande,
    étape 3 du TD.
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
    Le programme, les lignes du bas, passe dans une fonction `main`. La
    dernière ligne du fichier l'appelle quand le fichier est lancé par
    `python` ; un `import` du fichier ne l'appelle pas.
  ]

  #code-commente(
    taille-code: 13pt, taille-texte: 12.5pt,
    ("def lire_ingredients(chemin):", "les fonctions utiles, inchangées"),
    ("    ...", ""),
    ("", ""),
    ("def main():", "le programme devient une fonction"),
    ("    ingredients = lire_ingredients(RECETTES / NOM / \"ingredients.csv\")", "les mêmes lignes, indentées"),
    ("    ...", ""),
    ("    subprocess.run([\"pandoc\", ...], check=True)", ""),
    ("", ""),
    ("if __name__ == \"__main__\":", "vrai dans le fichier lancé par `python`, faux dans un fichier importé"),
    ("    main()", "l'appel : le programme s'exécute"),
  )

  #legende[
    `travail/recette.py`, étape 2 du TD. Le résultat ne change pas ; le
    fichier devient importable.
  ]

  #notes[
    `__name__` est une variable que Python remplit : `"__main__"` dans le
    fichier lancé, le nom du module (`"recette"`) dans un fichier importé.

    Au projet 4, ce fichier est importé par un autre pour ses fonctions ;
    sans le `if`, l'import exécuterait le programme. Un test peut aussi
    appeler `main` directement.
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
    `travail/recette.py`, dans `main`, étape 3 du TD ; docs.python.org/fr/3/library/argparse.html.
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

    Étape 3 du TD, un argument par commit. Faire lire `--help` : l'aide est
    produite depuis les `add_argument`, sans rien écrire d'autre.
  ]
]

// --------------------------------------------
#d("Une étape, un commit")[
  #annonce[
    À chaque étape du TD, un commit avec les commandes du cours 2. L'étape 3
    se fait sur une branche, fusionnée ensuite.
  ]

  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [`git status`], [les fichiers modifiés depuis le dernier commit],
    [`git diff`], [les lignes modifiées dans `recette.py`],
    [`git add recette.py`], [ajoute le fichier au prochain commit],
    [`git commit -m "Une fonction main"`], [enregistre l'état ; le message nomme l'étape],
    [`git checkout -b arguments`], [crée la branche et s'y place],
    [`git checkout master`, `git merge arguments`], [revient sur master, y ramène les commits de la branche],
    [`git log --oneline --graph`], [un commit par ligne, les branches dessinées],
  )

  #legende[
    `sortie/` est dans `.gitignore` : les fichiers produits par le programme
    ne sont pas versionnés, le programme les reproduit.
  ]

  #notes[
    Les commandes sont celles du cours 2. Un commit à la fin de chaque
    étape ; si une étape échoue, `git restore recette.py` remet le fichier à
    l'état du dernier commit.

    `master` : le nom que `git init` donne à la première branche sur les
    postes ; `main` si le poste est réglé autrement.
  ]
]
