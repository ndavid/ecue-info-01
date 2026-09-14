# Fichiers, formats et extensions — TD 1a, cours 1

Deux poèmes du domaine public, chacun décliné en plusieurs formats. Le TD
consiste à les copier, les renommer, changer leur extension et les ouvrir,
pour voir ce que l'extension décide et ce que le contenu est vraiment.

| Dossier | Ce qu'il contient |
|---|---|
| `depart/` | les fichiers fournis, à ne pas modifier |
| `travail/` | vide : vos copies, et ce que vous en faites |

Pour chaque texte, `depart/` porte la même matière sous cinq formes :

| Fichier | Ce que c'est |
|---|---|
| `<texte>_une_ligne.txt` | le poème entier sur une seule ligne |
| `<texte>_une_ligne.donnees` | le même fichier, à une extension que rien ne connaît |
| `<texte>.odt` | le même texte en document LibreOffice |
| `<texte>_brut.html` | la même page, sans feuille de style |
| `<texte>_style.html` | la même page, avec `style.css` |

Les trois premiers portent le même contenu et s'ouvrent différemment ; les
deux derniers portent le même contenu et s'affichent différemment. C'est le
propos du TD.

Rien ici n'est versionné : `make_data.py`, à la racine de `data/cours1/`,
refabrique le dossier à partir des textes de `fourni/`.

## Avant de commencer

Afficher les extensions de fichier, que Windows masque par défaut :
Explorateur → Affichage → Afficher → Extensions de noms de fichiers. Sans
cela, la moitié du TD se joue à l'aveugle.
