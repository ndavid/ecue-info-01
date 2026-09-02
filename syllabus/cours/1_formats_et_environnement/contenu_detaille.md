# Contenu détaillé — Cours 1 : Logiciel, programmation & formats de fichier

Vue d'ensemble : [../../01_syllabus_v1.md](../../01_syllabus_v1.md) (section « Cours 1 »).
Inversion C1↔C3 : [../../inversion_c1_c3.md](../../inversion_c1_c3.md).

**Supports** : [`src/cours1/notebook/`](../../../src/cours1/notebook/) (MyST, 3 pages) et [`src/cours1/diapo/`](../../../src/cours1/diapo/) (typst, 13 diapositives en assertion-evidence ; `--input notes=true` pour la version annotée).
Conventions d'écriture : [`STYLE.md`](../../../STYLE.md).
**Données** : [`data/cours1/`](../../../data/cours1/) — générées par `make_data.py`.

Objectif : comprendre ce qu'est un logiciel, pourquoi programmer revient à écrire du texte, et savoir manipuler fichiers et environnement de travail en confiance.

## Fil conducteur

La séance est construite comme une chaîne de questions, chacune amenant la suivante :

> *Qu'est-ce qu'un logiciel ?* → entrée/traitement/sortie, et c'est un fichier.
> *D'où vient ce fichier ?* → de **texte** écrit par un humain.
> *Alors dans quoi écrit-on ce texte, et sous quelle forme ?* → **formats de fichier**.
> *Et avec quels outils ?* → **IDE**, **environnement**, **notebooks**.

Aucune notion n'est introduite sans que la précédente l'ait rendue nécessaire.

## Déroulé détaillé

### 🎓 12′ — Qu'est-ce qu'un logiciel (haut niveau)

- Schéma unique et réutilisé tout le semestre : **entrée → traitement → sortie (ou action)**.
- Un logiciel installé = **des fichiers**, rien de plus. Double-cliquer = demander au système de lire un fichier et de l'exécuter.
- Ce fichier est **binaire** (illisible pour un humain) — mais il n'a pas été écrit comme ça, il a été *produit*.
- *Ne pas entrer* dans l'architecture machine (registres, mémoire) : c'est le cours 5.

### 🎓 10′ — Qu'est-ce que programmer

- Un langage = un vocabulaire, une grammaire, un sens. Écrire un programme = écrire un texte respectant cette convention.
- Démonstration : 3 lignes de Python affichées, exécutées en direct dans le notebook. Insister — *c'est du texte qu'on pourrait taper dans le Bloc-notes*.
- **Interpréteur vs compilateur**, tableau à 3 lignes. Python est interprété.
- **Graine explicite** : « exécution plus lente » → cours 6 (boucle vs numpy) et TD7 (×100–1000).

### 🎓 10′ — Formats & extensions

- Formats par usage : rapport `.odt`/`.docx`/`.pdf`, archive `.zip`, image `.png`, vidéo `.mp4`, texte `.txt`/`.md`/`.html`.
- **L'extension est une convention de nommage**, pas une nature — annonce la manipulation qui suit.
- **Fichiers et dossiers cachés** : nom commençant par `.` (`.gitignore`, dossier `.git/`) ; comment les afficher. *Prérequis du cours 2* — ne pas sauter.
- Faire activer **l'affichage des extensions** dans l'explorateur (masquées par défaut sous Windows/macOS) : à faire une fois, utile tout le semestre.

### ⌨️ 30′ — Un texte, quatre formes *(manipulation centrale)*

Données : `data/cours1/genere/`, produites par `python make_data.py fetch && python make_data.py build`.
Textes du domaine public : **The Raven** (Poe, 1845) et **Auld Lang Syne** (Burns, 1788) — un poème et une chanson, vers courts, structure visible.

| Étape | Fichier | Geste | Constat attendu |
|-------|---------|-------|------------------|
| 1 | `*_une_ligne.txt` | remettre en forme (un vers par ligne, strophes) | un fichier texte contient des **caractères** ; `\n` en est un — pas de « lignes » sans lui |
| 2 | `*_une_ligne.donnees` | renommer en `.txt`, puis `.html` | **mêmes octets**, comportement différent : l'extension est une étiquette — et elle peut mentir |
| 3 | `*.odt` | ouvrir dans **LibreOffice Writer**, puis copier en `.zip` et lire `content.xml` | un format « binaire » est souvent une **archive de XML** (idem `.docx`, `.xlsx`, `.epub`) |
| 4 | `*_brut.html` | ouvrir dans le **navigateur** (double-clic) | adresse en `file://` — **aucun serveur** ; le navigateur ignore les sauts de ligne : la structure se **déclare** (`<p>`, `<br>`) |
| 5 | `*_style.html` + `style.css` | ouvrir, puis éditer le CSS et recharger (`F5`) | **contenu ≠ présentation** : deux fichiers, on change l'apparence sans toucher au texte |

