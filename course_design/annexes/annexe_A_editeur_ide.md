# Annexe A — Éditeur / IDE (VSCode)

**Durée** : 2–3 h · **Place** : tout au début, **avant** git (sinon le panneau Source Control est une boîte noire).

## Objectif

Rendre l'étudiant à l'aise dans l'IDE au point de ne plus être bloqué par « où est mon fichier », « comment j'ouvre un terminal ». Juste ce qu'il faut, sans transformer « apprendre l'IDE » en détour de plusieurs heures.

## Points à montrer (dans cet ordre)

1. **Dossier = projet, pas fichier = projet.** Ouvrir un *dossier* (racine de travail), pas des fichiers isolés. C'est le mental model dont dépend tout le reste (chemins relatifs, racine du dépôt git, cwd du terminal).
2. **Palette de commandes** (`Ctrl/Cmd+Shift+P`) tôt et souvent — « c'est comme ça qu'on découvre ce que l'IDE sait faire », plutôt que d'apprendre chaque menu.
3. **Terminal intégré** — c'est *le même* shell qu'en autonome, ouvert dans le dossier de travail. C'est le **pont** qui fait de « IDE » et « ligne de commande » une seule compétence.
4. **Explorateur de fichiers** — créer/renommer/déplacer/supprimer ; **afficher les fichiers cachés** (pour que `.gitignore`, `.git/` ne soient pas mystérieux).
5. **Aperçu Markdown** (`Ctrl/Cmd+Shift+V`) — boucle de retour immédiate, rend le bloc Markdown vivant tout de suite.
6. **Extensions** — installer 1–2 en direct (Markdown, GitLens) : l'IDE est extensible ; où trouver l'écosystème ; « installer depuis un éditeur vérifié ».
7. **Panneau Source Control** — **après** quelques commandes git en terminal, présenté comme « mêmes commandes, autre bouton ». Renforce le mental model CLI au lieu de l'occulter.
8. **Fins de ligne / encodage** (LF vs CRLF, UTF-8) — 1 minute : source réelle et récurrente de diffs git bruités, surtout côté Windows.

## Écueils à éviter

- Ne pas énumérer tous les menus. Ne pas faire mémoriser des raccourcis.
- Ne pas introduire le panneau git **avant** le git en ligne de commande.

## Livrable de séance

Un dossier ouvert comme workspace, un `.md` créé et prévisualisé, le terminal intégré ouvert au bon endroit.
