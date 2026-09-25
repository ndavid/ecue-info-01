---
title: Dépannage
subtitle: Chaque problème rencontré en séance, avec ce qu'on voit, sa cause, comment vérifier et le remède
---

Les entrées sont groupées par outil, dans l'ordre de la mise en route
([réseau](#dep-reseau), [outils simples](#dep-outils-simples),
[Anaconda](#dep-anaconda), [VS Code](#dep-vscode), [Jupyter](#dep-jupyter),
[git](#dep-git), [outils installés par conda](#dep-outils-conda)), et
numérotées pour que la [FAQ](faq.md) et les feuilles de TD puissent y
renvoyer. Une dernière section liste ce qui ne se règle qu'au niveau de
l'image des postes, à l'intention du service informatique.

## Lire un message d'erreur

Avant de chercher, relever trois choses : la dernière ligne du message,
recopiée telle quelle (c'est elle qui nomme l'erreur ; ce qui précède est le
chemin qui y mène) ; le programme dans lequel elle s'affiche (Anaconda
Prompt, `cmd`, PowerShell, le terminal de VS Code, une cellule de notebook) ;
et d'où ce programme a été lancé (menu Démarrer, bureau, Navigator, un
autre terminal). Le même message a souvent deux causes selon le terminal,
et c'est ce relevé qui les départage.

(dep-reseau)=
## Réseau et session

(dep-r1)=
### R1. Rien ne se télécharge : la session réseau n'est pas ouverte

Ce qu'on voit
: Le navigateur affiche une page de connexion, ou rien. `conda create` ou
  `conda install` se termine par `CondaHTTPError: HTTP 000 CONNECTION FAILED
  for url <https://repo.anaconda.com/…>` ou `<https://conda.anaconda.org/…>`.
  Dans VS Code, le panneau Extensions reste vide ou affiche « We cannot
  connect to the Extensions Marketplace ». Anaconda Navigator met plusieurs
  minutes à s'ouvrir ({ref}`A4 <dep-a4>`).

Cause
: Le réseau de l'école n'ouvre l'accès à l'extérieur qu'après une
  authentification, valable [à compléter : durée]. Avant, et après
  expiration, toute connexion sortante échoue ou attend sans fin.

Vérifier
: Ouvrir dans le navigateur une page hors de l'école, par exemple
  <https://code.visualstudio.com>. Dans un `cmd`, `curl -I
  https://repo.anaconda.com` doit répondre par une ligne `HTTP/… 200`.

Remède
: Lancer le raccourci d'authentification du bureau [à compléter : nom
  exact], qui ouvre Firefox sur la page de connexion, et s'y connecter. Puis
  relancer la commande qui avait échoué. En cours de séance, une commande
  qui échoue alors qu'elle passait une heure plus tôt a la même cause et le
  même remède.

(dep-r2)=
### R2. Le navigateur fonctionne mais conda, pip ou VS Code n'atteignent rien

Ce qu'on voit
: Les pages web s'ouvrent, mais conda répond `ProxyError`, `HTTP 407`, ou
  une erreur `SSL` ; le marketplace de VS Code reste vide.

Cause
: Le réseau passe par un proxy que le navigateur connaît (il est configuré
  par le système) mais que les outils en ligne de commande ignorent tant
  qu'on ne le leur dit pas.

Vérifier
: Paramètres Windows, Réseau et Internet, Proxy : une adresse y figure-t-elle ?
  Dans un `cmd`, `netsh winhttp show proxy` et `echo %HTTPS_PROXY%`.

Remède
: [à compléter selon la salle]. Pour conda, dans `%USERPROFILE%\.condarc` :

```yaml
proxy_servers:
  http: http://<proxy>:<port>
  https: http://<proxy>:<port>
```

Pour les autres outils, les variables d'environnement `HTTP_PROXY` et
`HTTPS_PROXY` (`setx HTTPS_PROXY http://<proxy>:<port>`, puis rouvrir le
terminal) ; pour le marketplace de VS Code, le réglage `http.proxy`. Sur un
ordinateur personnel, hors de l'école, rien de tout cela ne s'applique.

(dep-r3)=
### R3. Ce qui avait été réglé la semaine dernière a disparu

Ce qu'on voit
: VS Code n'a plus l'extension Python, son terminal est de nouveau
  PowerShell, l'interpréteur n'est plus choisi, l'environnement créé au TD
  4a n'existe plus.

Cause
: La machine virtuelle est réinitialisée à chaque session, ou le profil du
  compte n'est pas conservé. Tout ce qui est rangé dans le profil
  ([chemins](chemins.md)) repart de zéro.

Vérifier
: Créer un fichier vide sur le bureau, se déconnecter, se reconnecter. S'il
  a disparu, c'est le cas.

Remède
: Côté élève, refaire en début de séance, dans cet ordre : session réseau
  ({ref}`R1 <dep-r1>`), extension Python ({ref}`V3 <dep-v3>`), profil de
  terminal ({ref}`V5 <dep-v5>`), interpréteur ({ref}`V6 <dep-v6>`), et
  garder ses fichiers de travail sur une clé USB ou l'espace personnel
  [à compléter]. Le profil de terminal peut voyager avec le dossier du TD,
  dans `.vscode/settings.json`, dès que le dossier est approuvé
  ({ref}`V4 <dep-v4>`) ; `python.condaPath`, lui, ne peut pas. Ce qui
  éviterait de tout refaire est du ressort de l'image du poste
  ([dernière section](#dep-image)).

(dep-r4)=
### R4. Le compte n'a pas les droits d'administrateur

Ce qu'on voit
: Un installateur demande un mot de passe d'administrateur ; conda répond
  `EnvironmentNotWritableError` ({ref}`A8 <dep-a8>`) ; PowerShell refuse
  `Set-ExecutionPolicy` ({ref}`A7 <dep-a7>`).

Cause
: Les comptes élèves de la salle n'ont pas ces droits, et Anaconda y est
  installé pour tous les utilisateurs, dans `C:\ProgramData\anaconda3`, en
  lecture seule pour eux.

Ce qui reste possible sans droits
: Créer ses propres environnements conda (ils vont dans
  `%USERPROFILE%\.conda\envs`) ; installer des extensions VS Code ;
  installer VS Code lui-même, en version « User Installer », et Git for
  Windows en installation utilisateur ; modifier tous les fichiers de
  réglages du compte.

Ce qui ne l'est pas
: Modifier ou mettre à jour `base` et Navigator ; changer la stratégie
  d'exécution de PowerShell quand une stratégie de groupe la fixe ;
  installer dans `Program Files` ; modifier le `PATH` système.

(dep-outils-simples)=
## Outils simples

(dep-o1)=
### O1. Le Bloc-notes ou Notepad++ ne se trouve pas

Ce qu'on voit
: Rien ne répond au nom tapé dans le menu Démarrer, ou l'icône attendue est
  absente du bureau.

Vérifier
: `Win` + `R`, taper `notepad`, Entrée : le Bloc-notes est dans Windows,
  il s'ouvre toujours. Pour Notepad++, `dir "C:\Program Files\Notepad++"`
  dans un `cmd` : si le dossier n'existe pas, le logiciel n'est pas installé
  sur ce poste.

Remède
: Menu Démarrer, taper le début du nom (`bloc`, `notepad`), Entrée. Pour
  ouvrir un fichier donné dans l'un ou l'autre : clic droit sur le fichier,
  Ouvrir avec, Choisir une autre application. Si Notepad++ manque, le
  Bloc-notes suffit au TD 1a ; sur un ordinateur personnel, il s'installe
  depuis <https://notepad-plus-plus.org>.

(dep-o2)=
### O2. L'explorateur cache les extensions de fichiers

Ce qu'on voit
: Le fichier `raven.txt` apparaît sous le nom `raven` ; renommer un fichier
  en `raven.donnees` produit en réalité `raven.donnees.txt`, et le TD 1a ne
  se comporte pas comme prévu.

Cause
: Par défaut, l'explorateur masque l'extension des types de fichiers
  connus.

Remède
: Windows 11 : menu Affichage, Afficher, cocher « Extensions de noms de
  fichiers ». Windows 10 : onglet Affichage, cocher « Extensions de noms de
  fichiers ». Au même endroit, « Éléments masqués » montre les dossiers
  `.git`, `.vscode` et `AppData`, utiles à partir de la séance 2.

(dep-o3)=
### O3. Windows demande avec quel programme ouvrir le fichier

Ce qu'on voit
: Au double-clic sur un fichier dont l'extension lui est inconnue
  (`.donnees`, `.md` sur un poste sans éditeur associé), Windows ouvre une
  liste de programmes au lieu du fichier.

Cause
: C'est le comportement normal pour une extension qu'aucun programme n'a
  déclarée. L'extension est une convention de nommage, pas une propriété
  du contenu, et c'est le sujet du TD 1a.

Remède
: Choisir le Bloc-notes ou Notepad++ dans la liste, sans cocher « Toujours
  utiliser cette application » (le TD fait justement changer de programme
  pour un même fichier).

(dep-o4)=
### O4. LibreOffice manque, ou n'exporte pas

Ce qu'on voit
: Le menu Démarrer ne connaît pas `libreoffice`, ou l'export en PDF du TD
  1a n'aboutit pas.

Vérifier
: `dir "C:\Program Files\LibreOffice\program\soffice.exe"` dans un `cmd`.

Remède
: L'export se fait par Fichier, Exporter vers, Exporter au format PDF, puis
  Exporter, sans changer d'option. Si LibreOffice manque sur le poste, le
  dossier `depart/` du TD contient déjà le fichier `.odt` et le PDF : passer
  l'étape d'export et continuer avec eux. Sur un ordinateur personnel,
  LibreOffice s'installe depuis <https://fr.libreoffice.org>.

(dep-anaconda)=
## Anaconda

(dep-a1)=
### A1. « Anaconda Prompt » n'apparaît pas dans le menu Démarrer

Ce qu'on voit
: Taper `anaconda` dans le menu Démarrer ne propose rien, ou seulement
  Navigator.

Cause
: Anaconda n'est pas installé ; ou il a été installé « Just me » par un
  autre compte, et ses raccourcis sont dans le menu Démarrer de ce
  compte-là ; ou le menu n'a pas encore indexé les raccourcis.

Vérifier
: Dans un `cmd`, `dir C:\ProgramData\anaconda3\Scripts\activate.bat`, puis
  `dir %USERPROFILE%\anaconda3`, `dir C:\anaconda3`,
  `dir %LOCALAPPDATA%\anaconda3`. Le premier chemin qui existe est
  l'installation.

Remède
: Ouvrir un `cmd` et taper, avec le chemin trouvé :

```
call C:\ProgramData\anaconda3\Scripts\activate.bat C:\ProgramData\anaconda3
```

L'invite passe à `(base)` et c'est un Anaconda Prompt. Pour ne pas le
retaper : clic droit sur le bureau, Nouveau, Raccourci, et comme
emplacement `%windir%\System32\cmd.exe /K
C:\ProgramData\anaconda3\Scripts\activate.bat C:\ProgramData\anaconda3`. Si
aucun chemin n'existe, Anaconda n'est pas sur le poste : le signaler.

(dep-a2)=
### A2. `conda` n'est pas reconnu

Ce qu'on voit
: Dans `cmd` : `'conda' n'est pas reconnu en tant que commande interne ou
  externe`. Dans PowerShell : `conda : Le terme 'conda' n'est pas reconnu`,
  ou, après `conda activate`, `CommandNotFoundError: Your shell has not been
  properly configured to use 'conda activate'`.

Cause
: L'installateur d'Anaconda n'ajoute pas conda au `PATH` (c'est son choix
  par défaut, et celui de la salle). Un `cmd` ou un PowerShell ordinaire ne
  le connaît donc pas ; seul l'Anaconda Prompt, qui lance `activate.bat`, le
  connaît.

Vérifier
: `where conda` dans le terminal en question : vide, c'est cette cause.

Remède
: Employer l'Anaconda Prompt ({ref}`A1 <dep-a1>`), ou, dans VS Code, le
  profil de terminal qui fait la même chose ({ref}`V5 <dep-v5>`). Sur un
  ordinateur personnel, `conda init cmd.exe` ou `conda init powershell`,
  tapé une fois dans l'Anaconda Prompt, rend `conda` disponible dans les
  terminaux ouverts ensuite ; pour PowerShell, la stratégie d'exécution doit
  le permettre ({ref}`A7 <dep-a7>`).

(dep-a3)=
### A3. L'invite ne commence pas par `(base)`

Ce qu'on voit
: Le terminal est ouvert mais l'invite est `C:\Users\<nom>>` ou `PS
  C:\Users\<nom>>`, sans nom d'environnement entre parenthèses.

Cause
: Aucun environnement n'est activé. `python` désigne alors le premier
  `python.exe` du `PATH`, qui peut être un autre Python que celui d'Anaconda,
  ou aucun ({ref}`V7 <dep-v7>`).

Vérifier
: `python -c "import sys; print(sys.executable)"` : le chemin doit contenir
  `anaconda3`.

Remède
: Si `conda` répond : `conda activate base`. Sinon : {ref}`A2 <dep-a2>`.
  Dans VS Code, le nom entre parenthèses apparaît quand le terminal a été
  ouvert après le choix de l'interpréteur ({ref}`V6 <dep-v6>`), avec un
  profil qui sait activer ({ref}`V5 <dep-v5>`).

(dep-a4)=
### A4. Anaconda Navigator met plusieurs minutes à s'ouvrir

Ce qu'on voit
: Après le clic, rien pendant une à plusieurs minutes ; parfois une fenêtre
  noire qui passe ; puis la fenêtre, ou le message de {ref}`A5 <dep-a5>`
  si on a recliqué.

Cause
: Navigator charge Python et un moteur d'affichage web (plusieurs
  centaines de Mo à lire, que l'antivirus inspecte à la première lecture,
  et sur une machine virtuelle réinitialisée c'est chaque fois la première),
  lance plusieurs commandes `conda`, puis interroge des serveurs (page
  d'accueil, mise à jour, compte). Sans session réseau ({ref}`R1 <dep-r1>`)
  ou derrière un pare-feu qui ne répond pas, chaque requête attend son
  délai d'expiration avant de passer à la suivante.

Vérifier
: Gestionnaire des tâches (`Ctrl` + `Maj` + `Échap`) : un processus
  « Anaconda Navigator » ou `pythonw.exe` existe-t-il ? S'il est là et que
  la fenêtre n'apparaît pas au bout de cinq minutes, il est bloqué. Lancé
  depuis l'Anaconda Prompt par `anaconda-navigator`, il affiche ce qu'il
  fait et sur quoi il attend.

Remède
: Un seul clic, puis attendre deux minutes sans recliquer, avec la session
  réseau ouverte. Répondre non à une proposition de mise à jour
  ({ref}`A6 <dep-a6>`). Et se souvenir que Navigator n'est pas nécessaire :
  lancer VS Code depuis le menu Démarrer avec le profil de terminal
  ({ref}`V5 <dep-v5>`) donne le même résultat. Une mention « offline mode »
  dans Navigator n'est pas une erreur : elle dit que le réseau manque, et
  n'empêche pas de lancer VS Code.

(dep-a5)=
### A5. « There is an instance of Anaconda Navigator already running »

Ce qu'on voit
: Ce message, et aucune fenêtre de Navigator à l'écran.

Cause
: Navigator pose un verrou au démarrage (`navigator.lock`, voir
  [chemins](chemins.md)) et abandonne au bout de trois secondes s'il est
  tenu. Le verrou est tenu par un processus vivant : soit l'instance du
  premier clic, encore en train de charger ({ref}`A4 <dep-a4>`), soit une
  instance laissée ouverte par une session précédente, soit une instance
  bloquée sans fenêtre.

Vérifier
: Gestionnaire des tâches, onglet Processus ou Détails : chercher
  « Anaconda Navigator » ou `pythonw.exe`.

Remède
: Si le premier clic date de moins de deux minutes, attendre. Sinon,
  terminer ces processus (clic droit, Fin de tâche ; un compte sans droits
  peut terminer ses propres processus), puis relancer une seule fois. Si le
  message persiste sans aucun processus, dans l'Anaconda Prompt :
  `anaconda-navigator --reset`, ou supprimer le dossier
  `%APPDATA%\.anaconda\navigator` et relancer.

(dep-a6)=
### A6. Navigator propose une mise à jour, ou reste sur « updating packages »

Ce qu'on voit
: Au démarrage, une boîte « Update Application » ; si on accepte, Navigator
  se relance, repropose la même mise à jour, ou reste sur « updating
  packages on 'root' » sans fin.

Cause
: Sur les postes de la salle, `base` n'est pas inscriptible par le compte
  élève : la mise à jour ne peut pas aboutir, et Navigator ne le détecte
  pas.

Remède
: Répondre No, et cocher « Don't show again » si la case est proposée. Si
  la mise à jour a été lancée et bloque, terminer le processus
  ({ref}`A5 <dep-a5>`). Dans Preferences, « Hide update dialog on startup »
  évite la question, tant que le profil est conservé ({ref}`R3 <dep-r3>`).

(dep-a7)=
### A7. « … cannot be loaded because running scripts is disabled on this system »

Ce qu'on voit
: Dans PowerShell, au démarrage du terminal de VS Code ou à `conda activate`
  : `… \activate.ps1 cannot be loaded because running scripts is disabled
  on this system`, ou le même message pour `conda-hook.ps1` ou pour
  `profile.ps1`.

Cause
: La stratégie d'exécution de PowerShell est `Restricted` : il exécute les
  commandes tapées, mais aucun fichier de script, et l'activation d'un
  environnement conda dans PowerShell passe par un script.

Vérifier
: Dans PowerShell, `Get-ExecutionPolicy -List`. Si `MachinePolicy` ou
  `UserPolicy` n'est pas `Undefined`, une stratégie de groupe la fixe et
  aucune commande locale n'y changera rien.

Remède
: Employer un `cmd` : `activate.bat` n'est pas un script PowerShell et n'est
  pas soumis à la stratégie ; c'est ce que fait l'Anaconda Prompt, et ce que
  le profil de terminal donne à VS Code ({ref}`V5 <dep-v5>`). Sur un
  ordinateur personnel, ou sur un poste sans stratégie de groupe, dans
  PowerShell : `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`, sans
  droits d'administrateur, puis rouvrir le terminal.

(dep-a8)=
### A8. `conda install` répond « EnvironmentNotWritableError »

Ce qu'on voit
: `EnvironmentNotWritableError: The current user does not have write
  permissions to the target environment. environment location:
  C:\ProgramData\anaconda3`.

Cause
: La commande visait `base`, qui appartient à l'installation pour tous les
  utilisateurs. Un compte élève y lit, mais n'y écrit pas.

Remède
: Créer son propre environnement, avec ce dont on a besoin dedans :

```
conda create -n recette -c conda-forge python pandoc
conda activate recette
```

Il est rangé dans `%USERPROFILE%\.conda\envs\recette`, où le compte a tous
les droits. C'est le geste du TD 4a, et la règle du module : on n'installe
rien dans `base`, même sur un ordinateur personnel où ce serait possible.

(dep-a9)=
### A9. `conda create` échoue en « CondaHTTPError », ou « Solving environment » n'en finit pas

Ce qu'on voit
: `CondaHTTPError: HTTP 000 CONNECTION FAILED for url <…>`, ou `HTTP 403`,
  `HTTP 407`, une erreur `SSL`, ou une ligne « Solving environment » qui
  tourne plusieurs minutes.

Cause
: `000 CONNECTION FAILED` : pas de session réseau ({ref}`R1 <dep-r1>`).
  `407` ou `SSL` : un proxy ({ref}`R2 <dep-r2>`). `403` : le serveur refuse
  (voir aussi {ref}`A10 <dep-a10>`). Une résolution longue sans erreur :
  la première commande qui emploie `conda-forge` télécharge l'index du
  canal, plusieurs dizaines de Mo, avant de calculer quoi installer ; sur
  un réseau lent, ça se compte en minutes, et c'est normal.

Vérifier
: `curl -I https://conda.anaconda.org` dans un `cmd` (une ligne `HTTP/… 200`
  attendue), puis relancer la commande.

Remède
: Ouvrir la session réseau et relancer. Si l'index paraît corrompu (erreur
  `JSONDecodeError` ou `Invalid index`), `conda clean --index-cache` puis
  relancer. Ne pas multiplier les canaux : `-c conda-forge` et rien d'autre
  garde la résolution courte.