*Conduite de séance* : faire l'étape 1 sur le poème tous ensemble (5′), laisser les étapes 2–5 en autonomie avec le notebook comme guide, puis mise en commun de 3′ sur l'étape 3 (l'ODT-ZIP est le moment « ah ! » de la séance).

*Si le temps manque* : l'étape 3 part en exercice complémentaire.

### 🎓 8′ — IDE (VSCode)

- **Dossier = projet** (on n'ouvre pas un fichier isolé) — habitude structurante pour git au cours 2.
- Explorateur, palette de commandes (`Ctrl+Maj+P`), terminal intégré, aperçu Markdown (`Ctrl+Maj+V`), extensions (Python, Jupyter, MyST).
- Numéros de ligne, tabulation vs espaces, encodage affiché dans la barre d'état.

### ⌨️ 25′ — Environnement Python (conda / conda-forge)

- **Le problème d'abord** : « ça marche sur ma machine ». Un environnement = un dossier isolé, décrit, recréable, supprimable sans dégât.
- **Miniforge** (<https://conda-forge.org/download/>), puis :
  ```bash
  conda create -n info01 -c conda-forge python=3.12 \
      jupyterlab mystmd numpy pillow pandoc typst ffmpeg imagemagick
  conda activate info01
  ```
- Vérification : prompt `(info01)`, `python --version`, `pandoc --version`, et surtout `import sys; print(sys.executable)`.
- **Message à marteler** : `ModuleNotFoundError` alors qu'« on vient d'installer » = presque toujours le **mauvais environnement actif**.
- L'env sert à **installer des outils**, pas à packager un projet (décision de conception du module).

> ⚠️ **Point de bascule de la séance.** Si l'installation dérape sur quelques postes, c'est tout le reste qui saute. Prévoir : consigne d'installation **avant** la rentrée, une clé USB avec l'installeur Miniforge (Windows/macOS), et un binôme d'entraide. Voir les leviers d'allègement dans [`inversion_c1_c3.md`](../../inversion_c1_c3.md).

### 🎓 10′ — Notebooks

- **Deux moitiés** : l'interface (navigateur ou VSCode) affiche, le **noyau** (un processus Python) calcule et *retient les variables*.
- Deux conséquences, à faire vivre plutôt qu'à énoncer :
  - « Redémarrer le noyau » efface les variables — le texte des cellules reste, son effet disparaît ;
  - l'ordre d'exécution (`[1]`, `[2]`…) n'est pas l'ordre d'affichage.
- **Démonstration en direct** (2′) : `x = 10` / `print(x*2)` → modifier la première cellule sans l'exécuter → la seconde ment. Puis *Restart & Run All*.
- **`.ipynb` vs MyST** : JSON généré (résultats et images inclus, `git diff` illisible) vs Markdown écrit (résultats recalculés, `diff` lisible). Montrer que **le support projeté est lui-même un fichier MyST**.
- **Bouclage explicite** : « même contenu, deux formats » — la leçon d'il y a une heure, appliquée à leur propre travail. Et amorce du cours 2 : *pourquoi le texte se versionne bien*.

### ⌨️ 10′ — Débouché : le dépôt de notes

- Markdown pour README et notes ; aperçu VSCode.
- Ouverture du **dépôt de notes du cours** — fil rouge git à faible enjeu, rejoué à chaque séance (git lui-même arrive au cours 2).

## Points d'attention

- **Ne pas glisser vers la programmation.** La séance parle de *fichiers et d'outils*. Le seul code montré sert d'illustration (3 lignes) — l'algorithmique est le cours parallèle.
- **Profils hétérogènes** (prépa littéraire / scientifique) : la manipulation « quatre formes » ne demande aucun prérequis et occupe utilement les plus rapides via les étapes ODT-ZIP et CSS.
- **Le binaire n'est plus ici** : si la question vient (« et le `.png` alors ? »), répondre en une phrase (« compressé, on l'ouvrira en hexadécimal au cours 3 ») et ne pas dévier.
- **Mention utile** : ce qu'on met dans un dépôt public y reste — d'où le choix de textes du domaine public et de données *générées* plutôt que versionnées. Amorce discrète de la leçon secrets (cours 5B).
