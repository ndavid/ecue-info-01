---
title: Images
subtitle: Comparaison d'un fichier texte et d'un fichier binaire
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# Images : texte et binaire

Ce notebook compare un fichier texte et un fichier binaire qui contiennent
la même image. Les exemples utilisent le format d'image PGM, un format simple
qui existe en deux variantes : texte et binaire.

Un fichier PGM représente une image en niveaux de gris. Il contient :

- un en-tête de trois lignes : le nom du format, la largeur et la hauteur,
  la valeur du blanc ;
- une valeur par pixel, de 0 pour le noir à la valeur du blanc, en général
  255.

Les deux variantes diffèrent par l'écriture des pixels :

- en `P2` (texte), chaque valeur est écrite en chiffres, suivie d'un espace
  ou d'un retour à la ligne ;
- en `P5` (binaire), chaque valeur est écrite sur un octet, sans
  séparateur. Si la valeur du blanc dépasse 255 (elle peut aller jusqu'à
  65535), chaque pixel occupe deux octets.

Dans les deux variantes, l'en-tête est écrit en texte.

Le PGM fait partie d'une famille de formats : le PBM (`P1`, `P4`) pour les
images en noir et blanc, avec des valeurs 0 ou 1, et le PPM (`P3`, `P6`) pour
les images en couleur, avec trois valeurs par pixel. Documentation :
[netpbm.sourceforge.net/doc/pgm.html](https://netpbm.sourceforge.net/doc/pgm.html).

La bibliothèque Pillow, livrée avec Anaconda, lit et écrit les deux
variantes, ainsi que les autres formats d'image utilisés dans ce notebook.

Les cellules s'exécutent pendant l'exposé avec `Maj` + `Entrée`. Les
cellules qui ne contiennent qu'un commentaire sont à compléter à partir de la
diapositive. Les fichiers créés par le notebook sont écrits dans `travail/`.

## 1 · Une image au format texte : PGM `P2`

Le fichier `depart/motif.pgm` est au format `P2` : il peut s'ouvrir dans un
éditeur de texte. Il contient trois lignes d'en-tête (le format, la taille,
la valeur maximale), puis un nombre par pixel. `read_text()` renvoie ce
contenu sous forme de texte.

```{code-cell} ipython3
from pathlib import Path

motif = Path("depart/motif.pgm")
print(motif.read_text())
```

La bibliothèque Pillow ouvre le même fichier comme une image. `size` donne
la largeur et la hauteur en pixels, `mode` le type d'image : `'L'` pour les
niveaux de gris.

```{code-cell} ipython3
from PIL import Image

image = Image.open(motif)
image.size, image.mode
```

L'image ne fait que 4 × 4 pixels. La méthode `resize` renvoie une copie
agrandie à 160 × 160 pixels. Avec `Image.NEAREST`, chaque pixel est recopié
sans lissage : les seize pixels restent distincts.

```{code-cell} ipython3
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

*Les sections 3 à 6 se lisent et s'exécutent après la séance. En séance, passer à la section 7.*

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

Dans la colonne de droite, `hexdump` affiche un point à la place de chaque
octet qui ne correspond pas à un caractère affichable.

- Dans le fichier texte, les seuls points sont les retours à la ligne
  (`0a`) : tous les autres octets sont des caractères.
- Dans le fichier binaire, les onze premiers octets sont l'en-tête, écrit en
  texte. Les seize octets suivants sont les pixels, `00` et `ff` : ce ne
  sont pas des caractères affichables, ils apparaissent donc tous comme des
  points.

## 4 · Trois formats réels pour la même image

Sous Windows, les images aux formats BMP et PNG s'ouvrent par un
double-clic. Chaque fichier commence par quelques octets fixes, appelés
signature, qui identifient son format : `BM` pour BMP, `‰PNG` pour PNG, `P5`
pour PGM binaire. `Image.open` reconnaît le format d'un fichier d'après sa
signature, et non d'après l'extension de son nom.

Le format du fichier écrit par `save` dépend de l'extension du nom de
fichier, comme à la section 2 pour `motif.pgm`.

```{code-cell} ipython3
:tags: [corrige]

# Enregistrer le motif dans travail/ en BMP (motif.bmp) et en PNG (motif.png)
image.save(TRAVAIL / "motif.bmp")
image.save(TRAVAIL / "motif.png")
```

`glob("motif.*")` renvoie les chemins du dossier dont le nom correspond au
motif : `*` remplace n'importe quelle suite de caractères. `stat().st_size`
renvoie la taille du fichier en octets.

```{code-cell} ipython3
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

Le fichier `depart/vague.jpg` contient *La Grande Vague* de Hokusai, une
image en couleur de 2 000 pixels de large, au format JPEG. Dans cette
section, l'image est convertie en niveaux de gris, puis enregistrée dans
cinq fichiers : PGM binaire, PNG, BMP, JPEG et PGM texte.

```{code-cell} ipython3
vague = Image.open("depart/vague.jpg")
print(vague.size, vague.mode)
vague.resize((600, 403))
```

