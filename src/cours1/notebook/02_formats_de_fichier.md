---
title: Formats de fichier
subtitle: Un même texte sous quatre formes
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

## Préparation

Les fichiers de cette page sont fabriqués à partir de textes du domaine public.
Depuis un terminal, à la racine du dépôt :

```bash
cd data/cours1
python make_data.py fetch    # télécharge les sources, une seule fois
python make_data.py build    # produit les fichiers dans genere/
```

```{code-cell} python
from pathlib import Path

# Le dossier courant dépend de l'outil qui exécute la page (JupyterLab, VSCode,
# sphinx-build) : on remonte donc jusqu'à la racine du dépôt.
def racine_du_depot(depart: Path = Path.cwd()) -> Path:
    for dossier in [depart, *depart.parents]:
        if (dossier / "data" / "cours1").is_dir():
            return dossier
    raise FileNotFoundError("racine du dépôt introuvable depuis " + str(depart))

DONNEES = racine_du_depot() / "data" / "cours1" / "genere"
for fichier in sorted(DONNEES.iterdir()):
    if fichier.is_file():
        print(f"{fichier.name:<34} {fichier.stat().st_size:>6} octets")
```

Deux textes sont disponibles : *The Raven* d'Edgar Allan Poe (1845) et
*Auld Lang Syne* de Robert Burns (1788). La suite prend le poème ; refaites
ensuite les mêmes opérations avec la chanson.

## Ce que contient un fichier texte

```{code-cell} python
brut = (DONNEES / "raven_une_ligne.txt").read_text(encoding="utf-8")
print(f"{len(brut)} caractères, {brut.count(chr(10))} saut de ligne")
print(brut[:180], "…")
```

Le poème entier tient sur une seule ligne. Un fichier texte ne contient pas des
lignes : il contient des caractères, dont l'un, noté `\n`, signifie « saut de
ligne ». En l'absence de ce caractère, le texte n'est pas découpé.

:::{admonition} Manipulation 1 — remettre le texte en forme
:class: tip

Ouvrez `raven_une_ligne.txt` dans VSCode et rendez-le lisible : un vers par
ligne, une ligne vide entre les strophes. La ponctuation (`,` `—` `?`) et les
majuscules en début de vers vous servent de repères.

Comparez ensuite votre résultat avec `genere/_corrige/raven.txt`.

En ajoutant ces sauts de ligne, vous avez ajouté au fichier une information
qu'il ne contenait pas : sa structure. Elle n'était pas déductible
automatiquement.
:::

## Extension et contenu

```{code-cell} python
a = (DONNEES / "raven_une_ligne.txt").read_bytes()
b = (DONNEES / "raven_une_ligne.donnees").read_bytes()
print("Contenus identiques :", a == b)
```

Ces deux fichiers portent des extensions différentes et contiennent exactement
les mêmes octets. L'extension n'agit pas sur le contenu : elle indique au
système quel logiciel proposer par défaut.

:::{admonition} Manipulation 2 — renommer une extension
:class: tip

1. Affichez les extensions dans votre explorateur de fichiers. Elles sont
   masquées par défaut sous Windows et macOS ; activez-les une fois, vous en
   aurez besoin tout le semestre.
2. Double-cliquez sur `raven_une_ligne.donnees`. Le système ne sait pas quoi en
   faire.
3. Renommez-le en `.txt` : il s'ouvre dans un éditeur. Renommez-le en `.html` :
   le navigateur l'ouvre. Le fichier lui-même n'a pas changé.
:::

:::{warning}
Une extension peut donc être trompeuse, par erreur ou volontairement. Un fichier
reçu en `.pdf` peut contenir autre chose. Le seul moyen de savoir ce qu'un
fichier contient est de regarder ses octets, ce que nous ferons au cours 3 avec
un éditeur hexadécimal.
:::

## Structure d'un fichier `.odt`

Un `.txt` ne contient que des caractères ; il n'a aucun endroit où noter qu'un
mot est en gras. Un `.odt`, le format de LibreOffice Writer, le peut. La cellule
suivante montre comment.

```{code-cell} python
import zipfile

with zipfile.ZipFile(DONNEES / "raven.odt") as archive:
    for membre in archive.namelist():
        print(membre)
```

Un `.odt` est une archive ZIP contenant des fichiers XML. Le texte est dans
`content.xml`, entouré de balises qui décrivent la mise en forme. Les formats
`.docx`, `.xlsx` et `.epub` sont construits de la même façon.

:::{admonition} Manipulation 3 — ouvrir l'ODT, puis l'ouvrir autrement
:class: tip

Ouvrez `raven.odt` avec LibreOffice Writer et observez la mise en page.

Copiez-le ensuite sous le nom `raven.zip`, ouvrez-le comme une archive, et lisez
`content.xml` dans VSCode.
:::

## Contenu et présentation en HTML

En HTML, le contenu porte des balises qui décrivent sa structure. La
présentation est décrite ailleurs, dans une feuille de style CSS.

```{code-cell} python
print((DONNEES / "raven_brut.html").read_text(encoding="utf-8")[:400])
```

:::{admonition} Manipulation 4 — comparer deux rendus
:class: tip

1. Ouvrez `raven_brut.html` dans votre navigateur, par double-clic ou par
   glisser-déposer. L'adresse commence par `file://` : le navigateur lit un
   fichier local, sans serveur ni réseau.
2. Le poème s'affiche en un seul bloc. Les sauts de ligne présents dans le
   fichier ne sont pas rendus : en HTML, la structure se déclare avec des
   balises comme `<p>` et `<br>`.
3. Ouvrez `raven_style.html`. Le contenu est le même ; l'en-tête contient une
   ligne de plus, `<link rel="stylesheet" href="style.css">`.
4. Modifiez `style.css` dans VSCode (`background`, `font-family`, `max-width`)
   et rechargez la page avec `F5`.
:::

```{code-cell} python
print((DONNEES / "style.css").read_text(encoding="utf-8")[:300])
```

Le fichier de contenu et le fichier de style sont séparés : l'apparence change
sans que le texte soit touché. On retrouvera ce principe dans le Markdown d'un
`README`, et plus généralement dans la séparation entre un programme et sa
configuration.

## Bilan

```{list-table}
:header-rows: 1

* - Format
  - Contient
  - S'ouvre avec
  - Se versionne bien
* - `.txt`
  - des caractères
  - n'importe quel éditeur
  - oui
* - `.md`
  - des caractères et un balisage léger
  - un éditeur, l'aperçu VSCode
  - oui
* - `.html` et `.css`
  - des caractères, de la structure, du style
  - un éditeur et un navigateur
  - oui
* - `.odt`, `.docx`
  - une archive ZIP de fichiers XML
  - LibreOffice, Word
  - non
```

La dernière colonne annonce le cours 2. Un format texte se relit, se compare
ligne à ligne et se versionne ; une archive compressée, non.

:::{seealso}
Suite : [Environnement Python et notebooks](03_environnement_python.md).
:::
