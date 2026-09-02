# Données — Cours 6 : Forge & git en équipe ; outil « trajectoire » (CM)

_(vide pour l'instant)_

Modèle : [`data/cours1/`](../cours1/) — le dépôt versionne un `make_data.py`
qui **génère** les fichiers de l'exercice, pas les fichiers eux-mêmes
(cf. `.gitignore` à la racine).

Besoins pressentis, d'après le [syllabus](../../syllabus/01_syllabus_v1.md) :

Objectif : maîtriser la forge (remote, push/pull) et branches/merge **en construisant** un petit outil qui calcule des stats sur une trajectoire (CSV/GPX) — les jalons de code *sont* les étapes git.

- **🎓 15′ · Forge** : compte, dépôt distant, `remote`, `clone`, `push`/`pull`.
- **🎓 15′ · Outil trajectoire** : distance totale et **vitesse moyenne** sur une suite de points ; deux comparaisons — boucle vs **numpy** (« Python interprété vs boucle **C** compilée ») et lecture **texte ligne par ligne** vs **binaire d'un bloc**.
- **⌨️ 10′ · numpy** introduit ici comme *ajout de dépendance* à l'env (`conda install numpy`, rappel c3).

**⌨️ ~55′ · Jalons de code = étapes git** (manipulation guidée) sur outils calcul stat gpx:

| Jalon | Code | Étape git |
|------|------|-----------|
| J1 | `load_txt` (lecture ligne par ligne) | `feat/load` → merge |
| J2 | `distance_totale` (boucle, Pythagore) | `feat/distance` → merge |
| J3 | `vitesse_moyenne` | `feat/speed` → merge — **conflit pré-amorcé** résolu ensemble |
| J4 | `distance_np` + `load_npy` (numpy / binaire) | `feat/numpy` → merge |
| J5 | mini-`benchmark()` | `feat/bench` → merge → `push` |

**But / seed** : chaque étudiant a poussé son outil sur la forge et fait ≥1 merge (dont un conflit résolu) ; sème le **TD7** (benchmark en plus gros).
