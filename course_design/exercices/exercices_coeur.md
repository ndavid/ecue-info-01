# Exercices — cœur

*Exercices de base, à faire par tous. Chacun réutilise et renforce les mêmes outils (répétition volontaire).*

---

## EX1 — Dépôt de notes du cours (fil rouge, faible enjeu)

- **But** : répétition git à faible enjeu tout au long du module.
- **Contenu** : prise de notes du cours en Markdown, dans un dépôt perso, **petits commits chaque séance**.
- **Outils** : IDE, Markdown, `git add/commit`, aperçu Markdown.
- **Livrable** : dépôt avec historique régulier.

## EX2 — README de profil GitHub (première victoire)

- **But** : premier « je commit, je push, ça apparaît en ligne » — payoff rapide avant les concepts git durs.
- **Contenu** : le dépôt spécial `pseudo/pseudo`, quelques lignes Markdown + un badge shields.io.
- **Outils** : forge, push, Markdown.
- **Livrable** : page de profil rendue.

## EX3 — CV en Markdown → PDF (artefact personnel réutilisable) ⭐

- **But** : produire un artefact **réellement utile** (candidatures de stage) tout en pratiquant Markdown + ligne de commande + git + sécurité.
- **Contenu** :
  1. CV en Markdown à partir d'un template ([markdown-cv](https://github.com/tompollard/markdown-cv)).
  2. Rendu PDF **sans LaTeX** : `pandoc cv.md -o cv.pdf --pdf-engine=typst` (binaire unique, Windows-friendly ; cf. annexe H).
  3. **Sécurité** : données perso réelles (adresse, tél, nom complet) dans un fichier **non versionné** (`.gitignore`) ; vérif `git status` / `git check-ignore`. L'historique public est permanent.
  4. Option publication : GitHub Pages.
- **Outils** : Markdown, `pandoc` (CLI), git, `.gitignore`, (SSH pour push).
- **Livrable** : dépôt CV, PDF généré, données perso démontrées comme ignorées.

## EX4 — Liste curatée de la classe via Pull Request (meilleur exercice git) ⭐

- **But** : le meilleur vecteur pour enseigner git collaboratif — **tout le monde édite le même fichier index** → **conflit de merge réel**.
- **Contenu** : dépôt commun amorcé (`awesome-geomatique-outils.md`, tableau Markdown) ; chaque étudiant ajoute une entrée via **branche + PR** ; au moins un conflit à résoudre.
- **Outils** : git branches, forge, PR, résolution de conflit, revue par les pairs.
- **Échauffement ludique** : [Learn Git Branching](https://learngitbranching.js.org/) en amont (cf. annexe I).
- **Variante à évaluer (ne remplace pas l'EX4)** : « livre-jeu » collectif en Markdown via PR (modèle Udacity) — même workflow, plus ludique. À comparer sur prototype, cf. annexe I.
- **Livrable** : PR fusionnée de chaque étudiant, historique du dépôt commun.

## EX5 — Carnet de terrain (ancrage géomatique)

- **But** : donner une raison **non artificielle** de rejouer git dans la durée + ancrage métier.
- **Contenu** : un `.md` par sortie, coordonnées GPS, front-matter YAML, cases à cocher matériel, liens relatifs vers photos ; **commit par sortie**.
- **Outils** : Markdown, YAML front-matter, git.
- **Livrable** : dépôt carnet avec plusieurs entrées horodatées.

---

## Exercices « ligne de commande » courts (échauffement)

- Naviguer une arborescence fournie et retrouver un fichier avec `find`.
- `grep -r` un mot-clé dans son propre dépôt de notes.
- Chaîner `sort` / `grep` / redirection sur un CSV de points → un résultat lisible.
- Chronométrer (`time`) le chargement petit vs gros fichier → discussion ordres de grandeur.
- `curl` vers une API géospatiale publique → observer le JSON.
