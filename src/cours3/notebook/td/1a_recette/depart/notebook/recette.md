---
title: Amélioration d'un code de génération de recette
execution: ../../travail
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Amélioration d'un code de génération de recette

Ce notebook a pour objectif d'améliorer un code de génération de recette en
utilisant des fonctions des bibliothèques standards de Python.

Le notebook est structuré en trois parties :

1. Le code brut, avec ses chemins écrits en dur.
2. Amélioration du code avec la bibliothèque `pathlib` pour la manipulation de
   chemins en Python.
3. Conversion du résultat en page HTML avec pandoc, d'abord en appelant l'outil manuellement dans le terminal, puis en l'appelant directement depuis le code Python.

Ce notebook est livré dans `depart/notebook/`. 
Avant de commencer, le copier dans `travail/` et ouvrir la copie : `depart/` ne doit pas être modifiée, les modifications sont faites dans le dossier `travail/`.

## 1 · Les fonctions utiles

Les fonctions reprises du cours 1 utiles pour le programme: 
 * lire les ingrédients
 * les mettre à l'échelle en fonction du nombre de personnes
 * convertir les unités ( SI -> US)
 * écrire le tableau contenant les ingrédients et leur quantité en format texte markdown. 
 
Ces fonctions sont à exécuter pour qu'elles soient disponibles pour le reste du notebook. 
Elles ne seront pas modifiées ni étudiées dans la suite de ce notebook mais seront vues plus en détails dans le notebook suivant.

```{code-cell} ipython3
import csv

FACTEURS = {"g": (28.3495, "oz"), "ml": (236.588, "cup")}


def lire_ingredients(chemin):
    """Les ingrédients du fichier CSV, quantités converties en nombres.
    
    la fonction renvoit les ingrédients sur la forme d'une liste de tuple.
    Chaque élément de la liste correspond à une "ligne" pour un ingrédient et contient 

    * nom de l'ingrédiant (pos 0) 
    * quantité de l'ingrédient (pos 1) en float
    * unité associée à la quantité.

    """
    ingredients = []
    with open(chemin, encoding="utf-8", newline="") as fichier:
        lecteur = csv.reader(fichier)
        # La première ligne du fichier nomme les colonnes : next() la lit et la
        # laisse de côté, la boucle commence à la ligne suivante.
        next(lecteur)
        for nom, quantite, unite in lecteur:
            ingredients.append((nom, float(quantite), unite))
    return ingredients


def convertir(quantite, unite):
    """Une quantité et son unité, exprimées en unités américaines."""
    if unite in FACTEURS:
        diviseur, nouvelle_unite = FACTEURS[unite]
        return quantite / diviseur, nouvelle_unite
    return quantite, unite


def adapter(ingredients, personnes, unites):
    """La recette pour ce nombre de personnes, dans ce système d'unités."""
    resultat = []
    for nom, quantite, unite in ingredients:
        quantite = quantite * personnes
        if unites == "US":
            quantite, unite = convertir(quantite, unite)
        resultat.append((nom, quantite, unite))
    return resultat


def tableau(ingredients):
    """Le tableau Markdown des ingrédients, quantités écrites à trois chiffres."""
    lignes = ["| Ingrédient | Quantité |", "|---|---|"]
    for nom, quantite, unite in ingredients:
        lignes.append(f"| {nom} | {quantite:.3g} {unite}".rstrip() + " |")
    return "\n".join(lignes)
```

## 2 · Le code brut, chemins en dur

Une version du programme, sans variable et utilisant des chemins "codés en dur". 
Par chemin en dur on entend que chaque chemin est écrit en entier, à partir de la racine et est spécifique à un ordinateur / poste.

Ce type de code n'est **PAS** un exemple de bonne pratique, mais on en croise des variantes assez souvent dans les rendus d'élèves. 
On va donc étudier comment l'améliorer.

```{code-cell} ipython3
:tags: [raises-exception]

ingredients = lire_ingredients("C:/Users/alice/Desktop/cours3/1a_recette/depart/recettes/crepes/ingredients.csv")
ingredients = adapter(ingredients, 4, "SI")

with open("C:/Users/alice/Desktop/cours3/1a_recette/depart/recettes/crepes/recette.md", encoding="utf-8") as fichier:
    source = fichier.read()
complete = source.replace("## Ingrédients", "## Ingrédients\n\n" + tableau(ingredients))

with open("C:/Users/alice/Desktop/cours3/1a_recette/travail/crepes.md", "w", encoding="utf-8") as fichier:
    fichier.write(complete)
print(complete)
```

