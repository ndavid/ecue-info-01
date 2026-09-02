# Syllabus v2 — Introduction à l'informatique (bac+2, 14 h)

> Public : 1re année d'école d'ingénieurs (géomatique), profils variés (prépa littéraire ou scientifique).
> Ce fichier est le document de référence (**vue d'ensemble**). Le détail par séance vit dans `cours/<n>_.../` (`contenu_detaille.md` + `exercices_complementaires.md`). Voir aussi [`README.md`](../README.md).

## Tableau des séances

| # | date | Séance (2 h) | type | Contenu |
|---|------|--------------|------|---------|
| 1 | 15/09 8h30-10h30 | CM | Logiciel, programmation & formats de fichier | logiciel/programmation (haut niveau) ; formats texte (`.txt`/`.odt`/`.html`/CSS), extensions ; IDE (dossier=projet) ; **env. conda** + notebooks (`.ipynb` vs MyST) |
| 2 | 22/09 8h30-10h30 | CM | Ligne de commande & git local | `init/add/commit/log/diff`, `.gitignore`, `restore` ; **dépôt de notes** (commits guidés en séance) |
| 3 | 29/09 8h30-10h30 | CM | Binaire, données & construction d'une CLI | **texte vs binaire, hexadécimal (PGM), ASCII/Unicode** ; `pathlib`, `subprocess`, `argparse` |
| 4 | 6/10 8h30-10h30 | TD | Studio d'automatisation (animation vidéo) | CLI Python (ImageMagick + ffmpeg) ; git local appliqué (commits par étape, `.gitignore` du généré) |
| 5 | 13/10 8h30-10h30 | CM | Matériel & réseau (ordres de grandeur) ; SSH, clés, secrets | ~1h culture hard/réseau + ~1h `ssh-keygen`/crypto/secrets |
| 6 | 20/10 8h30-10h30 | CM | Forge & git en équipe ; outil « trajectoire » | remote/push/pull, branch/merge ; distance & vitesse (boucle vs numpy, texte vs binaire) ; intro numpy |
| 7 | 03/11 8h30-10h30 | TD | Capstone : benchmark image + rapport (PR) | gris boucle vs numpy ; PR + conflit (branche pré-amorcée) + revue ; `RAPPORT.md` |


## Objectif du module

Rendre les étudiants à l'aise avec les **outils et concepts génériques** (environnement de développement, ligne de commande, versionnement) qui reviennent dans *tous* les cours mobilisant l'informatique et la programmation. Ce module est complémentaire du cours d'algo parallèle et a pour objectif de réduire la friction d'utilisation de ces outils et concepts dans les autres cours du programme où ils sont utilisés (en tant qu'outils, pas comme objectif d'apprentissage). S'y ajoute une **culture des ordres de grandeur** (mémoire, coût d'un calcul, réseau) qui éclaire *pourquoi* certains outils ou façons d'écrire sont plus rapides que d'autres.

- **Format des séances** : chaque séance alterne explications et **manipulations informatiques** illustrant immédiatement la notion vue (jamais un magistral pur).
- **Ancrage géomatique léger et sans prérequis** : les exemples peuvent se raccrocher à des notions géomatique (CSV de points = des coordonnées, distance = Pythagore) mais **n'exigent jamais une notion pas encore acquise**.
- **Découpage indicatif** : chaque séance ≈ 120 min ; parties notées 🎓 *exposé* / ⌨️ *manipulation* avec une durée indicative.

---

## Cours 1 — Logiciel, programmation & formats de fichier (CM)

Objectif : comprendre ce qu'est un logiciel, pourquoi programmer revient à écrire du texte, et savoir manipuler des fichiers et son environnement de travail en confiance.

> **Changement v2 (inversion partielle avec le cours 3).** L'installation de l'**environnement conda** remonte ici (semaine 1) pour que les autres cours du programme disposent d'un Python fonctionnel dès le départ ; en échange, le bloc **binaire / hexadécimal / PGM** descend au cours 3, juste avant `numpy` et le traitement d'image. S'y ajoute un point neuf sur les **notebooks**. Analyse : [`syllabus/inversion_c1_c3.md`](inversion_c1_c3.md).

