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

Depuis la racine du dépôt :

```bash
conda env create -f environment.yml
conda activate info01
```

Le prompt doit afficher `(info01)`. Durée observée : **~1 min 30** (première fois,
téléchargements inclus).

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
python make_data.py build    # dérive les fichiers de l'exercice dans genere/
```

Sans réseau : déposer un `.txt` dans `data/cours1/textes_sources/` (le nom du
fichier est la clé, ex. `raven.txt`) puis lancer directement `build`.

`build` produit, pour chaque texte : la version `.txt` **sur une ligne**, la
copie `.donnees` à mauvaise extension, l'`.odt` (via pandoc), l'`.html` brut,
l'`.html` + `style.css`, et le corrigé dans `genere/_corrige/`.

---

## 3. Diapositives (typst)

```bash
conda activate info01

# compilation unique → src/cours1/diapo/cours1.pdf
typst compile src/cours1/diapo/cours1.typ

# recompilation à chaque sauvegarde (confortable pour rédiger)
typst watch src/cours1/diapo/cours1.typ

# export images (une PNG par diapositive)
typst compile --format png --ppi 150 src/cours1/diapo/cours1.typ "apercu-{n}.png"
```

Tous les jeux d'un coup :

```bash
for f in src/cours*/diapo/cours*.typ; do typst compile "$f"; done
```

**Aucune dépendance externe** : le thème (`src/cours1/diapo/theme.typ`) n'importe
aucun paquet et n'utilise que des polices **embarquées dans typst**
(*Libertinus Serif*, *DejaVu Sans Mono*). La compilation est donc identique sur
tous les postes et fonctionne hors ligne.

Pour un rendu sans empattements, changer les deux constantes en tête de
`theme.typ` :

```typst
#let police-texte = ("Inter", "Segoe UI", "DejaVu Sans")
```

typst émettra alors un avertissement `unknown font family` pour chaque police
absente du poste — sans gravité, il prend la suivante de la liste.

Les PDF générés sont dans `.gitignore` : ce sont des artefacts.

### Structure d'un jeu de diapositives

`theme.typ` fournit la mise en page et quatre helpers :

| Helper | Rôle |
|--------|------|
| `diapos(titre:, sous-titre:, auteur:, date:)` | réglages globaux + diapo de titre |
| `d(titre)[…]` | une diapositive |
| `retenir[…]` | encadré « à retenir » |
| `expose(durée)` / `manip(durée)` | marqueurs 🎓 / ⌨ du syllabus |

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
de `data/cours1/genere/` : **générer les données avant de construire**
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
