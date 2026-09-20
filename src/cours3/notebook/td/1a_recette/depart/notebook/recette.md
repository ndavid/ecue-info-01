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
utilisant des fonctions des bibliothèques standard de Python.

1. Le code brut, avec ses chemins écrits en dur.
2. Amélioration avec la bibliothèque `pathlib` pour la manipulation de
   chemins en Python.
3. Conversion du résultat en page HTML avec pandoc : dans le terminal, puis
   depuis Python.

Ce notebook est livré dans `depart/notebook/`. Avant de commencer, le copier
dans `travail/` et ouvrir la copie : `depart/` ne se modifie pas, `travail/`
reçoit tout ce qu'on fabrique.

## 1 · Les fonctions utiles

Les fonctions du cours 1 : lire les ingrédients, les mettre à l'échelle,
convertir les unités, écrire le tableau. À exécuter telles quelles ; elles ne
changent pas dans la suite.

```{code-cell} ipython3
import csv

FACTEURS = {"g": (28.3495, "oz"), "ml": (236.588, "cup")}


def lire_ingredients(chemin):
    """Les ingrédients du fichier CSV, quantités converties en nombres."""
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
    """La recette pour ce nombre de convives, dans ce système d'unités."""
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

Le programme, sans variable : chaque chemin est écrit en entier, là où il
sert. Ces chemins sont ceux du poste de l'auteur.

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

La cellule s'arrête : `FileNotFoundError`, le dossier `C:/Users/alice/…`
n'existe pas sur votre poste.

:::{admonition} À faire
Dans la copie ci-dessous, remplacez les trois chemins par ceux de votre
poste : le chemin du dossier `1a_recette/` se lit dans la barre d'adresse de
l'explorateur de fichiers. Les `\` de Windows se remplacent par des `/` dans
le code. Exécutez : le programme écrit `travail/crepes.md`.
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
chemins ont été écrits. Le donner à quelqu'un d'autre, ou déplacer le
dossier, oblige à réécrire trois lignes. Un chemin absolu recopié dans un
code est l'erreur de `chemin.py` au TD 2b du cours 1.
:::

## 3 · Amélioration avec `pathlib`

### 3.1 · Importer `pathlib`, déclarer un chemin

`pathlib` est une bibliothèque livrée avec Python : rien à installer, une
ligne à importer. `Path("…")` déclare un chemin ; `/` lui ajoute un dossier
ou un fichier. Documentation :
[docs.python.org/fr/3/library/pathlib.html](https://docs.python.org/fr/3/library/pathlib.html).

```{code-cell} ipython3
from pathlib import Path

dossier = Path("C:/Users/alice/Desktop/cours3/1a_recette")
print(dossier)
print(dossier / "depart" / "recettes")
```

Un `Path` s'écrit avec des `/`, quel que soit le système ; sous Windows, il
s'affiche avec des `\`. Rien n'est vérifié à la déclaration : le dossier
d'Alice n'existe pas ici, et la cellule passe.

### 3.2 · Le même code, avec des variables

Les chemins sortent du code et deviennent des variables, déclarées dans un
bloc à part. Le code, lui, ne contient plus que les noms des variables.

```{code-cell} ipython3
# Déclaration brute : trois chaînes, à modifier toutes les trois pour changer de poste
FICHIER_INGREDIENTS = "C:/Users/alice/Desktop/cours3/1a_recette/depart/recettes/crepes/ingredients.csv"
FICHIER_RECETTE = "C:/Users/alice/Desktop/cours3/1a_recette/depart/recettes/crepes/recette.md"
FICHIER_SORTIE = "C:/Users/alice/Desktop/cours3/1a_recette/travail/crepes.md"
```

Avec `pathlib`, une seule valeur est écrite en dur, la racine du TD ; les
autres chemins s'en déduisent, en relatif.

```{code-cell} ipython3
:tags: [corrige]

# Déclaration avec pathlib : RACINE en dur, les trois chemins déduits avec /
RACINE = Path("C:/Users/alice/Desktop/cours3/1a_recette")

