# Contenu détaillé — Cours 1 : Logiciel, programmation & formats de fichier

Vue d'ensemble : [../../01_syllabus_v1.md](../../01_syllabus_v1.md) (section « Cours 1 »).
Inversion C1↔C3 : [../../inversion_c1_c3.md](../../inversion_c1_c3.md).

**Supports** : [`src/cours1/notebook/`](../../../src/cours1/notebook/) (MyST, 3 pages) et [`src/cours1/diapo/`](../../../src/cours1/diapo/) (typst, 89 diapositives en assertion-evidence, 92 avec les captures d'écran ; `--input notes=true` pour la version annotée, `--input corrige=true` pour le corrigé des manipulations, `--input captures=true` si les captures d'écran sont en place).
Conventions d'écriture : [`STYLE.md`](../../../STYLE.md).
**Données** : [`data/cours1/`](../../../data/cours1/) — générées par `make_data.py`.

Objectif : comprendre ce qu'est un logiciel, pourquoi programmer revient à écrire du texte, et savoir manipuler fichiers et environnement de travail en confiance.

---

## Fil conducteur

La séance est construite comme une chaîne de questions, chacune amenant la suivante :

> *Qu'est-ce qu'un logiciel ?* → entrée/traitement/sortie, et c'est un fichier.
> *Que manipule-t-il ?* → des **fichiers**, que l'extension nomme sans les décrire.
> *D'où vient le logiciel lui-même ?* → de **texte** écrit par un humain, dans un **éditeur** qui en connaît les règles.
> *Qu'y a-t-il vraiment dans un fichier ?* → des **octets**, que le format organise et que l'extension ne décrit pas.
> *De quoi un programme a-t-il besoin pour tourner ?* → de **bibliothèques**, donc d'un **environnement** qu'on installe au clavier.
> *Et l'outil qui réunit tout cela ?* → le **notebook**.

Aucune notion n'est introduite sans que la précédente l'ait rendue nécessaire.

Les diapositives suivent ce découpage en cinq parties, séparées par des
diapositives de séparation : *logiciels et formats de fichier*, *programmation
et éditeur de code*, *formats de fichier*, *environnement de programmation*,
*notebooks*. La diapositive « Contenu de la séance » les annonce, avant la
première séparation.

L'ordre a changé deux fois. En septembre 2026, la partie programmation et
éditeur est passée **avant** la ligne de commande, pour que les étudiants aient
écrit et lancé un programme avant qu'on leur explique comment on pilote un
logiciel au clavier. Puis la partie *formats de fichier* est remontée **avant**
la partie environnement : elle prolonge directement l'éditeur de code, puisque
lire les octets d'un fichier s'y fait avec un script Python lancé depuis
l'éditeur, et elle n'a besoin de rien d'autre.

La partie environnement, elle, a été recentrée sur ce qu'elle est vraiment,
l'installation et l'isolement des dépendances. Elle ne s'ouvre plus sur une
comparaison entre interfaces, mais sur le problème qui rend l'outil nécessaire :
un programme emprunte du code à d'autres, ces emprunts se contredisent d'un
projet à l'autre, et l'outil qui les démêle n'a pas de fenêtre. La ligne de
commande y est réduite à ce qu'il faut pour lire les trois commandes `conda` du
semestre ; elle est traitée pour elle-même au cours 2, et les diapositives qui
la détaillaient sont conservées en annexe du deck.

---

## Déroulé détaillé

---

## Partie 1 — Logiciels et formats de fichier

> **Le rythme est annoncé avant d'entrer dans la partie.** Une diapositive suit celle des notions déjà vues au lycée : la partie 1 les reprend, elle avance donc plus vite que les suivantes, et c'est la seule où le rythme est délibérément élevé. Le temps gagné va aux manipulations.
>
> Elle porte un **point d'attention** encadré (`bloc-titre`) : si quelque chose n'est pas clair ici, la question se pose tout de suite. Formulation qui fonctionne mieux qu'une invitation générale — dire qu'ici, ne pas comprendre est probable et normal *parce qu'on va vite exprès*, si bien que la question n'est pas un aveu mais ce que le rythme suppose. Le passage à surveiller est le vocabulaire (logiciel, application, format, extension, chemin) : des mots qu'ils croient connaître, et où les malentendus s'installent sans bruit.

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
- **un style, sans code hexadécimal** : dans `content.xml`, remplacer `Text_20_body` par `Heading_20_1` sur un paragraphe, qui devient un titre. Une diapositive montre la ligne avant et après, la partie changée en couleur. Le `_20_` intrigue toujours : ce n'est pas un nom en trois morceaux, c'est « Text body » dont l'espace est encodé, un nom XML n'en acceptant pas. ODF écrit chaque caractère interdit sous la forme de son code hexadécimal entre tirets bas, et l'espace vaut 20 — le même principe que le `%20` des adresses web. Le nom lisible est dans l'attribut `style:display-name`, et l'explication est donnée aux étudiants dans le notebook, avec un lien vers la spécification ;
- la taille : dans `styles.xml`, sur `Heading_20_1`, passer `fo:font-size` de `115%` à `220%`.

> **Sur la couleur, question attendue** : ODF n'accepte **pas** de nom de couleur. Vérifié — `fo:color="red"` est ignoré et le titre reste noir ; il faut `fo:color="#c0392b"`. C'est donc l'occasion d'expliquer le code hexadécimal, deux chiffres par composante rouge, verte et bleue. CSS, lui, accepte les deux écritures, ce qui se vérifie à la manipulation suivante.

`content.xml` fait 4 ko sur 21 lignes, dont une de 1 300 caractères : le Bloc-notes l'ouvre, en activant le retour à la ligne, mais l'éditeur de code du module est nettement plus confortable, puisqu'il colore et replie les balises.

> ⚠️ **Le piège, à annoncer avant qu'il ne se produise** : compresser les six fichiers, **pas le dossier qui les contient**. Sinon les chemins dans l'archive deviennent `extrait/content.xml` et LibreOffice refuse d'ouvrir, avec « source file could not be loaded ». Vérifié : c'est bien un échec, pas une dégradation silencieuse.

**5. Ouvrir une page depuis son disque.** Double-clic sur `raven_brut.html` : le navigateur l'affiche sans réseau, et l'adresse est un chemin du disque. Puis `raven_style.html`, même texte mis en forme, qui appelle `style.css` : changer une couleur dans le CSS et recharger avec `F5`. Le `.html` est identique dans les deux cas ; seule la ligne `<link rel="stylesheet" href="style.css">` les distingue. Si `style.css` n'est pas dans le même dossier, la page s'affiche sans mise en forme — bonne occasion de reparler des chemins relatifs.

