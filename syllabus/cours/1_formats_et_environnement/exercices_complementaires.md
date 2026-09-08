# Exercices complémentaires — Cours 1 : Logiciel, programmation & formats

> Un exercice = **Objectif · Prérequis · Énoncé · Plancher/Plafond · Critères**. Pour étudiants rapides ou en autonomie.
> Données : `data/cours1/produit/` (`python make_data.py fetch && python make_data.py build`).

## Ex. 1 — L'ODT est une archive

- **Objectif** : démonter l'opposition naïve « texte vs binaire » — un format bureautique est un assemblage de fichiers texte compressés.
- **Prérequis** : manipulation « un texte, quatre formes » (étapes 1–2).
- **Énoncé** : copier `raven.odt` en `raven.zip`, l'ouvrir comme une archive, lister son contenu, ouvrir `content.xml` dans VSCode et y retrouver le texte du poème. Repérer une balise qui décrit de la *mise en forme* (style, alignement) plutôt que du contenu.
- **Plancher / Plafond** : *plancher* — lister l'archive et retrouver le texte ; *plafond* — modifier une chaîne dans `content.xml`, recompresser en `.odt`, rouvrir dans LibreOffice et constater le changement.
- **Critères** : sait dire ce que contient un `.odt` et pourquoi il ne se versionne pas bien.

## Ex. 2 — Mettre en forme sans toucher au contenu

- **Objectif** : rendre tangible la séparation contenu / présentation.
- **Prérequis** : étapes 4–5 de la manipulation centrale.
- **Énoncé** : à partir de `raven_style.html` et `style.css`, produire **deux rendus nettement différents** du même fichier HTML — par exemple une version « livre ancien » (empattements, fond crème, colonne étroite) et une version « écran sombre ». **Interdiction de modifier le `.html`** : tout se joue dans le CSS.
- **Plancher / Plafond** : *plancher* — changer couleurs, police, largeur ; *plafond* — mettre le refrain en évidence via une classe CSS… ce qui oblige à toucher au HTML : bonne occasion de discuter *où passe la frontière* entre structure et style.
- **Critères** : deux captures d'écran, un seul fichier HTML, deux feuilles de style.

## Ex. 3 — Deviner le format sans l'extension

- **Objectif** : comprendre que le contenu, lui, ne ment pas.
- **Prérequis** : notion d'extension comme convention.
- **Énoncé** : renommer trois fichiers de `produit/` en `mystere1.dat`, `mystere2.dat`, `mystere3.dat`, les échanger avec un binôme, puis retrouver la nature de chacun **sans essayer les extensions au hasard** : ouvrir le début du fichier dans VSCode. Les premiers octets trahissent le format (`<!doctype html`, `PK` pour un ZIP/ODT, du texte brut sinon).
- **Plancher / Plafond** : *plancher* — distinguer texte et non-texte ; *plafond* — trouver ce qu'est le « nombre magique » d'un format, et vérifier que `PK` correspond bien au ZIP.
- **Critères** : les trois fichiers sont identifiés, avec l'indice qui a permis de conclure.

## Ex. 4 — Un notebook reproductible

- **Objectif** : intérioriser que le noyau, pas le fichier, détient l'état.
- **Prérequis** : bloc notebooks.
- **Énoncé** : fabriquer volontairement un notebook « menteur » — 4 cellules dont l'exécution dans l'ordre affiché donne un résultat, et dans l'ordre où on les a réellement exécutées un autre. Le donner à un binôme, qui doit le réparer par *Restart & Run All* et expliquer ce qui s'est passé.
- **Plancher / Plafond** : *plancher* — deux cellules, une variable ; *plafond* — le notebook produit une **erreur** après redémarrage alors qu'il « marchait » (variable définie puis cellule supprimée).
- **Critères** : sait expliquer la différence entre le texte des cellules et l'état du noyau.

## Ex. 5 — MyST ↔ `.ipynb`

- **Objectif** : appliquer la leçon « même contenu, deux formats » à son propre travail.
- **Prérequis** : env `info01` actif.
- **Énoncé** : convertir une page MyST du cours en `.ipynb` (`jupytext --to ipynb`), l'exécuter, puis reconvertir en MyST. Comparer les **tailles** des fichiers et la lisibilité de chacun dans VSCode. Rédiger 3 lignes : lequel choisir pour écrire un cours ? pour envoyer un résultat par mail ?
- **Plancher / Plafond** : *plancher* — la conversion aller-retour fonctionne ; *plafond* — regarder ce que devient une **image** produite par une cellule dans le `.ipynb` (base64) et en déduire pourquoi le fichier grossit.
- **Critères** : les deux formats sont décrits avec un cas d'usage pour chacun.
