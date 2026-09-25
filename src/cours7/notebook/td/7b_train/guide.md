---
title: "TD 7b — Deux effets pour la fenêtre du train"
subtitle: Guide, étape par étape
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

# TD 7b — Deux effets pour la fenêtre du train

Ce TD est la suite du TD 4c. Il ajoute au programme `train.py` une option
`--effet`, qui modifie chaque image de la série avant la vidéo. Deux effets,
d'après le clip « Moon » de Kid Francescoli :

- **`poteaux`**, pour tous : des bandes sombres qui passent très vite devant
  le paysage, l'ombre des poteaux le long de la voie ;
- **`parallaxe`**, dans un second temps : un second plan, la plage orange,
  qui défile deux fois plus vite que les voiles. Les objets proches passent
  plus vite que les objets lointains : c'est ce qui donne la profondeur.

Chaque effet est une fonction qui reçoit une image de la série (un tableau
numpy) et son numéro, et renvoie l'image modifiée. Elle est écrite deux
fois : avec une boucle sur les pixels, puis avec numpy. Un test vérifie que
les deux versions donnent exactement la même image ; un chronométrage
compare leurs durées. Le travail se fait sur une branche, publiée par une
pull request relue par un camarade.

Le guide donne le code des fonctions qui lisent et écrivent les images, du
test et du chronométrage. Pour les effets, il donne le calcul pour un pixel
et les outils numpy à employer, pas le code : c'est la partie à écrire.

| Étape | Ce qu'on fait | Commits à la fin |
|---|---|---|
| C0 | préparer : le dépôt, la branche `effet`, numpy et Pillow | 1 |
| C1 | le notebook `tableaux.ipynb` : les outils numpy | |
| C2 | lire et écrire les images de la série | 2 |
| C3 | l'effet `poteaux`, avec une boucle | 3 |
| C4 | l'effet `poteaux`, avec numpy, et le test | 4 |
| C5 | l'option `--effet` | 5 |
| C6 | mesurer, et le rapport | 6 |
| C7 | la pull request et la revue | fusion |
| C8 (second temps) | l'effet `parallaxe`, et plusieurs effets à la suite | 3 de plus |

## Au début de la séance

- Le dépôt du projet 4c (`train`), publié sur GitHub au cours 6.
- L'environnement `animation` du TD 4 (`conda env create -f environment.yml`
  s'il n'est plus sur le poste).
- La clé SSH du cours 5, enregistrée sur le compte GitHub.
- L'archive `info01-cours7.zip`, décompressée sur le Bureau dans `info01` :
  le dossier `cours7/7b_train/` contient `depart/notebook/tableaux.ipynb`,
  `depart/modeles/` (le test, le chronométrage, le gabarit du rapport),
  `depart/exemple.png` et `depart/decor/`.

Ouvrir `info01/cours7/7b_train/` dans VS Code, puis un terminal Git Bash
(cours 4, étape A1). Tout le TD se fait dans ce dossier.

## C0 · Préparer

> **À faire :** cloner le dépôt `train` dans `travail/` ; une branche
> `effet` ; installer numpy et Pillow dans `animation` et les ajouter à
> `environment.yml` ; un commit.
>
> **À obtenir :** `python -c "import numpy, PIL"` ne répond rien, sans
> erreur ; `git log --oneline` : le commit en haut.

**Le dépôt.** Sur la page du dépôt sur GitHub, bouton Code → SSH, copier
l'adresse, puis :

```text
cd travail
git clone git@github.com:<compte>/train.git
cd train
git checkout -b effet
```

Si le dépôt est déjà sur le poste, y aller et faire `git pull` avant
`git checkout -b effet`.

**Vérification** : `ls` liste `train.py`, `decor` et `README.md` ;
`git branch` affiche `* effet`.

**numpy et Pillow.** numpy calcule sur des tableaux ; Pillow lit et écrit les
fichiers d'images.

