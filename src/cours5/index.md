---
title: "Séance 5 — Matériel, réseau, SSH et secrets"
---

:::{note} Page à rédiger
Le plan ci-dessous est repris du syllabus (`syllabus/01_syllabus_v1.md`) ; le
déroulé détaillé est dans `syllabus/cours/5_materiel_reseau_ssh/`.
La séance 1 (`src/cours1/`) sert de modèle de mise en forme.
:::

Deux moitiés indépendantes ; la 2ᵉ prépare directement la forge (cours 6).

**A. Matériel, réseau & ordres de grandeur (~1 h) — culture, très haut niveau.**

- **🎓 12′ · Composants d'un PC** : CPU, RAM, disque (SSD/HDD), GPU — rôle de chacun en une phrase.
- **🎓 13′ · Réseau, le minimum** : local vs distant, client ↔ serveur, débit vs latence (motive « pourquoi un `push` est plus lent qu'un `commit` »).
- **🎓 20′ · Ordres de grandeur** (fil rouge de la séance) : temps d'accès (RAM ≪ SSD ≪ réseau), tailles (Ko/Mo/Go/To), coûts ; rendus incarnés par une échelle relative mémorable (« si la RAM = 1 s, le disque = …, le réseau = … »).
- **⌨️ 15′ · Manipulation légère** : comparer la taille d'une même image en png vs jpg (compression → cours 1) ; chronométrer la lecture d'un petit vs gros fichier (→ cours 2).
- **Cohérence** : se raccroche à trois fils déjà vus/à venir — tailles & compression (c.1), timing fichier (c.2), local vs distant (forge, c.6). *(Si un point ne se raccroche pas, tant pis : toutes les notions de base ne sont pas interdépendantes.)*

**B. SSH, clés & secrets (~1 h) — pratique, juste avant la forge.**

- **🎓 20′ · Crypto clé publique/privée**, niveau concept : une paire, publique partagée / privée secrète (analogie cadenas) ; hachage ≠ chiffrement (rappel du SHA de commit, cours 2).
- **⌨️ 25′ · `ssh-keygen`** + ajout de la clé **publique** au compte de la forge (préparation du cours 6).
- **🎓 15′ · Secrets & `.gitignore`** : ne jamais committer clé privée, mot de passe, token ; l'historique public est **permanent**. *(La leçon « secrets » atterrit ici.)*
