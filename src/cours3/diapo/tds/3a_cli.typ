// TD 3a du cours 3 — « Une ligne de commande pour la recette ».
//
// Inclus par `cours3.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
//
// Le programme se construit pas à pas depuis les cellules du notebook du
// TD 1a : un fichier, `main`, `argparse` sur une branche, un README ; puis,
// en facultatif, `src/` et `data/`, et `pyproject.toml`. Chaque étape a son
// corrigé dans `data/cours3/corriges/3a_cli/etape<n>/`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": *

#let td = (
  numero: "3a",
  titre: "Une ligne de commande pour la recette",
  annonce: "Construire recette.py depuis les cellules du notebook : un fichier, une fonction main, argparse, un README ; un commit par étape",
  dossier: "cours3/3a_cli/",
  duree: "45′",
)
#separateur-td(..td)

#d("Étape 0 : le dossier de travail et le dépôt")[
  #annonce[
    `travail/` reçoit les données et devient un dépôt git. Le code n'y est
    pas encore : c'est l'étape 1.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [copier `depart/recettes/` et `depart/style.css` dans `travail/` ; dans l'éditeur, Fichier #sym.arrow.r Ouvrir le dossier `travail/`],
      reponse[`recettes/` et `style.css` dans l'explorateur de l'éditeur ; le terminal s'ouvre dans `travail/`],
    [2], [dans le terminal : `git init`],
      reponse[`Dépôt Git vide initialisé` ; `git status` liste `recettes/` et `style.css` non suivis],
    [3], [créer un fichier `.gitignore` contenant la ligne `sortie/`],
      reponse[`git status` liste aussi `.gitignore`],
  )

  #legende[
    `sortie/` est le dossier que le programme va écrire : il ne sera pas
    versionné. `depart/` reste tel quel ; `depart/secours/recette.py` est le
    résultat attendu de l'étape 1, pour qui reste bloqué.
  ]

  #notes[
    Le terminal de l'éditeur s'ouvre dans le dossier ouvert : c'est depuis
    `travail/` que tout se lance. Le premier commit vient à l'étape 1, avec
    le code.

    Vérifier que le dépôt est dans `travail/` et non dans `3a_cli/` : `git
    status` doit lister `recettes/`, pas `depart/`.
  ]
]

#d("Étape 1 : le code du notebook dans un fichier")[
  #annonce[
    Un fichier `recette.py`, écrit dans l'éditeur, qui reprend les cellules
    du notebook `recette.ipynb` dans l'ordre, et produit `sortie/crepes.html`.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [en tête : les `import` (`csv`, `shutil`, `subprocess`, `Path`) ; `NOM = "crepes"`, `PERSONNES = 4`, `UNITES = "SI"` ; `RACINE = Path.cwd()`, puis `RECETTES`, `STYLE` et `SORTIE` déduits],
      reponse[`python recette.py` ne fait encore rien : pas d'erreur, pas de sortie],
    [2], [copier les fonctions utiles (section 1), le programme (section 3.3, avec `read_text` et `write_text`), l'appel de pandoc (section 4.4) ; finir par un `print` du chemin de la page],
      reponse[`python recette.py` écrit `sortie/crepes.html` ; la page s'ouvre par un double-clic],
    [3], [`git add .`, puis `git commit -m "Le programme du notebook, dans un fichier"`],
      reponse[`git status` : rien à valider ; `sortie/` n'est pas listé],
  )

  #notes[
    Le notebook affichait la dernière expression d'une cellule ; le script
    n'affiche que ce que `print` écrit.

    Le corrigé de l'étape : `corriges/3a_cli/etape1/recette.py`, identique à
    `depart/secours/recette.py`. Les cellules à recopier sont celles de la
    version finale : pas les chemins en dur de la section 2, pas les `!`.
    Les chemins passés à pandoc sont en `str(…)`.

    La copie de `style.css` dans `sortie/` (`shutil.copy`) est la seule ligne
    absente du notebook, où le CSS était déjà à côté : la dire.

    Erreur fréquente : `python recette.py` lancé depuis `3a_cli/` et non
    `travail/` ; `Path.cwd()` ne trouve alors pas `recettes/`.
  ]
]

#d("Étape 2 : une fonction main")[
  #annonce[
    Les lignes du programme, sous les fonctions utiles, passent dans une
    fonction `main`, appelée en bas du fichier. Le fichier produit est le
    même qu'avant.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [écrire `def main():` au-dessus des lignes du programme, et les indenter de quatre espaces],
      reponse[`python recette.py` ne produit plus rien : `main` est définie, pas appelée],
    [2], [en bas du fichier : `if __name__ == "__main__":` puis, indenté, `main()`],
      reponse[`python recette.py` produit la même page qu'à l'étape 1],
    [3], [`git diff`, puis `git commit -am "Une fonction main"`],
      reponse[le diff montre les mêmes lignes, indentées ; `git log --oneline` : deux lignes],
  )

  #legende[
    `git commit -am` ajoute les fichiers déjà suivis et valide en une
    commande. Un fichier nouveau demande `git add`.
  ]

  #notes[
    L'étape 1 de la question fait constater ce que dit la diapositive « Ce
    que l'interpréteur exécute » : `def` ne lance rien. Les trois valeurs
    restent en tête du fichier pour l'instant ; `main` les lit comme
    variables globales.

    Corrigé : `corriges/3a_cli/etape2/recette.py`.
  ]
]