```text
conda activate animation
conda install -c conda-forge numpy pillow
python -c "import numpy, PIL; print(numpy.__version__, PIL.__version__)"
```

**Vérification** : la dernière commande affiche deux numéros de version.

Ouvrir `environment.yml` et ajouter deux lignes à la fin de la liste
`dependencies` :

```yaml
  - numpy
  - pillow
```

```text
git commit -am "numpy et Pillow dans l'environnement"
```

## C1 · Le notebook : les outils numpy

> **À faire :** copier `tableaux.ipynb` dans `travail/`, lancer JupyterLab
> depuis `travail/` dans un second terminal, exécuter le notebook.
>
> **À obtenir :** section 1, `(480, 640, 3) uint8` ; section 6, `même
> résultat : True`.

Dans un second terminal Git Bash, depuis le dossier du TD :

```text
conda activate animation
cp depart/notebook/tableaux.ipynb travail/
cd travail
jupyter lab
```

Le notebook montre, sur d'autres exemples que les deux effets, ce que les
étapes suivantes emploient : une image est un tableau de forme
`(hauteur, largeur, 3)` ; les tranches (`image[:, 300:340]`) ; le
dépassement des `uint8` ; le choix de colonnes par un tableau de booléens ;
`np.roll` et les masques ; la mesure du temps.

## C2 · Lire et écrire les images de la série

> **À faire :** les imports, puis `lire`, `ecrire` et `appliquer` dans
> `train.py` ; un commit.
>
> **À obtenir :** `train.lire(...)` renvoie un tableau `(480, 640, 3)
> uint8`.

Dans `train.py`, sous `from pathlib import Path`, ajouter :

```python
import numpy as np
from PIL import Image
```

Puis, juste avant la ligne `# ---- Le programme`, coller :

```python
# ---- Les effets (projet 7) ---------------------------------------------------

def lire(fichier):
    """L'image du fichier, en tableau numpy (hauteur, largeur, 3) d'entiers de 0 à 255."""
    return np.asarray(Image.open(fichier).convert("RGB"))


def ecrire(tableau, fichier):
    """Enregistre le tableau comme image ; le format suit l'extension du fichier."""
    Image.fromarray(tableau).save(fichier)


def appliquer(effet):
    """Applique l'effet à chaque image de la série, en remplaçant le fichier ; renvoie le nombre d'images."""
    fichiers = sorted(IMAGES.glob("img_*.png"))
    for numero, fichier in enumerate(fichiers, start=1):
        ecrire(effet(lire(fichier), numero), fichier)
    return len(fichiers)


```

`appliquer` reçoit une fonction d'effet : pour chaque image de la série, elle
lit le fichier, appelle l'effet avec l'image et son numéro (1, 2, 3…), puis
réécrit le fichier.

**Vérifications**, dans le premier terminal, dans `travail/train/` :

```text
python train.py --decalage 200
python -c "import train; t = train.lire('sortie/train_0200.png'); print(t.shape, t.dtype)"
```

- la première commande affiche `…/sortie/train_0200.png`, comme au TD 4c ;
- la seconde affiche `(480, 640, 3) uint8`.

`import train` ne lance pas le programme : `main()` n'est appelé que sous
`if __name__ == "__main__":`.

```text
git commit -am "Effets : lire et écrire les images de la série"
```

## C3 · L'effet `poteaux`, avec une boucle

> **À faire :** trois constantes et la fonction `poteaux_boucle(image,
> numero)` ; un commit.
>
> **À obtenir :** `sortie/poteaux_1.png` : deux bandes sombres, aux colonnes
> 90 à 113 et 490 à 513.

Sous la fonction `appliquer`, coller les trois constantes de l'effet :

```python
# Les poteaux : des bandes sombres qui passent très vite vers la droite.
ECART_POTEAUX = 400       # pixels entre deux bandes
LARGEUR_POTEAU = 24       # largeur d'une bande, en pixels
VITESSE_POTEAUX = 90      # pixels par image
```

