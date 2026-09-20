---
title: Images
subtitle: Un fichier texte, un fichier binaire, et ce qui les distingue
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Images : texte et binaire

Ce notebook compare un format texte et un format binaire sur des données qui
ne sont pas du texte : des nombres, pas des phrases. Il prend pour cela des
images au format PGM, qui existe dans les deux variantes.

Un fichier PGM est une image en niveaux de gris : un en-tête de trois lignes
(le nom du format, la largeur et la hauteur, la valeur du blanc), puis une
valeur par pixel, 0 pour le noir, 255 pour le blanc. Dans la variante `P2`,
chaque valeur est écrite en chiffres, séparée de la suivante par un espace ou
un retour à la ligne ; dans la variante `P5`, chaque valeur occupe un octet,
sans séparateur. L'en-tête est du texte dans les deux cas. La valeur du blanc
peut aller jusqu'à 65535 : au-dessus de 255, un pixel prend deux octets en
`P5`. Une image en noir et blanc pur, 0 ou 1, est un PBM (`P1`, `P4`) ; une
image en couleur, trois valeurs par pixel, un PPM (`P3`, `P6`). Documentation :
[netpbm.sourceforge.net/doc/pgm.html](https://netpbm.sourceforge.net/doc/pgm.html).
Pillow, livré avec Anaconda, lit et écrit les deux variantes, et tous les
autres formats rencontrés ici.

Les cellules s'exécutent pendant l'exposé, par `Maj` + `Entrée`. Celles qui
ne contiennent qu'un commentaire sont à compléter avec ce que la diapositive
montre. Ce que vous fabriquez va dans `travail/`.

## 1 · Un fichier texte qui est une image

`depart/motif.pgm` s'ouvre dans un éditeur de texte : trois lignes d'en-tête
(le format, la taille, la valeur maximale), puis un nombre par pixel.

```{code-cell} ipython3
from pathlib import Path

motif = Path("depart/motif.pgm")
print(motif.read_text())
```

```{code-cell} ipython3
from PIL import Image

image = Image.open(motif)
image.size, image.mode
```

```{code-cell} ipython3
:tags: [corrige]

# Agrandir l'image 40 fois, sans lisser, pour voir chaque pixel
image.resize((160, 160), Image.NEAREST)
```

## 2 · La même image en binaire

Pillow enregistre un `.pgm` dans la variante binaire du même format : le même
en-tête, en clair, puis un octet par pixel au lieu d'un nombre écrit en
chiffres.

```{code-cell} ipython3
:tags: [corrige]

# Enregistrer l'image dans travail/motif.pgm, puis lire les octets du fichier produit
TRAVAIL = Path("travail")
TRAVAIL.mkdir(exist_ok=True)

image.save(TRAVAIL / "motif.pgm")
octets = (TRAVAIL / "motif.pgm").read_bytes()
octets
```

```{code-cell} ipython3
print(len(motif.read_bytes()), "octets en texte,", len(octets), "en binaire")
```

```{code-cell} ipython3
:tags: [corrige]

# Les mêmes octets en hexadécimal, séparés par des espaces
octets.hex(" ")
```

Les onze premiers octets sont l'en-tête, `P5`, `4 4`, `255`, séparés par
des retours à la ligne (`0a`). Les seize suivants sont les pixels : `00`
vaut 0, `ff` vaut 255.

Le fichier texte est lui aussi une suite d'octets : un par caractère, selon
le code ASCII. `255` y occupe trois octets, `32 35 35`, plus un espace, `20`.

```{code-cell} ipython3
print(motif.read_bytes()[:23].hex(" "))   # les 23 premiers octets du fichier texte : l'en-tête et la première ligne de pixels
```

## 3 · Lire n'importe quel fichier octet par octet

Un éditeur hexadécimal affiche ce que la cellule précédente montre, avec la
position de chaque octet et le caractère correspondant. Une fonction de six
lignes fait la même chose, pour n'importe quel fichier.

```{code-cell} ipython3
:tags: [corrige]

# Les n premiers octets d'un fichier, seize par ligne : position, hexadécimal, caractère si c'en est un
def hexdump(chemin, n=32, largeur=16):
    """Les n premiers octets d'un fichier, en hexadécimal et en caractères."""
    donnees = Path(chemin).read_bytes()[:n]
    for debut in range(0, len(donnees), largeur):
        tranche = donnees[debut:debut + largeur]
        texte = "".join(chr(octet) if 32 <= octet < 127 else "." for octet in tranche)
        print(f"{debut:04x}  {tranche.hex(' '):<{largeur * 3}} {texte}")


hexdump(TRAVAIL / "motif.pgm")
```

```{code-cell} ipython3
hexdump(motif)
```

Le fichier texte n'a que des caractères affichables ; le binaire en a onze,
puis des octets que la colonne de droite remplace par un point.

## 4 · Trois formats réels pour la même image

BMP et PNG sont les formats que Windows ouvre par un double-clic. Chacun
commence par une signature qui le nomme : `BM`, `‰PNG`. PGM commence par
`P5`. Les premiers octets disent le format, l'extension ne fait que le
rappeler.

```{code-cell} ipython3
:tags: [corrige]

# Enregistrer le motif en BMP et en PNG dans travail/, puis la taille de chaque fichier motif.*
image.save(TRAVAIL / "motif.bmp")
image.save(TRAVAIL / "motif.png")

for fichier in sorted(TRAVAIL.glob("motif.*")):
    print(f"{fichier.name:12} {fichier.stat().st_size:5} octets")
```

```{code-cell} ipython3
hexdump(TRAVAIL / "motif.bmp")
```

```{code-cell} ipython3
hexdump(TRAVAIL / "motif.png")
```

## 5 · Une vraie image, en quatre formats

*La Grande Vague* de Hokusai, 2 000 pixels de large, en JPEG. Convertie en
niveaux de gris, elle s'enregistre en PGM binaire, en PNG, en BMP, en JPEG,
et en PGM texte, cette dernière par une boucle écrite ici.

```{code-cell} ipython3
vague = Image.open("depart/vague.jpg")
print(vague.size, vague.mode)
vague.resize((600, 403))
```

```{code-cell} ipython3
:tags: [corrige]

# En niveaux de gris, puis enregistrée dans travail/ en vague.pgm, vague.png, vague.bmp et vague.jpg (qualité 85)
gris = vague.convert("L")

gris.save(TRAVAIL / "vague.pgm")
gris.save(TRAVAIL / "vague.png")
gris.save(TRAVAIL / "vague.bmp")
gris.save(TRAVAIL / "vague.jpg", quality=85)
```

```{code-cell} ipython3
:tags: [corrige]

# La version texte, vague_texte.pgm : l'en-tête P2, puis une ligne de nombres par ligne de pixels
largeur, hauteur = gris.size
donnees = gris.tobytes()          # un octet par pixel, ligne après ligne

lignes = [f"P2\n{largeur} {hauteur}\n255"]
for i in range(hauteur):
    ligne = donnees[i * largeur:(i + 1) * largeur]
    lignes.append(" ".join(str(octet) for octet in ligne))

(TRAVAIL / "vague_texte.pgm").write_text("\n".join(lignes) + "\n")
```

```{code-cell} ipython3
pixels = largeur * hauteur
print(f"{pixels:,} pixels\n")
for fichier in sorted(TRAVAIL.glob("vague*")):
    taille = fichier.stat().st_size
    print(f"{fichier.name:18} {taille:>10,} octets   {taille / pixels:5.2f} octet(s) par pixel")
```

La taille d'un fichier d'image non compressé se calcule : largeur × hauteur
× octets par valeur, plus l'en-tête. Le PGM binaire fait un octet par pixel,
plus 17 octets d'en-tête (`P5`, `2000 1344`, `255` et trois retours à la
ligne). Le BMP fait un octet par pixel, plus 1 078 octets d'en-tête et de
palette. Le texte fait plus de trois octets par pixel : chaque valeur a un à
trois chiffres, suivis d'un espace.

