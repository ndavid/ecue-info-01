# Annexe F — Sécurité (SSH, clés, secrets)

**Durée** : ~1,5 h **au total**, **rattachée à des exercices existants** (pas un bloc neuf). Tient dans le budget 16 h.

## Objectif

Introduire deux réflexes de sécurité concrets, au moment où l'étudiant en a besoin — pas de la crypto abstraite.

## Volet 1 — SSH & clé publique/privée (~45 min–1 h)

**Rattaché à** : configuration du push vers la forge (annexe C, séance forge).

- **Accroche réelle** : il faut une paire de clés pour pousser sur GitHub/GitLab → besoin ressenti comme point d'entrée.
- **Théorie minimale** : asymétrique vs symétrique (contraste avec un mot de passe/secret partagé qu'ils intuitionnent) ; modèle « je diffuse le cadenas, je garde la clé » ; le serveur stocke la clé **publique**, seule la privée prouve l'identité.
- **Pratique** : `ssh-keygen`, où vivent les clés (`~/.ssh`), permissions de la clé privée (`chmod 600` — rappel des permissions/fichiers cachés de l'annexe B), ajout de la clé publique sur la forge, test `ssh -T git@github.com`. Choix HTTPS+token vs SSH.
- **Distinguer** hachage (SHA des commits, annexe C) ≠ chiffrement ≠ signature. Une phrase.
- **Stretch (mention only)** : signature de commits (« pourquoi certains commits sont *verified* »).

## Volet 2 — Protéger les infos privées dans git (~30–45 min)

**Rattaché à** : exercice CV (annexe exercices).

- **Mental model clé** : l'historique d'un dépôt public est **lisible pour toujours** ; « supprimer » un fichier dans un commit ultérieur ne l'efface **pas** de l'historique.
- **Synergie CV** : le vrai fichier de données perso (adresse, téléphone, nom complet) = l'exemple concret de « à ne jamais commiter » → `.gitignore`, vérif `git status` / `git check-ignore`. Seul le rendu **anonymisé**/template est versionné.
- **Pointeur vers l'avant (mention only)** : le *secret scanning* des forges ; « si tu fuites un secret, **révoque-le/renouvelle-le**, ne te contente pas de supprimer le commit ».

## Écueils à éviter

- Ne pas plonger dans `git filter-repo` / BFG (réécriture d'historique) à ce niveau.
- Ne pas faire un cours de cryptographie : rester sur le modèle mental + la manip utile.

## Livrable

Une paire de clés SSH fonctionnelle (push OK) + un dépôt CV où les données perso sont bien ignorées (démontré via `git status`).
