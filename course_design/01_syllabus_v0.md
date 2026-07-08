# Syllabus v0 — 3 scénarios au choix

*v0 (2026-07-08). Les 3 scénarios réutilisent les **mêmes blocs** (voir `annexes/`), arrangés différemment. Choisir un scénario, puis affiner.*

## Les blocs de construction (modulaires)

| Bloc | Intitulé | Durée indicative | Annexe |
|------|----------|------------------|--------|
| A | Éditeur / IDE (VSCode) | 2–3 h | `annexe_A_editeur_ide.md` |
| B | Ligne de commande (shell) | 1,5–2 h | `annexe_B_ligne_commande.md` |
| C | Git & forge (GitHub/GitLab) | 4–5 h | `annexe_C_git.md` |
| D | Formats texte (Markdown, YAML/JSON) | 1 h (intégré) | `annexe_D_formats_texte.md` |
| E | Culture informatique | 1,5–2 h | `annexe_E_culture_info.md` |
| F | Sécurité (SSH, clés, secrets) | 1,5 h | `annexe_F_securite.md` |
| G | Pont MyST / algo | variable | `annexe_G_myst_pont_algo.md` |

---

## Scénario A — « Outils d'abord » (git au centre) ⟵ recommandé par défaut

Le plus aligné avec les manques observés. Le plus sûr. Facile à défendre devant les sceptiques.

| # | Séance (2 h) | Contenu | Blocs |
|---|--------------|---------|-------|
| 1 | IDE & fichiers | Workspace = dossier, palette, explorateur, aperçu Markdown | A + D |
| 2 | Ligne de commande | Navigation, pipes/redirection sur un vrai jeu de données | B |
| 3 | Git local | init/add/commit/log/diff, `.gitignore` ; notes du cours en dépôt perso | C |
| 4 | Git branches | branches, merge, **conflit provoqué** | C |
| 5 | Forge + SSH | remote, push/pull, `ssh-keygen`, clé pub/privée | C + F |
| 6 | Projet CV | CV Markdown → PDF (`pandoc`), données perso en `.gitignore` | D + F |
| 7 | Dépôt partagé | liste curatée de la classe via **PR** (conflit réel) | C |
| 8 | Culture info + synthèse | ordres de grandeur, CPU/GPU, client-serveur (API géo live) | E |

**Avantages** : couverture systématique, git bien dosé. **Risque** : peut sembler « scolaire » ; la motivation repose sur la qualité des exemples.

---

## Scénario B — « Projets fil rouge » (artefacts au centre)

Organisé autour de 2–3 artefacts concrets ; les outils sont enseignés **au service** de l'artefact.

| Fil rouge | Séances | Outils mobilisés en chemin |
|-----------|---------|----------------------------|
| **CV Markdown → PDF publié** | 1–3 | IDE, Markdown, ligne de commande (`pandoc`), git local, `.gitignore`/secrets |
| **Dépôt partagé de classe** | 4–6 | git branches, forge, SSH, PR, conflit de merge |
| **Carnet de terrain / notes** | 7–8 | répétition git, YAML front-matter, culture info en aparté |

**Avantages** : très motivant, sens immédiat, artefacts réutilisables. **Risque** : couverture des outils moins systématique — prévoir une **grille de compétences** pour vérifier qu'aucun fondamental n'est oublié.

---

## Scénario C — « Pont vers l'algo » (convergence MyST)

Couplé au cours d'algorithmique parallèle ; culmine sur un dépôt MyST commun illustrant des algorithmes.

| # | Séance | Contenu | Blocs |
|---|--------|---------|-------|
| 1–2 | Fondations | IDE + ligne de commande | A + B |
| 3–4 | Git essentiel | local + branches + conflit | C |
| 5 | Forge + sécurité | remote, SSH, secrets | C + F |
| 6 | Markdown enrichi → MyST | Markdown + MyST (maths, figures, cellules) | D + G |
| 7 | Contribution algo | chaque étudiant documente **1 algo** (déjà codé en algo) en page MyST | G |
| 8 | Agrégation + culture | PR vers dépôt commun, figure complexité, culture info | G + E |

**Avantages** : rend le ROI du module **visible** ; synergie forte entre les deux cours. **Risque** : dépend de la **coordination calendaire** avec le cours d'algo ; MyST/Jupyter Book ajoute de l'overhead (garder le *book* complet en option avancée).

---

## Comparatif express

| Critère | A · Outils d'abord | B · Projets | C · Pont algo |
|---------|:---:|:---:|:---:|
| Couverture systématique des outils | ●●● | ●● | ●● |
| Motivation / sens immédiat | ●● | ●●● | ●●● |
| Facilité à défendre (sceptiques) | ●●● | ●● | ●● |
| Indépendance vis-à-vis du cours d'algo | ●●● | ●●● | ● |
| Effort de préparation | ●● | ●● | ●●● |

**Recommandation** : démarrer sur **Scénario A** (robuste, autonome), en y **greffant la séance 6/7 de B** (CV + dépôt partagé, déjà présentes) et en gardant **C** comme évolution v1 une fois la coordination avec l'algo établie.
