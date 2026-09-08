# Installation & construction des supports

Environnement testé le 02/09/2026 sous Linux (conda 24.11, miniforge). Toutes les
commandes de ce document ont été exécutées telles quelles.

---

## 1. Environnement `info01`

### Installer conda

**Miniforge** — distribution conda préconfigurée sur `conda-forge`, sans licence
commerciale à surveiller : <https://conda-forge.org/download/>
(Windows, macOS Intel/ARM, Linux).

Vérifier ensuite dans un terminal neuf :

```bash
conda --version
```

> **Windows** : utiliser le *Miniforge Prompt* installé avec Miniforge, ou lancer
> `conda init powershell` une fois puis rouvrir le terminal.

### Créer l'environnement

Il y en a deux, et il faut savoir lequel on veut.

`info01` est l'environnement de **travail** : celui des étudiants, celui dans
lequel se jouent toutes les manipulations. Il contient Python, JupyterLab, numpy,
pillow, ffmpeg, ImageMagick et pandoc — rien de la chaîne documentaire.

```bash
conda env create -f environment.yml
conda activate info01
```

`info01-supports` est l'environnement de **fabrication** : il n'intéresse que qui
recompile les diapositives ou le book. Il reprend le contenu du premier — les
notebooks du book s'exécutent à la construction, donc avec les mêmes
bibliothèques que les étudiants — et y ajoute typst, Sphinx, myst-nb et jupytext.

```bash
conda env create -f environment-supports.yml
conda activate info01-supports
```

Le prompt doit afficher `(info01)` ou `(info01-supports)`. Durée observée pour
le premier : **~1 min 30** (première fois, téléchargements inclus).

Les deux coexistent sans se gêner : c'est précisément ce qu'un environnement
sert à faire, et la partie 4 du cours 1 le fait constater aux étudiants.

### Vérifier

```bash
python  --version    # Python 3.12.x
sphinx-build --version   # 9.x   → book
typst   --version    # 0.15.x    → diapositives
pandoc  --version    # 3.11      → conversions de documents
ffmpeg  -version     # → TD 4
magick  --version    # ImageMagick 7 → TD 4

python -c "import numpy, PIL; print(numpy.__version__, PIL.__version__)"
```

Et le réflexe enseigné en séance 1 — *quel Python tourne réellement ?* :

```bash
python -c "import sys; print(sys.executable)"   # doit contenir « info01 »
```

### Mettre à jour après modification de `environment.yml`

```bash
conda env update -f environment.yml --prune
```

### Repartir de zéro

```bash
conda deactivate
conda env remove -n info01
```

### Ce que contient l'environnement, et pourquoi

| Paquet | Sert à | Vu en |
|--------|--------|-------|
| `python=3.12` | socle | c1 |
| `jupyterlab` | exécuter les notebooks | c1 |
| `jupytext` | conversion `.ipynb` ↔ MyST | c1, ex. 5 |
| `sphinx`, `myst-nb`, `sphinx-book-theme`, `sphinx-design` | construire le book | supports |
| `sphinx-autobuild` | aperçu live pendant la rédaction | supports |
| `typst` | diapositives | supports |
| `pandoc` | conversions de documents | c2, `make_data.py` |
| `numpy`, `pillow` | calcul et images | c6, TD 7 |
| `ffmpeg`, `imagemagick` | pipeline d'animation | c3, TD 4 |

---

## 2. Données du cours 1

Le dépôt versionne le script, pas les textes (voir [`data/cours1/README.md`](data/cours1/README.md)).

```bash
conda activate info01
cd data/cours1
python make_data.py fetch    # télécharge les sources — une seule fois, réseau requis
python make_data.py build    # dérive les fichiers de l'exercice dans produit/
```

Sans réseau : déposer un `.txt` dans `data/cours1/fourni/` (le nom du
fichier est la clé, ex. `raven.txt`) puis lancer directement `build`.

`build` produit, pour chaque texte : la version `.txt` **sur une ligne**, la
copie `.donnees` à mauvaise extension, l'`.odt` (via pandoc), l'`.html` brut,
l'`.html` + `style.css`, et le corrigé dans `produit/_corrige/`.

---

## 2 ter. Ressources hors dépôt

Deux noms sont réservés dans `data/` : `produit/` désigne ce qu'une commande
refabrique, `fourni/` ce qui vient d'ailleurs et ne se refabrique pas. Les
captures d'écran des supports, dans `illustrations/`, sont du second genre.
Aucun des deux n'est versionné, mais seul le second doit suivre d'un poste à
l'autre.

```bash
python outils/ressources.py verifier                             # que manque-t-il ?
python outils/ressources.py importer /media/…/info01-ressources  # remettre en place
python outils/ressources.py exporter /media/…/info01-ressources  # publier vers la clé
```