(dep-a10)=
### A10. « CondaToSNonInteractiveError: Terms of Service have not been accepted »

Ce qu'on voit
: Ce message, qui cite `https://repo.anaconda.com/pkgs/main` et
  `https://repo.anaconda.com/pkgs/r`, ou une question `Do you accept the
  Terms of Service (ToS) for https://repo.anaconda.com/pkgs/main?
  [(a)ccept/(r)eject/(v)iew]`.

Cause
: Depuis Anaconda 2025.06, conda demande d'accepter les conditions
  d'utilisation des canaux d'Anaconda avant de s'en servir, une fois par
  compte. Les canaux `pkgs/main` et `pkgs/r` sont ceux que conda consulte
  par défaut, même quand on ajoute `-c conda-forge`.

Remède
: Dans un terminal, répondre `a` à la question ; ou, une fois pour toutes :

```
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main --channel https://repo.anaconda.com/pkgs/r
```

L'autre voie est de ne pas consulter ces canaux : `conda create -n recette
--override-channels -c conda-forge python pandoc` n'emploie que conda-forge,
qui n'a pas de conditions à accepter. Sur une machine réinitialisée à chaque
session ({ref}`R3 <dep-r3>`), l'acceptation est à refaire, et la seconde
voie évite la question.

(dep-a11)=
### A11. Un environnement créé n'apparaît pas dans la liste

Ce qu'on voit
: `conda env list` ne cite pas l'environnement ; ou il y est, mais VS Code
  (« Select Interpreter », « Select Kernel ») ou Navigator ne le proposent
  pas.

Cause
: conda tient la liste dans `%USERPROFILE%\.conda\environments.txt` ; un
  environnement créé par un autre compte, ou par chemin (`-p`) hors des
  dossiers habituels, n'y est pas. VS Code et Navigator, eux, lisent cette
  liste à leur démarrage et ne la relisent pas d'eux-mêmes.

Vérifier
: `conda env list` dans l'Anaconda Prompt ; puis `type
  %USERPROFILE%\.conda\environments.txt`.

Remède
: Si conda le connaît : dans VS Code, palette, « Python: Clear Cache and
  Reload Window » (extension classique) ou « Python Environments: Refresh
  Environment Managers » (extension Python Environments) ; dans Navigator,
  onglet Environments, « Update index ». Si conda ne le connaît pas :
  l'activer une fois par son chemin, `conda activate
  C:\Users\<nom>\.conda\envs\<nom>`, ce qui l'inscrit dans la liste.

(dep-vscode)=
## VS Code

(dep-v1)=
### V1. VS Code ne se trouve pas

Ce qu'on voit
: Rien ne répond à `visual studio code` ni à `code` dans le menu Démarrer.

Vérifier
: `dir "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe"` (installation
  utilisateur) et `dir "%ProgramFiles%\Microsoft VS Code\Code.exe"`
  (installation machine) dans un `cmd`.

Remède
: Si l'un des deux existe, le lancer par ce chemin et épingler l'icône. Si
  aucun n'existe sur un poste de la salle, le signaler. Sur un ordinateur
  personnel, prendre le « User Installer » sur <https://code.visualstudio.com>
  : il s'installe dans le profil, sans droits d'administrateur.

(dep-v2)=
### V2. VS Code ne se comporte pas pareil selon d'où on l'a lancé

Ce qu'on voit
: Lancé depuis Navigator, VS Code trouve `base` et son terminal trouve
  `python` ; lancé depuis le bureau, ni l'un ni l'autre, ou l'inverse selon
  les réglages posés.

Cause
: Un programme hérite du `PATH` de celui qui le lance. Navigator, qui
  tourne dans `base`, transmet à VS Code un `PATH` qui contient Anaconda ;
  le bureau transmet le `PATH` du compte, qui ne le contient pas
  ({ref}`A2 <dep-a2>`). Même chose pour un VS Code lancé par `code .` depuis
  l'Anaconda Prompt.

Remède
: Choisir une façon de lancer et s'y tenir. Celle du module est le menu
  Démarrer ou le bureau, avec le profil de terminal ({ref}`V5 <dep-v5>`) et
  l'interpréteur choisi ({ref}`V6 <dep-v6>`) : elle ne dépend ni de
  Navigator ni d'un terminal ouvert avant.

(dep-v3)=
### V3. L'extension Python ne s'installe pas

Ce qu'on voit
: Le panneau Extensions reste vide, affiche « We cannot connect to the
  Extensions Marketplace », ou l'installation tourne sans finir.

Cause
: Le marketplace est un serveur : sans session réseau
  ({ref}`R1 <dep-r1>`) ou derrière un proxy ({ref}`R2 <dep-r2>`), il est
  hors d'atteinte.

Vérifier
: Ouvrir <https://marketplace.visualstudio.com> dans le navigateur.

Remède
: Ouvrir la session réseau et relancer l'installation. À défaut de réseau,
  une extension s'installe depuis un fichier `.vsix` (panneau Extensions,
  menu `…`, « Install from VSIX… », ou `code --install-extension
  <fichier>.vsix` dans un `cmd`) ; l'extension Python en entraîne deux
  autres, Pylance et Python Debugger, à installer de la même façon
  [à décider : fournir les `.vsix` avec l'archive du TD].

(dep-v4)=
### V4. « Restricted Mode » : l'extension Python ne fait rien

Ce qu'on voit
: La barre d'état porte « Restricted Mode » ; « Python: Select Interpreter »
  n'apparaît pas dans la palette ; aucun terminal ne s'ouvre, ou VS Code
  demande d'abord si on fait confiance au dossier.

Cause
: Le dossier ouvert n'a pas été approuvé, et l'extension Python ne se
  charge que dans un dossier approuvé.

Remède
: Cliquer « Restricted Mode » dans la barre d'état, ou palette,
  « Workspaces: Manage Workspace Trust », et approuver le dossier du TD. Le
  choix est mémorisé par dossier, tant que le profil est conservé
  ({ref}`R3 <dep-r3>`).

(dep-v5)=
### V5. Le terminal de VS Code affiche une erreur à l'ouverture

Ce qu'on voit
: À chaque nouveau terminal, PowerShell écrit une commande d'activation
  puis `… activate.ps1 cannot be loaded because running scripts is disabled
  on this system` ({ref}`A7 <dep-a7>`), ou `conda n'est pas reconnu`
  ({ref}`A2 <dep-a2>`). L'invite ne porte pas `(base)`.