La cellule renvoie une erreur : `FileNotFoundError`. Cela est du au fait que le dossier `C:/Users/alice/…` n'existe pas sur votre poste.

:::{admonition} À faire
Dans la copie ci-dessous, remplacez les trois chemins par ceux de votre
poste : le chemin du dossier `1a_recette/` se lit dans la barre d'adresse de
l'explorateur de fichiers. 
Les `\` de Windows se remplacent par des `/` dans le code. 
Exécutez : le programme doit générer un fichier `travail/crepes.md`.
:::

```{code-cell} ipython3
:tags: [raises-exception]

ingredients = lire_ingredients("C:/Users/alice/Desktop/cours3/1a_recette/depart/recettes/crepes/ingredients.csv")
ingredients = adapter(ingredients, 4, "SI")

with open("C:/Users/alice/Desktop/cours3/1a_recette/depart/recettes/crepes/recette.md", encoding="utf-8") as fichier:
    source = fichier.read()
complete = source.replace("## Ingrédients", "## Ingrédients\n\n" + tableau(ingredients))

with open("C:/Users/alice/Desktop/cours3/1a_recette/travail/crepes.md", "w", encoding="utf-8") as fichier:
    fichier.write(complete)
print(complete)
```

:::{warning}
Ce code n'est pas portable : il ne fonctionne que sur le poste où les
chemins ont été écrits. 
Le donner à quelqu'un d'autre, ou déplacer le dossier, oblige à réécrire trois lignes pour faire fonctionner le code.
:::

## 3 · Amélioration du code avec variable et utilisation de `pathlib`


### 3.1 · Le même code, avec des variables

La première amélioration est de déclarer les chemins utilisés comme des variables dans un bloc à part.
Le code, lui, ne contient alors plus que les noms des variables.

**déclaration des variables chemins**

```{code-cell} ipython3
# Déclaration brute : trois chaînes, à modifier toutes les trois pour changer de poste
FICHIER_INGREDIENTS = "C:/Users/alice/Desktop/cours3/1a_recette/depart/recettes/crepes/ingredients.csv"
FICHIER_RECETTE = "C:/Users/alice/Desktop/cours3/1a_recette/depart/recettes/crepes/recette.md"
FICHIER_SORTIE = "C:/Users/alice/Desktop/cours3/1a_recette/travail/crepes.md"
```

**version du code utilisant les variables**

```{code-cell} ipython3
:tags: [raises-exception]

ingredients = lire_ingredients(FICHIER_INGREDIENTS)
ingredients = adapter(ingredients, 4, "SI")

with open(FICHIER_RECETTE, encoding="utf-8") as fichier:
    source = fichier.read()
complete = source.replace("## Ingrédients", "## Ingrédients\n\n" + tableau(ingredients))

with open(FICHIER_SORTIE, "w", encoding="utf-8") as fichier:
    fichier.write(complete)
