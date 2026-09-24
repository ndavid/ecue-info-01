# Syllabus v2 — Introduction à l'informatique (proposition pour 2027-2028)

> Proposition de refonte ouverte le 24/09/2026, après les séances 1 et 2. Le module tel qu'il est joué en 2026-2027 reste décrit dans [`01_syllabus_v1.md`](01_syllabus_v1.md). Les orientations de la section 2 sont arrêtées ; le reste (contenu fin, budgets, points à vérifier) est à reprendre séance par séance. La répartition des séances entre intervenants se fera sur cette version.
> Les numéros de diapositive renvoient aux PDF projetés de 2026, avec TD (`src/cours<n>/diapo/cours<n>.pdf`, compilés le 24/09) ; le titre est donné à côté, les numéros bougeant à chaque modification.

## 1. Constats de 2026

**Cours 1 trop long.** 123 diapositives et dix TD pour 2 h. Les parties 1 à 3 ont été jouées, la partie 4 (bibliothèques et environnements, diapositives 90 à 122) ne l'a pas été. La capacité réelle observée est d'environ 90′ de contenu après 10′ d'ouverture.

**Cours 2 un peu trop ambitieux.** 95′ de TD annoncés (3a, 4a, 4b, 4c, 6a), plus l'exposé. Git y va jusqu'au `rebase`, au `tag` et à l'organisation main / develop / feature, que le cours 6 reprend en équipe.

**Ligne de commande vue sans pratique.** Au cours 2, 13 pages d'exposé, sans TD. Les élèves ont manqué d'aisance avec le terminal, dont tous les cours suivants dépendent.

**Un terminal différent à chaque séance**, sans que leur différence soit expliquée :

| Cours | Terminal employé |
|---|---|
| 1, TD 2a | terminal de VS Code (PowerShell, qui refuse `activate.ps1`), remplacé par un profil Anaconda Prompt |
| 2 | bash (captures sous Linux) |
| 3 | Anaconda Prompt (préparation), Git Bash avec `conda init bash` (TD 3a) |
| 4 | Git Bash dans VS Code |
| 5 | Anaconda Prompt ; « Git Bash a la sienne » pour la clé SSH |

**Configuration de VS Code plus longue que prévu.** Au TD 2a du cours 1, chaque élève a configuré seul l'éditeur (extension, interpréteur, profil de terminal). Les problèmes de configuration, propres à chaque poste, et la prise en main d'un outil nouveau ont pris plus que les 25′ prévues, et c'est ce qui a repoussé la partie 4 hors de la séance.

**Travail perdu dans le dossier partagé.** À la séance 1, des élèves ont travaillé directement dans `formationTemp` et y ont perdu leur travail ([`src/avant/donnees.md`](../src/avant/donnees.md)). La différence entre le disque du poste et un dossier du réseau n'est expliquée nulle part avant le cours 5.

**Notions traitées deux fois.** Texte et binaire, ASCII et UTF-8 : cours 1 (diapositives 19, 20, 31) et cours 3 (TD 2b). `PATH` et activation : cours 1 (101) et cours 3 (« Où le terminal trouve pandoc »). Chemins : cours 1 (15 à 17), cours 2 (arborescence, 5 à 9), cours 3 (`pathlib`). Client et serveur : cours 1 (104 à 106) et cours 5 (22).

## 2. Orientations retenues

| Séance | Retire | Reçoit |
|---|---|---|
| **1** | VS Code et l'IDE (TD 2a, fonctions et édition d'un IDE), environnements et bibliothèques (partie 4), Markdown, binaire et texte | stockage local et distant et copie des fichiers du cours, à la suite des logiciels et fichiers ; terminal Git Bash et commandes de base, traités avec le premier programme (édité dans Notepad++, lancé au terminal), une partie du TD 1a faite en ligne de commande ; ouverture d'un notebook |
| **2** | la ligne de commande ; `rebase`, organisation des branches et `tag` (vers le cours 6) | configuration de VS Code en classe entière en début de séance ; l'IDE ; rappel de la configuration de Git Bash ; Markdown, qui fournit les fichiers des premiers commits |
| **3** | la préparation du poste en autonomie | les environnements, traités par la pratique : la séance commence par la création de son environnement ; le binaire et le texte du cours 1 |
| **4** | l'explication des environnements (acquise au cours 3) | du temps pour la partie B |
| **5** | — | le serveur de notebook comme exemple de client et serveur |
| **6** | — | `rebase`, organisation main / develop / feature, `tag` |