Cause
: VS Code ouvre PowerShell par défaut, et PowerShell ne peut pas activer
  l'environnement sur ces postes.

Remède
: Donner à VS Code le terminal de l'Anaconda Prompt. Palette, « Preferences:
  Open User Settings (JSON) », et ajouter avant l'accolade finale (précédé
  d'une virgule si le fichier contient déjà des réglages) :

```json
"terminal.integrated.profiles.windows": {
  "Anaconda Prompt": {
    "path": "C:\\Windows\\System32\\cmd.exe",
    "args": ["/K", "C:\\ProgramData\\anaconda3\\Scripts\\activate.bat", "C:\\ProgramData\\anaconda3"]
  }
},
"terminal.integrated.defaultProfile.windows": "Anaconda Prompt"
```

Les deux chemins sont ceux de la cible du raccourci « Anaconda Prompt »
(clic droit, Propriétés) ; les doubles barres obliques inverses sont la
syntaxe JSON. Enregistrer, puis menu Terminal, Nouveau terminal : l'onglet
s'appelle « Anaconda Prompt » et l'invite commence par `(base)`. Si rien ne
change, palette, « Developer: Reload Window ». Variante plus courte, quand
`conda` répond déjà dans un `cmd` ordinaire du poste :
`"terminal.integrated.defaultProfile.windows": "Command Prompt"`. Sous macOS
et Linux, rien de tout cela : le terminal par défaut active sans problème.