print(complete)
```

### 3.2 · Importer `pathlib`, déclarer un chemin

`pathlib` est une bibliothèque livrée avec Python, il n'est pas nécessaire de la préciser en dépendance par contre il et nécessaire de déclarer son import / utilisation. 

```{code-cell} ipython3
from pathlib import Path
```

`Path("/chemin/de/dossier/fichier.txt")` déclare un chemin ; 

```{code-cell} ipython3
dossier = Path("C:/Users/alice/Desktop/cours3/1a_recette")
print(dossier)
```

`/` ajoute un dossier ou un fichier au chemin. Il s'agit d'un opérateur comme `+` pour l'addition.

```{code-cell} ipython3
dossier_recette =  dossier / "depart" / "recettes"
print(dossier_recette)
```

En python un `Path` s'écrit avec des `/`, quel que soit le système ; sous Windows, il s'affiche avec des `\`. 

**REM**: construire un `Path` n'est pas équivalent à créer un fichier/dossier. Ici on construit juste un chemin et il n'y a aucune garantie que le dossier ou fichier correspondant existe. 

Documentation :
[docs.python.org/fr/3/library/pathlib.html](https://docs.python.org/fr/3/library/pathlib.html).


Avec `pathlib`, on ne déclare plus en dur qu'un seul chemin : la racine du TD. 
Les autres chemins s'en déduisent, en relatif. 

Cela est plus portable sur un autre ordi tant que l'on copie le dossier des données sans en changer l'aborescence.

**déclaration de la racine**

:::{admonition} À faire
Remplacez la valeur de `RACINE` par le chemin de votre dossier `1a_recette/`,
:::

```{code-cell} ipython3
:tags: [corrige]
# Déclaration avec pathlib : RACINE en dur
RACINE = Path("C:/Users/alice/Desktop/cours3/1a_recette")
```

les autres chemins sont contruits à partir de la racine en utilisant l'opérateur  '/' ci -dessous exemple pour RECETTE

```{code-cell} ipython3
RECETTE = RACINE / "depart" / "recettes" / "crepes"
```

:::{admonition} À faire
Completer les autres chemins de la même façon,
:::

Les chemins à écrire, à partir de `RACINE` :

```text
1a_recette/                      ← RACINE
├── depart/
│   └── recettes/
│       └── crepes/              ← RECETTE
│           ├── ingredients.csv  ← FICHIER_INGREDIENTS
│           └── recette.md       ← FICHIER_RECETTE
└── travail/                     ← dossier courant
    ├── recette.ipynb            ← le notebook
    └── crepes.md                ← FICHIER_SORTIE
```

```{code-cell} ipython3
FICHIER_INGREDIENTS =  
FICHIER_RECETTE =  
FICHIER_SORTIE = 
```

Tester le code :

```{code-cell} ipython3
:tags: [raises-exception]

ingredients = lire_ingredients(FICHIER_INGREDIENTS)
ingredients = adapter(ingredients, 4, "SI")

with open(FICHIER_RECETTE, encoding="utf-8") as fichier:
    source = fichier.read()
complete = source.replace("## Ingrédients", "## Ingrédients\n\n" + tableau(ingredients))

with open(FICHIER_SORTIE, "w", encoding="utf-8") as fichier:
    fichier.write(complete)
print(complete)
```

### 3.3 · Obtenir la racine automatiquement

Il reste une valeur écrite en dur, `RACINE`. Pathlib fournit des fonctions
pour définir des chemins correspondants à des emplacements spécifique. 
Par exemple le chemin courant est défini par `Path.cwd()`. 

Dans un notebook, `Path.cwd()` renvoie le dossier du fichier `.ipynb`, ici `travail/` : le serveur Jupyter y place le noyau au démarrage. 

Un autre chemin que l'on peut obtenir en python est celui de l'interpréteur Python, `sys.executable`.

```{code-cell} ipython3
import sys

print(Path.cwd())
print(sys.executable)
print((Path.cwd() / "recette.ipynb").exists())
```

`exists()` dit si un chemin existe sur le disque : le notebook est bien dans
le dossier courant. 
La racine du TD est le dossier au-dessus : `parent`, ou `..` dans un chemin relatif.

```{code-cell} ipython3
print(Path.cwd().parent)                 # le dossier au-dessus, en absolu
print(Path("..") / "depart" / "recettes")   # le même dossier, en relatif : tel qu'écrit
print((Path("..") / "depart" / "recettes").resolve())   # resolve() le transforme en chemin absolu
```

Un chemin relatif s'affiche tel qu'il a été écrit, avec les `..` dans le chemin inclus. 
La fonction `resolve()` transforme le chemin en un chemin absolu. i.e supprime les `..`. 
Les deux désignent chemins designent le même dossier. 

On calcul alors RACINE par rapport au chemin du notebook:

```{code-cell} ipython3
:tags: [corrige]

# Les mêmes chemins, RACINE déduite du dossier courant
RACINE = Path.cwd().parent

RECETTE = RACINE / "depart" / "recettes" / "crepes"
FICHIER_INGREDIENTS = RECETTE / "ingredients.csv"
FICHIER_RECETTE = RECETTE / "recette.md"
FICHIER_SORTIE = RACINE / "travail" / "crepes.md"

