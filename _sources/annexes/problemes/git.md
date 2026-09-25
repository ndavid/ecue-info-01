---
title: Problèmes avec git
subtitle: À partir de la séance 2
---

Cette page sera complétée après la séance 2, avec les messages réellement
rencontrés.

(dep-git)=
## Problèmes

(dep-g1)=
### G1. « 'git' n'est pas reconnu en tant que commande interne ou externe »

Ce qu'on voit
: Ce message dans le terminal. Dans VS Code : « Git not found. Install it
  or configure it using the 'git.path' setting ».

Vérifier
: Dans un `cmd`, `dir "C:\Program Files\Git\cmd\git.exe"` puis
  `dir "%LOCALAPPDATA%\Programs\Git\cmd\git.exe"`.

Remède
: Si l'un des deux fichiers existe : dans VS Code, palette, « Preferences:
  Open Settings (UI) », chercher `git.path` et y écrire ce chemin. Si aucun
  n'existe, git s'obtient sans droits d'administrateur de trois façons,
  Cmder, un environnement conda (`conda create -n outils -c conda-forge
  git`) ou l'archive portable de Git for Windows : [Git et Git
  Bash](../configuration/git.md), qui donne aussi le `git.path` de
  chacune.

(dep-g2)=
### G2. « Author identity unknown » au premier commit

Ce qu'on voit
: `Author identity unknown *** Please tell me who you are.`, suivi des deux
  commandes à taper.

Cause
: Chaque commit porte un nom et une adresse. git ne les connaît pas tant
  qu'on ne les lui a pas donnés.

Remède
: Une fois par compte, dans le terminal :

```
git config --global user.name "Prénom Nom"
git config --global user.email "prenom.nom@exemple.fr"
```

`git config --global user.name`, sans valeur, affiche ce qui est
enregistré. Sur un poste dont le compte Windows est commun à plusieurs
élèves, régler sans `--global`, dans le dépôt : le réglage ne vaut que
pour ce dépôt, et ne reste pas pour l'élève suivant ([Git et Git
Bash](../configuration/git.md)).

(dep-g3)=
### G3. « warning: … LF will be replaced by CRLF »

Ce qu'on voit
: `warning: in the working copy of 'notes.md', LF will be replaced by CRLF
  the next time Git touches it`.

Cause
: Windows termine les lignes d'un fichier texte par deux caractères
  (CR LF), macOS et Linux par un seul (LF). git prévient qu'il convertira.
  C'est un avertissement ; le commit a bien eu lieu.

Remède
: Rien à faire pour le module. Pour ne plus voir le message :
  `git config --global core.autocrlf false`.