```{code-cell} ipython3
:tags: [corrige]

# La taille attendue du PGM binaire : les pixels, un octet chacun, plus l'en-tête ; à comparer à la taille réelle
entete = f"P5\n{largeur} {hauteur}\n255\n"
attendu = largeur * hauteur * 1 + len(entete)
print(attendu, "octets attendus,", (TRAVAIL / "vague.pgm").stat().st_size, "réels")
```

PNG et JPEG sont plus petits parce qu'ils sont compressés. Compresser, c'est
écrire une répétition une fois, avec le nombre de fois, au lieu de répéter
la valeur : la ligne `0 0 0 0 0 255 255 0` s'écrit `5×0 2×255 1×0`. PNG le
fait sans perte, avec l'algorithme des fichiers ZIP (deflate) : les pixels
relus sont exactement ceux de départ. `zlib.compress` applique cet algorithme
aux pixels bruts. JPEG compresse avec perte : des détails sont abandonnés, et
l'image relue n'est pas exactement celle de départ.

```{code-cell} ipython3
import zlib

comprime = zlib.compress(donnees)   # les pixels bruts, compressés comme dans un ZIP
print(len(donnees), "octets bruts,", len(comprime), "compressés,", (TRAVAIL / "vague.png").stat().st_size, "en PNG")
```

