# Annexe B — Ligne de commande (shell)

**Durée** : 1,5–2 h · **Place** : juste après l'IDE, en réutilisant le terminal intégré.

## Objectif

Démystifier le terminal : ce n'est pas « pour experts », c'est l'interface la plus directe pour piloter des outils. Poser les commandes qui reviendront tout le semestre.

## Points à montrer

- **Modèle mental** : une commande = un programme + des arguments + (parfois) une entrée/sortie.
- **Navigation** : `pwd`, `ls`, `cd`, chemins **relatifs vs absolus**, `.` `..` `~`.
- **Manipulation fichiers** : `mkdir`, `cp`, `mv`, `rm` (prévenir : pas de corbeille !), `cat`, `less`.
- **Redirections & pipes** : `>`, `>>`, `|` sur un vrai petit jeu de données (ex. CSV de points).
- **Recherche** : `grep -r "motif" dossier/`, `find . -name "*.md"` — commandes qu'ils **réutiliseront** (ex. chercher dans leur dépôt de notes).
- **Aide** : `--help`, `man`, `tab` (complétion), `↑` (historique).
- **Un outil concret et utile** : `pandoc cv.md -o cv.pdf` (lien direct avec l'exercice CV) ou `sort -k2 -n data.csv`.

## Ancrage géomatique / culture

- Chronométrer le chargement d'un **petit** vs **gros** fichier (`time …`) → introduit les ordres de grandeur (annexe E).
- Un appel réseau simple : `curl` vers une API géospatiale publique → introduit client-serveur + JSON.

## Aparté « algo caché » (mentionné, pas enseigné)

- `sort` → algorithmes de tri (cours d'algo).

## Écueils à éviter

- Ne pas faire un catalogue exhaustif de commandes. Choisir ~10 commandes utiles et les **répéter** dans les exercices suivants.
- Prévenir explicitement du `rm` définitif.

## Livrable de séance

Une petite chaîne `commande | commande > fichier` produisant un résultat lisible à partir d'un jeu de données fourni.
