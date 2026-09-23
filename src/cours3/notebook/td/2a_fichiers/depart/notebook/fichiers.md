---
title: Lecture et écriture de fichiers texte
execution: ../../travail
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Lecture et écriture de fichiers texte

Ce notebook reprend le code de la recette dans son dernier état et
explique les lignes de code des fonctions utiles: ouvrir un fichier, le lire en bloc ou ligne par ligne, y écrire, le fermer, et les modes d'ouverture.

Comme le précédent, il se copie de `depart/notebook/` dans `travail/` avant d'être ouvert.

## 0 · Le point de départ

Les chemins de la section 3.3 du notebook précédent : la racine, dossier parent de `travail/`, et les fichiers déduits.

```{code-cell} ipython3
from pathlib import Path

RACINE = Path.cwd().parent
RECETTE = RACINE / "depart" / "recettes" / "crepes"
FICHIER_INGREDIENTS = RECETTE / "ingredients.csv"
FICHIER_RECETTE = RECETTE / "recette.md"
TRAVAIL = RACINE / "travail"

print(FICHIER_RECETTE.exists(), TRAVAIL.exists())
```

## 1 · Ouvrir, lire, fermer un fichier en python

Pour lire ou écrire un fichier en python il faut commencer par l'ouvrir avec un chemin. Pour cela on utilise la fonction `open`, celle-ci ne renvoie pas le texte du fichier, mais un objet fichier qui garde une position de lecture (du premier au dernier caractère, ou du premeir au dernier octet). 
L'objet renvoyé est nommé ici `fichier_ouvert`, pour le distinguer du
texte qu'on en lit . 
la fonction `read()` lit tout le texte depuis la position courante, en une
seule chaîne de caractères. 
`close()` ferme le fichier : tant qu'il est ouvert, il est réservé par le programme.

```{code-cell} ipython3
fichier_ouvert = open(FICHIER_RECETTE, encoding="utf-8")   # ouvre : un objet fichier
print(fichier_ouvert)
```

```{code-cell} ipython3
texte = fichier_ouvert.read()   # lit tout le texte, d'un coup, depuis la position courante
print(type(texte), len(texte), "caractères")
print(texte[:60])
```

```{code-cell} ipython3
print(fichier_ouvert.read())    # la position est à la fin : plus rien à lire, la chaîne est vide
```

```{code-cell} ipython3
fichier_ouvert.close()          # ferme : le fichier est rendu au système
print(fichier_ouvert.closed)
```

```{code-cell} ipython3
:tags: [raises-exception]

fichier_ouvert.read()           # un fichier fermé ne se lit plus
```

`read()` renvoie tout le texte du fichier dans une seule chaîne de
caractères. Les lignes y sont séparées par le caractère de retour à la
ligne, noté `\n`. 
`print` affiche ce caractère comme un passage à la ligne, `repr` l'écrit `\n`.

`readlines()` renvoie une liste de chaînes, une par ligne du fichier. Chaque
ligne garde son `\n` à la fin.

```{code-cell} ipython3
print(repr(texte[:60]))         # repr montre les caractères tels qu'ils sont : le \n apparaît
```

```{code-cell} ipython3
fichier_ouvert = open(FICHIER_RECETTE, encoding="utf-8")
lignes = fichier_ouvert.readlines()   # une liste : une chaîne par ligne
fichier_ouvert.close()

print(type(lignes), len(lignes), "lignes")
print(repr(lignes[0]))
print(repr(lignes[1]))
```

Sous Windows, les lignes d'un fichier texte sont souvent séparées par deux
caractères, `\r\n`. À la lecture, `open` remplace `\r\n` par `\n`. À
l'écriture sous Windows, il remplace `\n` par `\r\n`. Dans le programme
Python, les lignes sont donc toujours séparées par `\n`. L'argument
`newline` d'`open` permet de modifier cette conversion.

## 2 · Fermer automatiquement un fichier avec `with`

Un fichier ouvert doit être fermé, même si une erreur se produit pendant sa
lecture ou son écriture. Le bloc `with` ferme le fichier automatiquement :

- le fichier est ouvert au début du bloc ;
- dans le bloc, il est accessible sous le nom écrit après `as` ;
- à la fin du bloc, il est fermé, y compris en cas d'erreur.

En Python, on ouvre en général les fichiers avec `with`.

```{code-cell} ipython3
with open(FICHIER_RECETTE, encoding="utf-8") as fichier_ouvert:   # ouvert pour la durée du bloc
    texte = fichier_ouvert.read()

print(fichier_ouvert.closed)   # à la sortie du bloc, déjà fermé
print(texte[:60])
```

## 3 · Les modes d'ouverture

Le deuxième argument d'`open` indique le mode d'ouverture du fichier. Par
défaut, le fichier est ouvert en lecture seule (mode `"r"`).

| Mode | Ce qu'il fait | Si le fichier n'existe pas | S'il existe |
|---|---|---|---|
| `"r"` | lire (défaut) | erreur | lu |
| `"w"` | écrire | créé | vidé, puis réécrit |
| `"a"` | ajouter à la fin | créé | conservé, complété |
| `"x"` | créer et écrire | créé | erreur |

Ces quatre modes ouvrent le fichier en mode texte : ils lisent et écrivent des chaînes de caractères, et utilisent l'argument `encoding`.

Si on ajoute la lettre `b` au mode (`"rb"`, `"wb"`), le fichier est ouvert en mode binaire (*binary* en anglais) : Python lit et écrit alors des octets, sans encodage. 
Le mode binaire est étudié dans le notebook suivant images.ipynb.