PNG obtient moins que `zlib` seul parce qu'il transforme d'abord chaque ligne
(il écrit la différence avec le pixel voisin, plus souvent répétée que la
valeur elle-même) avant de compresser.

## 6 · Le temps de lecture

`%timeit` lance la cellule plusieurs fois et donne le temps moyen. `load()`
force Pillow à lire les pixels, ce qu'`open` seul ne fait pas.

```{code-cell} ipython3
%timeit -r 3 -n 1 Image.open(TRAVAIL / "vague_texte.pgm").load()
```

```{code-cell} ipython3
%timeit -r 3 -n 1 Image.open(TRAVAIL / "vague.pgm").load()
```

```{code-cell} ipython3
%timeit -r 3 -n 1 Image.open(TRAVAIL / "vague.png").load()
```

```{code-cell} ipython3
%timeit -r 3 -n 1 Image.open(TRAVAIL / "vague.jpg").load()
```

En binaire, l'octet lu est déjà la valeur du pixel : la lecture est une
copie. En texte, chaque nombre est une suite de chiffres à reconnaître et à
convertir, et il y en a un par pixel. PNG et JPEG sont plus petits sur le
disque, et demandent un calcul pour retrouver les pixels.

## 7 · ASCII et UTF-8

Un caractère est un nombre. Le code ASCII en définit 128, écrits sur un octet
chacun : les lettres sans accent, les chiffres, la ponctuation, l'espace et le
retour à la ligne. UTF-8 reprend ces 128 codes sur les mêmes octets, et écrit
tous les autres caractères sur deux, trois ou quatre octets : `é` et `œ` en
prennent deux, `😀` quatre. `len` compte les caractères ; `encode` donne les
octets.

```{code-cell} ipython3
:tags: [corrige]

# Pour "a", "é", "œ" et "😀" : le nombre de caractères, puis les octets en UTF-8
for texte in ("a", "é", "œ", "😀"):
    octets = texte.encode("utf-8")
    print(texte, len(texte), "caractère,", len(octets), "octet(s) :", octets.hex(" "))
```

```{code-cell} ipython3
:tags: [raises-exception]

"œ".encode("ascii")   # œ n'a pas de code ASCII
```

Le mot « œuf » a trois caractères et, en UTF-8, quatre octets ; « oeuf »,
écrit sans la ligature, en a quatre et quatre. `œ` n'existe ni en ASCII, ni
en ISO 8859-1, l'encodage courant des textes français avant UTF-8 : c'est
pourquoi les fichiers anciens écrivent « oeuf ».

```{code-cell} ipython3
for mot in ("œuf", "oeuf"):
    octets = mot.encode("utf-8")
    print(mot, len(mot), "caractères,", len(octets), "octets :", octets.hex(" "))
```

Des noms de communes de France portent ces caractères : Œuilly (Aisne, et
Marne), Plœuc-L'Hermitage (Côtes-d'Armor), L'Haÿ-les-Roses (Val-de-Marne),
Aÿ-Champagne (Marne). Un fichier en ASCII ne peut pas les écrire ; pour
qu'ils apparaissent tels quels sur une carte, le fichier qui les porte est
en UTF-8, et le programme qui le lit écrit `encoding="utf-8"`.

```{code-cell} ipython3
:tags: [corrige]

# Pour chaque nom : le nombre de caractères et le nombre d'octets en UTF-8
for nom in ("Œuilly", "Plœuc-L'Hermitage", "L'Haÿ-les-Roses", "Aÿ-Champagne"):
    octets = nom.encode("utf-8")
    print(nom, len(nom), "caractères,", len(octets), "octets")
```
