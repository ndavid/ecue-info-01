---
title: FAQ
subtitle: Partir de ce qu'on voit à l'écran, et trouver l'entrée de dépannage qui correspond
---

Chaque ligne décrit une situation avec les mots qu'on emploie pour la
raconter, et renvoie à l'entrée du [dépannage](depannage.md) qui la traite.
Quand plusieurs entrées sont citées, lire la première en premier : elle
renvoie aux autres si besoin. Si rien ne correspond, relever le message
exact et le terminal où il apparaît (section « Lire un message d'erreur » du
dépannage) avant de demander de l'aide.

## Réseau, session, droits

| Ce qu'on voit | Entrée |
|---|---|
| Le navigateur ouvre une page de connexion, ou aucune page ne charge | {ref}`R1 <dep-r1>` |
| `conda` dit `CONNECTION FAILED` ; le panneau Extensions de VS Code est vide | {ref}`R1 <dep-r1>`, {ref}`R2 <dep-r2>` |
| Ça marchait au début de la séance, plus maintenant | {ref}`R1 <dep-r1>` |
| Les pages web s'ouvrent, mais conda ou VS Code n'atteignent rien (`407`, `SSL`, `ProxyError`) | {ref}`R2 <dep-r2>` |
| Mes réglages, mon extension, mon environnement de la semaine dernière ont disparu | {ref}`R3 <dep-r3>` |
| On me demande un mot de passe d'administrateur | {ref}`R4 <dep-r4>` |
| Je voudrais savoir ce que je peux installer ou modifier sur le poste | {ref}`R4 <dep-r4>` |

## Bloc-notes, Notepad++, explorateur, LibreOffice

| Ce qu'on voit | Entrée |
|---|---|
| Je ne trouve pas le Bloc-notes, ou Notepad++ | {ref}`O1 <dep-o1>` |
| Les fichiers n'ont pas d'extension dans l'explorateur ; mon fichier renommé s'appelle `x.donnees.txt` | {ref}`O2 <dep-o2>` |
| Je ne vois pas les dossiers `.git`, `.vscode`, `AppData` | {ref}`O2 <dep-o2>` |
| Au double-clic, Windows me demande avec quoi ouvrir le fichier | {ref}`O3 <dep-o3>` |
| LibreOffice n'est pas là, ou l'export en PDF ne se fait pas | {ref}`O4 <dep-o4>` |

## Anaconda Prompt, conda, Navigator

| Ce qu'on voit | Entrée |
|---|---|
| « Anaconda Prompt » n'est pas dans le menu Démarrer | {ref}`A1 <dep-a1>` |
| `'conda' n'est pas reconnu en tant que commande interne ou externe` | {ref}`A2 <dep-a2>` |
| `CommandNotFoundError: Your shell has not been properly configured to use 'conda activate'` | {ref}`A2 <dep-a2>` |
| L'invite du terminal ne commence pas par `(base)` | {ref}`A3 <dep-a3>` |
| Je clique sur Anaconda Navigator et rien ne se passe pendant des minutes | {ref}`A4 <dep-a4>` |
| Navigator affiche « offline mode » | {ref}`A4 <dep-a4>` |
| « There is an instance of Anaconda Navigator already running », sans fenêtre | {ref}`A5 <dep-a5>` |
| Navigator veut se mettre à jour, ou reste sur « updating packages » | {ref}`A6 <dep-a6>` |
| `… activate.ps1 cannot be loaded because running scripts is disabled on this system` | {ref}`A7 <dep-a7>` |
| Même message pour `conda-hook.ps1` ou `profile.ps1` | {ref}`A7 <dep-a7>` |
| `EnvironmentNotWritableError` à `conda install` | {ref}`A8 <dep-a8>` |
| `CondaHTTPError`, ou « Solving environment » qui tourne des minutes | {ref}`A9 <dep-a9>` |
| `CondaToSNonInteractiveError`, ou une question `[(a)ccept/(r)eject/(v)iew]` | {ref}`A10 <dep-a10>` |
| Mon environnement créé n'apparaît pas dans VS Code, Navigator, ou `conda env list` | {ref}`A11 <dep-a11>` |

## VS Code

| Ce qu'on voit | Entrée |
|---|---|
| Je ne trouve pas VS Code sur le poste | {ref}`V1 <dep-v1>` |
| VS Code marche depuis Navigator mais pas depuis le bureau, ou l'inverse | {ref}`V2 <dep-v2>` |
| L'extension Python ne s'installe pas ; « We cannot connect to the Extensions Marketplace » | {ref}`V3 <dep-v3>` |
| « Restricted Mode » dans la barre d'état ; « Select Interpreter » absent de la palette | {ref}`V4 <dep-v4>` |
| Le terminal de VS Code affiche une erreur dès qu'il s'ouvre | {ref}`V5 <dep-v5>` |
| Je dois recopier le réglage du terminal (profil « Anaconda Prompt ») | {ref}`V5 <dep-v5>` |
| « Python: Select Interpreter » ne propose pas Anaconda | {ref}`V6 <dep-v6>` |
| `Python n'a pas été trouvé ; exécutez sans arguments pour l'installer à partir du Microsoft Store` | {ref}`V7 <dep-v7>` |
| `python` lance Python 2.7, ou un autre Python que celui d'Anaconda | {ref}`V7 <dep-v7>` |
| `ModuleNotFoundError` alors que le paquet est installé | {ref}`V8 <dep-v8>` |
| `Ctrl` + `ù` n'ouvre pas le terminal | {ref}`V9 <dep-v9>` |
| « Unable to write into user settings » ; un réglage ajouté ne fait rien | {ref}`V10 <dep-v10>` |

## Notebooks

| Ce qu'on voit | Entrée |
|---|---|
| « Select Kernel » ne propose pas mon environnement | {ref}`J1 <dep-j1>` |
| « Running cells with … requires the ipykernel package » | {ref}`J2 <dep-j2>` |
| La cellule reste sur `[*]` ; « Kernel died » ; « Failed to start the Kernel » | {ref}`J3 <dep-j3>` |
| `sys.executable` dans le notebook n'est pas le même que dans le terminal | {ref}`J4 <dep-j4>` |
| Un `import` réussit dans le terminal et échoue dans le notebook | {ref}`J4 <dep-j4>`, {ref}`V8 <dep-v8>` |
| JupyterLab affiche une adresse `localhost:8888` mais aucune page ne s'ouvre | {ref}`J5 <dep-j5>` |

## git (séance 2)

| Ce qu'on voit | Entrée |
|---|---|
| `'git' n'est pas reconnu` ; VS Code dit « Git not found » | {ref}`G1 <dep-g1>` |
| `Author identity unknown` au premier commit | {ref}`G2 <dep-g2>` |
| `warning: … LF will be replaced by CRLF` | {ref}`G3 <dep-g3>` |

## pandoc, typst, ImageMagick, ffmpeg

| Ce qu'on voit | Entrée |
|---|---|
| `'pandoc' n'est pas reconnu` (ou `typst`, `magick`, `ffmpeg`) après un `conda install` réussi | {ref}`X1 <dep-x1>` |
| `convert` parle de disques ou de systèmes de fichiers | {ref}`X2 <dep-x2>` |
