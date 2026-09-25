# Données — Cours 7 : Recap tout : benchmark image + rapport (PR)

| Dossier | Ce que c'est |
|---|---|
| `7b_train/` | le TD 7b, deux effets pour le programme du TD 4c (la fenêtre du train) : `poteaux`, puis `parallaxe` ; conception dans `syllabus/cours/7_projet_effets/variante_train.md` |
| `corriges/7b_train/` | le programme `train.py` avec les deux effets, le test et le chronométrage, testés |
| `make_data.py` | `build` remplit `7b_train/produit/depart/` (une image de la série du TD 4c, deux images du décor) |

```bash
conda activate info01
python make_data.py build
python ../../outils/construire_notebooks.py
python ../../outils/compiler_guides.py --cours 7
```

Le TD 7a (les quatre effets communs aux TD 4a, 4b et 4c) n'est pas encore
écrit : voir `syllabus/cours/7_projet_effets/contenu_detaille.md`. La suite
de ce fichier décrit le projet 7 du syllabus v1.

Modèle : [`data/cours1/`](../cours1/) — le dépôt versionne un `make_data.py`
qui **génère** les fichiers de l'exercice, pas les fichiers eux-mêmes
(cf. `.gitignore` à la racine).

Besoins pressentis, d'après le [syllabus](../../syllabus/01_syllabus_v1.md) :

Objectif : appliquer numpy + le workflow **Pull Request** sur un benchmark **image** 2D, et produire un **rapport markdown**. Dépôt **individuel** (GitHub Classroom) → aucun merge séquentiel entre élèves.

*Découpage ≈ 120 min : 🎓 ~15′ cadrage + ⌨️ ~95′ implémentation & PR + ~10′ mise en commun.*

- **Noyau (plancher, tous)** : niveaux de gris = **moyenne des 3 canaux** — version **boucle** sur les pixels vs version **numpy** vectorisée ; chronométrer → speedup ×100-1000 (« Python pur vs call C » à l'échelle 2D).
- **Plafond** : flou = moyenne d'un voisinage (moving average 2D) ; accès **ligne vs colonne** (cache, c5) ; lecture PNG vs `.npy`.
- **Étapes git (features à implémenter)** :
  1. `git clone` de son dépôt (squelette : loader, chrono `timed()`, image de référence, `RAPPORT.md` gabarit) ;
  2. `git switch -c feat/grayscale` → coder `gris_boucle` puis `gris_numpy` (commits jalons) → `push` ;
  3. **ouvrir la PR** (titre + « ce que je mesure ») ;
  4. **conflit via branche pré-amorcée** : merger la branche `conflit-rapport` fournie (elle touche l'en-tête de `RAPPORT.md`) → résoudre les marqueurs `<<<<<<<` ;
  5. **revue round-robin** : commenter la PR d'un pair assigné (N relit N+1) — parallèle, sans dépendance ;
  6. **merger sa propre PR** ; l'autograder vérifie `gris_numpy` vs référence.
- **Livrable** : PR mergée + conflit résolu + `RAPPORT.md` (image avant/après, tableau de temps, 1 phrase d'interprétation par comparaison) + une revue laissée.
- **Robustesse** : squelette fourni ; plancher = 1 ligne (`img.mean(axis=2)`) réussissable par tous ; médiane de N essais, « on lit des *ratios*, pas des chiffres exacts » ; `Pillow` + `numpy` via conda-forge ; **une seule** PR (jalons = commits) pour tenir en 2 h.

---
