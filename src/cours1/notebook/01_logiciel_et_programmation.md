---
title: "Qu'est-ce qu'un logiciel ?"
subtitle: Du bouton cliqué au fichier texte que quelqu'un a écrit
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

## Un logiciel, vu de loin

Vous utilisez des logiciels toute la journée : un navigateur, un traitement de
texte, une application de cartographie. Vu de l'extérieur, un logiciel se
présente comme une interface et un comportement : des menus, des boutons, et
quelque chose qui se produit quand on clique.

Vu de l'intérieur, la structure est plus simple. Un logiciel reçoit des données,
leur applique un traitement, et produit un résultat.

```{raw} html
<svg viewBox="0 0 720 138" width="100%" style="max-width:720px;height:auto;display:block;margin:1.2rem auto;font-family:inherit" role="img">
  <defs><marker id="fl" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7"
     markerHeight="7" orient="auto-start-reverse">
     <path d="M0,0 L10,5 L0,10 z" fill="currentColor"/></marker></defs>
  <rect x="10" y="30" width="195" height="78" rx="6" fill="none"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="107.5" y="66" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Des données</text>
  <text x="107.5" y="82" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">en entrée</text>
  <line x1="215" y1="69" x2="258" y2="69" stroke="currentColor"
     stroke-width="1.5" marker-end="url(#fl)" opacity=".8"/>
  <rect x="268" y="30" width="195" height="78" rx="6" fill="rgba(31,111,139,.10)"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="365.5" y="66" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Un programme</text>
  <text x="365.5" y="82" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">une suite d'instructions</text>
  <line x1="473" y1="69" x2="516" y2="69" stroke="currentColor"
     stroke-width="1.5" marker-end="url(#fl)" opacity=".8"/>
  <rect x="526" y="30" width="184" height="78" rx="6" fill="none"
     stroke="currentColor" stroke-width="1.5" opacity=".85"/>
  <text x="618.0" y="66" text-anchor="middle" fill="currentColor"
     font-size="14" font-weight="600" opacity="1">Des données</text>
  <text x="618.0" y="82" text-anchor="middle" fill="currentColor"
     font-size="12.5" font-weight="400" opacity=".75">en sortie, ou une action</text>

</svg>
```

Les données d'entrée peuvent être un fichier qu'on ouvre, un texte qu'on tape,
un clic, ou un relevé GPS. Le traitement est une suite d'instructions exécutées
dans l'ordre. Le résultat est un autre fichier, une image affichée, une ligne
écrite à l'écran, ou une action sur le monde extérieur : envoyer un message,
commander un moteur.

Ce schéma revient tout au long du module. Le TD de la dernière séance en est une
application directe : une image en entrée, un calcul, une image en sortie.

## Où se trouve le logiciel

Un logiciel installé sur votre machine est un ou plusieurs fichiers. Quand vous
double-cliquez sur une icône, le système lit un de ces fichiers et exécute ce
qu'il contient.

Ce fichier n'est pas lisible par un humain. Il contient du *binaire* : une suite
d'octets destinée au processeur. Il n'a pourtant pas été écrit sous cette forme.
Il a été produit à partir d'autre chose, et cette autre chose est du texte.

## Programmer consiste à écrire du texte

Un *langage de programmation* est une convention d'écriture. Il définit un
vocabulaire (des mots-clés), une grammaire (où placer les parenthèses, les
deux-points, les retours à la ligne) et une signification pour chaque
construction. Écrire un programme, c'est écrire un texte qui respecte cette
convention.

La cellule ci-dessous contient un programme complet. Exécutez-la avec le bouton
de lecture, ou avec `Maj+Entrée` :

```{code-cell} python
largeur = 1920
hauteur = 1080
print("Cette image contient", largeur * hauteur, "pixels")
```

Ces trois lignes sont une suite de caractères que vous pourriez taper dans
n'importe quel éditeur de texte, y compris le Bloc-notes. Ce qui les transforme
en action, c'est un second programme qui les lit et les exécute.

## Deux façons de passer du texte à l'action

```{list-table}
:header-rows: 1

* -
  - Interprété
  - Compilé
* - Ce qui se passe
  - le texte est lu et exécuté au fur et à mesure
  - le texte est traduit en binaire une fois pour toutes
* - Ce qui reste sur le disque
  - rien de nouveau
  - un fichier exécutable
* - Exemples
  - Python, JavaScript
  - C, C++, Rust
* - Compromis
  - démarrage immédiat, exécution plus lente
  - une étape de traduction, exécution rapide
```

Python est un langage interprété. Quand vous exécutez la cellule précédente, un
programme nommé `python` lit votre texte ligne par ligne et fait ce qu'il dit.

:::{note}
Ce compromis entre vitesse d'écriture et vitesse d'exécution revient au cours 6
et au TD 7. On y comparera une boucle écrite en Python à la même opération
confiée à `numpy`, qui la délègue à du code C compilé. L'écart de temps se
compte en centaines de fois.
:::

## Pourquoi les formats de fichier viennent ensuite

Si programmer revient à écrire du texte dans un fichier, alors la première
compétence à acquérir n'est pas de savoir programmer, mais de savoir manipuler
des fichiers sans hésiter. Cela suppose quatre choses :

1. savoir ce qu'un fichier contient réellement, indépendamment de ce que son
   icône laisse supposer ;
2. savoir qu'une extension est une convention de nommage et non une nature ;
3. savoir quel outil ouvre quel fichier, et pourquoi un traitement de texte
   convient mal à l'écriture de code ;
4. savoir distinguer le contenu d'un document de sa présentation.

La page suivante prend un même texte et l'observe sous quatre formes : `.txt`,
`.odt`, `.html` sans mise en forme, et `.html` avec une feuille de style.

:::{seealso}
Suite : [Formats de fichier](02_formats_de_fichier.md).
:::
