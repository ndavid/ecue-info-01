# Cours d'introduction à l'informatique (bac+2, 14 h)

École d'ingénieurs (géomatique), 1re année, profils variés (prépa littéraire ou scientifique).
Module d'**infrastructure de travail** (outils + concepts génériques) complémentaire du cours d'algo/programmation parallèle.

## Structure du dépôt

| Dossier | Rôle |
|---------|------|
| [`syllabus/`](syllabus/) | **Documents de référence** : [`01_syllabus_v1.md`](syllabus/01_syllabus_v1.md) (vue d'ensemble des 7 séances) et `cours/<n>_.../` (déroulé fin + exercices). |
| [`src/`](src/) | **Supports de séance** : `cours<n>/notebook/` (pages MyST exécutables), `cours<n>/diapo/` (sources typst), et [`conf.py`](src/conf.py) (config du book). |
| [`data/`](data/) | **Fichiers des manipulations**, un dossier par séance puis par manipulation. Deux noms réservés : `produit/` est refabricable par une commande, `fourni/` vient d'ailleurs et ne l'est pas. Ni l'un ni l'autre n'est versionné ; `fourni/` voyage avec [`outils/ressources.py`](outils/ressources.py). |
| [`illustrations/`](illustrations/) | **Captures d'écran des supports**, hors dépôt. Elles servent aux diapositives, pas aux travaux dirigés. |
| [`STYLE.md`](STYLE.md) | **Conventions d'écriture** des supports (diapositives, pages de cours, notes). À lire avant d'en rédiger. |
| [`environment.yml`](environment.yml) | Environnement de **travail** `info01` : celui des étudiants et des manipulations. |
| [`environment-supports.yml`](environment-supports.yml) | Environnement de **fabrication** `info01-supports` : typst et la chaîne du book, pour qui recompile les supports. |

*(Cours 1 rempli de bout en bout — syllabus, notebook, diapos, données ; cours 2–7 en gabarits.)*

## Démarrage

Pour **suivre** le cours et jouer les manipulations :

```bash
conda env create -f environment.yml && conda activate info01   # ~1 min 30
cd data/cours1 && python make_data.py fetch && python make_data.py build && cd ../..
```

Pour **recompiler** les supports, il faut en plus la chaîne documentaire :

```bash
conda env create -f environment-supports.yml && conda activate info01-supports
python outils/compiler_diapos.py                               # diapositives → PDF
sphinx-build -b html src _build/html                           # book → _build/html/index.html
```

Détail, vérifications et pannes connues : **[`INSTALLATION.md`](INSTALLATION.md)**.

## Décisions de conception (le « pourquoi »)

- **Ancrage géomatique léger, sans prérequis** : les exemples peuvent parler au métier (points, coordonnées, distance = Pythagore) mais n'exigent **jamais** une notion pas encore vue (pas d'API *live*, pas de Dijkstra).
- **Environnement = conda/conda-forge** : sert à *installer les outils* (ffmpeg, imagemagick, pandoc, typst, numpy, Pillow) de façon reproductible et cross-platform — pas à packager. Commandes fournies + testées.
- **Installé dès la séance 1** (v2) : les autres cours du programme mobilisent Python avant la semaine 3. En échange, le bloc *binaire / hexadécimal / PGM* descend au cours 3, où il précède directement `numpy` et le TD image. Analyse : [`syllabus/inversion_c1_c3.md`](syllabus/inversion_c1_c3.md).
- **Pas de navigation shell** (`ls`/`cd`/`rm`) : trop dépendante de l'OS (Windows) ; la manipulation de fichiers se fait en Python (`pathlib`).
- **Les données de cours sont générées, pas versionnées** : `data/cours<n>/make_data.py` récupère des sources du domaine public et en dérive les fichiers de l'exercice. Dépôt léger, données reproductibles, et le script devient lui-même un exemple de `pathlib`/`subprocess` (cours 3).
- **Supports en formats texte** : notebooks en **MyST** (`.md`) plutôt qu'en `.ipynb` — `git diff` lisible ; diapositives en **typst** sans dépendance externe. Le module enseigne ce qu'il pratique.
- **Book construit avec Sphinx + `myst-nb`** : produit du HTML à chemins **relatifs**, sans ressource externe — `_build/html/index.html` s'ouvre par double-clic, hors ligne, sans serveur. C'est la contrainte de distribution aux étudiants ; `mystmd` / Jupyter Book 2 génère une application web qui exige un serveur. Détail : [`INSTALLATION.md`](INSTALLATION.md).
- **Git enseigné par répétition à faible enjeu** (dépôt de notes) puis appliqué (TD4 animation, c6 trajectoire, TD7 benchmark).
- **TD collaboratif = parallèle, sans merge séquentiel** : dépôt **individuel** (GitHub Classroom), PR + **conflit pré-amorcé** (branche fournie) + **revue round-robin**. Réussite ≠ « mergé dans un main partagé ».
- **Fiche perso / CV écartée** comme TD (livrable trop léger en semaine 3) ; la leçon secrets/`.gitignore` est portée par le cours 5B.
- **Deux TD** : séance 4 = studio d'animation (subprocess + ImageMagick + ffmpeg) ; séance 7 = capstone benchmark image (boucle vs numpy, « Python pur vs call C »), rapport markdown.

## Conventions

L'écriture des supports suit [`STYLE.md`](STYLE.md) : diapositives en
assertion-evidence (titre = groupe nominal qui nomme le sujet, corps = preuve
visuelle, pas de liste à puces), pages de cours en prose autonome, notes
enseignant télégraphiques. À lire avant de rédiger une séance.

- Chaque séance ≈ **120 min** ; parties notées **🎓 exposé** ou **⌨ manipulation** + durée indicative.
- CM = cours (exposé + manipulation), TD = travaux dirigés.
- Un support de séance = une page MyST (`src/cours<n>/notebook/`) **et** un jeu de diapos (`src/cours<n>/diapo/`) ; le déroulé pour l'enseignant reste dans `syllabus/cours/<n>_.../`.

## Reste à faire

- Détailler `syllabus/cours/2..7` (contenu + exercices) sur le gabarit du cours 1.
- Rédiger les supports `src/cours2..7` (notebooks + diapos), modèle : `src/cours1/`.
- Alimenter `data/cours2..7` (un `make_data.py` par séance quand c'est pertinent).
- Ajouter une source `scarborough.txt` dans `data/cours1/fourni/` si on veut la ballade en plus (pas d'export texte stable sur Wikisource — la page ne contient que la partition).
- Dépôts-squelettes réels : TD4 (studio animation), TD7 (benchmark image + branche `conflit-rapport`), outil trajectoire (c6).
- Recaler le calendrier (dates) si besoin.
