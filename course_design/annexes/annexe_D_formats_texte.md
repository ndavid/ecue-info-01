# Annexe D — Formats texte (Markdown, YAML/JSON)

**Durée** : ~1 h **répartie** (jamais en cours magistral isolé — intégré au CV, au README, à la config).

## Objectif

Comprendre qu'un **fichier texte structuré** sert autant à écrire (Markdown) qu'à configurer (YAML/JSON), et que tous sont **diffables/versionnables** (lien avec git).

## Markdown (intégré au CV + README + notes)

- Titres, listes, liens, images, tableaux, blocs de code, cases à cocher `- [ ]`.
- Aperçu live dans l'IDE (annexe A).
- Débouché concret : `pandoc cv.md -o cv.pdf` (annexe B), README de dépôt, README de profil GitHub.

## YAML / JSON (intégré à la config + données CV)

- JSON introduit **naturellement** via un appel d'API (`curl`/réponse) — pas dans l'abstrait.
- YAML introduit via un fichier de **config** ou les **données du CV** (`cv_data.yaml`).
- Notion clé : **séparer les données de la présentation** (prépare l'outil de templating, annexe exercices avancés).
- Front-matter YAML en tête d'un `.md` (ex. carnet de terrain, page MyST).

## Principe pédagogique

> On n'enseigne pas « voici un langage de balisage » dans le vide — les étudiants décrochent vite. Chaque format apparaît **parce qu'un exercice en a besoin**.

## Écueils à éviter

- Pas de séance dédiée « syntaxe des formats ».
- Ne pas confondre YAML (config lisible) et JSON (échange machine) — montrer le même contenu dans les deux une fois suffit.

## Livrable

Un README de dépôt en Markdown + un fichier de config (YAML ou JSON) réellement utilisé par un exercice.