**Le calcul, pour le pixel de la ligne `y` et de la colonne `x`** : le pixel
est dans une bande si

```text
(x - VITESSE_POTEAUX * numero) % ECART_POTEAUX < LARGEUR_POTEAU
```

Dans une bande, chacune de ses trois valeurs `v` devient `v * 6 // 10` : le
pixel est assombri. Hors des bandes, le pixel ne change pas. Le modulo répète
les bandes tous les 400 pixels ; `- VITESSE_POTEAUX * numero` les fait
avancer de 90 pixels à chaque image.

**À écrire** : la fonction `poteaux_boucle(image, numero)`, qui renvoie une
nouvelle image de même forme. Partir de `resultat = image.copy()` et de
`hauteur, largeur, _ = image.shape` ; deux boucles, sur `y` puis sur `x` ; une
troisième sur les trois canaux pour les pixels des bandes. Convertir chaque
valeur avec `int(...)` avant de la multiplier (notebook, section 3).

**Vérification** :

```text
python -c "import train; train.ecrire(train.poteaux_boucle(train.lire('sortie/train_0200.png'), 1), 'sortie/poteaux_1.png')"
```

Ouvrir `sortie/poteaux_1.png` : deux bandes sombres, de 24 pixels de large,
aux colonnes 90 à 113 et 490 à 513 (pour `numero = 1`, `x - 90` modulo 400
est entre 0 et 23). Le reste de l'image est inchangé.

```text
git commit -am "Poteaux : la version boucle"
```

## C4 · L'effet `poteaux`, avec numpy, et le test

> **À faire :** la fonction `poteaux_numpy(image, numero)` ; le fichier
> `test_effet.py` ; un commit.
>
> **À obtenir :** `python test_effet.py` affiche trois lignes qui se
> terminent par `True`.

**À écrire** : `poteaux_numpy(image, numero)`, le même calcul sur les
colonnes entières, sans boucle. Les outils (notebook, sections 2 à 4) :

- `np.arange(largeur)` : le tableau des numéros de colonnes ;
- la condition du calcul, écrite sur ce tableau : un tableau de booléens,
  vrai pour les colonnes des bandes ;
- `image[:, colonnes]` : les pixels de ces colonnes, sur toutes les lignes ;
- `astype(np.uint16)` avant de multiplier par 6, sinon le calcul dépasse 255
  et donne un résultat faux.

**Le test.** Copier le modèle à côté de `train.py`, puis le lancer :

```text
cp ../../depart/modeles/test_effet.py .
python test_effet.py
```

**Vérification** : trois lignes, `poteaux 1 True`, `poteaux 2 True`,
`poteaux 50 True`. Le test applique les deux versions à une image au
hasard, pour trois numéros, et compare les résultats avec `np.array_equal`.
Si une ligne affiche `False`, la cause la plus fréquente est le dépassement
des `uint8` dans la version numpy.

```text
git add test_effet.py
git commit -am "Poteaux : la version numpy, et le test"
```

## C5 · L'option `--effet`

> **À faire :** le dictionnaire `EFFETS`, l'option `--effet`, l'appel
> d'`appliquer` dans `main` ; un commit.
>
> **À obtenir :** `python train.py --images 48 --effet poteaux --video`
> écrit une vidéo où passent les ombres des poteaux.

Sous la fonction `poteaux_numpy`, ajouter le dictionnaire des effets : le nom
donné sur la ligne de commande, et la fonction appelée.

```python
EFFETS = {"poteaux": poteaux_numpy}
```

Dans `main`, sous l'option `--nettoyer`, ajouter l'option :

```python
    analyseur.add_argument("--effet", choices=sorted(EFFETS), help="un effet appliqué à chaque image de la série")
```

`choices` limite les valeurs acceptées aux noms du dictionnaire. Puis, dans
la branche `else` de `main`, juste après la ligne
`print(nombre, "images dans", IMAGES)` et avant la vidéo :

