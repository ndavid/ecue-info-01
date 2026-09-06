---
title: Introduction
subtitle: Ce que ce module vous apporte, et ce qu'il ne traite pas
---

## À quoi sert ce module

Plusieurs cours de votre formation supposent que vous savez déjà installer un
environnement Python, ouvrir un projet dans un éditeur, lancer un script et
récupérer un fichier de résultats. Ces gestes sont rarement enseignés : ils sont
attendus.

Ce module les enseigne. Son objectif est que vous arriviez dans les cours de
programmation, et dans les TD qui utilisent Python, sans perdre de temps sur
l'outillage. Ce que vous y apprendrez ne sert pas qu'ici : ce sont les mêmes
gestes dans tous les cours où l'informatique intervient comme moyen et non comme
objet d'étude.

## Ce que le module couvre

**Les outils de la programmation.** En premier lieu l'édition de texte. Écrire
du code demande un éditeur adapté, qui n'est pas un traitement de texte. Vous
verrez ce qui les distingue, et pourquoi un fichier de code ne se manipule pas
comme un rapport.

**Le versionnement avec git.** Une initiation, pas une maîtrise complète :
enregistrer l'état de son travail, revenir en arrière sans crainte, et travailler
à plusieurs sur les mêmes fichiers. Git revient à chaque séance, sur des
exercices sans enjeu, jusqu'à devenir un réflexe.

**La forme d'un projet informatique.** Comment structurer un projet pour qu'il
soit repris par quelqu'un d'autre, ou par vous dans six mois. En pratique :
initialiser un projet avec un `README`, décrire son environnement pour qu'il
s'installe ailleurs, manipuler les fichiers avec les bibliothèques Python
prévues pour cela, et écrire un outil en ligne de commande dont les paramètres
se passent en argument plutôt qu'en modifiant le code.

**Des notions générales d'informatique.** Réparties en apartés au fil des
séances : ordres de grandeur (mémoire, temps de calcul, débit réseau), notions
de sécurité (clés, secrets, ce qu'on ne publie pas), et outils en ligne de
commande. Ces apartés expliquent *pourquoi* certaines façons de faire sont plus
rapides ou plus sûres que d'autres.

## Ce que le module ne couvre pas

Ce cours ne traite pas d'algorithmique. Écrire un algorithme, choisir une
structure de données, raisonner sur la complexité : c'est l'objet du cours de
programmation qui se déroule en parallèle.

La distinction se résume ainsi :

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

Les deux cours sont complémentaires. Un algorithme correct dans un projet
inexploitable ne sert à personne, et l'inverse est vrai aussi.

## Organisation

Sept séances de deux heures. Chaque séance alterne des explications courtes et
des manipulations faites en direct sur votre machine. Aucune séance n'est un
exposé continu.

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
  - Binaire, données et construction d'une CLI
  - cours
* - 4
  - Studio d'automatisation (animation vidéo)
  - TD
* - 5
  - Matériel, réseau, SSH et secrets
  - cours
* - 6
  - Forge, git en équipe, outil « trajectoire »
  - cours
* - 7
  - Benchmark image et rapport
  - TD
```

Les exemples empruntent parfois au domaine de la géomatique (des coordonnées,
une distance, une trajectoire), mais aucun ne suppose une notion qui n'a pas
encore été vue.

## Ce que vous saurez faire à la fin

- Ouvrir un projet dans un éditeur de code et vous y retrouver.
- Reconnaître ce que contient un fichier, indépendamment de son extension.
- Installer un environnement Python et le décrire pour qu'un autre l'installe.
- Enregistrer votre travail avec git, revenir en arrière, et contribuer à un
  dépôt partagé.
- Écrire un script Python qui lit des fichiers, en produit d'autres, et accepte
  ses paramètres en ligne de commande.
- Estimer si une opération va prendre une seconde ou une heure, et pourquoi.
