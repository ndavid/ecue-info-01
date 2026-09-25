---
title: Tester Anaconda
subtitle: Anaconda Prompt, Anaconda Navigator, Spyder
---

Les exercices de programmation en Python se feront avec les outils
d'Anaconda, installé sur les postes de la salle (c'est le choix de l'école
pour l'installation de Python). Anaconda contient Python et trois
programmes qui servent au module :

- Anaconda Navigator : une interface graphique qui sert à lancer les
  autres applications (JupyterLab, Spyder, VS Code) ; il peut être long à
  se lancer, surtout la première fois ;
- l'Anaconda Prompt : une fenêtre dans laquelle on tape des commandes ;
  c'est la version légère, qui s'ouvre tout de suite ;
- Spyder : un éditeur de code Python, pour écrire un programme et
  l'exécuter.

Le premier outil employé en séance sera probablement Navigator. Comme il
peut être lent, on commence par tester l'Anaconda Prompt, puis Navigator,
puis Spyder.

:::{warning}
Le premier lancement de l'année de chacun de ces outils peut être long :
ils créent leurs fichiers de configuration, et certains cherchent des
mises à jour. Cliquer une seule fois, puis attendre, jusqu'à deux minutes.
Les lancements suivants sont plus rapides.
:::

## L'Anaconda Prompt

L'Anaconda Prompt est une fenêtre noire. On y tape une commande, on
appuie sur Entrée, et la réponse s'affiche en dessous. La ligne qui attend
une commande s'appelle l'invite. Sur les postes de la salle, elle commence
par `(base)` : c'est le nom de l'environnement Python actif, celui
d'Anaconda.

```{figure} anaconda_prompt.svg
:alt: La fenêtre de l'Anaconda Prompt, avec une commande tapée et sa réponse
:width: 100%

Une commande tapée dans l'Anaconda Prompt, et sa réponse.
```

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Menu Démarrer, taper `anaconda prompt`, Entrée | une fenêtre noire ; l'invite commence par `(base)` | {ref}`A1 <dep-a1>`, {ref}`A3 <dep-a3>` |
| Taper `conda --version` puis Entrée | `conda 25.x` ou `conda 24.x` | {ref}`A2 <dep-a2>` |
| Taper `python -c "import sys; print(sys.executable)"` puis Entrée | un chemin qui contient `anaconda3` | {ref}`A3 <dep-a3>` |

Ce dernier chemin est celui du Python qui exécute les commandes. Il sert
de référence pour la suite : chaque fois qu'un outil affiche un chemin de
Python, ce doit être celui-là.

## Anaconda Navigator

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Menu Démarrer, taper `anaconda navigator`, Entrée, puis attendre | une fenêtre « Loading applications… », puis la page d'accueil, avec une fiche par application (JupyterLab, Spyder, VS Code…) | {ref}`A4 <dep-a4>`, {ref}`A5 <dep-a5>` |
| En haut de la page d'accueil, la liste déroulante des environnements | `base (root)` | {ref}`A11 <dep-a11>` |

:::{note}
Si Navigator propose une mise à jour, répondre No ({ref}`A6 <dep-a6>`).
:::

## Spyder

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Dans Navigator, fiche Spyder, bouton Launch (ou menu Démarrer, taper `spyder`, Entrée), puis attendre | la fenêtre de Spyder : un éditeur à gauche, une console à droite | {ref}`A12 <dep-a12>` |
| Dans la console, à droite, taper `import sys; print(sys.executable)` puis Entrée | le même chemin que dans l'Anaconda Prompt | {ref}`A12 <dep-a12>` |

La suite est dans les annexes : [tester JupyterLab](../annexes/configuration/jupyterlab.md),
puis [configurer VS Code](../annexes/configuration/vscode.md). Les
environnements et les notebooks dans Spyder sont dans
[Spyder](../annexes/configuration/spyder.md).

## Documentation officielle

- Anaconda Navigator : [Getting started with Navigator](https://www.anaconda.com/docs/tools/anaconda-navigator/getting-started)
  (en anglais), avec des captures de la page d'accueil.
- Anaconda Prompt et conda : [Getting started with conda](https://docs.conda.io/projects/conda/en/stable/user-guide/getting-started.html)
  (en anglais), section « Starting conda ».
- Spyder : [Tour de l'interface](https://docs.spyder-ide.org/current/quickstart.html)
  (en anglais).