(dep-v6)=
### V6. « Python: Select Interpreter » ne propose pas Anaconda

Ce qu'on voit
: La liste ne contient que « Enter interpreter path… », ou des Python qui
  ne sont pas celui d'Anaconda (`C:\Python27`, le Python du Microsoft
  Store).

Cause
: L'extension cherche conda dans le `PATH`, le registre, les emplacements
  habituels et `environments.txt` ; sur les postes de la salle, aucune de
  ces sources ne le désigne forcément.

Vérifier
: Panneau Output, canal « Python » (ou « Python Environments »), chercher
  `conda`. Avec l'extension Python Environments, l'icône Python de la barre
  d'activité liste ce qui a été trouvé.

Remède
: Le plus direct : « Enter interpreter path… », puis « Find… », et choisir
  `C:\ProgramData\anaconda3\python.exe`. Plus durable : réglage User
  `python.condaPath` avec `C:\ProgramData\anaconda3\Scripts\conda.exe`, puis
  « Developer: Reload Window » ; `base` et les environnements du compte
  apparaissent alors dans la liste. Le chemin exact est celui du raccourci
  Anaconda Prompt ({ref}`A1 <dep-a1>`).

(dep-v7)=
### V7. `python` lance un autre Python que celui d'Anaconda

Ce qu'on voit
: `Python n'a pas été trouvé ; exécutez sans arguments pour l'installer à
  partir du Microsoft Store…`, ou une invite `Python 2.7`, ou
  `ModuleNotFoundError` sur un module qui est pourtant dans `base`.

