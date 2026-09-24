---
title: Introduction
subtitle: Objectif, contenu et organisation du module
---

## Objectif du module

Plusieurs cours de la formation demandent d'installer un environnement
Python, d'ouvrir un projet dans un éditeur, de lancer un script et de
récupérer un fichier de résultats. Ces cours supposent ces opérations
acquises, et aucun ne les enseigne.

Ce module les enseigne, pour que vous arriviez dans les cours de
programmation et dans les TD qui emploient Python sans perdre de temps sur
l'outillage. Les mêmes opérations reviennent dans tous les cours où
l'informatique sert d'outil de travail.

## Contenu du module

Le module couvre quatre domaines.

Les outils de la programmation
: D'abord l'édition de texte. Écrire du code demande un éditeur de code ;
  le module montre ce qui le distingue d'un traitement de texte, et ce que
  cela change pour les fichiers qu'on écrit.

Le versionnement avec git
: Une initiation : enregistrer l'état de son travail, revenir à une
  version antérieure, et travailler à plusieurs sur les mêmes fichiers. Git
  est introduit à la séance 2, puis repris dans les séances suivantes sur
  des exercices courts.

L'organisation d'un projet
: Structurer un projet pour qu'une autre personne puisse le reprendre : un
  `README` qui le présente, un fichier qui décrit son environnement pour
  l'installer sur une autre machine, la manipulation des fichiers avec les
  bibliothèques Python prévues pour cela, et un outil en ligne de commande
  dont les paramètres se passent en argument, sans modifier le code.

Des notions générales d'informatique
: Les ordres de grandeur (mémoire, temps de calcul, débit réseau), la
  sécurité (clés, secrets, ce qu'on ne publie pas) et les outils en ligne
  de commande. Ces notions sont réparties au fil des séances ; elles
  expliquent pourquoi une façon de faire est plus rapide ou plus sûre
  qu'une autre.

## Hors du module

L'algorithmique n'est pas traitée ici. Écrire un algorithme, choisir une
structure de données et raisonner sur la complexité relèvent du cours de
programmation, qui a lieu en parallèle. Le tableau donne des exemples de
questions, et le cours qui les traite.

```{list-table}
:header-rows: 1

* - Question
  - Traitée ici
  - Traitée ailleurs
* - Quel algorithme résout ce problème ?
  -
  - cours de programmation
* - Où mettre ce fichier, et sous quel nom ?
  - oui
  -
* - Comment écrire cette boucle ?
  -
  - cours de programmation
* - Comment lancer ce script sur une autre machine ?
  - oui
  -
* - Comment retrouver la version qui fonctionnait ?
  - oui
  -
```

Les deux cours se complètent : le cours de programmation porte sur le code
lui-même, ce module sur les fichiers, les outils et l'environnement qui le
font fonctionner.

## Organisation

Le module compte sept séances de deux heures. Chaque séance alterne des
explications courtes et des TD faits sur machine. Les séances 4 et 7 sont
des projets, qui se terminent par un livrable.

```{list-table}
:header-rows: 1

* - Séance
  - Sujet
  - Type
* - 1
  - Logiciel, programmation et formats de fichier
  - cours
* - 2
  - Ligne de commande et git local
  - cours
* - 3
  - Chemins, fichiers, images et ligne de commande
  - cours
* - 4
  - Studio d'automatisation (animation vidéo)
  - projet
* - 5
  - Matériel, réseau, mots de passe, clés SSH et secrets
  - cours
* - 6
  - Forge, git en équipe, outil « trajectoire »
  - cours
* - 7
  - Benchmark image et rapport
  - projet
```

Certains exemples viennent de la géomatique (des coordonnées, une distance,
une trajectoire). Aucun ne suppose une notion qui n'a pas encore été vue.

## Compétences visées

À la fin du module, vous savez :

- ouvrir un projet dans un éditeur de code et vous y retrouver ;
- reconnaître ce que contient un fichier, indépendamment de son extension ;
- installer un environnement Python, et le décrire pour qu'une autre personne
  l'installe ;
- enregistrer votre travail avec git, revenir à une version antérieure, et
  contribuer à un dépôt partagé ;
- écrire un script Python qui lit des fichiers, en produit d'autres, et reçoit
  ses paramètres en ligne de commande ;
- estimer l'ordre de grandeur de la durée d'une opération, et l'expliquer.