print(FICHIER_INGREDIENTS.exists(), FICHIER_RECETTE.exists())
```

```{code-cell} ipython3
ingredients = lire_ingredients(FICHIER_INGREDIENTS)
ingredients = adapter(ingredients, 4, "SI")

with open(FICHIER_RECETTE, encoding="utf-8") as fichier:
    source = fichier.read()
complete = source.replace("## Ingrédients", "## Ingrédients\n\n" + tableau(ingredients))

with open(FICHIER_SORTIE, "w", encoding="utf-8") as fichier:
    fichier.write(complete)
print(complete)
```

Le même code tourne maintenant sur n'importe quel poste, à condition que
`depart/` et `travail/` soient côte à côte.


### 3.4 · Généraliser à plusieurs recettes

Le code traite une seule recette, `crepes`, et le fichier produit porte un nom générique. 
Le dossier `depart/recettes/` contient quatre dossiers, un par recette, tous ayant la même structure (aborescence similaire). 

```text
1a_recette/                      ← RACINE
├── depart/
│   └── recettes/                ← RECETTES
│       ├── crepes/
│       │   ├── ingredients.csv
│       │   └── recette.md
│       ├── …
│       └── salade_lentilles/
│           ├── ingredients.csv
│           └── recette.md
└── travail/                     ← dossier courant
    ├── recette.ipynb            ← le notebook
    ├── crepes.md
    ├── …
    └── salade_lentilles.md
```

Pour produire une page par recette, il faut lister ces dossiers, et déduire
le nom du fichier de sortie du nom du dossier. Cela fait aussi partie des fonctions de `pathlib`.

On commence par lister le contenu d'un dossier avec la fonction `iterdir()`

```{code-cell} ipython3
RECETTES = RACINE / "depart" / "recettes"

# iterdir() donne chaque entrée du dossier, fichiers et dossiers, sans ordre
for dossier in RECETTES.iterdir():
    print(dossier)
```

Ensuite on teste si l'élement du dossier est un sous-dosssier (est lui même un dossier) avec la fonction `is_dir()` et on extrait son nom avec `name`

```{code-cell} ipython3
# sorted() les trie ; is_dir() garde les dossiers ; name est le nom du dossier
for dossier in sorted(RECETTES.iterdir()):
    if dossier.is_dir():
        print(dossier.name)
```

`name` est l'une des parties d'un chemin que `pathlib` renvoie. Les exemples suivants utilisent le fichier de la recette des crêpes :

```{code-cell} ipython3
chemin = RECETTES / "crepes" / "recette.md"

print(chemin.name)                     # le nom du fichier : recette.md
print(chemin.stem)                     # le nom sans l'extension : recette
print(chemin.suffix)                   # l'extension, point compris : .md
print(chemin.parent)                   # le dossier qui le contient
print(chemin.parent.name)              # le nom de ce dossier : crepes
print(chemin.parts)                    # toutes les parties du chemin, dans un tuple
print(chemin.relative_to(RACINE))      # le chemin à partir de RACINE
print(chemin.with_suffix(".html"))     # le même chemin, extension changée
print(chemin.with_name("ingredients.csv"))  # le même dossier, autre nom de fichier
```

Le fichier de sortie porte le nom du dossier, avec l'extension `.md` : `with_suffix(".md")` la pose sur le chemin `travail/crepes`.

```{code-cell} ipython3
:tags: [corrige]

# Pour chaque dossier de recette : le fichier de sortie déduit du nom, et si ingredients.csv existe
for dossier in sorted(RECETTES.iterdir()):
    if dossier.is_dir():
        fichier_sortie = (RACINE / "travail" / dossier.name).with_suffix(".md")
        print(dossier.name, "->", fichier_sortie.name, (dossier / "ingredients.csv").exists())
```

On adapte le programme initial pour fonctionner avec plusieurs recettes : les chemins de la recette partent de `dossier`, le fichier de sortie de `dossier.name`.

```{code-cell} ipython3
:tags: [corrige]

# Le programme, une fois par dossier de recette
for dossier in sorted(RECETTES.iterdir()):
    if dossier.is_dir():
        ingredients = lire_ingredients(dossier / "ingredients.csv")
        ingredients = adapter(ingredients, 4, "SI")

        with open(dossier / "recette.md", encoding="utf-8") as fichier:
            source = fichier.read()
        complete = source.replace("## Ingrédients", "## Ingrédients\n\n" + tableau(ingredients))

        fichier_sortie = (RACINE / "travail" / dossier.name).with_suffix(".md")
        with open(fichier_sortie, "w", encoding="utf-8") as fichier:
            fichier.write(complete)
        print(dossier.name, "écrit")