Cause
: Sans environnement activé ({ref}`A3 <dep-a3>`), `python` est le premier
  `python.exe` du `PATH` : sur un poste Windows, c'est souvent l'alias du
  Store (`%LOCALAPPDATA%\Microsoft\WindowsApps\python.exe`, qui ne fait que
  proposer une installation), ou un vieux Python de l'image.

Vérifier
: `where python` liste tous les `python.exe` du `PATH`, dans l'ordre ;
  `python -c "import sys; print(sys.executable)"` dit lequel répond.

Remède
: Activer l'environnement ({ref}`A3 <dep-a3>`, {ref}`V5 <dep-v5>`). Le
  bouton Run de VS Code n'est pas concerné : il lance l'interpréteur choisi
  par son chemin complet. Sur un ordinateur personnel, l'alias du Store se
  désactive dans Paramètres, Applications, Paramètres avancés des
  applications, Alias d'exécution d'application (`python.exe`,
  `python3.exe`).

(dep-v8)=
### V8. `ModuleNotFoundError` alors que le paquet est installé

Ce qu'on voit
: `ModuleNotFoundError: No module named 'pandas'` (ou un autre), alors que
  `conda install` ou `conda list` dit que le paquet est là.

Cause
: Il est là dans un environnement, et le programme tourne dans un autre.
  Trois endroits choisissent l'environnement, et ils peuvent différer :
  l'interpréteur de VS Code (bouton Run), le terminal (ce qui est activé),
  le noyau du notebook.