```{code-cell} ipython3
essai = TRAVAIL / "essai.txt"

with open(essai, "w", encoding="utf-8") as fichier_ouvert:   # "w" : créé, ou vidé s'il existait
    fichier_ouvert.write("première ligne\n")

print(essai.read_text(encoding="utf-8"))
```

```{code-cell} ipython3
with open(essai, "a", encoding="utf-8") as fichier_ouvert:   # "a" : ajouté à la fin
    fichier_ouvert.write("deuxième ligne\n")

print(essai.read_text(encoding="utf-8"))
```

```{code-cell} ipython3
with open(essai, "w", encoding="utf-8") as fichier_ouvert:   # "w" de nouveau : tout est remplacé
    fichier_ouvert.write("tout est remplacé\n")

print(essai.read_text(encoding="utf-8"))
```

```{code-cell} ipython3
:tags: [raises-exception]

open(TRAVAIL / "absent.txt", encoding="utf-8")   # "r" par défaut : le fichier doit exister
```

```{code-cell} ipython3
:tags: [raises-exception]

open(essai, "x", encoding="utf-8")   # "x" : le fichier ne doit pas exister
```

`encoding` dit comment les caractères sont écrits en octets. 
Sans lui, Python prend l'encodage du système, `cp1252` sous Windows, et un fichier écrit en UTF-8 se lit de travers. 
La cellule force `cp1252` pour montrer ce qui arrive avec un muavais encodage.

```{code-cell} ipython3
with open(essai, encoding="cp1252") as fichier_ouvert:   # le mauvais encodage : « é » devient « Ã© »
    print(fichier_ouvert.read())
```

## 4 · Lire ligne par ligne

`read()` et `readlines()` lisent tout le fichier d'un coup. 
Un objet fichier se parcourt aussi avec `for` : à chaque iteration une ligne est lue, en incluant son caractère de fin de ligne `\n`. 
C'est la façon de lire un fichier plus gros que la mémoire, ou dont on n'a besoin que du début ou que l'on peut traiter ligne à ligne.

```{code-cell} ipython3
with open(FICHIER_INGREDIENTS, encoding="utf-8") as fichier_ouvert:
    for ligne in fichier_ouvert:   # une ligne à la fois, avec son "\n" final
        print(repr(ligne))
```

```{code-cell} ipython3
:tags: [corrige]

# Afficher les trois premières lignes de la recette, puis s'arrêter avec break
with open(FICHIER_RECETTE, encoding="utf-8") as fichier_ouvert:
    numero = 0
    for ligne in fichier_ouvert:
        numero = numero + 1
        print(numero, ligne.strip())   # strip() enlève le \n final
        if numero == 3:
            break
```

## 5 · Le CSV

Une ligne du CSV est une chaîne : `strip()` enlève son `\n`, `split(",")` la
coupe aux virgules, en une liste de trois string.

```{code-cell} ipython3
:tags: [corrige]

# Chaque ligne, sans son retour à la ligne, coupée aux virgules : une liste de trois chaînes de caractères
with open(FICHIER_INGREDIENTS, encoding="utf-8") as fichier_ouvert:
    for ligne in fichier_ouvert:
        morceaux = ligne.strip().split(",")
        print(morceaux)
```

La bibliothèque `csv` fait ce découpage de façon automatique, et traite aussi une virgule à l'intérieur d'un champ entre guillemets, ce que `split` ne fait pas.
`next()` lit la première ligne (header), celle des noms de colonnes, et la laisse de côté : c'est la fonction `lire_ingredients` du notebook précédent.

```{code-cell} ipython3
import csv

with open(FICHIER_INGREDIENTS, encoding="utf-8", newline="") as fichier_ouvert:
    lecteur = csv.reader(fichier_ouvert)   # découpe chaque ligne en liste de chaînes
    next(lecteur)                          # la ligne d'en-tête, laissée de côté
    for nom, quantite, unite in lecteur:
        print(nom, float(quantite), unite)
```

## 6 · Les raccourcis de `pathlib`

Pour lire ou écrire un fichier en entier, il faut l'ouvrir, lire ou écrire
son contenu, puis le fermer. Les objets `Path` ont des méthodes qui font ces
trois opérations en une seule ligne :

- `read_text()` renvoie tout le texte du fichier ;
- `write_text(texte)` écrit `texte` dans le fichier et remplace son contenu ;
- `read_bytes()` renvoie tout le contenu du fichier sous forme d'octets.

| Avec `open` | Avec `pathlib` |
|---|---|
| `with open(chemin, encoding="utf-8") as fichier_ouvert:` puis `texte = fichier_ouvert.read()` | `texte = chemin.read_text(encoding="utf-8")` |
| `with open(chemin, "w", encoding="utf-8") as fichier_ouvert:` puis `fichier_ouvert.write(texte)` | `chemin.write_text(texte, encoding="utf-8")` |
| `with open(chemin, "rb") as fichier_ouvert:` puis `octets = fichier_ouvert.read()` | `octets = chemin.read_bytes()` |

```{code-cell} ipython3
:tags: [corrige]

# Le programme de la recette, avec read_text et write_text à la place des deux with
source = FICHIER_RECETTE.read_text(encoding="utf-8")
complete = source.replace("## Ingrédients", "## Ingrédients\n\n(tableau)")
(TRAVAIL / "essai.md").write_text(complete, encoding="utf-8")

print((TRAVAIL / "essai.md").read_text(encoding="utf-8")[:120])
```

`read_text` lit tout le fichier en une seule fois. Pour un fichier trop gros
pour la mémoire, ou pour arrêter la lecture avant la fin, on utilise la
boucle `for ligne in fichier_ouvert` de la section 4.