```

## 4 · Convertir avec pandoc

`crepes.md` est un fichier Markdown, dans `travail/`. 
Pour le convertir en html on peut utiliser l'outil en ligne de commande pandoc, qui est livré avec Anaconda (envrionnement base). 
C'est un programme, pas une bibliothèque Python : il se lance dans le terminal. 
Documentation :
[pandoc.org/MANUAL.html](https://pandoc.org/MANUAL.html) (toutes les options)
et [pandoc.org/demos.html](https://pandoc.org/demos.html) (des exemples de
commandes).

### 4.1 · Dans le terminal

Dans Anaconda Prompt, se placer dans `travail/` (le chemin affiché par `Path.cwd()` à la section 3.3), puis appeler la commande pandoc :

```
(base) C:\Users\moi> cd Desktop\cours3\1a_recette\travail
(base) C:\Users\moi\Desktop\cours3\1a_recette\travail> pandoc crepes.md -o crepes.html
```

La commande se lit ainsi :

- `pandoc` : le programme lancé ;
- `crepes.md` : le fichier à lire, l'entrée ; pandoc la prend sans option
  (beaucoup d'autres programmes utilisent `-i`, pour `--input`) ;
- `-o crepes.html` : le fichier à écrire ; `-o` est le raccourci
  d'`--output`, la sortie ;
- le format de sortie est déduit de l'extension, ici `.html`.

Les chemins donnés à pandoc partent du dossier courant du terminal. 
Depuis `cours3/` La même conversion s'écrit avec les chemins jusqu'à `travail/`, pour l'entrée comme pour la sortie :

```
(base) C:\Users\moi\Desktop\cours3> pandoc 1a_recette\travail\crepes.md -o 1a_recette\travail\crepes.html
```

Avec `-o crepes.html` seul, la page serait écrite dans `cours3/`, et non à
côté de `crepes.md`.

Ouvrir `crepes.html` par un double-clic.

### 4.2 · Depuis le notebook, avec `!`

Une cellule qui commence par `!` n'est pas du Python : la ligne est passée au terminal, et sa sortie s'affiche sous la cellule. 
C'est propre aux notebooks, et pratique pour essayer une commande sans changer de fenêtre.

```{code-cell} ipython3
!pandoc --version
```

La conversion la plus simple, puis ses options, ajouter une par une. 
Après chaque cellule, les premiers caractères du fichier produit montrent ce qui a changé.

```{code-cell} ipython3
!pandoc crepes.md -o crepes.html
print(Path("crepes.html").read_text(encoding="utf-8")[:120])
```

Sans option, pandoc écrit un fragment : le contenu, sans en-tête ni `<html>`. Le navigateur l'affiche quand même, sans titre d'onglet.
`--standalone`, ou `-s`, demande une page complète.

```{code-cell} ipython3
!pandoc crepes.md -o crepes.html --standalone
print(Path("crepes.html").read_text(encoding="utf-8")[:120])
```

Le fichier `crepes.md` ne déclare pas de titre. pandoc utilise alors le nom
du fichier, `crepes`, comme titre de la page, et affiche un avertissement
pour le signaler. L'option `--metadata title=…` permet de choisir le titre.

```{code-cell} ipython3
!pandoc crepes.md -o crepes.html --standalone --metadata title=Crêpes
```

`--css` inscrit dans la page le lien vers une feuille de style. Le chemin
donné est celui que le navigateur suivra depuis la page : la feuille de style est donc copiée à côté d'elle, depuis `depart/`.

```{code-cell} ipython3
import shutil