L'argument à retenir dépasse la manipulation : un format **ouvert et documenté** se manipule avec des outils quelconques, et le contenu se sépare de sa présentation aussi bien dans un `.odt` que dans une page web.

---

## Partie 2 — Programmation et éditeur de code

### 🎓 10′ — Du code source à l'exécution *(ouverture de la partie)*

La partie s'ouvre sur le **vocabulaire**, diapositive « Programmes et applications » : un programme est un texte d'instructions, programmer c'est écrire ce texte, une application est un programme empaqueté pour celui qui s'en sert. Dire que la frontière entre les deux derniers tient à l'empaquetage et à l'usage, non à la technique, plutôt que de la laisser deviner — c'est la question qui revient chaque année. Le schéma entrée → traitement → sortie du début de séance se reprend ici **à l'oral**, pour poser ce qui suit : la boîte du milieu est un fichier, d'où vient-elle ?

**Code source et fichier exécutable** répond en montrant les deux côte à côte, trois lignes de Python d'un côté, les premiers octets de l'exécutable `python3` de l'autre.

**Interprété et compilé, en schéma plutôt qu'en tableau** : la chaîne compilée a une étape de plus (`raven.c` → compilateur → `raven.exe` → résultat) mais ne la fait **qu'une fois** ; la chaîne interprétée en a une de moins (`raven.py` → interpréteur → résultat) mais la refait **à chaque lancement**. Lancer un programme Python ne crée rien sur le disque, et c'est aussi pourquoi il est plus lent.

**La place de l'interpréteur** reprend enfin le schéma en couches de la partie 1, avec un étage de plus : un programme interprété s'adresse à l'interpréteur, qui s'adresse au système ; un programme compilé n'a pas cet étage. Le point à faire est que `python` est lui-même un exécutable compilé, celui dont les octets viennent d'être montrés. Un navigateur tient le même rôle pour HTML, CSS et JavaScript, et personne ne l'appelle interpréteur : le mot désigne un rôle. Conséquence pratique, qui justifie la partie 4 — il faut que Python soit installé pour lancer un programme Python.

Viennent ensuite, dans la même partie, la feuille de route des trois compétences, l'environnement conda et les notebooks : c'est l'outillage annoncé par le titre.

### 🎓 10′ — Qu'est-ce que programmer

- Un langage = un vocabulaire, une grammaire, un sens. Écrire un programme = écrire un texte respectant cette convention.
- Démonstration : 3 lignes de Python affichées, exécutées en direct dans le notebook. Insister — *c'est du texte qu'on pourrait taper dans le Bloc-notes*.
- La comparaison compilé / interprété est déjà faite juste avant : y renvoyer plutôt que la refaire.
- **Graine explicite** : « exécution plus lente » → cours 6 (boucle vs numpy) et TD7 (×100–1000).

### 🎓 8′ — IDE (VSCode)

Une capture d'écran de VSCode ouvert sur un petit projet sert de support : les trois zones y sont visibles d'un coup, et le fichier produit par la commande apparaît dans l'arborescence pendant qu'on parle.