La méthode `convert("L")` renvoie une copie de l'image en niveaux de gris,
un octet par pixel. `L` est le mode des images en niveaux de gris, déjà vu
avec `image.mode` à la section 1. La copie est enregistrée en PGM binaire.

```{code-cell} ipython3
gris = vague.convert("L")
gris.save(TRAVAIL / "vague.pgm")
```

```{code-cell} ipython3
:tags: [corrige]

# Enregistrer gris dans travail/ en PNG (vague.png) et en BMP (vague.bmp), sur le modèle de la cellule précédente
gris.save(TRAVAIL / "vague.png")
gris.save(TRAVAIL / "vague.bmp")
```

Pour le JPEG, l'argument `quality` règle la compression, de 1 à 95 : plus
la valeur est basse, plus le fichier est petit et plus l'image perd de
détails.

```{code-cell} ipython3
gris.save(TRAVAIL / "vague.jpg", quality=85)
```

Pillow n'écrit pas la variante texte `P2`. La cellule suivante l'écrit
sans Pillow, à exécuter et à lire :

- `gris.tobytes()` renvoie les pixels dans une suite d'octets, un octet par
  pixel, ligne après ligne ;
- la ligne de pixels numéro `i` va de l'octet `i * largeur` à l'octet
  `(i + 1) * largeur` ;
- chaque ligne de pixels devient une ligne de texte : les valeurs écrites en
  chiffres, séparées par des espaces ;
- le fichier contient l'en-tête, puis ces lignes.

```{code-cell} ipython3
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

L'en-tête du PGM binaire est du texte : chaque caractère occupe un octet,
et `len(entete)` donne donc sa taille en octets.

```{code-cell} ipython3
entete = f"P5\n{largeur} {hauteur}\n255\n"
print(repr(entete), len(entete), "octets")
```

```{code-cell} ipython3
:tags: [corrige]

# Calculer la taille attendue du PGM binaire (un octet par pixel, plus l'en-tête), puis l'afficher avec la taille réelle de travail/vague.pgm
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
retour à la ligne. 
UTF-8 reprend ces 128 codes sur les mêmes octets, et écrit tous les autres caractères sur deux, trois ou quatre octets : `é` et `œ` en prennent deux, `😀` quatre. 
`len` compte les caractères ; `encode` donne les octets.

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

En UTF-8, le premier octet d'un caractère indique sur combien d'octets le
caractère est écrit. Le nombre d'octets se lit sur les premiers bits de cet
octet, écrit en binaire :

| Premier octet, en binaire | En hexadécimal | Nombre d'octets du caractère |
|---|---|---|
| `0xxxxxxx` | `00` à `7f` | 1 : les 128 caractères ASCII |
| `110xxxxx` | `c2` à `df` | 2 |
| `1110xxxx` | `e0` à `ef` | 3 |
| `11110xxx` | `f0` à `f4` | 4 |

Les octets suivants du caractère commencent tous par `10` en binaire (`80` à
`bf` en hexadécimal). Un premier octet ne commence jamais par `10` : un
programme ne peut donc pas les confondre. Les bits notés `x`, mis bout à
bout, forment le numéro du caractère.

La cellule suivante affiche chaque octet en hexadécimal et en binaire.

```{code-cell} ipython3
# Chaque octet en hexadécimal, puis en binaire sur 8 bits
for texte in ("a", "é", "œ", "😀"):
    print(texte, " ".join(f"{octet:02x}={octet:08b}" for octet in texte.encode("utf-8")))
```

Pour `é`, le premier octet `c3` s'écrit `11000011` : il commence par `110`,
le caractère occupe donc deux octets, `c3 a9`. Pour `😀`, le premier octet
`f0` commence par `11110` : le caractère occupe quatre octets.

Un programme qui lit un fichier en UTF-8 applique cette règle octet après
octet. En pseudo-code :

```text
position ← 0
texte ← chaîne vide
tant que position < nombre d'octets du fichier :
    premier ← octets[position]
    si premier commence par 0 en binaire      : n ← 1
    sinon si premier commence par 110         : n ← 2
    sinon si premier commence par 1110        : n ← 3
    sinon si premier commence par 11110       : n ← 4
    sinon : erreur, le fichier n'est pas en UTF-8
    vérifier que les n - 1 octets suivants commencent par 10,
        sinon : erreur, le fichier n'est pas en UTF-8
    caractère ← le caractère dont le numéro est formé par les bits x
                des octets[position] à octets[position + n - 1]
    ajouter caractère à la fin de texte
    position ← position + n
```

C'est ce que fait Python quand un fichier est ouvert avec
`encoding="utf-8"`, ou quand on appelle `octets.decode("utf-8")`. Si la
règle n'est pas respectée, Python lève une erreur `UnicodeDecodeError`.

Lus avec un autre encodage, les mêmes octets donnent d'autres caractères.
En `cp1252`, chaque octet est un caractère : `c3 a9` se lit `Ã©` au lieu
de `é`. C'est l'erreur montrée dans le notebook `fichiers`, section 3.

```{code-cell} ipython3
octets = "é".encode("utf-8")
print(octets.decode("utf-8"), octets.decode("cp1252"))
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
