---
title: Installation et configuration
subtitle: Les outils du module, dans l'ordre où on les met en route, et où chercher quand l'un d'eux ne démarre pas
---

## À quoi servent ces pages

Le module emploie une poignée d'outils : un éditeur de texte simple, Anaconda
(l'interpréteur Python, `conda`, l'Anaconda Prompt), VS Code et ses
extensions, Jupyter pour les notebooks, puis git à partir de la séance 2.
Chacun a ses fichiers de configuration, ses messages d'erreur, et ses façons
de ne pas démarrer. Ces pages rassemblent ce qu'il faut savoir pour les
mettre en route et pour se dépanner seul, sur les postes de la salle comme
sur un ordinateur personnel.

Elles sont trois, à lire dans cet ordre quand quelque chose ne va pas :

- la [FAQ](faq.md) part de ce que vous voyez à l'écran et renvoie à l'entrée
  de dépannage qui correspond ;
- le [dépannage](depannage.md) décrit chaque problème rencontré en séance :
  ce qu'on voit, la cause, comment vérifier, et le remède ;
- les [chemins de configuration](chemins.md) disent où chaque outil range
  ses réglages, ses environnements et ses journaux, sous Windows, macOS et
  Linux.

Le reste de cette page est la mise en route, dans l'ordre. Chaque étape dit
ce qu'on fait, ce qu'on doit voir, et où aller si on ne le voit pas.

## Deux situations

Sur les **postes de la salle**, ce sont des machines virtuelles Windows, avec
Anaconda installé pour tous les utilisateurs dans `C:\ProgramData\anaconda3`,
et un compte élève sans droits d'administrateur : on ne peut ni modifier
l'environnement `base`, ni changer la stratégie d'exécution de PowerShell, ni
installer un logiciel dans `Program Files`. Tout ce que les pages proposent
pour la salle respecte cette contrainte.

Sur un **ordinateur personnel**, vous avez les droits, et la plupart des
problèmes de la salle n'existent pas. Ce qui reste vaut partout : quel Python
répond, dans quel environnement un paquet a été installé, et ce que VS Code a
trouvé ou non.

## Étape 0 : le réseau

:::{warning}
Sur les postes de la salle, rien ne se télécharge tant que la session réseau
n'est pas ouverte : ni une extension VS Code, ni un paquet conda, ni une page
web. Anaconda Navigator, qui interroge plusieurs serveurs au démarrage, met
alors plusieurs minutes à s'ouvrir. Commencez donc par là, avant toute
installation ou configuration.

1. Sur le bureau, lancer le raccourci d'authentification
   [à compléter : nom exact du raccourci], qui ouvre Firefox sur la page de
   connexion, et entrer vos identifiants.
2. La session réseau dure [à compléter : durée] ; passé ce délai, les
   téléchargements échouent de nouveau et il faut refaire le geste. Une
   commande qui échoue en fin de séance alors qu'elle passait au début a
   presque toujours cette cause.
3. Vérifier : ouvrir dans le navigateur une page hors de l'école, par exemple
   <https://code.visualstudio.com>, puis dans un `cmd` (menu Démarrer, taper
   `cmd`) :

   ```
   curl -I https://repo.anaconda.com
   ```

   La première ligne de la réponse doit contenir `HTTP/1.1 200` ou `HTTP/2
   200`. Un message `Could not resolve host` ou une attente sans fin veulent
   dire que la session n'est pas ouverte ({ref}`R1 <dep-r1>`) ; un `407` ou
   une erreur SSL, qu'un proxy est en jeu ({ref}`R2 <dep-r2>`).
:::

## Étape 1 : les outils simples

Avant tout ce qui touche à Python, s'assurer que le poste répond aux gestes
de base. Ça prend deux minutes et ça élimine une famille de fausses pistes.

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Menu Démarrer, taper `bloc-notes` (ou `notepad`), Entrée | une fenêtre vide du Bloc-notes | {ref}`O1 <dep-o1>` |
| Menu Démarrer, taper `notepad++`, Entrée | Notepad++ s'ouvre | {ref}`O1 <dep-o1>` |
| Explorateur, ouvrir le dossier du TD | les noms de fichiers montrent leur extension (`raven.txt`, pas `raven`) | {ref}`O2 <dep-o2>` |
| Double-clic sur un fichier `.txt` | il s'ouvre dans un éditeur de texte | {ref}`O3 <dep-o3>` |
| Menu Démarrer, taper `libreoffice`, Entrée | LibreOffice s'ouvre (TD 1a) | {ref}`O4 <dep-o4>` |

## Étape 2 : Anaconda Prompt et conda