- **Dossier = projet** (on n'ouvre pas un fichier isolé) — habitude structurante pour git au cours 2.
- Explorateur, palette de commandes (`Ctrl+Maj+P`), terminal intégré, aperçu Markdown (`Ctrl+Maj+V`), extensions (Python, Jupyter, MyST).
- Numéros de ligne, tabulation vs espaces, encodage affiché dans la barre d'état.

**Le sigle, une fois.** IDE, pour *integrated development environment*, se traduit par **environnement de développement intégré** ; « EDI » existe et ne s'emploie pas. La diapositive « Les fonctions d'un IDE » énumère ce que l'intégration recouvre — écrire le code, le lancer et le tester, naviguer dans le projet, déboguer — et l'argument est que seule la première ligne est le fait d'un éditeur de texte ordinaire. Les deuxième et troisième servent dès aujourd'hui, le débogage vient au cours 2. Ne pas s'attarder sur le fait que Microsoft présente VSCode comme un éditeur plutôt que comme un IDE : la frontière est commerciale autant que technique.

### 🎓 4′ — Lancer un programme depuis l'éditeur

La partie a dit qu'un IDE sert à lancer et à tester, sans jamais montrer par où. Trois menus suffisent, et ils sont projetés avant la manipulation plutôt que découverts pendant.

| | Le bouton d'exécution | Le terminal intégré |
|---|---|---|
| Où le trouver | en haut à droite de l'éditeur | Terminal → Nouveau terminal |
| Sur un `.py` | « Run Python File » | `python bonjour.py` |
| Sur un `.cpp` | « Run C/C++ File », qui demande le compilateur la première fois | `g++ …`, puis l'exécutable produit |
| Ce qu'il choisit à votre place | l'interpréteur, réglé par `Ctrl`+`Maj`+`P` → « Python: Select Interpreter » | rien : la commande dit tout |

Le module fait écrire la commande à la main, et il faut **dire pourquoi** plutôt que de l'imposer : elle est identique sur les trois systèmes, elle se relit, et c'est elle qu'on enchaînera au cours 2 puis qu'on mettra dans un script au cours 3. Le bouton, lui, change d'un langage à l'autre et masque ce qu'il fait — mais il écrit sa commande dans le terminal avant de l'exécuter, ce qui est l'argument à montrer.

> La dernière ligne est celle qui coûte cher si on la saute. Le bouton exécute avec **l'interpréteur sélectionné**, qui n'est pas forcément celui du module : c'est l'origine du `ModuleNotFoundError` « sur un paquet qu'on vient d'installer » annoncé en partie 4. La sélection vaut aussi pour le terminal, que l'extension Python active ensuite toute seule.

> Sur le bouton C++ : il existe, s'appelle « Run C/C++ File », demande de choisir un compilateur au premier lancement puis écrit un `tasks.json` dans le projet. Ne pas l'employer en séance — cela ajoute un fichier de configuration à expliquer — mais savoir répondre à celui qui l'aura trouvé.

### ⌨️ 10′ — Un hello world en Python et en C++ *(manipulation)*

La manipulation tient sur deux diapositives : les gestes, puis ce qu'ils ont produit. **Les gestes sont écrits un par un et projetés tels quels** — l'objectif seul ne suffit pas à cette séance, une étape sous-entendue est une étape où la moitié de la salle s'arrête sans le dire.

1. **Fichier → Ouvrir le dossier**, puis choisir `data/cours1/hello/` — le dossier, pas un fichier.
2. **`Ctrl`+`Maj`+`P`**, taper « Python: Select Interpreter », choisir `info01`. Rien ne se passe visiblement, et c'est normal : le réglage sert au terminal qu'on ouvre juste après. Sans lui, `python` peut être un autre que celui du module.
3. **Terminal → Nouveau terminal** : il s'ouvre en bas, déjà dans `hello/`, ce qu'il faut faire remarquer après les erreurs de chemin du début de séance.
4. Taper `python python/bonjour.py`, puis Entrée.
5. Taper `g++ cpp/bonjour.cpp -o cpp/bonjour`, puis Entrée. **Rien ne s'affiche**, et c'est l'étape où la question vient : faire regarder l'arborescence plutôt que le terminal, `cpp/bonjour` vient d'y apparaître.
6. Taper `cpp/bonjour`, puis Entrée.

Le bouton d'exécution fait la même chose que l'étape 4, et il existe aussi pour le C++ : c'est la diapositive précédente. Le montrer après, jamais avant — la commande écrite à la main est celle qui reste.

| | `python/bonjour.py` | `cpp/bonjour.cpp` |
|---|---|---|
| Ce qu'on tape | `python python/bonjour.py` | `g++ cpp/bonjour.cpp -o cpp/bonjour`, puis `cpp/bonjour` |
| Étapes | une | deux : compiler, puis exécuter |
| Sur le disque | rien | `cpp/bonjour`, un exécutable |
| Taille de la source | 121 octets | 230 octets |
| Taille produite | aucun fichier | environ 20 000 octets, près de cent fois la source |

La taille de l'exécutable dépend du compilateur et du système — 19 560 octets avec g++ 13.3, 23 624 relevés ailleurs — mais l'ordre de grandeur ne bouge pas, et c'est lui qu'on fait dire.

C'est la diapositive « Deux chemins du texte à l'exécution » faite à la main : y renvoyer explicitement. Faire ensuite ouvrir `cpp/bonjour` dans l'éditeur pour constater qu'il est illisible — la diapositive « Code source et fichier exécutable », vérifiée par eux.

Sous Windows, `g++` n'est pas fourni : MinGW-w64, MSYS2 ou le sous-système Windows pour Linux. Prévoir un poste de démonstration si personne ne l'a. Détails dans [`data/cours1/hello/README.md`](../../../data/cours1/hello/README.md).

---

## Partie 3 — Édition de texte et contenu des fichiers

La partie s'ouvre là où commence le fil du texte, et son titre ne reprend plus celui de la partie 1. Elle enchaîne quatre choses : programmer c'est éditer du texte, ce que l'éditeur apporte à cette édition, les formats de texte d'un projet — Markdown en tête —, puis ce que contient vraiment un fichier, jusqu'à ses premiers octets.

La manipulation « hello world » reste à la partie 2 : elle clôt l'exposé sur l'exécution, dont elle est la vérification. Celle des programmes fautifs vient ici, après les extensions et la vérification de l'écriture, dont elle dépend.

### 🎓 4′ — Programmation et édition de texte *(ouverture de la partie)*

Tout ce qui sera produit cette année passe par l'édition d'un fichier texte : le programme, ses réglages, sa documentation, jusqu'à ce que git doit ignorer. Ce n'est donc pas un détail d'outillage, c'est le geste de base — et c'est ce que la partie outille.

La preuve visuelle est un face-à-face de ce que coûte l'édition sans outil adapté : une faute qui se découvre à l'exécution plutôt que soulignée à la frappe, un fichier cherché dans l'explorateur plutôt que dans l'arborescence, un programme relancé dans une autre fenêtre, une indentation fausse qui ne se voit pas. La colonne de droite annonce le plan de la partie.

> La colonne de gauche n'est pas une caricature : c'est ce que fait quelqu'un qui écrit son code dans le Bloc-notes, et plusieurs l'auront fait au lycée. Ne pas s'en moquer, montrer ce que cela coûte.

### 🎓 5′ — Texte brut et document mis en forme

**Texte brut et document mis en forme.** Un programme s'écrit dans un éditeur de texte brut, jamais dans Word ni LibreOffice : pas de gras, pas de taille de police, pas de style, non parce que ce serait laid mais parce qu'un `.py` n'a aucun endroit où les enregistrer. La preuve est le `content.xml` ouvert en début de séance, la même ligne de code noyée dans les balises de style. Le piège concret à annoncer maintenant : un traitement de texte remplace tout seul les guillemets droits par des guillemets typographiques, et le programme recopié depuis un document Word refuse alors de s'exécuter sur un message qui ne parle pas de guillemets.

### 🎓 5′ — Ce que l'éditeur ajoute au texte

Deux fois la même ligne, en chasse fixe puis en chasse proportionnelle : à gauche les `=` s'alignent, à droite non. C'est la preuve visuelle, et elle suffit à faire passer le reste — couleurs, numéros de ligne et police sont des affichages, seule l'indentation est dans le fichier.

Point de culture à donner ici : un éditeur de code emploie toujours une police à chasse fixe, un traitement de texte une police proportionnelle. Le rapprocher de LibreOffice, manipulé en début de séance, où l'on choisit une police pour la mise en page alors qu'ici on la subit pour une raison technique.

### 🎓 4′ — Les règles d'écriture d'un langage

À placer **avant** la coloration et la vérification, qu'elle justifie l'une et l'autre. Un langage de programmation a une grammaire appliquée à la lettre, et surtout **beaucoup moins d'exceptions que l'orthographe** — c'est ce qui rend la vérification automatique possible.

| | L'orthographe du français | La grammaire d'un langage |
|---|---|---|
| Les règles | nombreuses, et souvent affaire d'usage | peu nombreuses, et écrites noir sur blanc |
| Les exceptions | à apprendre une par une | presque aucune |
| Qui tranche | l'usage, parfois personne | l'interpréteur, sans appel |
| Une faute | le lecteur comprend quand même | le programme s'arrête |

La comparaison sert à désamorcer une inquiétude, et il faut la formuler dans ce sens : un langage s'apprend plus vite qu'une langue, parce qu'il a peu de règles et presque pas d'exceptions. Ce qui est difficile n'est pas la syntaxe mais de savoir quoi écrire, et cela relève du cours de programmation. La contrepartie est la dernière ligne : la machine n'interprète pas les intentions.

> On ne peut pas écrire un logiciel qui corrige un texte français de façon sûre ; on peut en écrire un qui vérifie un programme. C'est exactement ce que fait l'extension installée à la manipulation qui suit.

### 🎓 6′ — Coloration et extensions

Trois diapositives qui expliquent ce que l'éditeur apporte au-delà de l'affichage, et qui préparent la manipulation.

- **Coloration syntaxique** : chaque langage a ses règles d'écriture, l'éditeur les connaît et donne une couleur à chaque catégorie de mot. La preuve est le même extrait Python affiché deux fois, sans couleur puis avec. Faire nommer par la salle ce que la couleur distingue — mots du langage, nombres, texte entre guillemets, noms choisis par celui qui écrit — avant de le dire. L'intérêt n'est pas le confort : un mot-clé mal orthographié perd sa couleur, et cela se voit sans rien exécuter.
- **Les extensions de l'éditeur** : la coloration des langages courants est fournie d'origine ; l'extension y ajoute la vérification, la complétion et le lancement. Les trois du module, avec leur identifiant, qui est ce qu'il faut chercher dans le panneau puisque les noms affichés se ressemblent tous :

| Langage | Extension | Ce qu'elle ajoute |
|---|---|---|
| Python | `ms-python.python` | vérification, complétion, lancement du fichier |
| C++ | `ms-vscode.cpptools` | vérification, complétion, compilation et débogage |
| Notebooks | `ms-toolsai.jupyter` | exécution des cellules dans l'éditeur |

> Identifiants relevés sur le poste de préparation, où les trois extensions sont installées. L'extension Python installe elle-même Pylance, qui fait la vérification : ne le dire que si quelqu'un remarque qu'une deuxième extension est apparue.

- **Vérification de l'écriture** : l'extension relit le fichier pendant qu'on l'écrit, le compilateur ne répond qu'au lancement. La comparaison qui fait comprendre est le correcteur orthographique, qui souligne le mot sans attendre l'impression. La preuve est `cpp/aire.cpp`, où le point-virgule manque à la ligne 6 et où **g++ signale la ligne 7** : un compilateur désigne l'endroit où il ne peut plus continuer, pas l'endroit de la faute. Lire le message, puis remonter d'une ligne, est le réflexe à donner.

### ⌨️ 5′ — Espaces, tabulations et fins de ligne

Erreur qui coûtera des heures au semestre si elle n'est pas nommée maintenant. Un fichier dont une ligne est indentée par quatre espaces et la suivante par une tabulation produit `TabError: inconsistent use of tabs and spaces in indentation`, et rien ne se voit à l'œil.

- Faire **activer l'affichage des espaces** sur les postes : Affichage → Rendu des espaces → Tout. Un point par espace, une flèche par tabulation.
- Faire lire la **barre d'état** : `Spaces: 4` dit ce qu'insère la touche de tabulation, `LF` ou `CRLF` dit comment les lignes se terminent.
- Sur les fins de ligne : Windows en met deux caractères, Linux et macOS un seul. Un même fichier n'a donc pas la même taille selon la machine qui l'a écrit, et un diff peut signaler toutes les lignes comme modifiées alors qu'aucune ne l'est. Le point est repris au cours 2 avec git ; aujourd'hui, savoir où l'éditeur l'affiche suffit.

### ⌨️ 10′ — Extensions de langage et programmes fautifs *(manipulation)*

Ouvrir `data/cours1/erreurs/` dans l'éditeur. Trois fichiers courts, chacun fautif d'un genre différent. Détails et messages complets dans [`data/cours1/erreurs/README.md`](../../../data/cours1/erreurs/README.md).

**1. Installer l'extension.** Ouvrir `python/surface.py` **avant** toute installation : le texte est déjà coloré, ce qui surprend et doit surprendre — la coloration ne vient pas de l'extension. Installer ensuite `ms-python.python` par `Ctrl`+`Maj`+`X`, rouvrir le fichier : une ligne se souligne, sans que rien ait été exécuté. C'est cela que l'extension apporte.

> L'éditeur n'a pas pu être piloté sur le poste de préparation. Le soulignement et la proposition automatique de l'extension C/C++ à l'ouverture d'un `.cpp` viennent de la documentation de VSCode et restent **à vérifier sur les postes de la salle**. Prévoir aussi le poste sans réseau : les extensions ne s'installent pas, et la suite se fait quand même.

**2. Corriger les trois programmes.** Lancer, lire le message, corriger, relancer. L'ordre est celui de la difficulté de lecture, et il faut le suivre.

| Fichier | Message | La faute |
|---|---|---|
| `python/surface.py` | `TabError: inconsistent use of tabs and spaces`, ligne 6 | ligne 6 indentée par une tabulation, ligne 5 par des espaces |
| `python/moyenne.py` | `SyntaxError: expected ':'`, ligne 6 | deux-points manquants après le `for` |
| `cpp/aire.cpp` | `error: expected ',' or ';' before 'std'`, ligne 7 | point-virgule manquant en fin de ligne 6 |

Messages réels, obtenus avec Python 3.12 et g++ 11.4. La colonne « la faute » est masquée à la projection et remplie par `--input corrige=true`.

La première ne se voit pas à l'œil : c'est là qu'on fait activer **l'affichage des espaces**, Affichage → Rendu des espaces → Tout, réglage à garder toute l'année. La troisième est la diapositive « Vérification de l'écriture », vérifiée par eux.

La vérification demandée n'est pas que le programme affiche le bon résultat, mais qu'il n'affiche plus de message : c'est la définition de « ça marche » à ce stade. Une fois corrigés, les trois affichent `294.0`, `130.05` et `294`.

Sous Windows sans compilateur, le fichier C++ se lit et se corrige mais ne se compile pas ; le soulignement de l'éditeur reste alors la seule vérification.

### 🎓 — Reprise du cours : Markdown et les autres fichiers texte

La manipulation précédente est au milieu de la partie, pas à sa fin. Une **diapositive de reprise** (`separateur-reprise`, fond bleu, mention « Reprise du cours ») marque le retour à l'exposé : sans elle, rien ne dit où le travail sur machine s'arrête, puisque les diapositives de manipulation ont le même fond blanc que le cours. Le bleu ouvre un bloc de cours, le brun un bloc sur machine.

### 🎓 10′ — Les fichiers texte d'un projet, et Markdown

Quatre diapositives qui existent parce que la séance **demande du Markdown sans l'avoir montré** : les notes du jour, le `README`, et le premier commit du cours 2 sont tous en `.md`.

- **La famille.** Le code n'est pas le seul texte d'un projet : `.py` porte les instructions, `.json` et `.yaml` les réglages, `.csv` les données, `.md` la documentation. Tous s'ouvrent dans le même éditeur, se comparent ligne à ligne et se versionnent. L'accroche géomatique est immédiate — un GeoJSON est un `.json` ordinaire, et c'est le fichier de l'annexe « Une vidéo, deux chemins ».
- **L'intention de Markdown.** John Gruber, 15 mars 2004, avec Aaron Swartz pour unique bêta-testeur ; les titres en `#` viennent d'`atx`, le format de Swartz. Le but déclaré : un texte « publiable tel quel, sans avoir l'air balisé », inspiré du courriel en texte brut. La preuve est un face-à-face `.md` / HTML au même rendu, dont seul le premier se lit sans conversion. CommonMark (2014) n'est à mentionner que si quelqu'un signale un rendu qui diffère d'un outil à l'autre.
- **Trois façons d'écrire un document**, et quand employer chacune :

| | `.txt` | `.md` | `.odt` / `.docx` |
|---|---|---|---|
| Titres, listes, emphase | aucun | dans le texte | dans des balises |
| Lisible sans logiciel | oui | oui | non |
| Se compare ligne à ligne | oui | oui | non |
| Mise en page fine | non | non | oui |
| Quand l'employer | note jetable, sortie de programme | `README`, notes, doc d'un projet | rapport à rendre, charte imposée |

> Le piège à désamorcer sur-le-champ : « mon rapport doit être en PDF » n'est pas un argument contre Markdown, puisque `pandoc notes.md -o notes.pdf` le produit — c'est d'ailleurs le premier outil du cours 2. Ce qu'on perd est le contrôle fin de la mise en page, ce qu'on gagne est de pouvoir relire, comparer et versionner.

- **Ce que l'éditeur en fait**, relevé dans les extensions livrées avec VSCode plutôt que supposé :

| Format | Fourni d'origine | Ce qu'une extension ajoute |
|---|---|---|
| `.md` | coloration, aperçu `Ctrl`+`Maj`+`V`, plan du document, liens vérifiés | du confort, rien d'essentiel |
| `.json` | coloration, pliage, formatage, vérification par schéma | rien, le plus souvent |
| `.yaml` | la coloration, et rien de plus | la vérification par schéma (`redhat.vscode-yaml`) |

> `markdown-language-features` et `json-language-features` sont livrés avec l'éditeur, `yaml-language-features` n'existe pas. C'est le contraste avec les extensions Python et C++ qui fait le propos : trois formats, trois réponses à « faut-il installer quelque chose ? ». Montrer l'aperçu Markdown en direct sur le fichier de notes du jour.

La grille des seize extensions de la partie 1 a été révisée en conséquence : `.md`, `.json` et `.yaml` y entrent, `.flac`, `.mkv` et `.7z` en sortent (des doublons de `.mp3`, `.mp4` et `.zip`), et la dernière ligne regroupe les quatre fichiers qu'ils éditeront eux-mêmes. Six des seize formats sont maintenant du texte, contre trois.

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

### ⌨️ 8′ — Les premiers octets d'un fichier *(mini-projet Python)*

La conclusion de la manipulation précédente : après avoir constaté que l'extension ne décrit pas le contenu, on regarde ce qui le décrit. Ouvrir `data/cours1/formats/` dans l'éditeur et lancer `python octets.py` au terminal — exactement le geste de la manipulation « hello world », refait sur un programme qui sert à quelque chose. Le script fait quarante lignes et se lit avant d'être lancé : trois fonctions, dont une qui compare le début du fichier à un dictionnaire de signatures.

| Fichier lu | Premiers octets | Ce qu'ils signent |
|---|---|---|
| `raven_une_ligne.txt` | `4F 6E 63 65` — `Once` | aucune signature : un fichier texte n'en porte pas |
| `raven_une_ligne.donnees` | `4F 6E 63 65` — `Once` | les mêmes octets que la ligne précédente |
| `raven.odt` | `50 4B 03 04` — `PK` | une archive ZIP, donc un `.odt` |
| `raven.pdf` | `25 50 44 46` — `%PDF` | un document PDF |

Sortie réelle. La colonne de droite est masquée à la projection. `raven.pdf` est celui qu'ils ont produit eux-mêmes en première partie ; s'il manque, le script écrit `introuvable` et continue.

Deux étages de décision, et c'est tout le propos : le **système** choisit le logiciel d'après le **nom**, le **logiciel** lit les **premiers octets**. Ces octets de tête s'appellent des *nombres magiques*. Que les fichiers texte n'en aient aucun est une information, pas un manque : rien dans un fichier texte ne dit de quoi il est fait.

**Deux extensions échangées**, en deux lignes et sans quitter le mini-projet :

```bash
cp ../genere/raven.odt ../genere/raven_odt.pdf
cp ../genere/raven.pdf ../genere/raven_pdf.odt
python octets.py ../genere/raven_odt.pdf ../genere/raven_pdf.odt
```

Le nom a changé, les octets non. Faire essayer le **double-clic** sur `raven_odt.pdf` avant de lancer le script : le lecteur PDF s'ouvre et refuse le fichier, et les deux étages se contredisent devant eux. Sous Windows, `copy` remplace `cp`.

> Ce bloc remplace les anciennes diapositives PowerShell et `head`/`xxd`/`file`, qui dépendaient du système et dont l'une n'avait jamais pu être exécutée. Elles sont conservées en annexe du deck. Détails dans [`data/cours1/formats/README.md`](../../../data/cours1/formats/README.md).

Ne pas développer le binaire ici : il est ouvert en hexadécimal au cours 3. Annoncer en revanche que le même phénomène est déjà passé en partie 2, où les premiers octets de `python3` se lisent « ELF ».

---

## Partie 4 — Environnement de programmation

La partie ne s'ouvre plus sur les interfaces mais sur le problème qui rend l'outil nécessaire. L'ordre est : ce qu'un programme emprunte, pourquoi il faut isoler ces emprunts, l'outil qui le fait, comment lire ses commandes, où les taper, puis l'installation elle-même.

### 🎓 6′ — Bibliothèques et dépendances

Trois diapositives, dans cet ordre. Elles répondent à la question que les étudiants ne posent pas : pourquoi s'embêter avec un environnement.

- **Ce qu'un programme emprunte** : les lignes `import` désignent du code écrit par d'autres. Nommer le mot *bibliothèque*, écarter « librairie », faux ami de *library*. L'image qui passe bien : une recette qui commence par « prenez une pâte brisée » — vous ne la fabriquez pas, mais il faut qu'elle soit dans le placard, et que ce soit la bonne.
- **Une bibliothèque en entraîne d'autres** : `environment.yml` nomme 15 paquets, l'environnement en contient 352. Personne ne tient cette liste à la main, d'où l'outil. Conséquence à énoncer : une installation est reproductible parce qu'un fichier la décrit, pas parce qu'on se souvient de ce qu'on a tapé.
- **Pourquoi isoler un environnement** : la même machine porte numpy 1.21.5 hors environnement et 2.5.2 dans `info01`. C'est la réponse au `ModuleNotFoundError` sur un paquet « qu'on vient d'installer », symptôme le plus fréquent du semestre.

### 🎓 6′ — L'outil, et le minimum de ligne de commande pour s'en servir

**C'est la charnière de la séance**, et elle explique pourquoi la ligne de commande arrive ici plutôt qu'au début : on ne l'apprend pas pour elle-même, on la rencontre parce que l'outil dont on a besoin n'existe que sous cette forme. Le dire simplement — beaucoup de programmes n'ont pas de fenêtre, parce que personne n'en a écrit une — sans en faire une question d'austérité.

Trois commandes pour tout le semestre :

| Ce que vous voulez | Ce que vous tapez |
|---|---|
| créer l'environnement du module | `conda env create -f environment.yml` |
| l'activer dans le terminal courant | `conda activate info01` |
| savoir ce qui est installé dedans | `conda list` |

Suivent **deux diapositives seulement**, le minimum pour lire ces lignes :

1. **Ligne de commande et interface graphique** — la comparaison sur cinq points, dont « ce qui en reste », qui prépare git au cours 2 et les scripts au cours 3. Aucune des deux ne remplace l'autre : on clique pour chercher, on tape pour répéter.
2. **Anatomie d'une commande** — le programme, l'option, l'argument, sur `soffice --convert-to pdf raven.odt`, avec le geste équivalent à la souris. Le lien est direct avec la première partie, où ils ont exporté `raven.odt` en PDF en cliquant : `soffice` n'est pas un autre outil, c'est le même appelé par son nom.

> **Ce qui a été retiré d'ici**, et qui reste en annexe du deck : la démonstration chiffrée `*.odt` (vingt fichiers en 2,1 s contre 1,4 s pour un seul), le tableau de décision « quand l'une, quand l'autre », les critères d'expérience utilisateur, le terminal sur les trois systèmes et la façon de l'ouvrir, et le TD de conversion LibreOffice / navigateur. **Le cours 2 traite la ligne de commande pour elle-même** : ces diapositives y sont reprises. Le dire à la salle en une phrase, pour que le survol ne passe pas pour de l'escamotage.

### 🎓 4′ — Le terminal de l'éditeur de code

Ils s'en sont déjà servis sans qu'on le nomme, à la manipulation « hello world » : c'est le moment d'y revenir. Le terminal intégré n'est pas un autre terminal, c'est le même programme affiché dans la fenêtre de l'éditeur — le dire, parce que la question vient.

| Le geste | Ce qu'il règle |
|---|---|
| Terminal → Nouveau terminal | un terminal dans le dossier ouvert |
| le sélecteur, à droite du panneau | l'interpréteur de commandes : PowerShell, bash, zsh |
| `Ctrl`+`Maj`+`P`, `Python: Select Interpreter` | l'environnement activé dans chaque nouveau terminal |
| la barre d'état, en bas | l'environnement en cours |

La troisième ligne est celle qui évite le `ModuleNotFoundError`, et la quatrième permet de le vérifier sans rien taper. Le dossier du projet est le **dossier courant** : c'est de lui que partent les chemins relatifs.

> Les libellés dépendent de la version de VSCode et de la langue de l'interface, qui est l'anglais par défaut : à vérifier sur le poste de démonstration avant la séance. Le terminal ouvert hors de l'éditeur, et la façon de l'ouvrir sur chaque système, sont en annexe du deck ; c'est le cours 2 qui s'en occupe.

### ⌨️ 25′ — Environnement Python (conda / conda-forge)

- **Le problème d'abord** : « ça marche sur ma machine ». Un environnement = un dossier isolé, décrit, recréable, supprimable sans dégât.
- **Miniforge** (<https://conda-forge.org/download/>), puis :
  ```bash
  conda create -n info01 -c conda-forge python=3.12 \
      jupyterlab mystmd numpy pillow pandoc typst ffmpeg imagemagick
  conda activate info01
  ```
- Vérification : prompt `(info01)`, `python --version`, `pandoc --version`, et surtout `import sys; print(sys.executable)`, dont le chemin doit contenir `info01`.
- **Message à marteler** : `ModuleNotFoundError` alors qu'« on vient d'installer » = presque toujours le **mauvais environnement actif**.
- L'env sert à **installer des outils**, pas à packager un projet (décision de conception du module).

> ⚠️ **Point de bascule de la séance.** Si l'installation dérape sur quelques postes, c'est tout le reste qui saute. Prévoir : consigne d'installation **avant** la rentrée, une clé USB avec l'installeur Miniforge (Windows/macOS), et un binôme d'entraide. Voir les leviers d'allègement dans [`inversion_c1_c3.md`](../../inversion_c1_c3.md).

### 🎓 4′ — Python en interactif

Taper `python` sans nom de fichier ouvre une session interactive : chaque ligne est lue, exécutée, et son résultat affiché aussitôt, sans `print`. La trace projetée est une session réelle, dans `data/cours1/formats/`, qui réimporte le script des octets de tête.

Deux façons d'exécuter du Python, et elles ne servent pas à la même chose : un script se lance en entier et se relance à l'identique, une session interactive s'essaie ligne à ligne et ne laisse rien.

- Faire remarquer les **trois chevrons** : c'est l'invite de Python, pas celle du terminal. Les confondre est l'erreur de début de semestre, et elle produit un `SyntaxError` quand on tape une commande du système dans Python.
- On y entre par `python`, on en sort par `exit()` ou `Ctrl`+`D`. Le dire tout de suite : on ne devine pas comment sortir.
- Le module réimporte ici son propre script comme une bibliothèque : c'est « Ce qu'un programme emprunte » vu de l'autre côté, le code de quelqu'un d'autre étant aussi du code écrit par eux dix minutes plus tôt.

**Amorce de la partie suivante** : un notebook est cette session interactive, avec le texte conservé autour.

---

## Partie 5 — Notebooks

### 🎓 10′ — Notebooks

- **Deux moitiés** : l'interface (navigateur ou VSCode) affiche, le **noyau** (un processus Python) calcule et *retient les variables*.
- Deux conséquences, à faire vivre plutôt qu'à énoncer :
  - « Redémarrer le noyau » efface les variables — le texte des cellules reste, son effet disparaît ;
  - l'ordre d'exécution (`[1]`, `[2]`…) n'est pas l'ordre d'affichage.
- **Démonstration en direct** (2′) : `x = 10` / `print(x*2)` → modifier la première cellule sans l'exécuter → la seconde ment. Puis *Restart & Run All*.
- **`.ipynb` vs MyST** : JSON généré (résultats et images inclus, `git diff` illisible) vs Markdown écrit (résultats recalculés, `diff` lisible). Montrer que **le support projeté est lui-même un fichier MyST**.
- **Bouclage explicite** : « même contenu, deux formats » — la leçon d'il y a une heure, appliquée à leur propre travail. Et amorce du cours 2 : *pourquoi le texte se versionne bien*.
- **Quand un notebook, quand un script** *(diapositive de clôture)*. La partie disait ce qu'est un notebook sans jamais dire quand en ouvrir un ; c'est ce que cette diapositive corrige.

| | Notebook | Script `.py` |
|---|---|---|
| Ce qu'on y cherche | explorer, expliquer, montrer | refaire, automatiser |
| Exécution | cellule par cellule, l'état reste | du début à la fin |
| Le résultat | dans le document, avec le texte qui l'explique | à l'écran ou dans un fichier |
| Se relance seul | non | oui |
| Se partage comme outil | mal : il faut le noyau, et le bon ordre | bien : une commande |

> La formule à laisser : **on explore dans un notebook, on livre un script.** Le cas d'usage se reconnaît — on ouvre un notebook parce qu'on ne sait pas encore ce qu'on cherche ; le jour où cela marche et doit tourner sans surveillance, cela devient un script, et c'est le cours 3. Ne pas opposer les deux : le notebook n'est pas un brouillon honteux, le script n'est pas la version sérieuse. La progression notebook → script → CLI est l'arc du module, et c'est ici qu'elle s'énonce.

Cette diapositive **remplace** « Ce que le notebook réunit », récapitulation que le minutage désignait déjà comme la première à sauter : la partie garde donc sa longueur, et « À retenir » assure seule la clôture de la séance.

---

## Annexes et bonus

### ⌨️ 10′ — Une vidéo, deux chemins *(bonus, pour aller plus loin)*

Trois diapositives désormais, au lieu d'une, pour que le bonus explique au lieu d'annoncer :

1. **Le trajet de la gare à l'école** — la comparaison clic / commande, et ce qui change à la deuxième exécution.
2. **Le fichier qui décrit le trajet** — `etapes.csv`, six lignes, une par étape : durée, point d'arrivée en pixels, sous-titre. Corriger une étape, c'est corriger une ligne. Le rapprocher du `.csv` de la grille des extensions et du `content.xml` de l'archive `.odt` : trois fois le même constat, le contenu utile est du texte.
3. **Ce que la commande enchaîne** — `etapes.csv` → une image par étape (ImageMagick) → `trajet.srt` → `trajet.mp4` (ffmpeg). Chaque étape produit un fichier que la suivante consomme ; ce sont les quatre blocs numérotés d'`anime.sh`, et ce sont les outils du TD 4.

Le fond de carte est **distribué avec les supports** et n'est pas à retélécharger : le serveur de tuiles d'OpenStreetMap est un service bénévole dont les conditions d'usage interdisent le téléchargement en masse.

Produire la même vidéo — le trajet de la gare à l'école en cinq étapes commentées — en assemblant des applications graphiques, puis en une commande. Scripts, données à préparer et alternatives « clic-bouton » : [`manip_video_trajet.md`](manip_video_trajet.md) et [`data/cours1/trajet/`](../../../data/cours1/trajet/).

`ffmpeg` et `imagemagick` sont déjà dans l'environnement `info01` : rien à installer. **Mais cela suppose l'environnement en place**, ce qui n'est pas le cas à ce stade du déroulé — voir la note de minutage ci-dessous.

### ⌨️ 10′ — Débouché : le dépôt de notes

- Markdown pour README et notes ; aperçu VSCode.
- Ouverture du **dépôt de notes du cours** — fil rouge git à faible enjeu, rejoué à chaque séance (git lui-même arrive au cours 2).

### 🎓 — Interface graphique et ligne de commande *(annexe, repris au cours 2)*

Ce bloc était la partie 3 de la séance jusqu'en septembre 2026. Il en reste deux diapositives dans la partie environnement, celles qui suffisent à lire une commande ; le reste est conservé ici, et c'est le **cours 2** qui le traite pour lui-même. Les mesures et les vérifications faites à l'époque sont gardées telles quelles.

#### Interface graphique et ligne de commande, en détail

Trois diapositives, dans cet ordre, et c'est la deuxième qui porte l'argument :

1. **Ligne de commande et interface graphique** — la comparaison sur cinq points, dont « ce qui en reste », qui prépare git au cours 2 et les scripts au cours 3.
2. **Désigner un fichier, ou les décrire tous** — la démonstration chiffrée. La même commande convertit un fichier en 1,4 s et vingt en 2,1 s, parce que le programme ne démarre qu'une fois ; seul le dernier mot change, `raven.odt` devenant `*.odt`. À la souris, les quatre gestes du menu deviennent quatre-vingts. Mesuré sur les fichiers du cours.
3. **Quand l'une, quand l'autre** — le tableau de décision. À résumer en une phrase : on clique pour chercher, on tape pour répéter.

La différence de fond, à énoncer sur la deuxième : à la souris on *montre* des objets déjà à l'écran, au clavier on *décrit* un ensemble, y compris des fichiers qu'on ne voit pas. C'est la distinction classique en ergonomie entre reconnaissance et rappel, chiffrée deux diapositives plus loin avec les critères de Nielsen.

- **La différence, en tableau** : au clic on désigne ce que l'on voit, au clavier on nomme ce que l'on veut ; les menus proposent ce qu'ils contiennent, la commande accepte tout ce que le programme sait faire ; pour dix fichiers, dix fois les mêmes gestes contre une ligne ; et surtout, **ce qui en reste** — rien d'un côté, la commande de l'autre. Aucune des deux n'est meilleure : elles ne rendent pas le même service.
- **Expérience utilisateur** : les perceptions et réactions qui résultent de l'usage d'un produit (norme ISO 9241-210). Critères d'après Jakob Nielsen, plus un cinquième ajouté ici, la trace laissée.
- **Le terminal** : une fenêtre où l'on tape des commandes et où le programme répond par du texte. Une commande se lit toujours pareil — le programme, ce qu'on lui demande, ce sur quoi il travaille.

| Système | Comment l'ouvrir |
|---------|------------------|
| Windows 11 | clic droit sur Démarrer ou `Win`+`X`, puis Terminal ; depuis un dossier, clic droit puis « Ouvrir dans le terminal » |
| macOS | Applications, Utilitaires, Terminal |
| Linux | `Ctrl`+`Alt`+`T` |

Sous Windows 11, **Terminal est l'application par défaut** et ouvre PowerShell ; l'Invite de commandes reste disponible dans le même onglet déroulant. Ne pas développer la différence, elle est au cours 2. Insister en revanche sur le fait que le terminal s'ouvre **dans un dossier** : c'est le dossier courant des chemins relatifs, et la source de la moitié des erreurs de début de semestre.

#### TD : le même geste, à la souris et au clavier

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

#### Les octets de tête au terminal, PowerShell et Unix

Faire ouvrir un terminal à toute la salle avant de commencer : c'est le premier usage réel de ce qui vient d'être présenté, et le geste sert ensuite toute l'année.

La diapositive principale est en **PowerShell**, puisque c'est ce que la majorité de la promotion a sous la main. Les octets à relever sont laissés vides à la projection et remplis dans la compilation `--input corrige=true` : `50 4B 03 04` (`PK`, une archive ZIP, donc un `.odt`) et `25 50 44 46` (`%PDF`). La diapositive suivante, `head`/`xxd`/`file` sous Linux et macOS, est **facultative** ; elle vaut surtout pour `file`, dont Windows n'a pas d'équivalent.

Les lignes PowerShell viennent de la documentation Microsoft et n'ont pas pu être exécutées sur le poste de préparation : à vérifier avant la séance. Les valeurs d'octets, elles, sont mesurées.

Deux étages de décision. Le **système** choisit le logiciel d'après le **nom** ; le **logiciel** ouvre le fichier et lit ses **premiers octets** : `PK` pour une archive ZIP donc un `.odt`, `%PDF` pour un PDF, lisibles en clair. Ces octets de tête s'appellent des *nombres magiques* ; `file` ne fait que les comparer à un catalogue.

Ne pas développer le binaire ici : il est ouvert en hexadécimal au cours 3. Annoncer en revanche que le même phénomène revient dans la partie programmation, où les premiers octets de `python3` se lisent « ELF ».

## Minutage

**Le deck est volontairement plus large que la séance.** Le parti pris est de produire les diapositives d'abord et de filtrer ensuite : le déroulé détaillé ci-dessus totalise environ **216 minutes** hors annexes, pour une séance de 120, et cet écart est assumé tant que le contenu n'est pas stabilisé. *(Le chiffre de 160 minutes annoncé précédemment sous-estimait la somme des blocs ; il est corrigé ici.)*

Le budget visé, celui de la diapositive « Contenu de la séance », est :

| Partie | Contenu | Durée |
|--------|---------|-------|
| Logiciels et formats de fichier | logiciel, vocabulaire, système d'exploitation, application web, extension, chemins, TD fichiers | 25′ |
| Programmation et éditeur de code | programmes et applications, compilé et interprété, code source et exécutable, place de l'interpréteur, éditeur et fonctions d'un IDE, lancer un programme, hello world | 25′ |
| Édition de texte et contenu des fichiers | programmation et édition de texte, texte brut, règles d'un langage, coloration et extensions, espaces et tabulations, programmes fautifs, fichiers texte et Markdown, un texte quatre formes, les premiers octets | 30′ |
| Environnement de programmation | bibliothèques et dépendances, conda, terminal de l'éditeur, Python interactif | 25′ |
| Notebooks | interface et noyau, trois façons de l'ouvrir, deux formats | 10′ |

La partie 1 perd cinq minutes par rapport au budget précédent, et la partie 2 en gagne dix : le levier employé est celui qui était déjà prévu, l'étape ODT-ZIP de la manipulation d'ouverture passant en exercice complémentaire.

Les autres leviers connus, à activer au moment de figer la séance :

1. « Une vidéo, deux chemins » en **démonstration** (3′) plutôt qu'en manipulation (10′), et rejouée en autonomie après l'installation de l'environnement.
2. Le bloc IDE réduit à ce qui sert au cours 2 : −4′.
3. Le bloc Markdown réduit à deux diapositives — l'intention et la comparaison des trois formats — en renvoyant l'édition dans l'éditeur au cours 2, où `pandoc` est de toute façon repris : −4′.
4. Le mini-projet « premiers octets » ramené à une démonstration au tableau : −5′. Il vaut mieux le garder en manipulation, c'est le seul moment où ils lancent un script qu'ils n'ont pas écrit.

**Contrainte d'ordre** : la manipulation vidéo a besoin de l'environnement conda, installé en fin de séance. D'où la démonstration au moment des formats, la manipulation complète venant après l'installation ou en exercice complémentaire.

## Manipulations et diapositives de séparation

Le deck distingue trois régimes par la couleur de fond de ses diapositives d'ouverture, et par rien d'autre : blanc pour l'exposé, bleu pour les diapositives de section (`separateur`), brun pour les manipulations et les travaux dirigés (`separateur-manip`, `separateur-td`). C'est la distinction 🎓 / ⌨️ de ce document, rendue visible de loin.

Cinq blocs de manipulation dans la séance, répartis sur les trois premières parties :

| Ouverture | Partie | Contenu |
|-----------|--------|---------|
| *Fichiers, formats et extensions* | 1 | exporter, renommer, ouvrir le `.odt` comme une archive et le modifier |
| *Un hello world en Python et en C++* | 2 | lancer les deux programmes, et voir ce que chacun laisse sur le disque |
| *Extensions de langage et programmes fautifs* | 2 | installer l'extension d'un langage, corriger trois fichiers |
| *Un texte, quatre formes* | 3 | le poème en `.txt`, `.odt`, `.html` brut, `.html` + CSS |
| *Les premiers octets d'un fichier* | 3 | le mini-projet Python, et l'extension qui ment |

L'installation de l'environnement, en partie 4, est une sixième manipulation, sans diapositive d'ouverture : elle occupe la partie entière.

Trois blocs sont **en annexe** en fin de deck, et n'ont pas vocation à être joués en séance 1 : *Comparaison interface graphique et ligne de commande* (convertir un document des deux façons, piloter le navigateur sans fenêtre), *Échanger deux extensions* (qui demande la ligne de commande), et *Une vidéo, deux chemins*, le bonus. Les résultats observés y sont conservés.

## Points d'attention

- **Ne pas glisser vers la programmation.** La séance parle de *fichiers et d'outils*. Le seul code montré sert d'illustration (3 lignes) — l'algorithmique est le cours parallèle.
- **Profils hétérogènes** (prépa littéraire / scientifique) : la manipulation « quatre formes » ne demande aucun prérequis et occupe utilement les plus rapides via les étapes ODT-ZIP et CSS.
- **Le binaire n'est plus ici** : si la question vient (« et le `.png` alors ? »), répondre en une phrase (« compressé, on l'ouvrira en hexadécimal au cours 3 ») et ne pas dévier.
- **Mention utile** : ce qu'on met dans un dépôt public y reste — d'où le choix de textes du domaine public et de données *générées* plutôt que versionnées. Amorce discrète de la leçon secrets (cours 5B).
