# Exercices — avancés (étudiants rapides)

*Palier « avancé » cohérent, pour ceux qui finissent le cœur. Peut être noté (bonus) ou purement optionnel — **décision à trancher**.*

---

## AV1 — Petit outil Python de templating de CV (anonymisation) ⭐

Prolonge EX3. Enseigne concrètement **séparer données et présentation** via un payoff discutable (CV anonyme = pratique réelle de lutte contre les biais à l'embauche en France).

- **Structure minimale (~30–40 lignes)** :
  - `cv_data.yaml` — contenu structuré (nom, contact, expériences, formation).
  - `template.md.j2` — template Jinja2 avec `{{ }}` et une boucle `{% for %}` sur les expériences.
  - `make_cv.py` — charge le YAML (PyYAML), rend avec Jinja2, sort du Markdown → `pandoc` pour le PDF.
- **`--anonymize`** : redacte les champs identifiants (nom → « Candidat A », école → « École X », photo retirée) **avant** rendu. *Même template, données différentes, sortie différente* : c'est tout l'intérêt, démontré en une commande.
- **`--deanonymize`** : table de correspondance (`{"Candidat A": "Marie Dupont"}`) dans un **fichier séparé non partagé** → miroir des workflows de double-aveugle, intro naturelle à « les secrets dans un fichier à part, jamais en dur ».
- **Référence « vrai outil »** : [RenderCV](https://docs.rendercv.com/) (Python → YAML → Typst → PDF), [JSON Resume](https://jsonresume.org/) — « votre script jouet, en version produit ».

## AV2 — CV en Typst

Typst = balisage comme Markdown mais **programmable** (variables, fonctions, boucles, import de données), compilation rapide, sans la douleur LaTeX.

1. Partir d'un template [Typst Universe](https://typst.app/universe/) : [modern-cv](https://typst.app/universe/package/modern-cv/), [basic-resume](https://typst.app/universe/package/basic-resume/) (ATS-friendly), [neat-cv](https://typst.app/universe/package/neat-cv/). Résultat visuel fort, peu d'effort.
2. **Aller plus loin** : Typst lit nativement un `.yaml`/`.json` et boucle dessus (`yaml("cv_data.yaml")` + `#for`) → reproduire la séparation données/template **sans script externe**. Beau point de comparaison : « version Python+Jinja2 » vs « même idée native en Typst ».
3. **Stretch** : réimplémenter le toggle anonymize/deanonymize en logique Typst.

## AV3 — Signature de commits & durcissement git

- Signer ses commits (SSH/GPG signing) → comprendre le « verified ».
- Explorer `.gitignore` global, hooks pre-commit simples.

## AV4 — Jupyter Book / site MyST navigable

Prolonge l'annexe G. Construire un vrai *book* MyST navigable (install + build + hébergement). Overhead réel → réservé aux avancés.

- Build du site, table des matières, références croisées entre pages d'algorithmes.
- Déploiement (GitHub Pages / CI) en stretch.

## AV5 — Contribution algo enrichie (pont MyST)

Prolonge l'annexe G / le cours d'algo :

- Ajouter une **figure de complexité** mesurée (nb d'opérations vs taille d'entrée, squelette matplotlib fourni).
- Comparer deux algorithmes résolvant le même problème sur la même figure.
- Ancrage géomatique : documenter un plus court chemin (Dijkstra) sur un petit réseau.

---

## Note de scoping

Garder ces exercices comme un **palier parallèle homogène** : un étudiant rapide peut suivre le fil « CV » (EX3 → AV1 → AV2) **ou** le fil « algo/MyST » (annexe G → AV4/AV5), sans obligation de tout faire.