L'Anaconda Prompt est un `cmd` dans lequel l'environnement `base` d'Anaconda
est déjà activé. C'est le terminal de référence sous Windows : quand une
commande `conda` ou `python` doit être tapée et qu'on ne précise rien, c'est
là.

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Menu Démarrer, taper `anaconda prompt`, Entrée | une fenêtre noire dont l'invite commence par `(base)` | {ref}`A1 <dep-a1>`, {ref}`A3 <dep-a3>` |
| `conda --version` | `conda 25.x` (ou 24.x) | {ref}`A2 <dep-a2>` |
| `python -c "import sys; print(sys.executable)"` | un chemin qui contient `anaconda3` | {ref}`A3 <dep-a3>`, {ref}`V7 <dep-v7>` |
| `conda info` | la ligne `envs directories` cite un dossier de votre profil (`C:\Users\<nom>\.conda\envs`) en plus de celui d'Anaconda | {ref}`R4 <dep-r4>` |

Anaconda Navigator n'est pas nécessaire : tout ce que le module lui demande
(lancer VS Code dans le bon environnement) se fait aussi bien depuis le
bureau, avec le réglage de l'étape 4. Sur les postes de la salle, il est lent
à s'ouvrir et se bloque facilement ({ref}`A4 <dep-a4>`, {ref}`A5 <dep-a5>`) ;
s'il propose une mise à jour, répondre non ({ref}`A6 <dep-a6>`).

## Étape 3 : VS Code et l'extension Python

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Menu Démarrer, taper `visual studio code`, Entrée | l'éditeur s'ouvre | {ref}`V1 <dep-v1>` |
| Fichier, Ouvrir le dossier, choisir le dossier du TD | un bandeau demande si vous faites confiance au dossier : répondre oui | {ref}`V4 <dep-v4>` |
| Panneau Extensions (`Ctrl` + `Maj` + `X`), chercher `ms-python.python`, Installer | l'extension Python apparaît comme installée, avec Pylance et Python Debugger | {ref}`V3 <dep-v3>` |
| Ouvrir un fichier `.py`, palette (`Ctrl` + `Maj` + `P`), « Python: Select Interpreter » | une entrée `base` dont le chemin contient `anaconda3` ; la choisir | {ref}`V6 <dep-v6>` |

## Étape 4 : le terminal de VS Code

C'est l'étape qui distingue les postes de la salle. VS Code ouvre par défaut
un terminal PowerShell, et PowerShell y refuse le script qui active
l'environnement. Le remède est de lui donner le terminal de l'Anaconda
Prompt, un `cmd` ; la marche à suivre est dans {ref}`V5 <dep-v5>`.

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Menu Terminal, Nouveau terminal | un onglet `cmd` (ou « Anaconda Prompt ») dont l'invite commence par `(base)` | {ref}`V5 <dep-v5>`, {ref}`A7 <dep-a7>` |
| `python -c "import sys; print(sys.executable)"` | le même chemin qu'à l'étape 2 | {ref}`V7 <dep-v7>` |
| Bouton Run (triangle en haut à droite) sur le fichier `.py` | sa sortie dans le terminal | {ref}`V8 <dep-v8>` |

## Étape 5 : les notebooks

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Panneau Extensions, chercher `ms-toolsai.jupyter`, Installer | l'extension Jupyter installée | {ref}`V3 <dep-v3>` |
| Ouvrir un fichier `.ipynb`, bouton « Select Kernel » en haut à droite | `base`, directement ou sous « Python Environments… » | {ref}`J1 <dep-j1>` |
| Exécuter une cellule contenant `import sys; print(sys.executable)` | le chemin d'Anaconda | {ref}`J2 <dep-j2>`, {ref}`J3 <dep-j3>`, {ref}`J4 <dep-j4>` |

## Étape 6 : git (à partir de la séance 2)

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Dans le terminal, `git --version` | `git version 2.x` | {ref}`G1 <dep-g1>` |
| `git config --global user.name` | votre nom ; sinon le définir avant le premier commit | {ref}`G2 <dep-g2>` |

## Ce qui survit d'une séance à l'autre

Sur les postes de la salle, la question se pose pour tout ce que les étapes
précédentes ont réglé : extension installée, interpréteur choisi, profil de
terminal, environnement conda créé au TD 4a. Le test est simple : créer un
fichier vide sur le bureau, se déconnecter, se reconnecter. S'il a disparu,
la machine est réinitialisée à chaque session et il faut relire
{ref}`R3 <dep-r3>` pour savoir quoi refaire, et dans quel ordre, en début de
séance.

:::{note}
Points à compléter sur place, après vérification sur un poste de la salle :
le nom du raccourci d'authentification et la durée de la session réseau
(étape 0) ; si les VM sont réinitialisées entre deux sessions ; si Notepad++,
LibreOffice et git sont dans l'image ; et le chemin exact d'Anaconda, lu dans
la cible du raccourci « Anaconda Prompt » (clic droit, Propriétés), à
reporter dans {ref}`V5 <dep-v5>`. Le relevé complet d'un poste se fait avec
`outils/diagnostic_salle/collecte.cmd` du dépôt, et son protocole de tests
est dans `outils/diagnostic_salle/PROTOCOLE.md`.
:::

```{toctree}
:maxdepth: 1

faq
depannage
chemins
```