#d("Étape 3 : les arguments, sur une branche")[
  #annonce[
    Une branche `arguments`, et un commit par argument ajouté à `argparse` :
    la recette, puis le nombre de personnes, puis les unités. La branche est
    ensuite fusionnée dans `master`.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [`git checkout -b arguments` ; dans `main` : l'analyseur, `nom` avec `choices` = les dossiers de `recettes/` (boucle de la section 3.4), `NOM = options.nom` ; supprimer `NOM` en tête ; commit],
      reponse[`python recette.py` seul : `arguments are required: nom` ; `gaufres` : `invalid choice`],
    [2], [`-p/--personnes`, `type=int`, `default=4` ; `PERSONNES = options.personnes` ; commit],
      reponse[`python recette.py pate_pizza -p 6` : la pâte à pizza pour six],
    [3], [`-u/--unites`, `choices=("SI", "US")`, `default="SI"` ; `UNITES = options.unites` ; commit],
      reponse[`pate_pizza -p 6 -u US` : en onces et en cups ; `--help` : les trois arguments],
    [4], [`git checkout master`, `git merge arguments`, `git log --oneline --graph`],
      reponse[cinq commits sur une ligne : fusion en avance rapide],
  )

  #notes[
    `import argparse` en tête du fichier, et les trois lignes `NOM = …`
    disparaissent de la tête au fur et à mesure. Corrigé de la fin de
    l'étape : `corriges/3a_cli/etape3/recette.py`.

    Faire lire `--help` après chaque `add_argument` : l'aide change à chaque
    commit. `help="…"` dans `add_argument` complète l'aide ; le corrigé
    l'écrit, le TD peut s'en passer.
  ]
]

#d("Étape 4 : un README")[
  #annonce[
    Le dépôt reçoit un fichier `README.md` qui dit ce que fait le programme,
    comment l'installer et comment le lancer. Un modèle à compléter est dans
    `depart/modeles/`.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [copier `depart/modeles/README.md` dans `travail/`, l'ouvrir dans l'éditeur],
      reponse[cinq parties ; quatre passages « (À compléter …) »],
    [2], [compléter : la phrase d'objectif, la façon de récupérer le dossier, un exemple avec `-p` et `-u`, la liste des recettes, votre nom],
      reponse[l'aperçu Markdown de l'éditeur (`Ctrl+Maj+V` dans VS Code) montre la page],
    [3], [`git add README.md`, `git commit -m "Un README"`],
      reponse[six commits dans `git log --oneline`],
  )

  #legende[
    Le README est le premier fichier lu par qui ouvre le dépôt : il dit
    comment installer et lancer. Le cours 6 le publie avec le dépôt.
  ]

  #notes[
    Le corrigé, `corriges/3a_cli/etape4/README.md`, est une façon de le
    remplir. Ce qui compte : les commandes du README s'exécutent telles
    quelles, depuis le dossier du projet.

    Fin du TD obligatoire : quatre étapes, six commits. Les deux étapes
    suivantes sont pour qui a le temps.
  ]
]

