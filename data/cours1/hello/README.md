# Deux « hello world » — Cours 1

Le même programme, en Python et en C++ : il affiche une phrase, rien de plus.
Ce qui compte n'est pas ce qu'ils font, mais ce qu'il faut faire pour les
lancer, et ce que chacun laisse sur le disque.

Ces fichiers sont versionnés, contrairement au reste de `data/` : ce sont des
sources de quelques lignes, pas des données dérivées.

## Ce que la manipulation montre

| | `python/bonjour.py` | `cpp/bonjour.cpp` |
|---|---|---|
| Ce qu'on tape | `python python/bonjour.py` | `g++ cpp/bonjour.cpp -o cpp/bonjour`, puis `cpp/bonjour` |
| Nombre d'étapes | une | deux : compiler, puis exécuter |
| Ce qui apparaît sur le disque | rien | `cpp/bonjour`, un exécutable |
| Taille du fichier source | 121 octets | 230 octets |
| Taille du fichier produit | aucun fichier | environ 20 000 octets |

Tailles relevées avec `g++` 13 sous Linux ; celle de l'exécutable varie d'un
compilateur et d'un système à l'autre, mais l'ordre de grandeur, près de cent
fois le fichier de départ, ne varie pas. L'exécutable embarque de quoi tourner
sans le compilateur.

## Déroulé, geste par geste

Dans l'éditeur de code, dans cet ordre :

1. **Fichier → Ouvrir le dossier**, puis choisir `data/cours1/hello/`. On ouvre
   le dossier, pas un fichier : c'est lui qui devient le projet, et
   l'arborescence de gauche l'affiche.
2. **`Ctrl` + `Maj` + `P`**, taper « Python: Select Interpreter », choisir
   `info01`. Rien ne se passe à l'écran, et c'est normal : le réglage sert au
   terminal ouvert à l'étape suivante, que l'extension Python place alors dans
   le bon environnement. Sans lui, `python` peut être un autre que celui du
   module.
3. **Terminal → Nouveau terminal.** Il s'ouvre en bas, déjà placé dans
   `hello/` : il n'y a aucun chemin à écrire, ce qui évite l'erreur la plus
   fréquente de la séance.
4. Taper `python python/bonjour.py`, puis Entrée. La phrase s'affiche.
5. Taper `g++ cpp/bonjour.cpp -o cpp/bonjour`, puis Entrée. **Rien ne
   s'affiche, et c'est normal** : cette commande ne montre pas un résultat,
   elle produit un fichier. Le fichier `cpp/bonjour` apparaît dans
   l'arborescence de gauche.
6. Taper `cpp/bonjour`, puis Entrée. La même phrase s'affiche, produite cette
   fois par l'exécutable.

Les mêmes commandes, hors de l'éditeur :

```bash
conda activate info01
cd data/cours1/hello

python python/bonjour.py            # une étape

g++ cpp/bonjour.cpp -o cpp/bonjour  # compiler
cpp/bonjour                         # exécuter
```

Le bouton d'exécution en haut à droite de l'éditeur, « Run Python File », fait
la même chose que l'étape 4 et affiche dans le terminal la commande qu'il a
tapée. Il existe aussi pour le C++, sous le nom « Run C/C++ File » ; il demande
alors de choisir un compilateur au premier lancement, puis écrit un
`tasks.json` dans le projet. La commande écrite à la main reste préférable :
elle est identique sur les trois systèmes, elle se relit, et c'est elle qu'on
mettra dans un script au cours 3.

## Sous Windows

`python` vient de l'environnement conda. `g++`, en revanche, n'est pas fourni
avec Windows : il s'obtient avec MinGW-w64, MSYS2 ou le sous-système Windows
pour Linux. L'exécutable produit s'appelle alors `bonjour.exe` et se lance par
`.\cpp\bonjour`.

Prévoir un poste de démonstration si personne dans la salle n'a de
compilateur : la comparaison vaut d'être vue même par ceux qui ne peuvent pas
la refaire.

## Ce qui est laissé de côté

Le fichier `cpp/bonjour` produit par la compilation n'est pas versionné : c'est
un artefact, comme les PDF et les vidéos du reste du dépôt. Le supprimer avant
la séance suivante pour que la manipulation reparte de zéro.
