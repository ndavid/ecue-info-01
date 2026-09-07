# Contenu détaillé — Cours 1 : Logiciel, programmation & formats de fichier

Vue d'ensemble : [../../01_syllabus_v1.md](../../01_syllabus_v1.md) (section « Cours 1 »).
Inversion C1↔C3 : [../../inversion_c1_c3.md](../../inversion_c1_c3.md).

**Supports** : [`src/cours1/notebook/`](../../../src/cours1/notebook/) (MyST, 3 pages) et [`src/cours1/diapo/`](../../../src/cours1/diapo/) (typst, 58 diapositives en assertion-evidence ; `--input notes=true` pour la version annotée).
Conventions d'écriture : [`STYLE.md`](../../../STYLE.md).
**Données** : [`data/cours1/`](../../../data/cours1/) — générées par `make_data.py`.

Objectif : comprendre ce qu'est un logiciel, pourquoi programmer revient à écrire du texte, et savoir manipuler fichiers et environnement de travail en confiance.

## Fil conducteur

La séance est construite comme une chaîne de questions, chacune amenant la suivante :

> *Qu'est-ce qu'un logiciel ?* → entrée/traitement/sortie, et c'est un fichier.
> *Comment le pilote-t-on ?* → une **interface**, graphique ou textuelle.
> *Que manipule-t-il ?* → des **fichiers**, que l'extension nomme sans les décrire.
> *D'où vient le logiciel lui-même ?* → de **texte** écrit par un humain.
> *Et avec quels outils travaille-t-on ?* → **IDE**, **environnement**, **notebooks**.

Aucune notion n'est introduite sans que la précédente l'ait rendue nécessaire.

Les diapositives suivent ce découpage en trois parties, séparées par des
diapositives de séparation : *logiciels et interfaces*, *programmation*,
*formats de fichier et outils de travail*.

## Déroulé détaillé

### 🎓 12′ — Qu'est-ce qu'un logiciel (haut niveau)

- Schéma unique et réutilisé tout le semestre : **entrée → traitement → sortie**. Distinguer deux sortes de sorties : celle **qui reste** (un fichier) et celle **qui passe** (un périphérique : écran, son). Le module s'intéresse surtout à la première, parce que c'est elle qui se relit, se compare et se versionne.
- Un logiciel installé = **des fichiers**, rien de plus. Double-cliquer = demander au système de lire un fichier et de l'exécuter.
- Ce fichier est **binaire** (illisible pour un humain) — mais il n'a pas été écrit comme ça, il a été *produit*.
- *Ne pas entrer* dans l'architecture machine (registres, mémoire) : c'est le cours 5.

### 🎓 6′ — Logiciel, application, app

- **Le vocabulaire d'abord**, parce qu'il est flottant : *logiciel* est le terme général ; un *logiciel d'application* sert une tâche de l'utilisateur ; *application*, *appli* et *app* en sont des synonymes ou des abréviations, pas d'autres objets.
- Définitions de référence : « logiciel », vocabulaire de l'informatique publié au *Journal officiel* du 22 septembre 2000 ; « logiciel d'application », Grand dictionnaire terminologique de l'OQLF.
- **Deux questions posées à la salle**, réponses à l'oral :
  1. *Quel système d'exploitation tourne sur votre téléphone ?* — attendu Android ou iOS (ordre de grandeur mondial : ~70 % / ~30 %, StatCounter 2026). Personne ne dit « Linux » alors qu'Android en est un : c'est le point à relever.
  2. *Qu'est-ce qu'une application web, une « webapp » ? Citez-en une que vous utilisez.* — laisser venir « un site où on fait des choses », « ça marche sans installer », sans corriger. Les exemples viennent seuls : messagerie, documents partagés, retouche d'image, cartes.
- Le schéma des couches (programmes → système → matériel) se lit dans la foulée : le système d'exploitation est justement le *logiciel de base* de la définition.

> Ne pas citer Android ni iOS avant la question 1, ni les logiciels que les étudiants ne connaissent pas encore en début d'année (QGIS arrive plus tard dans le cursus). Les exemples des diapositives précédentes ont été choisis dans ce sens.

### 🎓 5′ — L'application web, et où le calcul se fait