shutil.copy(RACINE / "depart" / "style.css", "style.css")
!pandoc crepes.md -o crepes.html --standalone --metadata title=Crêpes --css style.css
```

`--toc` ajoute une table des matières, construite sur les titres.

```{code-cell} ipython3
!pandoc crepes.md -o crepes.html --standalone --metadata title=Crêpes --css style.css --toc
```

Ouvrir `crepes.html` à chaque étape pour voir la différence. 
Le format de sortie suit l'extension : `.docx` pour Word, `.odt` pour LibreOffice, `.txt` avec `-t plain` pour du texte sans balise.

```{code-cell} ipython3
!pandoc crepes.md -o crepes.docx
!pandoc crepes.md -o crepes.txt -t plain
print(Path("crepes.txt").read_text(encoding="utf-8")[:200])
```

pandoc lit aussi la plupart des formats qu'il écrit : le document Word peut être reconvertit en Markdown.

```{code-cell} ipython3
!pandoc crepes.docx -o retour.md
print(Path("retour.md").read_text(encoding="utf-8")[:300])
```

```{code-cell} ipython3
!pandoc --list-output-formats
```

### 4.3 · Où le terminal trouve pandoc

Le terminal a lancé `pandoc` sans qu'on lui dise où est le programme. 
Il l'a cherché dans une liste de dossiers, la variable d'environnement `PATH`.
`shutil.which` fait la même recherche et renvoie le chemin absolu trouvé.

```{code-cell} ipython3
chemin = shutil.which("pandoc")
print(chemin)
```

Appeler le programme par son chemin absolu revient au même ; `{chemin}`
insère la variable Python dans la ligne de commande.

```{code-cell} ipython3
!"{chemin}" --version
```

Les variables d'environnement sont lisibles depuis Python dans `os.environ`, qui est un dictionnaire. 
`PATH` en une de ces variables d'environnement: c'est une seule chaîne de caractère (string), où les dossiers sont séparés par `;` sous Windows et `:` ailleurs ; `os.pathsep` donne le bon séparateur.

```{code-cell} ipython3
import os

# La variable PATH : une seule chaîne, tous les dossiers à la suite
path = os.environ["PATH"]
print(path)
```

```{code-cell} ipython3
# Le séparateur entre deux dossiers dépend du système
print(os.pathsep)

# Découper la chaîne à chaque séparateur : une liste, un dossier par élément
dossiers = path.split(os.pathsep)
print(len(dossiers), "dossiers")
```

```{code-cell} ipython3
:tags: [corrige]

# Afficher chaque dossier, un par ligne, et marquer celui qui contient pandoc
dossier_pandoc = Path(chemin).parent

for dossier in dossiers:
    if Path(dossier) == dossier_pandoc:
        print(dossier, "  <- pandoc est ici")
    else:
        print(dossier)
```

Une commande « introuvable » est un programme dont le dossier n'est pas dans
cette liste. 
`conda activate` modifie le `PATH` : c'est ce qui fait qu'une
commande peut exister dans un environnement et pas dans un autre. 
Sous Windows, conda range les programmes qui ne sont pas du Python, pandoc compris, dans `Library\bin`.

### 4.4 · Appeler pandoc depuis Python

La syntaxe `!` ne fonctionne que dans un notebook. Dans un programme Python,
une commande se lance avec la bibliothèque standard, de deux façons :

- `os.system` reçoit la ligne de commande en une seule chaîne ;
- `subprocess.run` reçoit le programme et ses arguments dans une liste.

`subprocess.run` est la forme à utiliser : les arguments sont transmis sans
être redécoupés, l'affichage du programme peut être récupéré, et
`check=True` déclenche une erreur Python si la commande échoue.

```{code-cell} ipython3
# os.system : la ligne de commande en une chaîne ; renvoie le code de retour, 0 si tout va bien
code = os.system("pandoc crepes.md -o crepes.html --standalone --metadata title=Crêpes")
print(code)
```

```{code-cell} ipython3
:tags: [corrige]

# subprocess.run : le programme puis chaque argument, en liste ; check=True lève une erreur si pandoc échoue
import subprocess

subprocess.run(["pandoc", "crepes.md", "-o", "crepes.html",
                "--standalone", "--metadata", "title=Crêpes", "--css", "style.css"],
               check=True)
```

```{code-cell} ipython3
# capture_output=True récupère l'affichage du programme ; text=True le convertit en chaîne
resultat = subprocess.run(["pandoc", "--version"], capture_output=True, text=True)
print(resultat.returncode)
print(resultat.stdout.splitlines()[0])
```

Un chemin `Path` se passe à `subprocess` par `str(chemin)` : la commande ne
prend comme paramètre que des chaînes de caractères. 
