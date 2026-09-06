---
title: "Séance 2 — Ligne de commande et git local"
---

:::{note} Page à rédiger
Le plan ci-dessous est repris du syllabus (`syllabus/01_syllabus_v1.md`) ; le
déroulé détaillé est dans `syllabus/cours/2_cli_git_local/`.
La séance 1 (`src/cours1/`) sert de modèle de mise en forme.
:::

Objectif : lancer des outils au terminal (sans dépendre de l'OS) et versionner son travail en local.

- **🎓 12′ · Modèle mental CLI** : une commande = un programme + des arguments + des options ; GUI vs CLI ; bonnes pratiques (`--help`, `--verbose`).
- **🎓 5′ · Intérêt** : la CLI permet d'**enchaîner et d'automatiser** des étapes (motive le cours 3).
- **⌨️ 13′ · Un outil utile tout de suite** : `pandoc fiche.md -o fiche.pdf --pdf-engine=typst` (conversion de document, sans LaTeX) ; éventuellement une conversion ImageMagick.
- **🎓 20′ · Git local** : les 3 zones (working / staging / repo), `init`/`status`/`add`/`commit`/`log`/`diff`, `.gitignore`, annuler sans peur (`restore`).
- **⌨️ 40′ ·Manipulation guidée** (chaque étudiant en parallèle du tableau) : (TODO : trouver idée de texte à ecrire/modifier)
  1. `git init` dans `notes-info/` (un dépôt = un dossier suivi) ;
  2. écrire les notes du jour en `.md` → `git add`/`commit` (staging → commit) ;
  3. `git status`/`log`/`diff` pour *lire* ce que git dit (démystifier) ;
  4. modifier, revoir le `diff`, re-committer (le diff sur du texte = intérêt des formats du cours 1) ;
  5. `.gitignore` un fichier temporaire ; `restore` d'une modif ratée (moment anti-panique).
- **But de fin de séance** : chaque étudiant a son dépôt de notes (≥3 commits) et a vu `status`/`log`/`diff`/`restore`. Rejoué chaque séance.