Réponse à la question 2, en deux diapositives. L'enjeu n'est pas le vocabulaire : il est de faire remarquer que des tâches qui demandaient un logiciel installé se font aujourd'hui dans un navigateur, et que le lieu du calcul, donc celui des fichiers, a changé sans qu'on le dise.

- **Définition** : « application fonctionnant dynamiquement avec le concours d'un navigateur web » (Grand dictionnaire terminologique de l'OQLF). Pas d'installation : le code est téléchargé à chaque visite et exécuté par le navigateur, dans un environnement isolé.
- **Le navigateur fait le travail d'un système d'exploitation** : il charge du code, l'exécute dans une machine virtuelle, lui donne du stockage et un accès réseau, et l'empêche de toucher au reste de la machine. La documentation de Mozilla emploie littéralement le mot « machine virtuelle » pour le moteur qui exécute JavaScript et WebAssembly, ce dernier tournant à une vitesse *proche du natif*. Ne pas entrer dans les technologies.
- **Deux endroits pour le calcul**, et c'est la conséquence qui compte :

| | Calcul dans le navigateur | Calcul sur un serveur |
|---|---|---|
| Votre fichier | ne quitte pas la machine | part sur le réseau |
| Sans connexion | peut continuer | s'arrête |
| Qui calcule | votre processeur | celui du service |
| Exemples | retouche d'image en ligne | traduction, IA générative |

- **Rattachement** : l'outil en ligne proposé pour la manipulation vidéo annonce que le rendu se fait sur l'appareil, ce qui explique qu'il n'exige ni compte ni connexion permanente. La phrase « ce qu'on dépose quelque part y reste » est semée ici et reprise au cours 5 avec les secrets.

### 🎓 10′ — Outils de programmation : IDE et environnement *(partie de cours)*

La partie s'ouvre en **reprenant le schéma entrée → traitement → sortie** du début de séance, pour poser la question qu'il laissait ouverte : la boîte du milieu est un fichier, d'où vient-elle ? La réponse tient en deux temps, un humain écrit du texte, puis quelque chose le transforme en instructions.

**Interprété et compilé, en schéma plutôt qu'en tableau** : la chaîne compilée a une étape de plus (`raven.c` → compilateur → `raven.exe` → résultat) mais ne la fait **qu'une fois** ; la chaîne interprétée en a une de moins (`raven.py` → interpréteur → résultat) mais la refait **à chaque lancement**. Lancer un programme Python ne crée rien sur le disque, et c'est aussi pourquoi il est plus lent.

Viennent ensuite, dans la même partie, la feuille de route des trois compétences, l'environnement conda et les notebooks : c'est l'outillage annoncé par le titre.

### 🎓 10′ — Qu'est-ce que programmer

- Un langage = un vocabulaire, une grammaire, un sens. Écrire un programme = écrire un texte respectant cette convention.
- Démonstration : 3 lignes de Python affichées, exécutées en direct dans le notebook. Insister — *c'est du texte qu'on pourrait taper dans le Bloc-notes*.
- **Interpréteur vs compilateur**, tableau à 3 lignes. Python est interprété.
- **Graine explicite** : « exécution plus lente » → cours 6 (boucle vs numpy) et TD7 (×100–1000).

### 🎓 6′ — Fichier, extension, type de fichier

- **Anatomie d'un nom de fichier** : le nom, puis l'extension après le dernier point. L'extension décide quel logiciel le système lance au double-clic ; elle ne modifie aucun octet.
- **Fichiers et dossiers cachés** : nom commençant par `.` (`.gitignore`, dossier `.git/`) ; comment les afficher. *Prérequis du cours 2* — ne pas sauter.
- Faire activer **l'affichage des extensions** dans l'explorateur (masquées par défaut sous Windows/macOS) : à faire une fois, utile tout le semestre, et **indispensable à la manipulation suivante**.

### 🎓 4′ — Reconnaître un format à son extension

Grille de seize extensions (`.mp3` `.flac` `.mp4` `.mkv` `.jpg` `.png` `.svg` `.tif` `.pdf` `.odt` `.xlsx` `.csv` `.zip` `.7z` `.py` `.exe`), interrogation rapide de la salle, puis la même grille avec les réponses.