```python
        # L'effet, sur les images de la série, avant la vidéo
        if options.effet:
            appliquer(EFFETS[options.effet])
            print("effet", options.effet, "appliqué")
```

**Vérifications** :

```text
python train.py --images 48 --effet poteaux --video
python train.py --images 48 --video
python train.py --images 4 --effet flou
```

- la première affiche `48 images dans …`, `effet poteaux appliqué`, puis la
  ligne de la vidéo ; dans `sortie/train.mp4`, les ombres passent ;
- la deuxième écrit la vidéo sans effet, comme au TD 4c ;
- la troisième affiche
  `error: argument --effet: invalid choice: 'flou' (choose from poteaux)`.

```text
git commit -am "L'option --effet : poteaux"
```

## C6 · Mesurer, et le rapport

> **À faire :** chronométrer les deux versions avec `mesurer.py` ; écrire
> `RAPPORT.md` avec une image avant et après l'effet ; un commit.
>
> **À obtenir :** le tableau des temps rempli ; `RAPPORT.md` s'affiche avec
> les deux images dans l'aperçu de VS Code.

**Chronométrer.** `mesurer.py` lit les images de la série, puis applique
chaque version à la première image, puis à toute la série, et affiche les
durées.

```text
cp ../../depart/modeles/mesurer.py .
python train.py --images 120
python mesurer.py poteaux
```

**Vérification** : deux lignes, `boucle` puis `numpy`. Sur la machine de
préparation, la boucle prend environ 0,04 s par image et 5 s pour la série ;
numpy moins d'une milliseconde par image et 0,04 s pour la série. Les
durées changent d'un poste à l'autre ; le rapport entre les deux reste du
même ordre.

**Les deux images du rapport** : l'image 31 de la série, sans puis avec
l'effet.

```text
python train.py --images 31
cp sortie/images/img_0031.png avant.png
python train.py --images 31 --effet poteaux
cp sortie/images/img_0031.png apres.png
cp ../../depart/modeles/RAPPORT.md .
```

Compléter `RAPPORT.md` : le nom de l'effet, les quatre durées, le nombre
d'images, et une phrase qui dit combien de fois numpy est plus rapide, et
pourquoi.

```text
git add RAPPORT.md avant.png apres.png mesurer.py
git commit -m "Le rapport : poteaux, boucle et numpy"
```

## C7 · La pull request et la revue

> **À faire :** pousser la branche ; ouvrir la pull request ; la faire
> relire par un camarade ; relire la sienne ; fusionner.
>
> **À obtenir :** la pull request fusionnée ; `master` à jour sur le poste.

```text
git push -u origin effet
```

Sur la page du dépôt, GitHub propose « Compare & pull request ». Titre :
`Effet poteaux` ; description : le tableau des temps du rapport.

**La revue.** Settings → Collaborators : ajouter le camarade comme
collaborateur. Dans la pull request, Reviewers : le désigner. Le relecteur
récupère la branche (`git fetch`, puis `git checkout effet`) et vérifie trois
choses :

1. la commande `python train.py --images 48 --effet poteaux --video`
   fonctionne ;
2. `python test_effet.py` affiche `True` sur chaque ligne ;
3. `RAPPORT.md` donne les quatre durées.

Il laisse un commentaire, puis approuve (Review changes → Approve).

**Fusionner.** Sur le site, « Merge pull request ». Puis, sur le poste :

```text
git checkout master
git pull
git log --oneline --graph
```

**Vérification** : `git log` montre le commit de fusion de la pull request.

## C8 (second temps) · L'effet `parallaxe`

> **À faire :** une branche `parallaxe` ; `lire_rgba` et `charger` ;
> `parallaxe_boucle`, puis `parallaxe_numpy` et le test ; `--effet`
> répétable ; une pull request.
>
> **À obtenir :** `python train.py --images 120 --effet parallaxe --effet
> poteaux --video` : la plage orange passe au premier plan, sous les ombres.