Vérifier
: Dans chacun, `import sys; print(sys.executable)` : les chemins doivent
  être identiques. `conda list -n <env> <paquet>` dit dans quel
  environnement le paquet est.

Remède
: Aligner les trois sur le même environnement ({ref}`V6 <dep-v6>`,
  {ref}`V5 <dep-v5>`, {ref}`J4 <dep-j4>`), ou installer le paquet dans
  celui qui tourne : `conda install -n <env> -c conda-forge <paquet>`.

(dep-v9)=
### V9. Le raccourci du terminal ne répond pas

Ce qu'on voit
: `Ctrl` + `ù` n'ouvre rien, ou ouvre autre chose.

Cause
: Le raccourci dépend de la disposition du clavier (`Ctrl` + `` ` `` sur
  un clavier américain), et le poste n'a pas forcément celle attendue.

Remède
: Menu Terminal, Nouveau terminal ; ou palette, « Terminal: Create New
  Terminal ». La palette elle-même s'ouvre par `Ctrl` + `Maj` + `P` ou
  `F1`.

(dep-v10)=
### V10. `settings.json` refuse d'enregistrer, ou les réglages sont ignorés

Ce qu'on voit
: « Unable to write into user settings. Please open the user settings to
  correct errors/warnings in it and try again », ou un réglage ajouté qui
  ne produit rien, avec une ligne soulignée en rouge dans le fichier.

Cause
: Une erreur de syntaxe JSON : virgule manquante entre deux réglages,
  virgule en trop avant l'accolade finale, guillemet ou barre oblique
  inverse simple dans un chemin.

Vérifier
: Palette, « Preferences: Open User Settings (JSON) » ; le panneau Problems
  (`Ctrl` + `Maj` + `M`) indique la ligne.

Remède
: Corriger la ligne indiquée : chaque réglage est séparé du suivant par une
  virgule, le dernier n'en a pas, et les chemins Windows s'écrivent avec
  `\\`. En cas de doute, faire le réglage dans l'interface (palette,
  « Preferences: Open Settings (UI) »), qui écrit le JSON elle-même.

(dep-jupyter)=
## Jupyter et notebooks

(dep-j1)=
### J1. « Select Kernel » ne propose pas l'environnement

Ce qu'on voit
: Le bouton en haut à droite du notebook n'offre que « Select Another
  Kernel… », ou une liste sans `base` ni l'environnement attendu.

Cause
: Le premier niveau du sélecteur ne montre que les noyaux déjà employés.
  Les environnements Python sont sous « Python Environments… », et cette
  liste vient de l'extension Python : si elle ne trouve pas conda
  ({ref}`V6 <dep-v6>`), Jupyter ne le trouve pas non plus. Un dossier non
  approuvé ({ref}`V4 <dep-v4>`) a le même effet.

Vérifier
: « Python: Select Interpreter » sur un fichier `.py` du même dossier :
  l'environnement y est-il ?

Remède
: « Select Another Kernel… », puis « Python Environments… ». Si la liste est
  vide, attendre dix secondes (la découverte n'est pas finie), ou palette,
  « Python Environments: Refresh Environment Managers », puis rouvrir le
  sélecteur. Si l'environnement n'est proposé nulle part : {ref}`V6 <dep-v6>`,
  puis vérifier que `jupyter.kernels.excludePythonEnvironments` ne l'exclut
  pas.

(dep-j2)=
### J2. VS Code propose d'installer `ipykernel`

Ce qu'on voit
: « Running cells with '<env>' requires the ipykernel package », avec un
  bouton Install.

Cause
: Le noyau d'un notebook est le paquet `ipykernel`, installé dans
  l'environnement qui exécute. `base` l'a ; un environnement créé au TD 4a
  ne l'a que si on l'y a mis.

Remède
: Dans son propre environnement, accepter : VS Code tape la commande dans
  un terminal, qu'on peut lire ; ou la taper soi-même, `conda install -n
  <env> -c conda-forge ipykernel`. Si la proposition concerne `base` sur un
  poste de la salle, l'installation échouera ({ref}`A8 <dep-a8>`) et c'est
  que le noyau choisi n'est pas celui qu'on croit : rouvrir le sélecteur
  ({ref}`J1 <dep-j1>`).

(dep-j3)=
### J3. Le noyau ne démarre pas, ou s'arrête

Ce qu'on voit
: La cellule reste sur `[*]` sans fin ; ou « Kernel died », « Failed to
  start the Kernel », « timed out waiting for kernel to be ready ».

Cause
: Sur une machine virtuelle lente, le premier démarrage d'un noyau dépasse
  parfois le délai prévu. Sinon, l'environnement choisi n'existe plus
  ({ref}`A11 <dep-a11>`), ou une cellule précédente a fait tomber le
  processus (boucle sans fin, mémoire).

Vérifier
: Panneau Output, canal « Jupyter », les lignes qui suivent
  `ipykernel_launcher`.

Remède
: Relancer une fois (bouton Restart). Si l'erreur cite `conda run` ou un
  chemin qui n'existe pas, rechoisir le noyau ({ref}`J1 <dep-j1>`). Une
  cellule qui ne finit pas s'interrompt par le bouton Interrupt, puis
  Restart.

(dep-j4)=
### J4. Le notebook n'exécute pas le Python attendu

Ce qu'on voit
: `import sys; print(sys.executable)` dans une cellule affiche un autre
  chemin que l'Anaconda Prompt ou le terminal de VS Code ; un `import`
  échoue dans le notebook et réussit dans le terminal.

Cause
: Le noyau du notebook est choisi séparément de l'interpréteur des
  fichiers `.py` et du terminal ({ref}`V8 <dep-v8>`) ; c'est le sujet du TD
  4b.

Remède
: Bouton du noyau en haut à droite, choisir l'environnement voulu, puis
  « Restart » et réexécuter depuis le début (« Run All ») : l'ordre
  d'exécution des cellules compte, pas leur ordre d'affichage.

(dep-j5)=
### J5. JupyterLab lancé depuis Navigator ou le terminal n'ouvre aucune page

Ce qu'on voit
: Une fenêtre noire défile et s'arrête sur des lignes `http://localhost:8888/lab?token=…`,
  mais aucun navigateur ne s'ouvre, ou une page vide.

Cause
: JupyterLab est un serveur local ; c'est le navigateur par défaut qui doit
  s'ouvrir sur son adresse, et sur les postes de la salle il n'y en a pas
  forcément un d'associé.

Remède
: Copier l'adresse complète, avec le `token`, de la fenêtre noire vers
  Firefox. Ne pas fermer la fenêtre noire tant qu'on travaille (c'est le
  serveur) ; `Ctrl` + `C` dedans l'arrête. Le module fait les notebooks dans
  VS Code, qui n'a pas besoin de ce serveur.