**Une configuration par séance.** L'ordre des séances sert aussi à répartir les étapes d'installation et de configuration, qui sont ce qui déborde, et à laisser aux élèves le temps de prendre en main un outil avant le suivant : Git Bash et `conda init bash` au cours 1, VS Code au cours 2 (en classe entière), un environnement conda au cours 3. Chaque séance n'en a qu'une, placée tôt, avec une vérification immédiate ; chaque outil est ensuite réemployé à la séance suivante avant qu'un autre s'ajoute.

Terminal de référence du module : **Git Bash**, configuré au cours 1 (`conda init bash`), rappelé au cours 2, employé ensuite partout, cours 5 compris. C'est le langage du cours 2 et des postes macOS et Linux des élèves, et le cours 4 l'emploie déjà.

---

## Cours 1 — Logiciels, fichiers, terminal et premier programme (CM)

Objectif : savoir où sont ses fichiers et où les ranger, se déplacer et agir sur des fichiers depuis un terminal, écrire un programme Python dans un éditeur de texte et le lancer, ouvrir un notebook.

- **🎓 10′ · Ouverture du module** : diapositives 2 à 8 de 2026, inchangées sur le fond.
- **Partie 1 · Logiciels, fichiers et stockage (30′)**
  - 🎓 10′ · logiciel, système d'exploitation, entrées et sorties, application web, utilité d'un fichier, extension et type de fichier, quiz des extensions (diapositives 10 à 14, 18, 21, 22). Une phrase sur le texte : un fichier texte s'ouvre dans un éditeur de texte, les autres dans le logiciel de leur format ; le détail en octets est au cours 3.
  - 🎓 5′ · **stockage local et distant** *(nouveau)* : où est un fichier (disque du poste, dossier partagé sur un serveur de l'école `formationTemp`, espace personnel réseau, stockage en ligne synchronisé, clé USB) ; pour chacun, qui le voit, ce qui arrive quand deux personnes y écrivent, ce qui reste après la déconnexion, la vitesse (un mot, les chiffres sont au cours 5). Un chemin qui commence par `\\` ou par une autre lettre que `C:` est sur le réseau.
  - ⌨️ 5′ · copier l'archive de la séance depuis `formationTemp` dans `Desktop\info01`, la décompresser, vérifier la barre d'adresse. Reprend la page [`src/avant/donnees.md`](../src/avant/donnees.md) : ce qui était une consigne devient une notion, appliquée tout de suite. En fin de séance, emporter son travail (où : à préciser, voir section 4).
  - ⌨️ 10′ · **TD 1a, première moitié, à la souris** : afficher les extensions, exporter `raven.odt` sous deux autres formats, ouvrir une page HTML depuis le disque, Bloc-notes et Notepad++ sur les mêmes fichiers. La table ASCII part au cours 3.
- **Partie 2 · Terminal et premier programme (50′)** *(le terminal est repris du cours 2 de 2026)*
  - 🎓 10′ · le terminal (la fenêtre) et l'interpréteur de commandes (le langage : cmd, PowerShell, bash) ; une diapositive-tableau des terminaux du poste (où le trouver, son langage, les cours qui l'emploient) qui justifie le choix de Git Bash ; lire l'invite (utilisateur, dossier courant) ; `commande [options] <arguments>`, `--help` ; chemin absolu et relatif, `.` et `..`, fichiers cachés (fusion des diapositives 15 à 17 du cours 1 et 5 à 11 du cours 2) ; le motif `*`, présenté comme un motif de noms de fichiers (le cours 2 de 2026 l'appelait à tort « expressions régulières »).
  - ⌨️ 15′ · **TD 1a, seconde moitié, en ligne de commande** : ouvrir Git Bash dans `cours1/1a_formats/` ; `pwd`, `ls`, `ls -a`, `cd` ; copier `depart/` vers `travail/` (`cp`) ; renommer une extension (`mv raven_odt.odt raven_odt.pdf`) puis ouvrir le fichier (`start`) pour voir l'effet ; créer un nom avec espace et constater qu'il faut des guillemets ; `conda init bash`, une fois, puis `python --version` dans un nouveau terminal.
  - 🎓 5′ · programme et application, compilé et interprété, la place de l'interpréteur (diapositives 39, 40, 42) ; un programme est un fichier texte, n'importe quel éditeur de texte suffit pour l'écrire, et le terminal le fait exécuter par l'interpréteur.
  - ⌨️ 10′ · **TD 2a** : ouvrir `altitudes.py` dans Notepad++, le lancer dans Git Bash (`python altitudes.py`), le modifier, le relancer ; Python en interactif (`python`, puis `exit()`).
  - ⌨️ 10′ · **TD 2b · Trois programmes fautifs**, dans Notepad++ (Affichage → Symboles spéciaux → Afficher tous les caractères) : espaces et tabulations, puis corriger et relancer au terminal.
