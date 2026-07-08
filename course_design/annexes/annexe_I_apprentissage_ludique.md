# Annexe I — Apprentissage ludique (git & Markdown, cross-platform)

*Le ludique doit vivre là où le cours vit : **git et Markdown**, pas dans du traitement de texte shell unix (les idées grep/Wordle ont été écartées : non portables Windows, niveau shell trop avancé). Tout ici est **cross-platform** et **niveau débutant**.*

## Jeux pour apprendre git

| Ressource | Type | Rôle proposé | Lien |
|-----------|------|--------------|------|
| **Learn Git Branching** | Jeu **navigateur**, 0 install | ✅ **Cœur — échauffement** avant/pendant le bloc git : 50+ niveaux visuels, on tape de vraies commandes, diagrammes de branches animés. Cross-platform total. | https://learngitbranching.js.org/ |
| **Oh My Git!** | Jeu **desktop** open-source | ✅ **Bonus** : binaires **Windows/mac/Linux**, cartes = commandes git, visualisation live commits/branches/remotes. Bon pour débutants. | https://ohmygit.org/ · https://github.com/git-learning-game/oh-my-git |

**Intégration** : Learn Git Branching en amont de l'annexe C (débloque le mental model branches/merge de façon ludique, sans risque sur un vrai dépôt). Oh My Git! proposé en autonomie pour ceux qui veulent s'entraîner davantage.

## Écriture collaborative ludique en Markdown

> ⚠️ **Statut : référence à évaluer** — **ne remplace pas l'EX4** (liste curatée). Gardé ici comme piste alternative/complémentaire, à trancher après avoir vu un exemple concret.

| Ressource | Intérêt | Lien |
|-----------|---------|------|
| **Udacity — create-your-own-adventure** | Dépôt Markdown conçu **pour enseigner la Pull Request** : « livre dont vous êtes le héros » écrit à plusieurs, un fragment à la fois, liens Markdown entre pages. Même workflow branche+PR+conflit que l'EX4, en plus ludique. Cross-platform, débutant. | https://github.com/udacity/create-your-own-adventure |
| **Twine / Twee2** | Fiction interactive ; Twee2 = fichiers texte versionnables (git-friendly), Twine = éditeur visuel. | https://dan-q.github.io/twee2/ |
| **Adventure / Fractive / Ficdown** | Moteurs « livre-jeu » pilotés par Markdown → générer un HTML jouable. Palier avancé. | https://github.com/Ubersmake/Adventure · https://github.com/rudism/Ficdown |

**Idée maîtresse (à évaluer)** : un **livre-jeu collectif de la classe en Markdown, construit via Pull Requests** (modèle Udacity). Chaque étudiant écrit un embranchement et l'ajoute par PR. Même valeur pédagogique git que l'EX4, format plus motivant, 100 % cross-platform.

**Décision en attente** : conserver la **liste curatée (EX4)** comme exercice de référence, et **comparer** avec la variante livre-jeu sur un prototype avant d'arbitrer (ou proposer les deux au choix de l'enseignant).

## Ce qui a été écarté (traçabilité)

- **Wordle via `grep`/regex sur `/usr/share/dict/words`**, pipelines `awk`/`sed` : unix-centrés, absents/pénibles sous Windows, au-dessus du niveau CLI visé par le cours. Non retenus.
