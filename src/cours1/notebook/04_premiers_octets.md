---
title: Les premiers octets d'un fichier
subtitle: Lire ce qu'un fichier contient vraiment, plutôt que ce que son nom annonce
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

## Ce qu'on cherche

Le système choisit un logiciel d'après **l'extension du nom**. Le logiciel, lui,
ouvre le fichier et lit ses **premiers octets**. Les deux peuvent se
contredire — c'est ce qu'on va vérifier.

Ce notebook se lit de haut en bas, en exécutant chaque cellule. Le résultat
s'affiche sous la cellule qui l'a produit, et c'est toute la différence avec un
script.

:::{note}
L'ordre compte. Une cellule qui n'a pas été exécutée n'a rien changé, même si
son texte est à l'écran. En cas de doute : *Restart & Run All*.
:::

## Où sont les fichiers

Ceux du TD 1a : `cours1/1a_formats/depart/`, et le PDF que vous avez exporté
dans `cours1/1a_formats/travail/`.

```{code-cell} ipython3
from pathlib import Path

def dossier_seance(depart: Path = Path.cwd()) -> Path:
    """Le dossier de la séance, celui qui contient `1a_formats/`.

    Le notebook s'ouvre depuis l'archive du cours, depuis le dépôt ou pendant
    la construction du book, et le dossier courant change à chaque fois : on
    remonte donc jusqu'à le trouver.
    """
    for dossier in [depart, *depart.parents]:
        for candidat in (dossier, dossier / "data" / "cours1"):
            if (candidat / "1a_formats").is_dir():
                return candidat
    raise FileNotFoundError("dossier de la séance introuvable depuis " + str(depart))

# Dans le dépôt du cours, les fichiers fabriqués sont rangés dans produit/.
def dossier_td(nom: str) -> Path:
    td = dossier_seance() / nom
    return td / "produit" if (td / "produit").is_dir() else td

GENERE = dossier_td("1a_formats") / "depart"    # les fichiers donnés
EXPORTE = dossier_td("1a_formats") / "travail"  # ce que vous avez exporté

sorted(p.name for p in GENERE.glob("raven*"))
```

## Lire quatre octets, sans lire le reste

Un fichier peut peser des mégaoctets ; on n'en lit que le début.

```{code-cell} ipython3
def entete(chemin, taille=4):
    with open(chemin, "rb") as fichier:
        return fichier.read(taille)

entete(GENERE / "raven.odt")
```

Le `b` devant les guillemets signale des **octets**, pas du texte. Les deux
premiers se lisent (`PK`), les deux suivants n'ont pas de caractère affichable
et Python les écrit `\x03\x04`.

## Les mêmes octets, écrits autrement

```{code-cell} ipython3
def en_hexadecimal(octets):
    return " ".join(f"{octet:02X}" for octet in octets)

def en_caracteres(octets):
    return "".join(chr(o) if 32 <= o < 127 else "." for o in octets)

octets = entete(GENERE / "raven.odt")
en_hexadecimal(octets), en_caracteres(octets)
```

Rien n'a changé dans le fichier : `50 4B 03 04` et `PK..` sont deux façons
d'écrire les **mêmes** quatre octets.

## Un catalogue de signatures

Ces octets de tête s'appellent des **nombres magiques**. Chaque format en a un,
sauf le texte.

```{code-cell} ipython3
SIGNATURES = {
    b"PK\x03\x04": "archive ZIP, donc .odt, .docx, .xlsx ou .epub",
    b"%PDF": "document PDF",
    b"\x89PNG": "image PNG",
}

def format_reconnu(octets):
    for signature, description in SIGNATURES.items():
        if octets.startswith(signature):
            return description
    return "aucune signature : sans doute du texte"

# raven.pdf est celui que vous avez exporté depuis raven.odt au TD 1a.
pdf = EXPORTE / "raven.pdf"
if pdf.exists():
    print(format_reconnu(entete(pdf)))
else:
    print("raven.pdf manque : exportez-le depuis raven.odt (TD 1a), puis relancez")
```

## Le tableau complet

```{code-cell} ipython3
for chemin in [GENERE / "raven_une_ligne.txt", GENERE / "raven_une_ligne.donnees",
               GENERE / "raven.odt", GENERE / "raven_brut.html", EXPORTE / "raven.pdf"]:
    nom = chemin.name
    if not chemin.exists():
        print(f"{nom:26} introuvable")
        continue
    octets = entete(chemin)
    print(f"{nom:26} {en_hexadecimal(octets)}  {en_caracteres(octets):6} "
          f"{format_reconnu(octets)}")
```

## Ce que le tableau montre

Deux lignes portent des extensions différentes et **les mêmes octets** :
`raven_une_ligne.txt` et `raven_une_ligne.donnees`. L'extension n'a pas touché
au contenu.

Et les fichiers texte n'ont **aucune signature**. Ce n'est pas un manque : rien
dans un fichier texte ne dit de quoi il est fait, et c'est au logiciel qui
l'ouvre d'en décider. C'est pourquoi `.py`, `.md`, `.csv` et `.json` sont
indiscernables au niveau des octets.

## À vous

Copiez un fichier en changeant son extension, puis relisez ses octets.

```{code-cell} ipython3
import shutil

menteur = EXPORTE / "raven_odt.pdf"
shutil.copy(GENERE / "raven.odt", menteur)

octets = entete(menteur)
print(en_hexadecimal(octets), "→", format_reconnu(octets))
```

Le nom annonce un PDF, les octets disent une archive ZIP. **Un double-clic
lancerait le lecteur PDF, qui refuserait le fichier.**

:::{tip}
Essayez avec une image de votre choix : `entete(Path("…"))` puis
`format_reconnu(...)`. Si la signature n'est pas au catalogue, ajoutez-la.
:::