RECETTE = RACINE / "depart" / "recettes" / "crepes"
FICHIER_INGREDIENTS = RECETTE / "ingredients.csv"
FICHIER_RECETTE = RECETTE / "recette.md"
FICHIER_SORTIE = RACINE / "travail" / "crepes.md"
```

:::{admonition} À faire
Remplacez la valeur de `RACINE` par le chemin de votre dossier `1a_recette/`,
exécutez la cellule, puis le code ci-dessous : une seule ligne a changé par
rapport au code brut.
:::

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

Il reste une valeur écrite en dur, `RACINE`. Python connaît le dossier
courant, celui d'où partent les chemins relatifs : `Path.cwd()`. Dans un
notebook, c'est le dossier du fichier `.ipynb`, ici `travail/` : le serveur
Jupyter y place le noyau au démarrage. Ce n'est pas le dossier de
l'interpréteur Python, `sys.executable`, qui est ailleurs.

```{code-cell} ipython3
import sys

print(Path.cwd())
print(sys.executable)
print((Path.cwd() / "recette.ipynb").exists())
```

`exists()` dit si un chemin existe sur le disque : le notebook est bien dans
le dossier courant. La racine du TD est le dossier au-dessus : `parent`, ou
`..` dans un chemin relatif.

```{code-cell} ipython3
print(Path.cwd().parent)                 # le dossier au-dessus, en absolu
print(Path("..") / "depart" / "recettes")   # le même dossier, en relatif : tel qu'écrit
print((Path("..") / "depart" / "recettes").resolve())   # resolve() le rend absolu
```

Un chemin relatif s'affiche tel qu'il a été écrit, `..` compris ; `resolve()`
le colle au dossier courant et rend le chemin absolu. Les deux désignent le
même dossier. `RACINE` n'a donc plus à être écrite.

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
`depart/` et `travail/` soient côte à côte : c'est ce que l'archive garantit.

### 3.4 · Généraliser à plusieurs recettes

Le code traite une seule recette, `crepes`, et le fichier produit porte un
nom générique. `depart/recettes/` contient quatre dossiers, un par recette,
tous construits de la même façon. Pour produire une page par recette, il
faut lister ces dossiers, et déduire le nom du fichier de sortie du nom du
dossier. `pathlib` sait faire les deux.

```{code-cell} ipython3
RECETTES = RACINE / "depart" / "recettes"

# iterdir() donne chaque entrée du dossier, fichiers et dossiers, sans ordre
for dossier in RECETTES.iterdir():
    print(dossier)
```

```{code-cell} ipython3
# sorted() les trie ; is_dir() garde les dossiers ; name est le dernier morceau du chemin
for dossier in sorted(RECETTES.iterdir()):
    if dossier.is_dir():
        print(dossier.name)
```

```{code-cell} ipython3
:tags: [corrige]

# Pour chaque dossier de recette : le fichier de sortie déduit du nom, et si ingredients.csv existe
for dossier in sorted(RECETTES.iterdir()):
    if dossier.is_dir():
        fichier_sortie = RACINE / "travail" / (dossier.name + ".md")
        print(dossier.name, "->", fichier_sortie.name, (dossier / "ingredients.csv").exists())
```

Le programme de la section 3.3, dans la boucle : les chemins de la recette
partent de `dossier`, le fichier de sortie de `dossier.name`.

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

        with open(RACINE / "travail" / (dossier.name + ".md"), "w", encoding="utf-8") as fichier:
            fichier.write(complete)
        print(dossier.name, "écrit")
```

## 4 · Convertir avec pandoc

