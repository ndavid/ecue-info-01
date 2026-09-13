# Le même programme en C++ — TD 2c, cours 1, facultatif

Le `bonjour.py` du TD 2a, réécrit en C++. Même phrase affichée ; ce qui change
est le nombre d'étapes pour y arriver, et ce qui reste sur le disque.

| | `bonjour.py` (TD 2a) | `bonjour.cpp` |
|---|---|---|
| Ce qu'on tape | `python bonjour.py` | `g++ bonjour.cpp -o bonjour`, puis `./bonjour` |
| Nombre d'étapes | une | deux : compiler, puis exécuter |
| Ce qui apparaît sur le disque | rien | `bonjour`, un exécutable |
| Taille du fichier source | 121 octets | 230 octets |
| Taille du fichier produit | aucun fichier | environ 20 000 octets |

Tailles relevées avec `g++` 13 sous Linux ; celle de l'exécutable varie d'un
compilateur et d'un système à l'autre, mais l'ordre de grandeur, près de cent
fois le fichier de départ, ne varie pas. L'exécutable embarque de quoi tourner
sans le compilateur.

Le TD est facultatif : il demande un compilateur, que Windows ne fournit pas,
et l'installation de l'extension C/C++ de l'éditeur. Il se fait après les
autres, ou chez soi.

## Déroulé

Dans l'éditeur, **Fichier → Ouvrir le dossier** sur `cours1/2c_hello_cpp/`,
puis **Terminal → Nouveau terminal** :

```bash
g++ bonjour.cpp -o bonjour   # compiler : rien ne s'affiche, un fichier apparaît
./bonjour                    # exécuter
```

**Rien ne s'affiche à la compilation, et c'est normal** : cette commande ne
montre pas un résultat, elle produit un fichier. `bonjour` apparaît dans
l'arborescence de gauche.

Le bouton d'exécution existe aussi pour le C++, « Run C/C++ File » ; il demande
de choisir un compilateur au premier lancement, puis écrit un `tasks.json`
dans le projet. La commande écrite à la main reste préférable.

## Sous Windows

Un compilateur C++ n'est pas fourni avec Windows : il s'installe dans
l'environnement conda du module.

```bash
conda install -c conda-forge gxx
```

**La commande ne s'appelle pas `g++`.** Le paquet installe
`x86_64-w64-mingw32-g++.exe` — le nom complet de la cible, architecture,
système et format — et c'est lui qu'il faut taper :

```bat
x86_64-w64-mingw32-g++ bonjour.cpp -o bonjour.exe
.\bonjour.exe
```

> Le nom de l'exécutable a été relevé dans le contenu du paquet `gxx_win-64`
> de conda-forge, sans machine Windows pour l'essayer : **à confirmer avant la
> séance**. Ne pas employer `m2w64-toolchain`, encore proposé par de vieilles
> réponses en ligne : le paquet affiche lui-même à l'activation qu'il est
> obsolète et renvoie vers `gcc`, `gxx` et `gfortran`.

L'installation demande du réseau et quelques minutes : la lancer avant la
séance, ou au début du TD en enchaînant sur autre chose pendant qu'elle
tourne.

## Ce qui est laissé de côté

L'exécutable `bonjour` (ou `bonjour.exe`) n'est pas versionné : c'est un
artefact, comme les PDF et les vidéos du reste du dépôt. Le supprimer avant la
séance suivante pour que le TD reparte de zéro.