(dep-git)=
## git

À compléter après la séance 2, avec les messages réellement rencontrés.

(dep-g1)=
### G1. `git` n'est pas reconnu

Ce qu'on voit
: `'git' n'est pas reconnu en tant que commande interne ou externe` ; dans
  VS Code, « Git not found. Install it or configure it using the 'git.path'
  setting ».

Vérifier
: `dir "C:\Program Files\Git\cmd\git.exe"` et `dir
  "%LOCALAPPDATA%\Programs\Git\cmd\git.exe"` dans un `cmd`.

Remède
: Si l'un existe, l'ajouter au `PATH` du compte (Paramètres, « Modifier
  les variables d'environnement pour votre compte », variable `Path`,
  ajouter le dossier `cmd`), ou donner son chemin à VS Code dans `git.path`.
  Si aucun n'existe sur un poste de la salle, git s'installe sans droits
  dans un environnement conda : `conda install -n <env> -c conda-forge git`,
  et il répond dans tout terminal où cet environnement est activé. Sur un
  ordinateur personnel, <https://git-scm.com> ; sous Windows, l'installateur
  propose une installation pour le compte seul quand il est lancé sans
  droits d'administrateur.

(dep-g2)=
### G2. « Author identity unknown » au premier commit

Ce qu'on voit
: `Author identity unknown *** Please tell me who you are.`, suivi des deux
  commandes à taper.

Cause
: Chaque commit porte un nom et une adresse, et git ne les invente pas.