`crepes.md` est un fichier Markdown, dans `travail/`. pandoc, livré avec
Anaconda, le convertit en page HTML, en document Word et en beaucoup
d'autres formats. C'est un programme, pas une bibliothèque Python : il se
lance dans le terminal. Documentation :
[pandoc.org/MANUAL.html](https://pandoc.org/MANUAL.html) (toutes les options)
et [pandoc.org/demos.html](https://pandoc.org/demos.html) (des exemples de
commandes).

### 4.1 · Dans le terminal

Dans Anaconda Prompt, se placer dans `travail/` (le chemin affiché par
`Path.cwd()` à la section 3.3), puis convertir :

```
(base) C:\Users\moi> cd Desktop\cours3\1a_recette\travail
(base) C:\Users\moi\Desktop\cours3\1a_recette\travail> pandoc crepes.md -o crepes.html
```

`pandoc` reçoit le fichier à lire, puis `-o` et le fichier à écrire. `-o`
est le raccourci d'`--output`, la sortie ; beaucoup de programmes ont de
même `-i` pour `--input`, l'entrée, mais pandoc prend l'entrée sans option.
Le format de sortie est déduit de l'extension. Ouvrir `crepes.html` par un
double-clic.

### 4.2 · Depuis le notebook, avec `!`

Une cellule qui commence par `!` n'est pas du Python : la ligne est passée
au terminal, et sa sortie s'affiche sous la cellule. C'est propre aux
notebooks, et pratique pour essayer une commande sans changer de fenêtre.

```{code-cell} ipython3
!pandoc --version
```

La conversion la plus simple, puis ses options, une à la fois. Après chaque
cellule, les premiers caractères du fichier produit montrent ce qui a changé.

```{code-cell} ipython3
!pandoc crepes.md -o crepes.html
print(Path("crepes.html").read_text(encoding="utf-8")[:120])
```

Sans option, pandoc écrit un fragment : le contenu, sans en-tête ni
`<html>`. Le navigateur l'affiche quand même, sans titre d'onglet.
`--standalone`, ou `-s`, demande une page complète.

```{code-cell} ipython3
!pandoc crepes.md -o crepes.html --standalone
print(Path("crepes.html").read_text(encoding="utf-8")[:120])
```

Le titre de la page est pris sur le nom du fichier, `crepes` ; pandoc 2
l'écrit en avertissement. `--metadata title=…` le donne.

```{code-cell} ipython3
!pandoc crepes.md -o crepes.html --standalone --metadata title=Crêpes
```

`--css` inscrit dans la page le lien vers une feuille de style. Le chemin
donné est celui que le navigateur suivra depuis la page : la feuille est
donc copiée à côté d'elle, depuis `depart/`.

```{code-cell} ipython3
import shutil

shutil.copy(RACINE / "depart" / "style.css", "style.css")
!pandoc crepes.md -o crepes.html --standalone --metadata title=Crêpes --css style.css
```

`--toc` ajoute une table des matières, construite sur les titres.

```{code-cell} ipython3
!pandoc crepes.md -o crepes.html --standalone --metadata title=Crêpes --css style.css --toc
```

Ouvrir `crepes.html` à chaque étape pour voir la différence. Le format de
sortie suit l'extension : `.docx` pour Word, `.odt` pour LibreOffice, `.txt`
avec `-t plain` pour du texte sans balise.

```{code-cell} ipython3
!pandoc crepes.md -o crepes.docx
!pandoc crepes.md -o crepes.txt -t plain
print(Path("crepes.txt").read_text(encoding="utf-8")[:200])
```

pandoc lit aussi la plupart des formats qu'il écrit : le document Word
revient en Markdown.

```{code-cell} ipython3
!pandoc crepes.docx -o retour.md
print(Path("retour.md").read_text(encoding="utf-8")[:300])
```

```{code-cell} ipython3
!pandoc --list-output-formats
```

### 4.3 · Où le terminal trouve pandoc

Le terminal a lancé `pandoc` sans qu'on lui dise où est le programme. Il l'a
cherché dans une liste de dossiers, la variable d'environnement `PATH`.
`shutil.which` fait la même recherche et rend le chemin absolu trouvé.

```{code-cell} ipython3
chemin = shutil.which("pandoc")
print(chemin)
```

Appeler le programme par son chemin absolu revient au même ; `{chemin}`
insère la variable Python dans la ligne de commande.

```{code-cell} ipython3
!"{chemin}" --version
```

Les variables d'environnement sont lisibles depuis Python dans
`os.environ`, un dictionnaire. `PATH` en est une : une seule chaîne, où les
dossiers sont séparés par `;` sous Windows et `:` ailleurs ; `os.pathsep`
donne le bon séparateur.

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
cette liste. `conda activate` modifie le `PATH` : c'est ce qui fait qu'une
commande existe dans un environnement et pas dans un autre. Sous Windows,
conda range les programmes qui ne sont pas du Python, pandoc compris, dans
`Library\bin`.

### 4.4 · Appeler pandoc depuis Python

`!` n'existe que dans un notebook. Un programme Python appelle une commande
par la bibliothèque standard : `os.system`, la ligne telle qu'on l'aurait
tapée, ou `subprocess.run`, la commande en liste. La seconde est la forme à
retenir : chaque argument arrive au programme tel quel, on récupère ce qu'il
affiche, et `check=True` transforme un échec en erreur Python.

```{code-cell} ipython3
# os.system : la ligne de commande en une chaîne ; rend le code de retour, 0 si tout va bien
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
# capture_output=True récupère l'affichage du programme ; text=True le rend en chaîne
resultat = subprocess.run(["pandoc", "--version"], capture_output=True, text=True)
print(resultat.returncode)
print(resultat.stdout.splitlines()[0])
```

Un chemin `Path` se passe à `subprocess` par `str(chemin)` : la commande ne
prend que des chaînes. C'est la forme que le TD 3a emploie dans le programme
`recette.py`.
