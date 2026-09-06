---
title: "Séance 4 — Studio d'automatisation (animation vidéo)"
---

:::{note} Page à rédiger
Le plan ci-dessous est repris du syllabus (`syllabus/01_syllabus_v1.md`) ; le
déroulé détaillé est dans `syllabus/cours/4_td_animation/`.
La séance 1 (`src/cours1/`) sert de modèle de mise en forme.
:::

Objectif : appliquer `subprocess`/`argparse` (cours 3) et git local en produisant une **courte vidéo animée** — l'orchestration d'outils, pas de la programmation compliquée.

*Découpage ≈ 120 min : 🎓 ~15′ cadrage (démo du pipeline) + ⌨️ ~95′ réalisation + ~10′ mise en commun.*

- **Réalisation** : une CLI Python qui anime un objet simple (forme qui tourne / se déplace, orbite, aiguille d'horloge…).
- **Pipeline** : config keyframes → Python interpole/positionne → **ImageMagick** dessine les frames → **ffmpeg** assemble + incruste un texte.
- **Maths mobilisées (optionnel selon profil)** : rotation 2D (matrice), interpolation `lerp = (1−t)·a + t·b` (= moyenne pondérée → pont vecteurs/stats).
- **CLI** : `argparse` avec sous-commandes (`render`/`preview`/`clean`), `--verbose`.
- **git appliqué** : commits par étape du pipeline ; `.gitignore` des frames et de la vidéo générées (on ne versionne pas les binaires).
- **Différenciation** : *plancher* — câbler la chaîne, changer couleurs/texte/keyframes ; *plafond* — écrire soi-même la matrice de rotation, easing non-linéaire, 2ᵉ objet, stat incrustée.
- **Livrable** : un court `.mp4` + le dépôt (CLI, config, README du pipeline) à l'historique propre.
- **Pré-requis pratique** : env conda prêt + dépôt-squelette fourni (sinon l'installation mange la séance).
