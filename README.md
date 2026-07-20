# Cours d'introduction à l'informatique (bac+2, 14 h)

École d'ingénieurs (géomatique), 1re année, profils variés (prépa littéraire ou scientifique).
Module d'**infrastructure de travail** (outils + concepts génériques) complémentaire du cours d'algo/programmation parallèle.

## Structure du dépôt

| Élément | Rôle |
|---------|------|
| [`01_syllabus_v1.md`](01_syllabus_v1.md) | **Document de référence** : vue d'ensemble des 7 séances (tableau + description courte + découpage temps). |
| `cours/<n>_.../` | Détail par séance : `contenu_detaille.md` (déroulé fin) + `exercices_complementaires.md`. |

*(Cours 1 rempli comme gabarit ; cours 2–7 à détailler.)*

## Décisions de conception (le « pourquoi »)

- **Ancrage géomatique léger, sans prérequis** : les exemples peuvent parler au métier (points, coordonnées, distance = Pythagore) mais n'exigent **jamais** une notion pas encore vue (pas d'API *live*, pas de Dijkstra).
- **Environnement = conda/conda-forge** : sert à *installer les outils* (ffmpeg, imagemagick, pandoc, typst, numpy, Pillow) de façon reproductible et cross-platform — pas à packager. Commandes fournies + testées.
- **Pas de navigation shell** (`ls`/`cd`/`rm`) : trop dépendante de l'OS (Windows) ; la manipulation de fichiers se fait en Python (`pathlib`).
- **Git enseigné par répétition à faible enjeu** (dépôt de notes) puis appliqué (TD4 animation, c6 trajectoire, TD7 benchmark).
- **TD collaboratif = parallèle, sans merge séquentiel** : dépôt **individuel** (GitHub Classroom), PR + **conflit pré-amorcé** (branche fournie) + **revue round-robin**. La vraie collaboration multi-élèves est séquentielle → on la remplace par un conflit *mis en scène*, résolu par chacun en parallèle. Réussite ≠ « mergé dans un main partagé ».
- **Fiche perso / CV écartée** comme TD (livrable trop léger en semaine 3) ; la leçon secrets/`.gitignore` est portée par le cours 5B.
- **Deux TD** : séance 4 = studio d'animation (subprocess + ImageMagick + ffmpeg) ; séance 7 = capstone benchmark image (boucle vs numpy, « Python pur vs call C »), rapport markdown.

## Conventions

- Chaque séance ≈ **120 min** ; parties notées **🎓 exposé** ou **⌨️ manipulation** + durée indicative.
- CM = cours (exposé + manipulation), TD = travaux dirigés.

## Reste à faire

- Détailler `cours/2..7` (contenu + exercices) sur le gabarit du cours 1.
- Dépôts-squelettes réels : TD4 (studio animation), TD7 (benchmark image + branche `conflit-rapport`), outil trajectoire (c6).
- Recaler le calendrier (dates) si besoin.
