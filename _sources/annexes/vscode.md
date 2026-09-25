---
title: VS Code
subtitle: Extension Python, extension Jupyter, terminal
---

VS Code est l'éditeur de code du module. Seul, il ne sait pas exécuter du
Python : il lui faut l'extension Python, et pour les notebooks l'extension
Jupyter. Une extension est un module qu'on ajoute à VS Code depuis son
panneau Extensions. Sur les postes de la salle, il faut aussi indiquer à VS
Code quel terminal ouvrir. Les six étapes ci-dessous se font une fois par
poste et par compte.

Deux gestes reviennent à chaque étape :

- la palette de commandes, ouverte par `Ctrl` + `Maj` + `P` (ou `F1`) : on
  y tape le début du nom d'une commande, et on la choisit dans la liste ;
- le panneau Extensions, ouvert par `Ctrl` + `Maj` + `X` : on y tape
  l'identifiant d'une extension, et on clique Install.

## Étape 1 : ouvrir le dossier du TD

Menu Démarrer, taper `visual studio code`, Entrée. Puis menu File, Open
Folder, choisir le dossier du TD. VS Code demande si on fait confiance au
dossier : répondre « Yes, I trust the authors ». Sans cette réponse,
l'extension Python ne se charge pas ({ref}`V4 <dep-v4>`).

## Étape 2 : installer l'extension Python

Panneau Extensions, taper `ms-python.python`, Install. Trois extensions
apparaissent ensuite comme installées : Python, Pylance, Python Debugger.
Si l'installation ne se fait pas : {ref}`V3 <dep-v3>`.

## Étape 3 : installer l'extension Jupyter

Panneau Extensions, taper `ms-toolsai.jupyter`, Install. Elle sert à ouvrir
les fichiers `.ipynb`.

## Étape 4 : choisir l'interpréteur

L'interpréteur est le Python que VS Code emploie pour exécuter les fichiers
`.py`. Ouvrir un fichier `.py` du TD, puis palette, « Python: Select
Interpreter ». Choisir la ligne `base` dont le chemin contient `anaconda3`.
Le nom choisi s'affiche en bas à droite. Si la ligne n'existe pas :
{ref}`V6 <dep-v6>`.

## Étape 5 : régler le terminal

Le terminal est une fenêtre de commandes à l'intérieur de VS Code. Par
défaut, c'est un PowerShell, et sur les postes de la salle PowerShell ne
peut pas activer l'environnement d'Anaconda ({ref}`A7 <dep-a7>`). On lui
donne à la place le terminal de l'Anaconda Prompt.