`exporter` met à jour `outils/ressources.json`, qui retient la taille et
l'empreinte de chaque fichier. Ce manifeste étant versionné, `verifier`
fonctionne sur un poste fraîchement cloné, avant toute copie : il dit ce qui
manque plutôt que de laisser une manipulation s'arrêter en séance.

Les copies sont relues après écriture, `importer` n'efface jamais rien et
refuse d'écraser un fichier dont le contenu diffère tant qu'on ne lui passe pas
`--forcer`. `--simuler` montre ce qui serait fait sans rien écrire, et
`--archive` produit en plus un zip daté à côté du dossier.

## 2 bis. Notebooks

Les notebooks sont écrits en **MyST Markdown**, dans `src/cours<n>/notebook/`.
C'est du texte : il se relit, se compare ligne à ligne et se versionne — la
démonstration du cours 1 appliquée à ses propres supports. Les `.ipynb` en sont
dérivés, comme les PDF le sont des `.typ`, et ils sont dans `.gitignore`.

```bash
conda activate info01

python outils/construire_notebooks.py             # cellules vides, à ouvrir en séance
python outils/construire_notebooks.py --executer  # sorties remplies, pour distribuer
```

## 3. Diapositives (typst)

### Polices — à faire une fois, avant la première compilation

Le thème reprend l'identité du thème Beamer *Bruno*, qui impose **Fira Sans**
et dont le « gras » est en réalité un demi-gras (graisse 500). Les gabarits
sont calibrés sur la chasse de cette police.

Sans elle, typst ne s'arrête pas : il prend la suivante de la pile de
substitution et signale `unknown font family`. Le document compile, mais plus
large, et c'est ainsi que du texte est passé par-dessus le bord de ses cadres
dans une version antérieure de ce dépôt.

```bash
conda activate info01

python outils/verifier_polices.py             # état des lieux
python outils/verifier_polices.py --installer # télécharge et installe Fira Sans
```

L'installation se fait dans le dossier de polices de l'utilisateur, sans droits
d'administration : `~/.local/share/fonts` sous Linux, `~/Library/Fonts` sous
macOS, `%LOCALAPPDATA%\Microsoft\Windows\Fonts` sous Windows. Fira Sans est
publiée par Mozilla sous licence SIL Open Font License 1.1 ; le dépôt ne
l'embarque pas, pour rester sans fichier binaire.

> **Terminal intégré de VSCode installé en snap** : il redéfinit
> `XDG_DATA_HOME` pour s'isoler, et fontconfig cherche alors les polices dans
> le bac à sable du snap. Le script installe aux deux endroits, de sorte que le
> rendu soit le même depuis un terminal ordinaire et depuis celui de l'éditeur.

Depuis la version qui suit, les schémas mesurent leurs boîtes avant de les
poser : le texte ne peut plus déborder, même sans aucune police système. La
police reste néanmoins nécessaire pour retrouver la mise en page voulue.

### Compiler

Le script de compilation évite d'avoir à retenir les options : il place la
racine du bac à sable de typst sur celle du dépôt, et n'emploie les captures
d'écran que si elles sont réellement présentes.

```bash
conda activate info01

python outils/compiler_diapos.py             # le cours 1, à projeter
python outils/compiler_diapos.py --notes     # version annotée
python outils/compiler_diapos.py --corrige   # corrigé des manipulations
python outils/compiler_diapos.py --tous      # les sept jeux
python outils/compiler_diapos.py --sans-captures   # vérifier le repli dessiné
```

Les commandes équivalentes, à la main :

```bash
conda activate info01

# compilation unique → src/cours1/diapo/cours1.pdf
typst compile --root . src/cours1/diapo/cours1.typ

# version annotée, avec les notes de conduite de l'enseignant
typst compile --root . --input notes=true src/cours1/diapo/cours1.typ cours1-notes.pdf

# avec les captures d'écran, si l'archive a été décompressée
typst compile --root . --input captures=true src/cours1/diapo/cours1.typ

# avec le corrigé des manipulations, à distribuer après la séance
typst compile --root . --input corrige=true src/cours1/diapo/cours1.typ cours1-corrige.pdf

# recompilation à chaque sauvegarde (confortable pour rédiger)
typst watch --root . src/cours1/diapo/cours1.typ

# export images (une PNG par diapositive)
typst compile --root . --format png --ppi 150 src/cours1/diapo/cours1.typ "apercu-{n}.png"
```

`--root .` place la racine du bac à sable de typst sur celle du dépôt : sans
elle, un `.typ` de `src/cours1/diapo/` ne peut pas lire une image de `data/`.

Tous les jeux d'un coup :

