---
title: Tester le réseau
---

:::{warning}
**Tester et configurer la session réseau avant tout le reste.**

Sur les postes de la salle, l'accès à Internet demande une authentification.
Certains outils du module, comme Anaconda Navigator ou VS Code, ont besoin
du réseau : pour installer une extension, ou au lancement, pour chercher des
mises à jour. Sans réseau, leur lancement peut être long, et leur
configuration peut échouer une fois lancés.
:::

## Ouvrir la session réseau

1. Sur le bureau, double-cliquer sur le raccourci [à compléter : nom exact
   du raccourci]. Firefox s'ouvre sur une page de connexion.
2. Entrer ses identifiants.
3. La session dure [à compléter : durée]. Après ce délai, les
   téléchargements échouent de nouveau : refaire les étapes 1 et 2.

## Vérifier

### Dans Firefox

Ouvrir <https://code.visualstudio.com>. La page doit s'afficher. Sinon :
{ref}`R1 <dep-r1>`.

### Dans un terminal

Un terminal est une fenêtre dans laquelle on tape une commande, puis
Entrée. La ligne qui attend une commande s'appelle l'invite. Windows a deux
terminaux : `cmd`, l'invite de commandes, et PowerShell. Le test est le même
dans les deux ; seul l'aspect de l'invite change.

::::{tab-set}

:::{tab-item} cmd
Menu Démarrer, taper `cmd`, Entrée. L'invite se termine par `>`. Taper la
commande, puis Entrée :

```
C:\Users\eleve>curl.exe -sS -I -m 10 https://repo.anaconda.com
HTTP/2 200
date: Sat, 19 Sep 2026 20:49:25 GMT
content-type: text/html
…
```
:::

:::{tab-item} PowerShell
Menu Démarrer, taper `powershell`, Entrée. L'invite commence par `PS`.
Taper la commande, puis Entrée :

```
PS C:\Users\eleve> curl.exe -sS -I -m 10 https://repo.anaconda.com
HTTP/2 200
date: Sat, 19 Sep 2026 20:49:25 GMT
content-type: text/html
…
```

Écrire `curl.exe` avec son extension. Dans PowerShell, `curl` sans
extension désigne une autre commande, qui n'a pas les mêmes options.
:::

::::

La commande et ses options :

- `curl.exe` : un programme de Windows qui contacte un serveur ;
- `-sS` : n'affiche que la réponse, ou l'erreur ;
- `-I` : ne demande que l'en-tête de la page, pas son contenu ;
- `-m 10` : attend au plus dix secondes ;
- `https://repo.anaconda.com` : le serveur des paquets d'Anaconda.

Ce qu'on doit voir : une première ligne `HTTP/2 200` (ou `HTTP/1.1 200`).
Seule cette ligne compte ; celles qui suivent décrivent la page.

Quand la session réseau n'est pas ouverte, la réponse est une seule ligne,
immédiate ou après dix secondes :

```
curl: (6) Could not resolve host: repo.anaconda.com
```

```
curl: (28) Connection timed out after 10002 milliseconds
```

Dans les deux cas, ouvrir la session réseau et retaper la commande. Toute
autre réponse (`407`, une erreur de certificat) : {ref}`R2 <dep-r2>`.
