# Exercices complémentaires — Cours 3 : Binaire, données & CLI

> Un exercice = **Objectif · Prérequis · Énoncé · Plancher/Plafond · Critères**.
> Les deux premiers viennent du cours 1 (v1), déplacés avec le bloc binaire.

## Ex. 1 — ASCII ↔ texte (aller-retour)

- **Objectif** : rendre concret « un caractère = un code ».
- **Prérequis** : lancer un script Python (cours 1), listes.
- **Énoncé** : écrire deux petits scripts — l'un prend une liste de codes ASCII et écrit le fichier texte correspondant ; l'autre relit un fichier texte et affiche les codes. Vérifier l'aller-retour sur son prénom.
- **Plancher / Plafond** : *plancher* — ASCII pur ; *plafond* — gérer un caractère accentué (UTF-8) et observer qu'il occupe plusieurs octets.
- **Critères** : l'aller-retour redonne le texte de départ ; un accent est expliqué.

## Ex. 2 — Deviner l'image depuis l'hexadécimal

- **Objectif** : lire un fichier binaire simple « à la main ».
- **Prérequis** : focus PGM/hex du contenu détaillé.
- **Énoncé** : on fournit un `binaire.pgm` (P5, 4×4). Sans l'ouvrir dans un visualiseur, lire l'en-tête et les octets en hexadécimal, puis **dessiner sur papier** le motif attendu. Vérifier ensuite avec `magick binaire.pgm -scale 400x apercu.png`.
- **Plancher / Plafond** : *plancher* — gris 0/255 ; *plafond* — niveaux intermédiaires, ou passer en couleur `P6` (3 octets/pixel).
- **Critères** : le motif dessiné correspond à l'aperçu.

## Ex. 3 — (à ajouter : `subprocess` / `argparse`)

- **Objectif** :
- **Prérequis** :
- **Énoncé** :
- **Plancher / Plafond** :
- **Critères** :