- **Partie 3 · Ouvrir un notebook (10′)**
  - 🎓 un notebook : texte, code et résultat dans un seul document ; un bloc de code s'exécute dans un noyau qui retient les variables (diapositives 79, 81).
  - ⌨️ **TD 3b allégé** : `altitudes.ipynb` ouvert dans JupyterLab (depuis Navigator, ou `jupyter lab` dans Git Bash), exécuter les cellules dans le désordre, voir ce que le noyau retient.
- **Clôture** : « À retenir », resserré sur logiciel, extension, disque local et réseau, terminal, chemin relatif, interpréteur, notebook.

**Budget** : 10 + 30 + 50 + 10 = **100′**, autant que ce qui a été joué en 2026. Les minutes ne disent pas tout : le cours 1 de 2026 a débordé sur la configuration de VS Code, poste par poste, et le cours 1 v2 n'a plus qu'une étape de configuration (`conda init bash`), placée dans un TD court et vérifiée aussitôt par `python --version`. Si la séance déborde malgré tout, la partie 3 passe en début de cours 3, qui ouvre des notebooks de toute façon ; le TD 2b ensuite.

**En annexe** : TD 1b (`.odt` archive ZIP), TD 2c (C++) avec la diapositive 41 (étapes de la compilation), débogueur pas à pas (diapositives 61, 62), TD 4c (trajet).

## Cours 2 — Éditeur de code, Markdown et git local (CM)

Objectif : travailler dans un éditeur de code configuré, écrire de la documentation en Markdown, et versionner ce travail avec git en local.

- **⌨️ 20′ · Configuration de VS Code, en classe entière** : l'enseignant projette, chaque élève fait la même étape en même temps, on ne passe à la suivante que lorsque la salle a fini. Lancer VS Code ; installer l'extension Python ; choisir l'interpréteur ; faire de Git Bash le terminal par défaut (`terminal.integrated.defaultProfile.windows`) ; ouvrir le dossier `cours2/` ; vérifier `(base)` et `python --version` dans le terminal intégré. Reprend les diapositives 50 à 56 du cours 1 de 2026, remplace le profil Anaconda Prompt par Git Bash, et s'appuie sur [`src/annexes/configuration/vscode.md`](../src/annexes/configuration/vscode.md).
  - Le guide du TD, plus détaillé qu'en 2026 : une capture par étape, la vérification attendue, et la réponse aux blocages connus (PowerShell et `activate.ps1`, interpréteur absent de la liste, webview de l'aperçu). Distribué avant la séance pour les élèves qui veulent prendre de l'avance.
