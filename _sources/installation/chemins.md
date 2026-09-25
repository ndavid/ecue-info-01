---
title: Où chaque outil range sa configuration
subtitle: Dossiers, fichiers de réglages, environnements et journaux, sous Windows, macOS et Linux
---

## Lire un chemin Windows

Windows désigne les dossiers du compte par des variables, écrites entre `%`.
Elles reviennent dans toutes les pages de dépannage, et dans les messages
d'erreur des outils.

| Variable | Dossier | Ce qu'il contient |
|---|---|---|
| `%USERPROFILE%` | `C:\Users\<nom>` | le profil du compte : Bureau, Documents, et les dossiers `.conda`, `.vscode`, `.jupyter`, `.ssh` que les outils y créent |
| `%APPDATA%` | `C:\Users\<nom>\AppData\Roaming` | les réglages qui suivent le compte (réglages de VS Code, noyaux Jupyter, cache de Navigator) |
| `%LOCALAPPDATA%` | `C:\Users\<nom>\AppData\Local` | ce qui reste sur la machine (l'exécutable de VS Code en installation utilisateur, les caches) |
| `%PROGRAMDATA%` | `C:\ProgramData` | ce qui est commun à tous les comptes, dont l'Anaconda de la salle |
| `%PATH%` | | la liste des dossiers où le terminal cherche une commande, dans l'ordre |

Le dossier `AppData` est masqué. Pour l'atteindre, taper la variable dans la
barre d'adresse de l'explorateur (`%APPDATA%`) ou dans Exécuter
(`Win` + `R`) ; dans un `cmd`, `echo %APPDATA%` affiche le chemin réel, ce
qui dit au passage si le profil est local ou sur un serveur ({ref}`R3 <dep-r3>`).

Sous macOS et Linux, `~` désigne le dossier personnel (`/Users/<nom>`,
`/home/<nom>`), et les fichiers dont le nom commence par un point sont
masqués par défaut (`ls -a` les montre).

## Anaconda et conda

| Quoi | Windows | macOS, Linux |
|---|---|---|
| Installation pour tous les utilisateurs (la salle) | `C:\ProgramData\anaconda3` | `/opt/anaconda3` |
| Installation personnelle (« Just me ») | `C:\Users\<nom>\anaconda3` | `~/anaconda3` (Miniforge : `~/miniforge3`) |
| Python de `base` | `<install>\python.exe` | `<install>/bin/python` |
| `conda` | `<install>\Scripts\conda.exe`, `<install>\condabin\conda.bat` | `<install>/bin/conda` |
| Script d'activation, `cmd` | `<install>\Scripts\activate.bat` | `<install>/bin/activate` |
| Script d'activation, PowerShell | `<install>\shell\condabin\conda-hook.ps1` | |
| Configuration du compte | `%USERPROFILE%\.condarc` | `~/.condarc` |
| Configuration de l'installation | `<install>\.condarc` | `<install>/.condarc` |
| Environnements créés par le compte | `%USERPROFILE%\.conda\envs\<nom>` | `~/.conda/envs/<nom>` |
| Environnements créés dans l'installation (si elle est inscriptible) | `<install>\envs\<nom>` | `<install>/envs/<nom>` |
| Liste des environnements connus | `%USERPROFILE%\.conda\environments.txt` | `~/.conda/environments.txt` |
| Cache des paquets téléchargés | `<install>\pkgs`, sinon `%USERPROFILE%\.conda\pkgs` | `<install>/pkgs`, sinon `~/.conda/pkgs` |
| Paquets d'un environnement | `<env>\Lib\site-packages` | `<env>/lib/python3.x/site-packages` |

Le raccourci « Anaconda Prompt » du menu Démarrer a pour cible
`%windir%\System32\cmd.exe "/K" <install>\Scripts\activate.bat <install>` :
c'est là qu'on lit le chemin réel de l'installation (clic droit sur le
raccourci, Propriétés, champ Cible).

Sur les postes de la salle, `<install>` n'est pas inscriptible par un compte
élève : conda y lit `base`, et range tout ce qu'il crée dans
`%USERPROFILE%\.conda`. `conda info` le montre, lignes `envs directories` et
`package cache` ; `conda config --show-sources` liste les fichiers `.condarc`
lus et ce que chacun fixe.

## Anaconda Navigator