```text
git checkout -b parallaxe
```

**Les données.** L'effet a besoin de deux images du décor, lues une fois
avant la série : la plage (`decor/plage.png`, une bande de 1 920 pixels) et
la vitre de la fenêtre. Sous `EFFETS`, coller :

```python
def lire_rgba(fichier):
    """L'image du fichier avec sa transparence : un tableau (hauteur, largeur, 4)."""
    return np.asarray(Image.open(fichier).convert("RGBA"))


# La parallaxe : la plage du premier plan, deux fois plus rapide que le plan.
VITESSE_PLAGE = 16        # pixels par image
DONNEES = {}              # rempli par charger : la plage et la vitre


def charger(decor):
    """Lit la plage (une bande RGBA) et la vitre (vrai là où la fenêtre est transparente)."""
    DONNEES["plage"] = lire_rgba(decor / "plage.png")
    DONNEES["vitre"] = lire_rgba(decor / "fenetre.png")[:, :, 3] == 0
```

**Le calcul, pour le pixel `(y, x)`**, avec `plage = DONNEES["plage"]`,
`vitre = DONNEES["vitre"]` et `d = VITESSE_PLAGE * numero` : le pixel de la
plage qui arrive en `x` est celui de la colonne
`xp = (x - d) % largeur_plage`, où `largeur_plage` vaut 1 920. Si
`vitre[y, x]` est vrai et si ce pixel de la plage est opaque
(`plage[y, xp, 3] > 0`), le pixel `(y, x)` de l'image prend ses trois
couleurs, `plage[y, xp, :3]`. Sinon, il ne change pas.

**À écrire** : `parallaxe_boucle(image, numero)`, puis
`parallaxe_numpy(image, numero)`. Les outils de la version numpy (notebook,
section 5) : `np.roll` sur la bande, avec `axis=1`, puis ses 640 premières
colonnes ; un masque qui combine la vitre et l'opacité avec `&` ;
`resultat[masque] = …` pour ne remplacer que ces pixels.

**Le test** : dans `test_effet.py`, enlever le `#` devant les trois
dernières lignes. **Vérification** : six lignes qui se terminent par
`True`.

**Plusieurs effets à la suite.** Ajouter `"parallaxe": parallaxe_numpy` au
dictionnaire `EFFETS` (le déplacer sous `parallaxe_numpy`). Dans l'option,
ajouter `action="append"` : l'option peut alors être répétée, et
`options.effet` est la liste des noms, dans l'ordre. Remplacer l'appel
d'`appliquer` par :

```python
        # Les effets, dans l'ordre de la ligne de commande
        if options.effet:
            if "parallaxe" in options.effet:
                charger(decor)
            for nom in options.effet:
                appliquer(EFFETS[nom])
                print("effet", nom, "appliqué")
```

**Vérifications** :

```text
python train.py --images 120 --effet parallaxe --effet poteaux --video
python train.py --images 120 --effet poteaux --effet parallaxe --video
python mesurer.py parallaxe
```

- la première affiche deux lignes `effet … appliqué` ; dans la vidéo, la
  plage orange passe devant les voiles, plus vite qu'elles, et les ombres
  passent par-dessus ;
- la deuxième fait passer la plage par-dessus les ombres : l'ordre des
  effets compte ;
- la troisième affiche les durées : sur la machine de préparation, 0,08 s
  par image et 10 s pour la série en boucle, 0,3 s pour la série avec numpy.

Un commit par version (boucle, numpy et test, option), puis une pull request
`Effet parallaxe`, relue comme en C7.

**Dossier à la fin du TD** :

```text
travail/train/
├── .git/
├── .gitignore
├── README.md
├── RAPPORT.md
├── apres.png
├── avant.png
├── decor/
├── environment.yml         (avec numpy et pillow)
├── mesurer.py
├── test_effet.py
├── train.py
└── sortie/                 (non versionné)
```
