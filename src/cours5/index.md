---
title: "Séance 5 — Matériel, réseau, clés SSH et secrets"
---

## Contenu de la séance

Quatre parties. Les deux premières donnent les ordres de grandeur du matériel
et du réseau ; les deux suivantes mettent en place ce qu'il faut avant de
travailler sur une forge : une clé SSH sur le compte, et la règle qui tient
les secrets hors du dépôt.

```{list-table}
:header-rows: 1

* - Partie
  - Ce qu'on y voit
  - Durée
* - Le matériel
  - processeur, mémoire vive, disque ; tailles et temps d'accès
  - 20 min
* - Le réseau
  - local et distant, client et serveur, débit et latence ; TD 1a
  - 30 min
* - S'identifier auprès d'une machine distante
  - une paire de clés à la place d'un mot de passe ; TD 2a
  - 40 min
* - Secrets et sécurité
  - ce qui ne va pas dans un dépôt, mots de passe, deuxième facteur, hameçonnage
  - 20 min
```

Le TD 3a, facultatif, rejoue sur un dépôt neuf ce que la partie 4 montre : un
secret supprimé reste dans l'historique.

## Avant la séance

Les fichiers des TD sont dans l'archive `cours5/` remise avec la séance : un
dossier par TD, et dans chacun la feuille du TD en PDF.

Le TD 2a demande un compte GitHub : le créer avant la séance, avec l'adresse
de l'école, et activer la double authentification quand GitHub la propose.
Le cours 6 commence par `git clone` et suppose la clé en place.

Les pages de cours de cette séance restent à rédiger ; le déroulé est dans
`syllabus/cours/5_materiel_reseau_ssh/contenu_detaille.md` et les
diapositives dans `src/cours5/diapo/`.