| Quoi | Windows | macOS, Linux |
|---|---|---|
| Préférences | `%USERPROFILE%\.anaconda\navigator\anaconda-navigator.ini` | `~/.anaconda/navigator/anaconda-navigator.ini` |
| Verrou, cache des images, journaux | `%APPDATA%\.anaconda\navigator\` (le verrou est `navigator.lock`, dans un sous-dossier `.anaconda\navigator\` redoublé ; les journaux dans `logs\navigator.log`) | `~/.anaconda/navigator/` |

Selon la version, les journaux sont sous `%USERPROFILE%` ou sous
`%APPDATA%` ; `dir /s /b "%USERPROFILE%\.anaconda" "%APPDATA%\.anaconda"`
les trouve. `anaconda-navigator --reset`, dans l'Anaconda Prompt, remet les
préférences à zéro sans toucher aux paquets ; `anaconda-navigator --help`
liste les autres options.

## VS Code

| Quoi | Windows | macOS | Linux |
|---|---|---|---|
| Exécutable, installation utilisateur | `%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe` | `/Applications/Visual Studio Code.app` | selon le paquet (`/usr/share/code`, snap) |
| Exécutable, installation machine | `%ProgramFiles%\Microsoft VS Code\Code.exe` | | |
| Commande `code` | `…\Microsoft VS Code\bin\code.cmd` | à installer par la palette, « Shell Command: Install 'code' command in PATH » | `/usr/bin/code` |
| Réglages User | `%APPDATA%\Code\User\settings.json` | `~/Library/Application Support/Code/User/settings.json` | `~/.config/Code/User/settings.json` |
| Réglages Workspace | `<dossier>\.vscode\settings.json` | idem | idem |
| Extensions | `%USERPROFILE%\.vscode\extensions` | `~/.vscode/extensions` | `~/.vscode/extensions` |
| État par dossier ouvert (interpréteur choisi…) | `%APPDATA%\Code\User\workspaceStorage\` | `~/Library/Application Support/Code/User/workspaceStorage/` | `~/.config/Code/User/workspaceStorage/` |
| Journaux | `%APPDATA%\Code\logs\<date>\` | `~/Library/Application Support/Code/logs/` | `~/.config/Code/logs/` |

Le fichier `settings.json` s'ouvre sans chercher le chemin : palette
(`Ctrl` + `Maj` + `P`), « Preferences: Open User Settings (JSON) ». Les
journaux se lisent dans le panneau Output (`Ctrl` + `Maj` + `U`), canaux
« Python », « Python Environments », « Jupyter » ; « Developer: Open Extension
Logs Folder » ouvre le dossier. `code --list-extensions --show-versions`
liste les extensions installées.

Les réglages que le module fait toucher, et leur portée :

| Réglage | Rôle | Portée |
|---|---|---|
| `python.defaultInterpreterPath` | interpréteur proposé quand aucun n'a été choisi pour le dossier | User ou Workspace |
| `python.condaPath` | chemin de `conda.exe` quand VS Code ne le trouve pas seul | User seulement |
| `terminal.integrated.profiles.windows`, `terminal.integrated.defaultProfile.windows` | le terminal ouvert par défaut ({ref}`V5 <dep-v5>`) | User ; Workspace seulement dans un dossier approuvé |
| `python.terminal.activateEnvironment` | activer ou non l'environnement dans le terminal | User ou Workspace |
| `jupyter.kernels.excludePythonEnvironments` | environnements retirés de la liste des noyaux | User ou Workspace |
| `git.path` | chemin de `git.exe` quand il n'est pas dans le PATH | User seulement |
| `http.proxy` | proxy pour le marketplace des extensions | User |

## Jupyter

| Quoi | Windows | macOS | Linux |
|---|---|---|---|
| Configuration | `%USERPROFILE%\.jupyter` | `~/.jupyter` | `~/.jupyter` |
| Noyaux déclarés par le compte | `%APPDATA%\jupyter\kernels` | `~/Library/Jupyter/kernels` | `~/.local/share/jupyter/kernels` |
| Noyau livré avec un environnement | `<env>\share\jupyter\kernels\python3` | `<env>/share/jupyter/kernels/python3` | idem |
| Fichiers d'exécution (noyaux en cours, serveurs) | `%APPDATA%\jupyter\runtime` | `~/Library/Jupyter/runtime` | `~/.local/share/jupyter/runtime` |

`jupyter --paths` affiche les trois listes (config, data, runtime) dans
l'ordre où Jupyter les consulte ; `jupyter kernelspec list` affiche les
noyaux déclarés. VS Code n'en a pas besoin pour un environnement conda : il
lance `ipykernel` directement avec le `python` de l'environnement choisi, à
condition que `ipykernel` y soit installé ({ref}`J2 <dep-j2>`).

## PowerShell et cmd

| Quoi | Où |
|---|---|
| Windows PowerShell 5.1 | `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe` |
| PowerShell 7 (`pwsh`), s'il est installé | `C:\Program Files\PowerShell\7\pwsh.exe` |
| Profil PowerShell 5.1 (`$PROFILE`) | `%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1` |
| Profil PowerShell 7 | `%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1` |
| Stratégie d'exécution | `Get-ExecutionPolicy -List` ; fixée par stratégie de groupe si `MachinePolicy` ou `UserPolicy` n'est pas `Undefined` |
| Ce que `conda init cmd.exe` modifie | la clé de registre `HKCU\Software\Microsoft\Command Processor\AutoRun` |
| Ce que `conda init powershell` modifie | le profil PowerShell ci-dessus |

Sous macOS et Linux, `conda init` écrit un bloc `conda initialize` dans
`~/.bashrc` ou `~/.zshrc`.

## git et SSH

| Quoi | Windows | macOS, Linux |
|---|---|---|
| Exécutable, installation machine | `C:\Program Files\Git\cmd\git.exe` | `/usr/bin/git` |
| Exécutable, installation utilisateur | `%LOCALAPPDATA%\Programs\Git\cmd\git.exe` | |
| Configuration du compte (`--global`) | `%USERPROFILE%\.gitconfig` | `~/.gitconfig` |
| Configuration d'un dépôt (`--local`) | `<dépôt>\.git\config` | `<dépôt>/.git/config` |
| Configuration de l'installation (`--system`) | `C:\Program Files\Git\etc\gitconfig` | `/etc/gitconfig` |
| Clés SSH (séance 5) | `%USERPROFILE%\.ssh\` | `~/.ssh/` |

`git config --list --show-origin` affiche chaque réglage avec le fichier
d'où il vient.

## pip

Le module passe par conda, mais `pip` reste présent dans chaque
environnement et lit sa propre configuration : `%APPDATA%\pip\pip.ini` sous
Windows, `~/.config/pip/pip.conf` sous Linux,
`~/Library/Application Support/pip/pip.conf` sous macOS ; `pip config list`
et `pip cache dir` les affichent.

## Éditeurs de texte et LibreOffice

| Quoi | Windows |
|---|---|
| Bloc-notes | `C:\Windows\System32\notepad.exe` ; sous Windows 11, une application du Store qui porte le même nom |
| Notepad++ | `C:\Program Files\Notepad++\notepad++.exe` ; réglages dans `%APPDATA%\Notepad++\config.xml` |
| LibreOffice | `C:\Program Files\LibreOffice\program\soffice.exe` ; profil dans `%APPDATA%\LibreOffice\4\user` |

Sous macOS, le profil LibreOffice est dans `~/Library/Application
Support/LibreOffice/4/user`, sous Linux dans `~/.config/libreoffice/4/user`.

## Ce qui suit le compte et ce qui reste sur la machine

Quand le profil Windows est itinérant, ce qui est sous `%APPDATA%` (Roaming)
et à la racine de `%USERPROFILE%` est copié entre le serveur et le poste à
chaque ouverture et fermeture de session ; ce qui est sous `%LOCALAPPDATA%`
reste sur le poste. Deux conséquences pour les outils du module : les
réglages de VS Code, les noyaux Jupyter et le cache de Navigator suivent le
compte ; les environnements conda, dans `%USERPROFILE%\.conda\envs`, le
suivent aussi, et comme ils pèsent vite plusieurs centaines de Mo, ils
allongent les ouvertures de session. Quand la machine virtuelle est
réinitialisée à chaque session, rien de tout cela ne survit
({ref}`R3 <dep-r3>`).

## Cinq commandes qui résument l'état d'un poste

Dans l'Anaconda Prompt (ou, ailleurs, dans un terminal où `conda` répond) :

```
conda info
conda config --show-sources
where python
jupyter --paths
git config --list --show-origin
```

Elles disent, dans l'ordre : quelle installation et quels dossiers conda
emploie ; quels `.condarc` il lit ; quel `python` un terminal lance en
premier ; où Jupyter cherche ses noyaux ; d'où viennent les réglages git.
Sous macOS et Linux, `which -a python` remplace `where python`.
