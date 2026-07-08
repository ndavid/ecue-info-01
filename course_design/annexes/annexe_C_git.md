# Annexe C — Git & forge (GitHub/GitLab)

**Durée** : 4–5 h (le **plus gros** poste — c'est le point de blocage n°1 observé). · **Place** : après IDE + shell.

## Objectif

Rendre git **non anxiogène** : faire une modif, la voir suivie, l'annuler sans paniquer. Puis collaborer via une forge. Priorité à la **répétition** du même workflow plutôt qu'à la variété.

## Progression

1. **Pourquoi** : historique, revenir en arrière, collaborer sans s'écraser. Contre-exemple : `cv_final_v2_vraiment_final.docx` par mail.
2. **Git local** : `init`, `status`, `add`, `commit`, `log`, `diff`. Les 3 zones (working / staging / repo).
3. **`.gitignore`** : ne pas versionner ce qu'il ne faut pas (fichiers générés, données perso — lien annexe F). Vérifier avec `git status` / `git check-ignore`.
4. **Annuler sans peur** : `restore`, `checkout` d'un fichier, comprendre ce qui est réversible.
5. **Branches** : créer, basculer, `merge`. **Provoquer un conflit** volontairement et le résoudre (moment clé).
6. **Forge** : compte, dépôt distant, `remote`, `push`/`pull`, `clone`.
7. **Workflow collaboratif** : branche → **Pull/Merge Request** → revue → merge. Sur le **dépôt partagé de classe** (conflit réel car tout le monde édite le même index).

## Répétition intégrée (pas un bloc isolé)

- Notes du cours dans un dépôt perso : petits commits chaque séance.
- CV, liste partagée, carnet de terrain : autant d'occasions de rejouer add/commit/push/PR.

## Aparté « algo caché » (mentionné, pas enseigné)

- Hash de commit (SHA) → **hachage** (et distinguer hash ≠ chiffrement, cf. annexe F).
- `git diff` → algorithme de **diff** (Myers).

## Écueils à éviter

- **Ne pas** partir d'un projet Python complexe (lint + typing + CI) : trop de bruit simultané pour un débutant.
- Éviter `.ipynb` bruts dans git (JSON illisible en diff/merge) — préférer texte brut / MyST (annexe G).
- Ne pas introduire le rebase/l'historique avancé à ce niveau.

## Livrable

Un dépôt perso avec historique propre **et** au moins une PR fusionnée sur le dépôt de classe (avec un conflit résolu).
