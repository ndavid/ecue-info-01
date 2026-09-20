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

Les fonctions utiles du notebook précédent ouvrent, lisent et écrivent des
fichiers sans que ces lignes aient été expliquées : c'était pour aller au
but. Ce notebook reprend le code de la recette dans son dernier état et
explique ces lignes : ouvrir un fichier, le lire en bloc ou ligne par ligne,
y écrire, le fermer, et les modes d'ouverture.

Comme le précédent, il se copie de `depart/notebook/` dans `travail/` avant
d'être ouvert.

## 0 · Le point de départ

Les chemins de la section 3.3 du notebook précédent : la racine, dossier
parent de `travail/`, et les fichiers déduits.

```{code-cell} ipython3
from pathlib import Path

RACINE = Path.cwd().parent
RECETTE = RACINE / "depart" / "recettes" / "crepes"
FICHIER_INGREDIENTS = RECETTE / "ingredients.csv"
FICHIER_RECETTE = RECETTE / "recette.md"
TRAVAIL = RACINE / "travail"

print(FICHIER_RECETTE.exists(), TRAVAIL.exists())
```

## 1 · Ouvrir, lire, fermer

`open` ne rend pas le texte du fichier : il rend un objet fichier, qui a une
position de lecture. Il est nommé ici `fichier_ouvert`, pour le distinguer du
texte qu'on en lit ; dans les fonctions utiles du cours 1, il s'appelle
`fichier`. `read()` lit tout le texte depuis la position courante, en une
seule chaîne de caractères. `close()` ferme le fichier : tant qu'il est
ouvert, il est réservé par le programme.

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

Le texte lu est une seule chaîne. Les lignes y sont séparées par le
caractère de retour à la ligne, `\n`, que `print` n'affiche pas et que
`repr` montre. `readlines()` lit le fichier en une liste de chaînes, une par
ligne, chacune avec son `\n` final.

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

Sous Windows, les fichiers texte séparent souvent les lignes par deux
caractères, `\r\n` ; `open` les traduit en `\n` à la lecture, et fait
l'inverse à l'écriture. L'argument `newline` d'`open` règle cette traduction ;
le séparateur de lignes lui-même n'est pas un choix : c'est `\n`.

## 2 · `with` : fermer sans y penser

Un fichier ouvert doit être fermé, y compris quand une erreur survient entre
les deux. Le bloc `with` s'en charge : le fichier est ouvert à l'entrée du
bloc, disponible sous le nom donné après `as`, et fermé à la sortie, quoi
qu'il arrive. C'est la forme à employer.

```{code-cell} ipython3
with open(FICHIER_RECETTE, encoding="utf-8") as fichier_ouvert:   # ouvert pour la durée du bloc
    texte = fichier_ouvert.read()

print(fichier_ouvert.closed)   # à la sortie du bloc, déjà fermé
print(texte[:60])
```

## 3 · Les modes d'ouverture

Le deuxième argument d'`open` dit ce qu'on va faire du fichier. Sans lui,
c'est la lecture.

| Mode | Ce qu'il fait | Si le fichier n'existe pas | S'il existe |
|---|---|---|---|
| `"r"` | lire (défaut) | erreur | lu |
| `"w"` | écrire | créé | vidé, puis réécrit |
| `"a"` | ajouter à la fin | créé | conservé, complété |
| `"x"` | créer et écrire | créé | erreur |

Ces modes lisent et écrivent du texte, et demandent `encoding`. Un `b`
ajouté, `"rb"` ou `"wb"`, lit et écrit des octets, sans encodage : c'est le
sujet du notebook des images.

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

`encoding` dit comment les caractères sont écrits en octets. Sans lui,
Python prend l'encodage du système, `cp1252` sous Windows, et un fichier
écrit en UTF-8 se lit de travers. La cellule force `cp1252` pour montrer ce
qui arrive.

```{code-cell} ipython3
with open(essai, encoding="cp1252") as fichier_ouvert:   # le mauvais encodage : « é » devient « Ã© »
    print(fichier_ouvert.read())
```

## 4 · Lire ligne par ligne

`read()` et `readlines()` lisent tout le fichier d'un coup. Un objet fichier
se parcourt aussi avec `for` : à chaque tour de boucle, une ligne est lue,
avec son `\n` final, et la suivante n'est pas encore en mémoire. C'est la
façon de lire un fichier plus gros que la mémoire, ou dont on n'a besoin que
du début.

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
coupe aux virgules, en une liste de trois chaînes.

```{code-cell} ipython3
:tags: [corrige]

# Chaque ligne, sans son retour à la ligne, coupée aux virgules : une liste de trois chaînes
with open(FICHIER_INGREDIENTS, encoding="utf-8") as fichier_ouvert:
    for ligne in fichier_ouvert:
        morceaux = ligne.strip().split(",")
        print(morceaux)
```

La bibliothèque `csv` fait ce découpage, et traite aussi une virgule à
l'intérieur d'un champ entre guillemets, ce que `split` ne fait pas.
`next()` lit la première ligne, celle des noms de colonnes, et la laisse de
côté : c'est la fonction `lire_ingredients` du notebook précédent.

```{code-cell} ipython3
import csv

with open(FICHIER_INGREDIENTS, encoding="utf-8", newline="") as fichier_ouvert:
    lecteur = csv.reader(fichier_ouvert)   # découpe chaque ligne en liste de chaînes
    next(lecteur)                          # la ligne d'en-tête, laissée de côté
    for nom, quantite, unite in lecteur:
        print(nom, float(quantite), unite)
```

## 6 · Les raccourcis de `pathlib`

Ouvrir, lire tout, fermer : trois lignes qui reviennent souvent. Un `Path`
les fait en une seule.

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

`read_text` convient à un fichier qu'on lit en entier. Le `for ligne in
fichier` de la section 4 garde son intérêt pour un fichier trop gros pour
tenir en mémoire, ou qu'on veut arrêter de lire en route.