- **🎓 10′ · L'IDE** : les fonctions d'un IDE ; édition (coloration syntaxique, chasse fixe, indentation) ; dossier ouvert = projet (diapositives 43 à 47 du cours 1 de 2026).
- **🎓 5′ · Rappel Git Bash** : l'invite, `cd`, `ls -a`, `conda init bash` si le poste a changé.
- **Markdown (20′)**
  - 🎓 les fichiers texte d'un projet, le format de la documentation, l'intention de Markdown et sa syntaxe (diapositives 75 à 78 du cours 1 de 2026).
  - ⌨️ la recette en Markdown avec l'aperçu de VS Code (TD 3a du cours 1 de 2026, sans le diagramme `mermaid`, qui passe en annexe). Le fichier obtenu est celui du premier commit.
- **Git local (≈ 60′)**
  - 🎓 à quoi sert git ; `init`, fichiers suivis et non suivis, zone de préparation, commit ; `status`, `log --graph`, `diff` ; `.gitignore` ; annuler (`restore`, `revert`) ; une branche et un `merge`.
  - ⌨️ un dépôt pour la recette : premier commit, modifier le Markdown, lire le `diff`, committer à nouveau ; ignorer un fichier généré (l'export HTML de l'aperçu) ; une branche pour une variante de la recette, fusionnée. Tout depuis le terminal intégré de VS Code.
- **Vers le cours 6** : `rebase`, conflits, organisation main / develop / feature, `tag` (TD 4b, 4c, 6a et diapositives 66 à 72 de 2026).

**Budget** : 20 + 10 + 5 + 20 + 60 = **115′**. Le premier poste à surveiller est la configuration : si elle dépasse 20′ en classe entière, le guide distribué avant la séance doit la faire commencer avant.

## Cours 3 — Environnements, chemins et fichiers en Python, ligne de commande (CM)

Objectif : installer un projet dans son propre environnement, manipuler chemins et fichiers en Python, construire un programme en ligne de commande. Séance surtout pratique.

- **⌨️ 20′ · Un environnement pour la séance** *(remplace la préparation du poste, et la partie 4 du cours 1 de 2026)* : copier l'archive, ouvrir le dossier dans VS Code ; lire `environment.yml` ; `conda env create -f environment.yml`, `conda activate cours3` ; constater qu'un paquet présent dans l'environnement ne l'est pas dans `base` ; choisir cet environnement comme interpréteur et comme noyau.
  - 🎓 intercalé, trois diapositives : dépendances et versions (95, 96), l'environnement contre les conflits (97), d'où viennent les paquets (99). L'activation et `PATH` (101) fusionnent avec « Où le terminal trouve pandoc ».
- **Chemins (20′)** : `recette.ipynb`, comme en 2026 ; le renvoi au « programme recette du cours 1 » disparaît, la recette est présentée ici.
- **Texte et binaire (35′)** : `images.ipynb`, qui reçoit en ouverture le schéma bit → octet → hexadécimal → caractère (diapositive 19 du cours 1 de 2026) et la table ASCII (31). `fichiers.ipynb` passe en lecture autonome, ses fonctions étant déjà employées par `recette.ipynb`.
- **Ligne de commande (45′)** : TD 3a comme en 2026, l'étape 6 (`pyproject.toml`, `pip install -e .`) reçoit la diapositive 102 du cours 1 de 2026.

**Budget** : 20 + 20 + 35 + 45 = **120′**, sans marge. Ce qui se retire d'abord : la section compression et temps de lecture de `images.ipynb` (§ 5 et 6), puis les étapes facultatives du TD 3a.

## Projet (séance 4) — Une animation, du notebook au programme