```bash
for f in src/cours*/diapo/cours*.typ; do typst compile --root . "$f"; done
```

### Les compilations, et à qui elles servent

| Options | Pour qui | Ce qui change |
|---------|----------|---------------|
| aucune | projeté en séance | la séance seule, colonnes d'observation vides |
| `--input corrige=true` | distribué après la séance | ces colonnes sont remplies |
| `--input notes=true` | l'enseignant | les notes de conduite s'ajoutent sous la diapositive, sur une page plus haute |
| `--input annexes=true` | l'enseignant, et après la séance | les annexes s'ajoutent à la fin |
| `--input captures=true` | partout, si les images sont là | les captures d'écran remplacent les schémas dessinés |

Les options se combinent. Ce que la manipulation fait constater n'est pas
projeté pendant qu'elle se fait : la tentative, même infructueuse, améliore la
rétention de la réponse donnée ensuite, et un support à trous est plus efficace
qu'un support complet. Les références sont dans
[`STYLE.md`](STYLE.md#manipulations-et-corrigé).

### Vérifier une fois compilé

typst ne signale pas une diapositive trop pleine : le gabarit répartit l'espace
libre par des ressorts, et quand le corps est trop haut ils se referment
silencieusement, collant la phrase d'annonce sous le titre. Le symptôme se
mesure sur le PDF :

```bash
python outils/verifier_diapos.py src/cours1/diapo/cours1.pdf
```

La version annotée est plus contrainte, puisqu'elle réserve le bas de la page
aux notes de conduite. Elle se relit avec un seuil plus bas :

```bash
typst compile --root . --input notes=true src/cours1/diapo/cours1.typ notes.pdf
python outils/verifier_diapos.py --seuil 10 notes.pdf
```

Le script sort en code 1 dès qu'une diapositive est signalée.

### Captures d'écran

Les images d'illustration ne sont pas versionnées : voir
[`illustrations/cours1/README.md`](illustrations/cours1/README.md)
pour l'arborescence attendue, les noms de fichiers et le format. Sans elles,
chaque diapositive concernée emploie un équivalent dessiné en typst, et le
document compile normalement.

### Dépendances

**Aucun paquet typst importé.** La seule dépendance externe est la police du
texte, traitée ci-dessus ; celle du code (*DejaVu Sans Mono*) est embarquée
dans typst. Les PDF générés sont dans `.gitignore` : ce sont des artefacts.

### Structure d'un jeu de diapositives

Le contenu est découpé par partie sous `src/cours1/diapo/parties/` ;
`cours1.typ` ne porte que les réglages globaux et l'ordre des inclusions. Les
gabarits sont partagés par les sept séances dans `src/commun/`, et un seul
import les apporte tous :

```typst
#import "../../commun/prelude.typ": *
```

`src/commun/theme.typ` porte la mise en page et les gabarits. Les principaux :

| Helper | Rôle |
|--------|------|
| `diapos(titre-court:, auteur-court:)` | réglages globaux, pied de page |
| `d(titre)[…]` | une diapositive ordinaire |
| `separateur(…)` / `separateur-td(…)` / `separateur-manip(…)` | diapositives de section |
| `annonce[…]`, `legende[…]`, `notes[…]` | phrase sous le titre, source, notes de conduite |
| `tableau(…)`, `face-a-face(…)`, `panneau(…)` | preuves visuelles |
| `fenetre(titre)[…]` | fenêtre d'application dessinée |
| `illustration(chemin, repli)` | capture d'écran si elle est là, dessin sinon |

La liste complète est dans [`src/cours1/diapo/README.md`](src/cours1/diapo/README.md).
`src/cours1/diapo/cours1.typ` sert de modèle ; les gabarits des cours 2–7
importent le même thème.

---

## 4. Book (notebooks)

Le book couvre les 7 séances. Sa configuration, [`src/conf.py`](src/conf.py), est
lue par **Sphinx** ; les pages sont du Markdown MyST exécutable (`myst-nb`).

Toutes les commandes se lancent depuis la **racine du dépôt**.

### Construire

```bash
conda activate info01
sphinx-build -b html src _build/html
```

Sortie dans `_build/html/`. Durée observée : **~6 s** en repartant de zéro,
exécution des notebooks comprise. `nb_execution_mode = "cache"` ne réexécute
ensuite que les pages modifiées.

### Consulter le résultat

**Double-cliquer sur `_build/html/index.html`.** C'est tout.

Le HTML produit utilise des **chemins relatifs** et n'appelle **aucune ressource
externe** : le site s'ouvre en `file://`, sans serveur et sans connexion. C'est
la contrainte qui a décidé du choix de Sphinx (voir §6).

Pour distribuer aux étudiants : zipper `_build/html/` (≈ 7,6 Mo) ou le déposer
sur l'ENT — dans les deux cas ça marche hors ligne.

> Seule réserve : la **recherche plein texte** peut rester inerte en `file://`
> (le navigateur bloque les requêtes locales). La navigation, les pages et les
> résultats de cellules, eux, fonctionnent.

### Aperçu live — pour rédiger

```bash
sphinx-autobuild src _build/html      # → http://localhost:8000
```

Reconstruit et rafraîchit le navigateur à chaque sauvegarde.

### Nettoyer

```bash
rm -rf _build
```

`_build/` est dans `.gitignore`.

### Prérequis d'exécution

Les cellules de `src/cours1/notebook/02_formats_de_fichier.md` lisent les fichiers
de `data/cours1/produit/` : **générer les données avant de construire**
(section 2), sinon la build échoue (`nb_execution_raise_on_error = True` — une
cellule cassée doit se voir).

La page localise la racine du dépôt en remontant l'arborescence : elle fonctionne
aussi bien depuis JupyterLab, VSCode que `sphinx-build`.

### Écrire une page

Une page exécutable = du Markdown MyST avec ce frontmatter :

```yaml
---
title: Titre de la page
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---
```

Sans le bloc `jupytext`, `myst-nb` traite le fichier comme du Markdown ordinaire
et **n'exécute pas** les cellules.

Puis les cellules de code :

````markdown
```{code-cell} python
print("exécuté à la construction")
```
````

Les pages du cours 1 servent de modèle (encadrés `:::{note}` / `:::{important}`,
tableaux `{list-table}`, schémas SVG).

## 5. Problèmes rencontrés (et leur solution)

**La page est vide, ou le navigateur affiche la liste des fichiers.** Symptôme
d'un site MyST/`mystmd` ouvert en `file://` — plus d'actualité depuis le passage
à Sphinx : `_build/html/index.html` s'ouvre directement. Si ça se reproduit,
vérifier qu'on regarde bien `_build/html/` et non un ancien dossier.

**Les cellules n'ont pas de résultat dans le HTML.** Le frontmatter `jupytext`
manque sur la page (voir « Écrire une page » ci-dessus). Sans lui, `myst-nb` lit
le fichier comme du Markdown simple.

**`Executing notebook failed: CellExecutionError`.** La build s'arrête
volontairement sur une cellule en erreur. La cause la plus fréquente : les
données du cours 1 n'ont pas été générées (section 2). Le traceback complet est
écrit dans `_build/html/reports/`.

**`ERROR: Failed to complete gtk3's post-link script`** pendant
`conda env create`. Sans conséquence : ce script concerne l'interface graphique
d'ImageMagick, dont on n'utilise que la ligne de commande. Vérifier simplement
que `magick --version` répond.

**`ModuleNotFoundError` alors que le paquet est installé.** Presque toujours le
mauvais environnement actif. Contrôler `python -c "import sys; print(sys.executable)"` :
le chemin doit contenir `info01`. C'est le message à marteler en séance 1.

**`mamba` renvoie une `ImportError`.** Installation `mamba`/`conda` désynchronisée
sur ce poste. `conda` seul suffit pour tout ce document (le solveur `libmamba`
est déjà celui de conda ≥ 23).

---

## 6. Pourquoi Sphinx et pas `mystmd` / Jupyter Book 2

Les deux lisent le même Markdown MyST. Ils ne produisent pas la même chose :

| | `mystmd` (Jupyter Book 2) | **Sphinx + `myst-nb`** |
|---|---|---|
| Sortie HTML | application web, chemins **absolus** | pages statiques, chemins **relatifs** |
| Ouvrable en `file://` | non | oui, par double-clic |
| Serveur nécessaire | oui | non |
| Dépendances | + Node.js | Python seul |
| Ressources externes | quelques-unes | aucune |

Le module distribue ses supports à des étudiants de 1re année, sur des postes
variés, parfois hors ligne. **Devoir lancer un serveur local pour lire un cours
est une friction inacceptable** — c'est ce seul critère qui a tranché.

`mystmd` reste le meilleur outil si la destination est un site hébergé ; ce
n'est pas le cas ici.

Deux conséquences de ce choix, assumées :

- **Node.js n'est plus dans l'environnement** (~150 Mo et une source de panne en
  moins : `conda-forge` sert par moments une version *alpha* de Node que
  `mystmd` refuse).
- **Les schémas ne sont plus en `mermaid`** — Sphinx n'a pas de moteur mermaid
  hors ligne. Les trois diagrammes du cours 1 sont écrits en **SVG inline** dans
  les pages, en `currentColor` : ils suivent le thème clair/sombre et ne
  dépendent de rien.