Palette, « Preferences: Open User Settings (JSON) ». Un fichier s'ouvre. Il
contient au moins `{` et `}`. Ajouter entre les deux accolades (après une
virgule, s'il y a déjà quelque chose) :

```json
"terminal.integrated.profiles.windows": {
  "Anaconda Prompt": {
    "path": "C:\\Windows\\System32\\cmd.exe",
    "args": ["/K", "C:\\ProgramData\\anaconda3\\Scripts\\activate.bat", "C:\\ProgramData\\anaconda3"]
  }
},
"terminal.integrated.defaultProfile.windows": "Anaconda Prompt"
```

Les deux chemins `C:\ProgramData\anaconda3` sont ceux de la cible du
raccourci « Anaconda Prompt » du menu Démarrer (clic droit, Propriétés).
Les barres obliques inverses sont doublées : c'est la règle de ce format
de fichier. Enregistrer (`Ctrl` + `S`).

Puis menu Terminal, New Terminal. L'onglet s'appelle « Anaconda Prompt » et
l'invite commence par `(base)`. Si rien ne change : palette, « Developer:
Reload Window ». Si le terminal affiche une erreur : {ref}`V5 <dep-v5>`.

## Étape 6 : vérifier

| Ce qu'on fait | Ce qu'on doit voir | Sinon |
|---|---|---|
| Dans le terminal, taper `python -c "import sys; print(sys.executable)"` | le chemin d'Anaconda, le même que dans l'Anaconda Prompt | {ref}`V7 <dep-v7>` |
| Ouvrir un fichier `.py`, bouton Run (le triangle en haut à droite) | ce que le programme affiche, dans le terminal | {ref}`V8 <dep-v8>` |
| Ouvrir un fichier `.ipynb`, bouton « Select Kernel » en haut à droite | `base`, directement ou sous « Python Environments… » | {ref}`J1 <dep-j1>` |
| Exécuter une cellule contenant `import sys; print(sys.executable)` | le chemin d'Anaconda | {ref}`J2 <dep-j2>`, {ref}`J4 <dep-j4>` |

## Fichiers utiles

| Quoi | Où |
|---|---|
| Réglages du compte (`settings.json`) | palette, « Preferences: Open User Settings (JSON) » ; sur le disque, `C:\Users\<nom>\AppData\Roaming\Code\User\settings.json` |
| Réglages du dossier ouvert | `<dossier>\.vscode\settings.json` |
| Extensions installées | `C:\Users\<nom>\.vscode\extensions` ; `code --list-extensions` dans un `cmd` |
| Journaux des extensions | panneau Output (`Ctrl` + `Maj` + `U`), liste déroulante « Python », « Python Environments », « Jupyter » |

(dep-vscode)=
## Problèmes

(dep-v1)=
### V1. VS Code n'est pas dans le menu Démarrer

Ce qu'on voit
: Rien ne répond à `visual studio code` ni à `code`.

Vérifier
: Dans un `cmd`, `dir "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe"`
  puis `dir "%ProgramFiles%\Microsoft VS Code\Code.exe"`.

Remède
: Si l'un des deux fichiers existe, double-cliquer dessus dans
  l'explorateur, puis clic droit sur l'icône de la barre des tâches,
  « Épingler à la barre des tâches ». Si aucun n'existe, VS Code n'est pas
  sur le poste : le signaler.

(dep-v2)=
### V2. VS Code ne trouve pas Python selon d'où on l'a lancé

Ce qu'on voit
: Lancé depuis Navigator, VS Code propose `base` et son terminal trouve
  `python`. Lancé depuis le menu Démarrer, ni l'un ni l'autre. Ou l'inverse
  selon les réglages déjà faits.

Cause
: Un programme reçoit de celui qui le lance la liste des dossiers où
  chercher les commandes. Navigator, qui s'exécute dans `base`, transmet à VS
  Code une liste qui contient Anaconda ; le menu Démarrer transmet celle du
  compte, qui ne le contient pas ({ref}`A2 <dep-a2>`).

Remède
: Toujours lancer VS Code depuis le menu Démarrer, avec les étapes 4 et 5
  faites. Le résultat ne dépend alors ni de Navigator ni d'une fenêtre
  ouverte avant.

(dep-v3)=
### V3. L'extension Python ne s'installe pas

Ce qu'on voit
: Le panneau Extensions reste vide, ou affiche « We cannot connect to the
  Extensions Marketplace », ou l'installation ne finit pas.

Cause
: Les extensions viennent d'un serveur. Sans session réseau
  ({ref}`R1 <dep-r1>`) ou derrière un proxy ({ref}`R2 <dep-r2>`), VS Code
  ne l'atteint pas.

Vérifier
: Ouvrir <https://marketplace.visualstudio.com> dans Firefox.

Remède
: Ouvrir la session réseau et relancer l'installation. Sans réseau, une
  extension s'installe depuis un fichier `.vsix` : panneau Extensions,
  bouton `…` en haut, « Install from VSIX… ». L'extension Python en
  demande deux autres, Pylance et Python Debugger, à installer de la même
  façon [à décider : fournir les `.vsix` avec l'archive du TD].

(dep-v4)=
### V4. « Restricted Mode » : l'extension Python ne fait rien

Ce qu'on voit
: « Restricted Mode » en bas de la fenêtre. « Python: Select Interpreter »
  n'est pas dans la palette. Aucun terminal ne s'ouvre, ou VS Code demande
  d'abord si on fait confiance au dossier.

Cause
: Le dossier ouvert n'a pas été approuvé, et l'extension Python ne se
  charge que dans un dossier approuvé.

Remède
: Cliquer sur « Restricted Mode » en bas de la fenêtre, puis « Trust ». Ou
  palette, « Workspaces: Manage Workspace Trust ».

(dep-v5)=
### V5. Le terminal de VS Code affiche une erreur dès qu'il s'ouvre

Ce qu'on voit
: À chaque nouveau terminal, une ligne de commande s'écrit toute seule,
  puis `… activate.ps1 cannot be loaded because running scripts is disabled
  on this system` ({ref}`A7 <dep-a7>`), ou `'conda' n'est pas reconnu`
  ({ref}`A2 <dep-a2>`). L'invite ne commence pas par `(base)`.

Cause
: Le terminal est un PowerShell, qui ne peut pas activer l'environnement
  sur les postes de la salle.

Remède
: Faire l'étape 5 ci-dessus. Si elle est faite et que l'erreur reste :
  vérifier que les chemins du réglage sont ceux du raccourci Anaconda
  Prompt, que le fichier a été enregistré, et faire palette, « Developer:
  Reload Window ». Si le fichier de réglages est souligné en rouge :
  {ref}`V10 <dep-v10>`.

(dep-v6)=
### V6. « Python: Select Interpreter » ne propose pas Anaconda

Ce qu'on voit
: La liste ne contient que « Enter interpreter path… », ou des Python qui
  ne sont pas celui d'Anaconda (`C:\Python27`, le Python du Microsoft
  Store).

Cause
: L'extension cherche Anaconda à plusieurs endroits du poste, et sur les
  postes de la salle aucun ne le lui indique.

Remède
: Cliquer « Enter interpreter path… », puis « Find… », et choisir le fichier
  `C:\ProgramData\anaconda3\python.exe`. Pour que la liste devienne
  complète (avec les environnements du TD 4a) : palette, « Preferences:
  Open User Settings (JSON) », ajouter
  `"python.condaPath": "C:\\ProgramData\\anaconda3\\Scripts\\conda.exe"`,
  enregistrer, puis « Developer: Reload Window ». Le chemin exact est celui
  du raccourci Anaconda Prompt ({ref}`A1 <dep-a1>`).

(dep-v7)=
### V7. `python` lance un autre Python que celui d'Anaconda

Ce qu'on voit
: « Python n'a pas été trouvé ; exécutez sans arguments pour l'installer à
  partir du Microsoft Store… ». Ou `Python 2.7`. Ou `ModuleNotFoundError`
  sur un module qui est pourtant dans `base`.

Cause
: Sans environnement activé ({ref}`A3 <dep-a3>`), `python` est le premier
  `python.exe` que Windows trouve : souvent un raccourci du Microsoft Store
  qui ne fait que proposer une installation, ou un vieux Python du poste.

Vérifier
: `where python` dans le terminal liste tous les `python.exe` trouvés,
  dans l'ordre. `python -c "import sys; print(sys.executable)"` dit lequel
  répond.

Remède
: Employer le terminal « Anaconda Prompt » (étape 5). Le bouton Run n'est
  pas concerné : il lance l'interpréteur choisi à l'étape 4, par son chemin
  complet.

(dep-v8)=
### V8. `ModuleNotFoundError` alors que le paquet est installé

Ce qu'on voit
: `ModuleNotFoundError: No module named 'pandas'` (ou un autre), alors que
  `conda list` dit que le paquet est là.

Cause
: Le paquet est dans un environnement, et le programme s'exécute dans un
  autre. Trois choix indépendants désignent l'environnement : l'interpréteur
  (bouton Run), le terminal (ce qui y est activé), le noyau du notebook.

Vérifier
: Dans chacun des trois, `import sys; print(sys.executable)` : les chemins
  doivent être identiques. `conda list -n <env> <paquet>` dit dans quel
  environnement le paquet est.

Remède
: Choisir le même environnement aux trois endroits (étapes 4 et 5,
  {ref}`J4 <dep-j4>`), ou installer le paquet dans celui qui s'exécute :
  `conda install -n <env> -c conda-forge <paquet>`.

(dep-v9)=
### V9. Le raccourci clavier du terminal ne répond pas

Ce qu'on voit
: `Ctrl` + `ù` n'ouvre rien, ou ouvre autre chose.

Cause
: Le raccourci dépend de la disposition du clavier, et le poste n'a pas
  forcément celle attendue.

Remède
: Menu Terminal, New Terminal. Ou palette, « Terminal: Create New
  Terminal ».

(dep-v10)=
### V10. Le fichier de réglages est souligné en rouge, ou ne s'enregistre pas

Ce qu'on voit
: « Unable to write into user settings. Please open the user settings to
  correct errors/warnings in it and try again ». Ou un réglage ajouté qui
  ne produit rien, avec une ligne soulignée en rouge dans `settings.json`.

Cause
: Une erreur de syntaxe dans le fichier : virgule manquante entre deux
  réglages, virgule en trop avant l'accolade finale, barre oblique inverse
  simple dans un chemin.

Vérifier
: Palette, « Preferences: Open User Settings (JSON) ». Le panneau Problems
  (`Ctrl` + `Maj` + `M`) indique la ligne.

Remède
: Corriger la ligne indiquée. Chaque réglage est séparé du suivant par une
  virgule ; le dernier n'en a pas ; les chemins s'écrivent avec `\\`. En
  cas de doute, passer par l'interface : palette, « Preferences: Open
  Settings (UI) », qui écrit le fichier elle-même.