Remède
: Une fois par compte :

```
git config --global user.name "Prénom Nom"
git config --global user.email "prenom.nom@exemple.fr"
```

Ils vont dans `%USERPROFILE%\.gitconfig`, donc à refaire sur une machine
réinitialisée ({ref}`R3 <dep-r3>`). `git config --global user.name`, sans
valeur, affiche ce qui est enregistré.

(dep-g3)=
### G3. « LF will be replaced by CRLF »

Ce qu'on voit
: `warning: in the working copy of 'notes.md', LF will be replaced by CRLF
  the next time Git touches it`.

Cause
: Windows termine les lignes par deux caractères (CR LF), macOS et Linux
  par un seul (LF) ; git prévient qu'il convertira. C'est un avertissement,
  pas une erreur, et le commit a bien eu lieu.

Remède
: Rien à faire pour le module. Pour ne plus le voir : `git config --global
  core.autocrlf false` (git garde alors les fins de ligne telles quelles).

(dep-outils-conda)=
## Outils installés par conda

(dep-x1)=
### X1. `pandoc`, `typst`, `magick` ou `ffmpeg` n'est pas reconnu

Ce qu'on voit
: `'pandoc' n'est pas reconnu en tant que commande interne ou externe`,
  alors que `conda install` l'a installé sans erreur.

Cause
: Ces outils sont installés dans un environnement, et ne répondent que
  dans un terminal où cet environnement est activé. Le terminal de VS Code
  active celui de l'interpréteur choisi, pas forcément celui où l'outil
  est.

Vérifier
: `conda list -n <env> pandoc` dit où il est ; `where pandoc` dans le
  terminal dit s'il y est visible.

Remède
: `conda activate <env>` dans le terminal, ou choisir cet environnement
  comme interpréteur dans VS Code ({ref}`V6 <dep-v6>`) et ouvrir un nouveau
  terminal.

(dep-x2)=
### X2. `convert` ne fait pas ce qu'on attend sous Windows

Ce qu'on voit
: `convert image.png image.jpg` répond `Format de lecteur non valide` ou
  une aide sur les systèmes de fichiers.

Cause
: `convert.exe` est un utilitaire de Windows (conversion de disques FAT en
  NTFS), trouvé avant celui d'ImageMagick, dont le nom historique est le
  même.

Remède
: Employer `magick` : `magick image.png image.jpg`. C'est le nom de
  la commande d'ImageMagick 7, et le seul que le module emploie.

(dep-image)=
## Ce qui ne se règle qu'au niveau de l'image

Sur les postes de la salle, plusieurs entrées ci-dessus n'ont qu'un
contournement côté élève. Le remède complet est dans l'image des machines,
et relève du service informatique. Par ordre d'effet sur les séances :

1. Stratégie d'exécution PowerShell fixée à `RemoteSigned` par stratégie
   de groupe : c'est la valeur par défaut de Windows Server, elle n'ouvre
   aucun droit d'installation, et elle supprime {ref}`A7 <dep-a7>` et
   {ref}`V5 <dep-v5>` (VS Code marche alors avec son terminal par défaut).
2. `PATH` système complété par `C:\ProgramData\anaconda3\condabin` :
   `conda` répond dans tout terminal, VS Code le découvre seul
   ({ref}`A2 <dep-a2>`, {ref}`V6 <dep-v6>`).
3. Réseau : autoriser `repo.anaconda.com`, `conda.anaconda.org`,
   `anaconda.cloud`, `anaconda.com`, `api.anaconda.org`,
   `marketplace.visualstudio.com` et `update.code.visualstudio.com`, ou
   faire refuser franchement ces connexions plutôt que les laisser expirer
   ({ref}`A4 <dep-a4>`) ; déclarer le proxy dans
   `C:\ProgramData\anaconda3\.condarc` (`proxy_servers`) et dans les
   variables système `HTTP_PROXY` / `HTTPS_PROXY` ({ref}`R2 <dep-r2>`).
4. Profil par défaut (`C:\Users\Default`) garni des réglages que chaque
   élève refait sinon à chaque session ({ref}`R3 <dep-r3>`) :
   `AppData\Roaming\Code\User\settings.json` avec le profil de terminal et
   `python.condaPath` ; `.anaconda\navigator\anaconda-navigator.ini` avec
   `hide_update_dialog = True` et le mode hors ligne, ou le raccourci
   Navigator retiré du menu Démarrer ({ref}`A4 <dep-a4>`,
   {ref}`A6 <dep-a6>`) ; l'acceptation des conditions conda
   ({ref}`A10 <dep-a10>`), par `conda tos accept` lancé en administrateur
   ou par la variable système `CONDA_PLUGINS_AUTO_ACCEPT_TOS=true`.
5. Persistance des profils ou des machines virtuelles entre deux
   sessions, ce qui règle {ref}`R3 <dep-r3>` et fait payer le démarrage à
   froid de Navigator une seule fois ({ref}`A4 <dep-a4>`) ; à défaut,
   exclusion de `C:\ProgramData\anaconda3` de l'analyse antivirus en temps
   réel, en lecture seule pour les élèves donc à faible risque.
6. Logiciels dans l'image : Notepad++, LibreOffice, Git for Windows,
   et les extensions VS Code `ms-python.python`, `ms-toolsai.jupyter`
   pré-installées dans le profil par défaut ({ref}`O1 <dep-o1>`,
   {ref}`O4 <dep-o4>`, {ref}`G1 <dep-g1>`, {ref}`V3 <dep-v3>`).
7. À plus long terme, une image sans Navigator, avec Miniforge (conda
   configuré sur conda-forge, sans conditions d'utilisation à accepter) et
   VS Code, ce qui correspond à ce que le module enseigne.