#d("Étape 5, facultative : src et data")[
  #annonce[
    Le code va dans `src/`, les données dans `data/`. Les chemins des données
    partent alors du dossier du script, `__file__`, et non du terminal : le
    programme se lance depuis n'importe quel dossier.
  ]

  #code-commente(
    taille-code: 12.5pt, taille-texte: 12pt,
    ("ICI = Path(__file__).resolve().parent", "le dossier du script, `src/` : `__file__` en absolu, puis son parent"),
    ("RACINE = ICI.parent", "le dossier du projet"),
    ("RECETTES = RACINE / \"data\" / \"recettes\"", "les données, à côté de `src/`"),
    ("STYLE = RACINE / \"data\" / \"style.css\"", ""),
    ("SORTIE = Path.cwd() / \"sortie\"", "la sortie reste dans le dossier du terminal"),
  )

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [`git mv recette.py src/recette.py` (après `mkdir src`), `git mv recettes data/recettes`, `git mv style.css data/style.css`],
      reponse[`git status` : trois renommages],
    [2], [remplacer les quatre lignes de chemins par celles ci-dessus ; `python src/recette.py crepes`, puis `cd ..` et `python travail/src/recette.py crepes`],
      reponse[la page est écrite dans `sortie/` du dossier courant, dans les deux cas],
    [3], [`git commit -am "src/ et data/"`],
      reponse[sept commits],
  )

  #notes[
    `__file__` n'existe pas dans un notebook : aucun fichier `.py` n'est en
    cours d'exécution. `resolve()` avant `parent` : `__file__` peut être un
    chemin relatif, `src/recette.py`.

    Corrigé : `corriges/3a_cli/etape5/src/recette.py`.
  ]
]

#d("Étape 6, facultative : une commande installée")[
  #annonce[
    Un fichier `pyproject.toml` décrit le projet ; `pip install -e .` en fait
    une commande, `recette`, disponible dans tous les dossiers, sans écrire
    `python` ni le chemin du script.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [copier `depart/modeles/pyproject.toml` dans `travail/` ; compléter `description`],
      reponse[`[project.scripts]` : `recette = "recette:main"`, la commande et la fonction qu'elle appelle],
    [2], [dans le terminal, dans `travail/` : `pip install -e .`],
      reponse[`Successfully installed recette-0.1`],
    [3], [`cd ..`, puis `recette crepes -p 2` ; `recette --help`],
      reponse[la page dans `sortie/` du dossier courant ; l'aide, sans `python`],
    [4], [mettre le README à jour (la commande remplace `python recette.py`) ; `git add .`, `git commit -m "pyproject.toml : la commande recette"`],
      reponse[huit commits],
  )

  #legende[
    `-e` : installation « éditable », la commande exécute le fichier de
    `src/` ; une modification du code est prise en compte sans réinstaller.
    `pip uninstall recette` la retire.
  ]

  #notes[
    `pyproject.toml` est le format standard des projets Python (PEP 621) ;
    le projet 4 y revient avec les dépendances et l'environnement. Ici, une
    seule chose à lire : `[project.scripts]`.

    Si `pip install -e .` échoue faute de réseau (il télécharge `setuptools`
    pour construire le paquet) : `pip install -e . --no-build-isolation`.

    Corrigé : `corriges/3a_cli/etape5/`, avec `pyproject.toml` et le README
    mis à jour.
  ]
]