- **🎓 12′ · Qu'est-ce qu'un logiciel** (haut niveau) : entrée → traitement → sortie ; un logiciel installé = des fichiers ; le fichier exécuté est binaire, mais il a été *produit* à partir de texte.
- **🎓 10′ · Qu'est-ce que programmer** : un langage = du texte suivant des conventions ; interpréteur vs compilateur (sème le « Python vs C » des cours 6–7) ; d'où la question : *dans quoi écrit-on ce texte, et sous quelle forme le stocke-t-on ?*
- **🎓 10′ · Formats & extensions** : texte vs formats riches (`docx`/`odt`/`pdf`/`zip`/`png`) ; l'extension est une **convention de nommage**, pas une nature ; fichiers et dossiers **cachés** (`.gitignore`, `.git/`) — prérequis du cours 2.
- **⌨️ 30′ · Un texte, quatre formes** *(manipulation centrale)* : le même poème/chanson en `.txt` **sur une seule ligne** (à remettre en forme), en `.donnees` (mêmes octets, extension à corriger), en `.odt` (LibreOffice, puis renommé `.zip` → c'est une archive de XML), en `.html` **brut** ouvert dans le navigateur (`file://`), puis en `.html` + **`style.css`** (contenu ≠ présentation). Données générées par `data/cours1/make_data.py`.
- **🎓 8′ · IDE (VSCode)** : *dossier = projet* (pas fichier isolé), explorateur, palette de commandes, terminal intégré, aperçu Markdown, extensions.
- **⌨️ 25′ · Environnement Python (conda / conda-forge)** : `conda create -n info01 -c conda-forge python jupyterlab mystmd numpy pillow pandoc typst ffmpeg imagemagick` puis `conda activate` ; vérifier avec `sys.executable` (« le mauvais env actif » = l'erreur n°1 du semestre). L'env sert à *installer les outils*, pas à packager.
- **🎓 10′ · Notebooks** : interface vs **noyau** (où tourne le code, pourquoi « Restart & Run All ») ; ordre d'exécution ≠ ordre d'affichage ; `.ipynb` (JSON, résultats inclus, `diff` illisible) vs **MyST** (Markdown, `diff` lisible) — *même contenu, deux formats*, ce qui reboucle sur la manipulation centrale.
- **⌨️ 10′ · Débouché** : Markdown pour README et notes ; on ouvre le **dépôt de notes du cours** (fil rouge git à faible enjeu, rejoué chaque séance).

*Détail & exercices : [`cours/1_formats_et_environnement/`](cours/1_formats_et_environnement/). Supports : [`src/cours1/`](../src/cours1/) (notebook MyST + diapos typst), données : [`data/cours1/`](../data/cours1/).*

## Cours 2 — Ligne de commande & git local (CM)

Objectif : lancer des outils au terminal (sans dépendre de l'OS) et versionner son travail en local.

- **🎓 12′ · Modèle mental CLI** : une commande = un programme + des arguments + des options ; GUI vs CLI ; bonnes pratiques (`--help`, `--verbose`).
- **🎓 5′ · Intérêt** : la CLI permet d'**enchaîner et d'automatiser** des étapes (motive le cours 3).
- **⌨️ 13′ · Un outil utile tout de suite** : `pandoc fiche.md -o fiche.pdf --pdf-engine=typst` (conversion de document, sans LaTeX) ; éventuellement une conversion ImageMagick.
- **🎓 20′ · Git local** : les 3 zones (working / staging / repo), `init`/`status`/`add`/`commit`/`log`/`diff`, `.gitignore`, annuler sans peur (`restore`).
- **⌨️ 40′ ·Manipulation guidée** (chaque étudiant en parallèle du tableau) : (TODO : trouver idée de texte à ecrire/modifier)
  1. `git init` dans `notes-info/` (un dépôt = un dossier suivi) ;
  2. écrire les notes du jour en `.md` → `git add`/`commit` (staging → commit) ;
  3. `git status`/`log`/`diff` pour *lire* ce que git dit (démystifier) ;
  4. modifier, revoir le `diff`, re-committer (le diff sur du texte = intérêt des formats du cours 1) ;
  5. `.gitignore` un fichier temporaire ; `restore` d'une modif ratée (moment anti-panique).
- **But de fin de séance** : chaque étudiant a son dépôt de notes (≥3 commits) et a vu `status`/`log`/`diff`/`restore`. Rejoué chaque séance.

## Cours 3 — Binaire, données & construction d'une CLI (CM)

Objectif : voir ce qu'il y a *vraiment* dans un fichier binaire, puis écrire un petit outil Python qui **orchestre des commandes**.

> **Changement v2** : reçoit le bloc **binaire / hexadécimal / PGM** venu du cours 1 (il prépare directement `numpy` et le TD image) ; l'installation de l'environnement conda est désormais faite en séance 1 — ici, simple **rappel d'activation** et ajout de dépendances.

- **🎓 15′ · Binaire vs texte** : encodage, bit et puissances de 2, hexadécimal (code couleur), ASCII/Unicode ; nom des symboles de programmation (`| { [ #` …).
- **⌨️ 20′ · Voir un fichier binaire** : ouvrir une petite image **PGM/PPM** (Netpbm) en **hexadécimal** — en-tête lisible + octets de pixels ; ASCII (`P2`/`P3`) vs binaire (`P5`/`P6`), *même image, deux encodages*. Rappel du cours 1 (« l'extension ne dit pas le contenu ») et préparation du TD7 (une image = un tableau de pixels).
- **🎓 12′ · Fichiers en Python avec `pathlib`** : chemins portables (Windows inclus), lecture / écriture — c'est *ici* qu'on manipule les fichiers, pas au shell.
- **🎓 13′ · Appel de commandes externes** : `subprocess.run([...], check=True)` (forme liste, codes de retour) ; enchaîner des étapes = automatisation. *(`data/cours1/make_data.py`, déjà utilisé en séance 1, en est un exemple à relire.)*
- **🎓 15′ · Construire une CLI** : `argparse`, sous-commandes, options `--verbose`/`--help` ; point sur `args`/`kwargs` (relation list/dict).
- **⌨️ 40′ · Manipulation guidée — mini-pipeline** : construire ensemble un script qui (1) génère quelques frames (ex. 5 images d'un disque qui se déplace) en appelant ImageMagick via `subprocess` (Python calcule les coordonnées, `magick -draw` dessine), (2) les assemble en un court clip avec ffmpeg, (3) expose 1–2 options `argparse` (`--frames N`, `--out`).
- **But** : *voir* concrètement l'automatisation d'un enchaînement d'outils. Sème le **TD séance 4**, qui en fait la version créative complète.

## TD (séance 4) — Studio d'automatisation (animation vidéo)

Objectif : appliquer `subprocess`/`argparse` (cours 3) et git local en produisant une **courte vidéo animée** — l'orchestration d'outils, pas de la programmation compliquée.

*Découpage ≈ 120 min : 🎓 ~15′ cadrage (démo du pipeline) + ⌨️ ~95′ réalisation + ~10′ mise en commun.*

- **Réalisation** : une CLI Python qui anime un objet simple (forme qui tourne / se déplace, orbite, aiguille d'horloge…).
- **Pipeline** : config keyframes → Python interpole/positionne → **ImageMagick** dessine les frames → **ffmpeg** assemble + incruste un texte.
- **Maths mobilisées (optionnel selon profil)** : rotation 2D (matrice), interpolation `lerp = (1−t)·a + t·b` (= moyenne pondérée → pont vecteurs/stats).
- **CLI** : `argparse` avec sous-commandes (`render`/`preview`/`clean`), `--verbose`.
- **git appliqué** : commits par étape du pipeline ; `.gitignore` des frames et de la vidéo générées (on ne versionne pas les binaires).
- **Différenciation** : *plancher* — câbler la chaîne, changer couleurs/texte/keyframes ; *plafond* — écrire soi-même la matrice de rotation, easing non-linéaire, 2ᵉ objet, stat incrustée.
- **Livrable** : un court `.mp4` + le dépôt (CLI, config, README du pipeline) à l'historique propre.
- **Pré-requis pratique** : env conda prêt + dépôt-squelette fourni (sinon l'installation mange la séance).

## Cours 5 — Matériel & réseau ; SSH, clés, secrets (CM)

Deux moitiés indépendantes ; la 2ᵉ prépare directement la forge (cours 6).

**A. Matériel, réseau & ordres de grandeur (~1 h) — culture, très haut niveau.**

- **🎓 12′ · Composants d'un PC** : CPU, RAM, disque (SSD/HDD), GPU — rôle de chacun en une phrase.
- **🎓 13′ · Réseau, le minimum** : local vs distant, client ↔ serveur, débit vs latence (motive « pourquoi un `push` est plus lent qu'un `commit` »).
- **🎓 20′ · Ordres de grandeur** (fil rouge de la séance) : temps d'accès (RAM ≪ SSD ≪ réseau), tailles (Ko/Mo/Go/To), coûts ; rendus incarnés par une échelle relative mémorable (« si la RAM = 1 s, le disque = …, le réseau = … »).
- **⌨️ 15′ · Manipulation légère** : comparer la taille d'une même image en png vs jpg (compression → cours 1) ; chronométrer la lecture d'un petit vs gros fichier (→ cours 2).
- **Cohérence** : se raccroche à trois fils déjà vus/à venir — tailles & compression (c.1), timing fichier (c.2), local vs distant (forge, c.6). *(Si un point ne se raccroche pas, tant pis : toutes les notions de base ne sont pas interdépendantes.)*

**B. SSH, clés & secrets (~1 h) — pratique, juste avant la forge.**

- **🎓 20′ · Crypto clé publique/privée**, niveau concept : une paire, publique partagée / privée secrète (analogie cadenas) ; hachage ≠ chiffrement (rappel du SHA de commit, cours 2).
- **⌨️ 25′ · `ssh-keygen`** + ajout de la clé **publique** au compte de la forge (préparation du cours 6).
- **🎓 15′ · Secrets & `.gitignore`** : ne jamais committer clé privée, mot de passe, token ; l'historique public est **permanent**. *(La leçon « secrets » atterrit ici.)*

## Cours 6 — Forge & git en équipe ; outil « trajectoire » (CM)

Objectif : maîtriser la forge (remote, push/pull) et branches/merge **en construisant** un petit outil qui calcule des stats sur une trajectoire (CSV/GPX) — les jalons de code *sont* les étapes git.

- **🎓 15′ · Forge** : compte, dépôt distant, `remote`, `clone`, `push`/`pull`.
- **🎓 15′ · Outil trajectoire** : distance totale et **vitesse moyenne** sur une suite de points ; deux comparaisons — boucle vs **numpy** (« Python interprété vs boucle **C** compilée ») et lecture **texte ligne par ligne** vs **binaire d'un bloc**.
- **⌨️ 10′ · numpy** introduit ici comme *ajout de dépendance* à l'env (`conda install numpy`, rappel c3).

**⌨️ ~55′ · Jalons de code = étapes git** (manipulation guidée) sur outils calcul stat gpx:

| Jalon | Code | Étape git |
|------|------|-----------|
| J1 | `load_txt` (lecture ligne par ligne) | `feat/load` → merge |
| J2 | `distance_totale` (boucle, Pythagore) | `feat/distance` → merge |
| J3 | `vitesse_moyenne` | `feat/speed` → merge — **conflit pré-amorcé** résolu ensemble |
| J4 | `distance_np` + `load_npy` (numpy / binaire) | `feat/numpy` → merge |
| J5 | mini-`benchmark()` | `feat/bench` → merge → `push` |

**But / seed** : chaque étudiant a poussé son outil sur la forge et fait ≥1 merge (dont un conflit résolu) ; sème le **TD7** (benchmark en plus gros).

## TD (séance 7) — Recap tout : benchmark image + rapport (PR)

Objectif : appliquer numpy + le workflow **Pull Request** sur un benchmark **image** 2D, et produire un **rapport markdown**. Dépôt **individuel** (GitHub Classroom) → aucun merge séquentiel entre élèves.

*Découpage ≈ 120 min : 🎓 ~15′ cadrage + ⌨️ ~95′ implémentation & PR + ~10′ mise en commun.*

- **Noyau (plancher, tous)** : niveaux de gris = **moyenne des 3 canaux** — version **boucle** sur les pixels vs version **numpy** vectorisée ; chronométrer → speedup ×100-1000 (« Python pur vs call C » à l'échelle 2D).
- **Plafond** : flou = moyenne d'un voisinage (moving average 2D) ; accès **ligne vs colonne** (cache, c5) ; lecture PNG vs `.npy`.
- **Étapes git (features à implémenter)** :
  1. `git clone` de son dépôt (squelette : loader, chrono `timed()`, image de référence, `RAPPORT.md` gabarit) ;
  2. `git switch -c feat/grayscale` → coder `gris_boucle` puis `gris_numpy` (commits jalons) → `push` ;
  3. **ouvrir la PR** (titre + « ce que je mesure ») ;
  4. **conflit via branche pré-amorcée** : merger la branche `conflit-rapport` fournie (elle touche l'en-tête de `RAPPORT.md`) → résoudre les marqueurs `<<<<<<<` ;
  5. **revue round-robin** : commenter la PR d'un pair assigné (N relit N+1) — parallèle, sans dépendance ;
  6. **merger sa propre PR** ; l'autograder vérifie `gris_numpy` vs référence.
- **Livrable** : PR mergée + conflit résolu + `RAPPORT.md` (image avant/après, tableau de temps, 1 phrase d'interprétation par comparaison) + une revue laissée.
- **Robustesse** : squelette fourni ; plancher = 1 ligne (`img.mean(axis=2)`) réussissable par tous ; médiane de N essais, « on lit des *ratios*, pas des chiffres exacts » ; `Pillow` + `numpy` via conda-forge ; **une seule** PR (jalons = commits) pour tenir en 2 h.

---

## Détail par séance

Le déroulé fin et les exercices complémentaires de chaque séance vivent dans un sous-dossier dédié — `contenu_detaille.md` + `exercices_complementaires.md` :

| Séance | Dossier |
|--------|---------|
| 1 | [`cours/1_formats_et_environnement/`](cours/1_formats_et_environnement/) ✅ rempli (gabarit) — supports [`src/cours1/`](../src/cours1/), données [`data/cours1/`](../data/cours1/) |
| 2 | `cours/2_cli_git_local/` |
| 3 | `cours/3_python_env_cli/` |
| 4 | `cours/4_td_animation/` |
| 5 | `cours/5_materiel_reseau_ssh/` |
| 6 | `cours/6_forge_trajectoire/` |
| 7 | `cours/7_td_benchmark_image/` |

---

## Annexe — Artefact optionnel « fiche perso » (à trancher, non retenu comme TD)

Rôle pédagogique *spécifique* : la leçon **secrets / `.gitignore`** (données perso réelles → historique public **permanent**), difficile à enseigner ailleurs, + Markdown/pandoc. Tâches : `fiche.md` ; données dans `perso.yaml` **ignoré** (prouver via `git check-ignore`) ; photo recadrée (ImageMagick) ; PDF (pandoc). Hook motivant *seulement si publiée* (page `username.github.io`, séance forge). **Verdict** : livrable léger pour des primo-entrants en semaine 3 → à garder en artefact court/optionnel ou pour la seule leçon secrets, pas comme TD principal. *(La leçon secrets est désormais portée par le cours 5B — la fiche perso n'est donc plus nécessaire pour ça.)*