Inchangé sur le fond. La partie A (créer l'environnement `animation`, lancer JupyterLab) devient une application du cours 3 et passe de 35′ à ≈ 20′ ; les 15′ gagnées vont à la partie B, dont l'étape B4 (README) peut alors se faire en séance.

## Cours 5 — Matériel, réseau ; mots de passe, clés, secrets (CM)

Inchangé sur le fond. La diapositive « Client et serveur » reçoit l'exemple du serveur de notebook sur son propre poste (`localhost:8888`, diapositives 104 à 106 du cours 1 de 2026), et « Local et distant » renvoie à la partie stockage du cours 1. Les TD passent de l'Anaconda Prompt à Git Bash (`cat ~/.ssh/id_ed25519.pub` au lieu de `type %USERPROFILE%\…`).

## Cours 6 et projet 7

Le cours 6 reçoit `rebase`, les conflits hors ceux du jalon J3, l'organisation main / develop / feature et le `tag` ; son programme reste à écrire. Projet 7 inchangé.

---

## 3. Déplacements, diapositive par diapositive

| Diapositives de 2026 | Titre | Vers |
|---|---|---|
| c1 · 15 à 17 | Quiz chemins ; Le chemin d'un fichier | c1, partie 2 (terminal), fusionnées avec c2 · 5 à 11 |
| c1 · 19, 20, 31 | Binaire et texte ; Le fichier texte ; Table ASCII | c3, ouverture de `images.ipynb` |
| c1 · 33 à 37 | TD 1b | annexe |
| c1 · 41, 67 à 73 | Du code source aux instructions ; TD 2c | annexe |
| c1 · 43 à 47 | Fonctions et édition d'un IDE | c2 |
| c1 · 48 à 56 | TD 2a, configuration de VS Code | c2, classe entière |
| c1 · 57 à 60 | Programme du TD, lancer, Python interactif, Anaconda Prompt | c1, TD 2a sans VS Code, dans Git Bash |
| c1 · 61, 62 | Débogueur | annexe, ou c2 si le temps le permet |
| c1 · 74 à 78, 83 à 87 | Markdown, TD 3a | c2 |
| c1 · 79 à 82, 88 à 89 | Notebook, TD 3b | c1 allégé (partie 3) |
| c1 · 90 à 101 | Bibliothèques, dépendances, environnements | c3, ouverture pratique (quatre diapositives) |
| c1 · 102 | `pyproject.toml` | c3, TD 3a étape 6 |
| c1 · 103 | Le terminal de l'éditeur | c2 |
| c1 · 104 à 106 | Client et serveur d'un notebook | c5, réseau |
| c1 · 107 à 113 | TD 4a, installer le projet recette | c3, ouverture pratique (même démarche sur l'environnement de la séance) |
| c1 · 114 à 122 | TD 4b, TD 4c | annexes |
| c2 · 2 à 14 | Terminal, bash, commandes, arborescence, fichiers cachés, `*` | c1, partie 2 (terminal) |
| c2 · 36 à 37, 46, 66 à 72 | `revert` et `tag`, `rebase`, bonnes pratiques | c2 garde `revert` ; le reste vers c6 |
| c2 · TD 4b, 4c, 6a | Annuler et `rebase`, conflit, publier une version | c6 |

## 4. À vérifier avant d'écrire les supports

1. Sur un poste de la salle : `conda init bash` dans Git Bash tient-il d'une session à l'autre sans droits d'administrateur ? Toute l'orientation « Git Bash partout » en dépend.
2. Le Bureau du poste est-il conservé d'une séance à l'autre, ou effacé à la déconnexion ? Et quel stockage l'école donne-t-elle aux élèves (espace réseau personnel, OneDrive de l'école, autre) ? La partie 2 du cours 1 en dépend.
3. Notepad++ est-il installé sur tous les postes de la salle ?
4. Les autres cours du programme demandent-ils, en septembre, de lancer un script, d'ouvrir un notebook, ou d'utiliser VS Code ? Si c'est VS Code, le reporter au cours 2 les gêne pendant une semaine.
5. `start` ouvre-t-il un fichier depuis Git Bash sur les postes de la salle, ou faut-il `explorer.exe` ?