Les trois qui font débat : `.svg` (une image, mais du texte XML), `.csv` (du texte, pas un fichier Excel) et `.7z` (une archive comme `.zip`, mais d'un autre outil). **Trois des seize sont du texte** : ce sont ceux qu'on peut ouvrir dans un éditeur, comparer ligne à ligne et versionner — la conclusion qui prépare le cours 2.

> `.geojson` a été retiré de la grille : les étudiants ne l'ont pas encore rencontré en début d'année.

### 🎓 6′ — Chemins de fichiers et adresses de pages

- **Le chemin d'un fichier**, décomposé sur un exemple Windows : `C:\` le disque, `Users\alice\Documents\` les dossiers du plus large au plus précis, `raven` le nom, `.odt` l'extension. Windows sépare par une barre inversée, macOS et Linux par une barre normale ; un chemin **relatif** part du dossier courant.
- **L'adresse d'une page** est le même objet, précédé de la machine où aller chercher : `https://` comment on parle, `www.ensg.eu` à quelle machine, `/cours/info01/` le chemin sur cette machine, `raven.html` le fichier.
- **Le pont** : `file:///C:/Users/alice/Documents/raven.html`, même structure sans machine distante. C'est ce qui explique le `file:///` que les étudiants verront en ouvrant une page par double-clic, tout de suite après.
- *Semé pour le cours 3* : « le fichier existe pourtant » signifie presque toujours qu'on ne l'a pas cherché depuis le bon dossier.

### ⌨️ 20′ — TD : fichiers, formats et extensions *(manipulation, LibreOffice)*

Fichier de départ : `data/cours1/genere/raven.odt`, produit par `python make_data.py fetch && python make_data.py build`. Tous les résultats ci-dessous ont été observés, sur LibreOffice piloté en mode sans interface.

**1. Un même document, trois formats.** Ouvrir le `.odt` dans Writer, puis :

| Fichier produit | Comment | Le texte est-il encore du texte ? |
|-----------------|---------|-----------------------------------|
| `raven.pdf` | Fichier → Exporter au format PDF | oui : il se sélectionne et se cherche |
| `raven.png` | Fichier → **Exporter…**, type PNG | non : des pixels, et la première page seulement |
| `raven.odt` | le fichier de départ | oui, et il reste modifiable |

L'export en image se trouve sous *Fichier > Exporter*, pas sous *Enregistrer sous* : les filtres `writer_png_Export` et `writer_jpg_Export` existent bien depuis Writer. Nommer la différence entre une page **décrite** (PDF, texte vectoriel) et une page **photographiée** (PNG, JPEG). Rouvrir le `.png` dans LibreOffice : il s'ouvre dans **Draw**.

**2. Renommer, et voir qui se laisse tromper.** Avec `F2`, sur des copies, en gardant `odt` dans le nom :

| Nom donné | Ce que le système propose | Ce qui se passe |
|-----------|---------------------------|-----------------|
| `raven_odt.pdf` | un lecteur PDF | refus : le fichier n'est pas un PDF |
| `raven_odt.jpg` | une visionneuse | refus : *Not a JPEG file: starts with 0x50 0x4b* |
| `riri.fifi.loulou.odt` | LibreOffice Writer | s'ouvre : seule la fin du nom compte |
| `raven.loulou` | LibreOffice Writer | s'ouvre : extension inconnue, le système regarde le contenu |

La quatrième ligne est la plus instructive et n'est pas intuitive : avec une extension **inventée**, le système n'a plus de convention à appliquer et se rabat sur les premiers octets. Laisser la salle inventer l'extension. Le message de la visionneuse nomme lui-même les octets lus, `0x50 0x4b`, soit « PK ».

> **Prérequis, vérifié en 2026** : Windows 11 masque toujours les extensions des types connus **par défaut**. Le réglage est dans *Explorateur > Affichage > Afficher > Extensions de noms de fichiers* ; sous macOS, *Finder > Réglages > Avancé > « Afficher tous les suffixes de fichiers »*. Sans cela, `F2` ne montre pas ce qu'on renomme et toute la manipulation tombe à plat. C'est le premier geste de la séance, et il est rappelé sur la diapositive elle-même.

**3. Un `.odt` est une archive.** Renommer en `.zip`, ouvrir avec le gestionnaire d'archives : six fichiers, dont `mimetype`, `content.xml` (le texte) et `styles.xml` (la mise en forme). Ouvrir `content.xml` dans l'éditeur : le poème est en clair. C'est aussi la réponse à « pourquoi un `.odt` se versionne mal ».

**4. Modifier le document sans traitement de texte.** Éditer les fichiers extraits, recompresser, renommer en `.odt` :

- le texte : dans `content.xml`, remplacer `>The Raven<` par `>Le Corbeau<` ;
- **un style, sans code hexadécimal** : dans `content.xml`, remplacer `Text_20_body` par `Heading_20_1` sur un paragraphe, qui devient un titre. Une diapositive montre la ligne avant et après, la partie changée en couleur ;
- la taille : dans `styles.xml`, sur `Heading_20_1`, passer `fo:font-size` de `115%` à `220%`.

> **Sur la couleur, question attendue** : ODF n'accepte **pas** de nom de couleur. Vérifié — `fo:color="red"` est ignoré et le titre reste noir ; il faut `fo:color="#c0392b"`. C'est donc l'occasion d'expliquer le code hexadécimal, deux chiffres par composante rouge, verte et bleue. CSS, lui, accepte les deux écritures, ce qui se vérifie à la manipulation suivante.

`content.xml` fait 4 ko sur 21 lignes, dont une de 1 300 caractères : le Bloc-notes l'ouvre, en activant le retour à la ligne, mais l'éditeur de code du module est nettement plus confortable, puisqu'il colore et replie les balises.

> ⚠️ **Le piège, à annoncer avant qu'il ne se produise** : compresser les six fichiers, **pas le dossier qui les contient**. Sinon les chemins dans l'archive deviennent `extrait/content.xml` et LibreOffice refuse d'ouvrir, avec « source file could not be loaded ». Vérifié : c'est bien un échec, pas une dégradation silencieuse.

**5. Ouvrir une page depuis son disque.** Double-clic sur `raven_brut.html` : le navigateur l'affiche sans réseau, et l'adresse est un chemin du disque. Puis `raven_style.html`, même texte mis en forme, qui appelle `style.css` : changer une couleur dans le CSS et recharger avec `F5`. Le `.html` est identique dans les deux cas ; seule la ligne `<link rel="stylesheet" href="style.css">` les distingue. Si `style.css` n'est pas dans le même dossier, la page s'affiche sans mise en forme — bonne occasion de reparler des chemins relatifs.

L'argument à retenir dépasse la manipulation : un format **ouvert et documenté** se manipule avec des outils quelconques, et le contenu se sépare de sa présentation aussi bien dans un `.odt` que dans une page web.

### 🎓 4′ — Comment un logiciel reconnaît un fichier

Deux étages de décision. Le **système** choisit le logiciel d'après le **nom** ; le **logiciel** ouvre le fichier et lit ses **premiers octets** : `PK` pour une archive ZIP donc un `.odt`, `%PDF` pour un PDF, lisibles en clair. Ces octets de tête s'appellent des *nombres magiques* ; `file` ne fait que les comparer à un catalogue.

Ne pas développer le binaire ici : il est ouvert en hexadécimal au cours 3. Annoncer en revanche que le même phénomène revient dans la partie programmation, où les premiers octets de `python3` se lisent « ELF ».

### 🎓 10′ — Interface graphique et ligne de commande *(partie de cours)*

- **La différence, en tableau** : au clic on désigne ce que l'on voit, au clavier on nomme ce que l'on veut ; les menus proposent ce qu'ils contiennent, la commande accepte tout ce que le programme sait faire ; pour dix fichiers, dix fois les mêmes gestes contre une ligne ; et surtout, **ce qui en reste** — rien d'un côté, la commande de l'autre. Aucune des deux n'est meilleure : elles ne rendent pas le même service.
- **Expérience utilisateur** : les perceptions et réactions qui résultent de l'usage d'un produit (norme ISO 9241-210). Critères d'après Jakob Nielsen, plus un cinquième ajouté ici, la trace laissée.
- **Le terminal** : une fenêtre où l'on tape des commandes et où le programme répond par du texte. Une commande se lit toujours pareil — le programme, ce qu'on lui demande, ce sur quoi il travaille.

| Système | Comment l'ouvrir |
|---------|------------------|
| Windows 11 | clic droit sur Démarrer ou `Win`+`X`, puis Terminal ; depuis un dossier, clic droit puis « Ouvrir dans le terminal » |
| macOS | Applications, Utilitaires, Terminal |
| Linux | `Ctrl`+`Alt`+`T` |

Sous Windows 11, **Terminal est l'application par défaut** et ouvre PowerShell ; l'Invite de commandes reste disponible dans le même onglet déroulant. Ne pas développer la différence, elle est au cours 2. Insister en revanche sur le fait que le terminal s'ouvre **dans un dossier** : c'est le dossier courant des chemins relatifs, et la source de la moitié des erreurs de début de semestre.

### ⌨️ 10′ — TD : le même geste, à la souris et au clavier

**1. Convertir des deux façons.** *Fichier > Exporter au format PDF* d'un côté, la commande de l'autre. Le fichier produit est identique ; la commande, elle, se recopie et se relance sur trois cents documents.

> ⚠️ **La commande n'a pas la même forme selon le système.** LibreOffice n'est ajouté au `PATH` par aucun installeur.
>
> | Système | Ce qu'il faut taper |
> |---------|---------------------|
> | Linux | `soffice --headless --convert-to pdf raven.odt` |
> | macOS | `/Applications/LibreOffice.app/Contents/MacOS/soffice --headless …` |
> | Windows | `& "C:\Program Files\LibreOffice\program\soffice.com" --headless …` |
>
> Trois pièges : le `PATH` ; le choix de **`soffice.com`** et non `soffice.exe`, que demande la [documentation officielle](https://help.libreoffice.org/latest/en-US/text/shared/guide/start_parameters.html) puisque seule la version console attend la fin de la conversion ; et l'opérateur d'appel `&` de PowerShell, sans lequel un chemin entre guillemets est pris pour du texte.
>
> **Seule la ligne Linux a été exécutée.** Celles de Windows et macOS viennent de la documentation et restent à vérifier sur ces systèmes avant la séance. *Repli* : `pandoc raven.odt -o raven.pdf`, qui est dans le `PATH` sur les trois systèmes une fois `conda activate info01` fait.

**2. Le navigateur aussi se pilote au clavier.** Même idée que LibreOffice, sur un logiciel que tout le monde connaît par ses fenêtres. **Les trois lignes ci-dessous ont été exécutées et vérifiées.**

| Ce que l'on veut | La commande |
|------------------|-------------|
| la page en PDF | `chromium --headless --no-pdf-header-footer --print-to-pdf=page.pdf file://…` |
| la page en image | `chromium --headless --screenshot=page.png --window-size=900,1200 file://…` |
| la page en image, Firefox | `firefox --headless --screenshot page.png --window-size 900,1200 file://…` |

Deux détails avant de lancer en séance : sans `--no-pdf-header-footer`, Chromium ajoute la date et l'adresse sur chaque page ; et Firefox refuse de démarrer si une fenêtre est déjà ouverte, il faut alors `--profile` avec un profil à part. **Firefox ne sait pas produire de PDF** de cette façon, Chromium si.

**3. Le minimum sur le binaire.** Un octet vaut de 0 à 255 et s'écrit avec deux chiffres hexadécimaux ; « texte » signifie « octets plus une table de correspondance ». `P` vaut 80 soit `50`, `K` vaut 75 soit `4B`, `é` vaut `C3 A9` en UTF-8. Rien de plus : le binaire est ouvert pour de bon au cours 3.

**4. Ce qu'un logiciel lit vraiment.** `head -c 8 … | xxd` puis `file` : `PK` pour une archive ZIP donc un `.odt`, `%PDF` pour un PDF. Ces octets de tête s'appellent des *nombres magiques*.

> **Équivalent Windows**, puisque `head` et `xxd` n'existent pas : `Format-Hex raven.odt | Select-Object -First 1` remplace les deux à la fois, en affichant l'hexadécimal et le texte côte à côte. Le paramètre `-Count`, plus direct, n'existe qu'à partir de PowerShell 6.2 et **pas** dans le PowerShell 5.1 livré avec Windows, d'où le passage par `Select-Object`. Windows ne fournit aucun équivalent de `file`. **Ces lignes viennent de la documentation Microsoft et n'ont pas pu être exécutées** faute de Windows : à vérifier avant la séance.

### ⌨️ 10′ — Une vidéo, deux chemins *(bonus, pour aller plus loin)*

Produire la même vidéo — le trajet de la gare à l'école en cinq étapes commentées — en assemblant des applications graphiques, puis en une commande. Scripts, données à préparer et alternatives « clic-bouton » : [`manip_video_trajet.md`](manip_video_trajet.md) et [`data/cours1/trajet/`](../../../data/cours1/trajet/).

`ffmpeg` et `imagemagick` sont déjà dans l'environnement `info01` : rien à installer. **Mais cela suppose l'environnement en place**, ce qui n'est pas le cas à ce stade du déroulé — voir la note de minutage ci-dessous.

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

## Minutage

**Le deck est volontairement plus large que la séance.** Le parti pris est de produire les diapositives d'abord et de filtrer ensuite : le déroulé détaillé ci-dessus totalise environ **160 minutes** pour une séance de 120, et cet écart est assumé tant que le contenu n'est pas stabilisé.

Le budget visé, celui de la diapositive « Contenu de la séance », reste :

| Partie | Contenu | Durée |
|--------|---------|-------|
| Logiciels et interfaces | logiciel, vocabulaire, système d'exploitation, application web, modes et UX, démo vidéo | 30′ |
| Programmation | code source et exécutable, interprété et compilé | 10′ |
| Fichiers et formats | extension, échange d'extensions, grille, un texte quatre formes | 40′ |
| Outils de travail | IDE, environnement conda, notebooks, dépôt de notes | 40′ |

Trois leviers connus pour y arriver, à activer au moment de figer la séance :

1. « Une vidéo, deux chemins » en **démonstration** (3′) plutôt qu'en manipulation (10′), et rejouée en autonomie après l'installation de l'environnement.
2. L'étape 3 de « un texte, quatre formes » (ODT-ZIP) en exercice complémentaire, comme déjà prévu : −6′.
3. Le bloc IDE réduit à ce qui sert au cours 2 : −4′.

**Contrainte d'ordre** : la manipulation vidéo a besoin de l'environnement conda, installé plus tard dans la séance. D'où la démonstration au moment des interfaces, la manipulation complète venant après l'installation ou en exercice complémentaire.

## Manipulations et diapositives de séparation

Le deck distingue trois régimes par la couleur de fond de ses diapositives d'ouverture, et par rien d'autre : blanc pour l'exposé, bleu pour les diapositives de section (`separateur`), brun pour les manipulations et les travaux dirigés (`separateur-manip`, `separateur-td`). C'est la distinction 🎓 / ⌨️ de ce document, rendue visible de loin. Trois blocs de manipulation dans la séance :

| Ouverture | Contenu |
|-----------|---------|
| *Fichiers, formats et extensions* | exporter, renommer, ouvrir le `.odt` comme une archive et le modifier |
| *Le même geste, à la souris et au clavier* | convertir un document des deux façons, puis lire les nombres magiques |
| *Une vidéo, deux chemins* — **bonus** | le trajet de la gare à l'école, pour ceux qui vont vite |
| *Un texte, quatre formes* | le poème en `.txt`, `.odt`, `.html` brut, `.html` + CSS |

Un troisième bloc, *Échanger deux extensions* (convertir un `.odt` en PDF, échanger les extensions des copies, essayer d'ouvrir), est **passé en annexe** en fin de deck : il demande la ligne de commande, trop tôt à ce stade de la séance. Les résultats observés y sont conservés, et la diapositive « Comment un logiciel reconnaît un fichier » en donne la conclusion sans la manipulation.

## Points d'attention

- **Ne pas glisser vers la programmation.** La séance parle de *fichiers et d'outils*. Le seul code montré sert d'illustration (3 lignes) — l'algorithmique est le cours parallèle.
- **Profils hétérogènes** (prépa littéraire / scientifique) : la manipulation « quatre formes » ne demande aucun prérequis et occupe utilement les plus rapides via les étapes ODT-ZIP et CSS.
- **Le binaire n'est plus ici** : si la question vient (« et le `.png` alors ? »), répondre en une phrase (« compressé, on l'ouvrira en hexadécimal au cours 3 ») et ne pas dévier.
- **Mention utile** : ce qu'on met dans un dépôt public y reste — d'où le choix de textes du domaine public et de données *générées* plutôt que versionnées. Amorce discrète de la leçon secrets (cours 5B).
