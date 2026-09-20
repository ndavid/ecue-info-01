---
title: "Séance 5 — Matériel, réseau, mots de passe, clés SSH et secrets"
---

## Contenu de la séance

Quatre parties. Les deux premières donnent les ordres de grandeur du matériel
et du réseau. Les deux suivantes partent du mot de passe, des façons de le
perdre et des parades, jusqu'à la clé SSH et aux secrets d'un programme, ce
qu'il faut avoir en place avant la forge du cours 6.

```{list-table}
:header-rows: 1

* - Partie
  - Ce qu'on y voit
  - Durée
* - Le matériel
  - composants, tailles et temps d'accès, trente ans d'évolution, puissance et consommation, coût des services en ligne
  - 30 min
* - Le réseau
  - local et distant, client et serveur, débit et latence, le sans-fil ; TD 1a
  - 30 min
* - Prouver qui l'on est
  - le mot de passe, les quatre façons de le perdre, les parades, le deuxième facteur, la clé SSH ; TD 2a
  - 40 min
* - Les secrets de vos programmes
  - ce qui ne va pas dans un dépôt, et quoi faire si c'est arrivé
  - 15 min
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
