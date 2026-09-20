# Contenu détaillé — Cours 5 : Matériel, réseau, clés SSH et secrets

Vue d'ensemble : [../../01_syllabus_v1.md](../../01_syllabus_v1.md) (section « Cours 5 »).

**Supports** : [`src/cours5/diapo/`](../../../src/cours5/diapo/) (typst, 37 diapositives d'exposé hors TD ; `--input notes=true` pour la version annotée, `--input corrige=true` pour le corrigé, `--input tds=false` pour le fil du cours).
**TD** : trois, `1a` (mesures), `2a` (clé SSH), `3a` (secret dans l'historique, facultatif). Un fichier par TD dans [`src/cours5/diapo/tds/`](../../../src/cours5/diapo/tds/), un dossier de même nom dans [`data/cours5/`](../../../data/cours5/).
Conventions d'écriture : [`STYLE.md`](../../../STYLE.md).

Objectif : donner les ordres de grandeur du matériel et du réseau qui expliquent la vitesse des outils, puis préparer la forge du cours 6 : une clé SSH sur le compte, et ce qui ne doit jamais entrer dans un dépôt.

---

## Parti pris

La séance 1 a été trop longue pour la salle. Celle-ci est écrite plus courte : 37 diapositives d'exposé, deux TD en séance (40′ en tout) et un TD facultatif. Le contenu est surtout de la culture générale ; les schémas portent l'essentiel, les tableaux le reste, et les notes de conduite sont brèves.

Deux fils relient la séance au reste du module :

- les ordres de grandeur reviennent au cours 6 (boucle Python contre numpy, texte contre binaire) et au projet 7 (benchmark) ;
- la clé SSH et le compte sur la forge sont les prérequis du cours 6, et la règle « aucun secret dans un dépôt » vaut pour les deux projets.

## Déroulé

| Partie | Nature | Durée |
|--------|--------|-------|
| Ouverture | cours | 5′ |
| 1. Le matériel | cours | 20′ |
| 2. Le réseau | cours, puis TD 1a | 15′ + 15′ |
| 3. S'identifier auprès d'une machine distante | cours, puis TD 2a | 15′ + 25′ |
| 4. Secrets et sécurité | cours ; TD 3a facultatif | 20′ |
| Clôture | cours | 5′ |

Total : 120′, dont 40′ de TD.

---

## Ouverture (2 diapositives)

1. Page de titre.
2. **Contenu de la séance** : le tableau ci-dessus.

## Partie 1 — Le matériel (🎓 20′, 9 diapositives)

3. Séparateur.
4. **Les composants d'un ordinateur.** Schéma dessiné : le boîtier avec processeur, mémoire vive, disque, carte graphique et carte réseau ; l'écran et le clavier à l'extérieur. Un rôle en quelques mots sous chaque composant.
5. **Le processeur.** Quatre cœurs, chacun avec sa file d'instructions ; cadence 3 GHz = 3 milliards de cycles par seconde. Notes : un programme Python ordinaire n'occupe qu'un cœur.
6. **Mémoire vive et disque.** Tableau : taille, temps d'accès, à l'extinction, ce qu'on y trouve. Le lien avec le cours 1 : les variables d'un programme sont en mémoire vive, un fichier est sur le disque, et c'est pour cela qu'il reste.
7. **Le chemin d'une donnée.** Pyramide cache / mémoire vive / disque / réseau, avec taille et temps d'accès à chaque étage. Une donnée traitée par le processeur passe par tous les étages.
8. **Ordres de grandeur : tailles.** Tableau octet, Ko, Mo, Go, To avec un exemple chacun, dont une dalle d'orthophoto (5 000 × 5 000 pixels × 3 octets = 75 Mo). Notes : Ko = 1 000 octets, Kio = 1 024 ; Windows affiche des Kio en les appelant Ko.
9. **Ordres de grandeur : temps d'accès.** Barres sur échelle logarithmique, de la nanoseconde à la seconde : cache, mémoire vive, SSD, disque dur, réseau local, Paris–Marseille, Paris–New York, Paris–Sydney.
10. **Si la mémoire vive valait une seconde.** La même échelle, tableau : mémoire vive 1 s, SSD un quart d'heure, disque dur une journée, Paris–New York une semaine, Paris–Sydney un mois. C'est la diapositive à retenir de la partie.
11. **Processeur et carte graphique.** Huit cœurs rapides contre des milliers de cœurs simples : le GPU sert quand la même opération s'applique à des millions de valeurs (image, tableau, réseau de neurones).
12. **Ce que cela change pour un programme.** Tableau : lire un fichier une fois plutôt que mille, garder en mémoire ce qu'on réutilise, numpy plutôt qu'une boucle (cours 6), binaire plutôt que texte (cours 3), commit local et push réseau (partie 2).

Sources : Brendan Gregg, *Systems Performance* (2020), table 2.2 des latences ; Peter Norvig et Jeff Dean, « Latency numbers every programmer should know ».

## Partie 2 — Le réseau (🎓 15′, 8 diapositives)

13. Séparateur.
14. **Local et distant.** Schéma dessiné : le poste, le réseau de la salle, celui de l'école, Internet, le serveur ; les distances et les temps d'un aller-retour.
15. **Client et serveur.** Le client envoie une requête, le serveur répond. Tableau : navigateur et site web, `git push` et forge, `ssh` et serveur de calcul.
16. **Adresse, nom et port.** Une adresse SSH et une URL décomposées, comme le chemin de fichier du cours 1 : le protocole, le nom (que le DNS traduit en adresse IP), le port, le chemin.
17. **Débit et latence.** Schéma du tuyau : la latence est le temps du premier octet, le débit le nombre d'octets par seconde. Temps = latence + taille ÷ débit, calculé pour 1 Ko et 1 Go.
18. **La latence dépend de la distance.** Tableau Paris → Marseille, Londres, New York, Tokyo, Sydney : distance, aller-retour mesuré, part de la vitesse de la lumière dans la fibre (200 000 km/s). Source : wondernetwork.com, septembre 2026.
19. **Le débit dépend du lien.** Tableau : Ethernet de la salle, Wi-Fi, 4G, ADSL, et le temps de transfert de 1 Go. Avertissement : les débits sont en bits par seconde, les fichiers en octets, facteur 8.
20. **Un commit et un push.** Schéma : le commit écrit sur le disque local (millisecondes), le push traverse le réseau (latence, puis débit). Conséquence : on peut travailler sans réseau et pousser quand on veut.

### ⌨️ TD 1a — Les ordres de grandeur de votre poste (15′)

Dossier `cours5/1a_mesures/`. Deux gestes :

1. Gestionnaire des tâches (`Ctrl` + `Maj` + `Échap`), onglet Performance : relever le nombre de cœurs, la cadence, la taille de la mémoire vive, le type et la taille du disque.
2. `python mesures.py` : quatre mesures (10 millions d'additions, copier 100 Mo en mémoire, écrire puis relire 100 Mo sur le disque, un aller-retour vers `github.com` et un téléchargement de 10 Mo). Remplir le tableau, comparer à l'échelle de la diapositive 9.

Ce que le TD fait constater (dans `reponse[…]`) : l'addition prend quelques dizaines de nanosecondes ; la relecture est dix fois plus rapide que l'écriture, parce que le système garde une copie du fichier en mémoire vive ; l'aller-retour réseau se compte en dizaines de millisecondes.

À vérifier en salle avant la séance : que `github.com:443` et `speed.cloudflare.com` répondent depuis les VM, une fois la session réseau ouverte. Le script affiche un message et continue si l'un des deux ne répond pas.

## Partie 3 — S'identifier auprès d'une machine distante (🎓 15′, 7 diapositives)

21. Séparateur.
22. **Prouver qui l'on est.** Tableau mot de passe / clé : où est le secret, ce qui traverse le réseau, ce qui se passe si le serveur est compromis.
23. **Une paire de clés.** Schéma cadenas et clé : la clé publique ferme, on la distribue ; la clé privée ouvre, elle ne quitte pas le poste.
24. **La connexion SSH.** Diagramme de séquence en quatre flèches : le client se présente, le serveur envoie un défi chiffré avec la clé publique, le client le résout avec la clé privée, le serveur ouvre l'accès. Le secret n'a pas traversé le réseau.
25. **Les deux fichiers de la paire.** Sortie réelle de `ssh-keygen` ; `id_ed25519` (419 octets, droits restreints) et `id_ed25519.pub` (107 octets, une ligne, à coller sur la forge).
26. **Où une clé SSH sert.** Tableau : forge (`git clone git@github.com:…`), serveur de calcul (`ssh alice@calcul.ecole.fr`), copie de fichiers (`scp`), VS Code à distance. Notes : l'accès HTTPS par jeton existe aussi ; la clé est le choix du module parce qu'elle sert aussi aux serveurs.
27. **Empreinte et chiffrement.** Tableau : le hachage est à sens unique et sert à identifier ou vérifier (identifiant de commit, empreinte de clé, mot de passe stocké) ; le chiffrement est réversible avec la clé et sert à cacher. Exemple réel : SHA-256 de « bonjour » et de « Bonjour ».

### ⌨️ TD 2a — Une clé SSH sur votre compte (25′)

Dossier `cours5/2a_cle_ssh/`. Prérequis : un compte GitHub créé avant la séance (page « Avant les séances »).

1. Dans Anaconda Prompt : `ssh-keygen -t ed25519 -C "prenom.nom@etu.ecole.fr"`, Entrée à chaque question (emplacement par défaut, sans phrase de passe pour aujourd'hui).
2. `type %USERPROFILE%\.ssh\id_ed25519.pub`, copier la ligne.
3. GitHub → Settings → SSH and GPG keys → New SSH key, coller, enregistrer.
4. `ssh -T git@github.com` : accepter l'empreinte du serveur à la première connexion, lire `Hi <compte>! You've successfully authenticated`.

Ce que le TD fait constater : le fichier `.pub` est une seule ligne ; le fichier sans extension n'est jamais ouvert ni copié ; la question `Are you sure you want to continue connecting` est l'empreinte du serveur, posée une fois.

À vérifier en salle avant la séance : que le port 22 sortant est ouvert. Sinon, GitHub accepte SSH sur le port 443 (`ssh.github.com`), avec un fichier `.ssh/config` à fournir dans le dossier du TD. `ssh-keygen` et `ssh` sont installés d'origine sous Windows 10 et 11 (`C:\Windows\System32\OpenSSH`).

## Partie 4 — Secrets et sécurité (🎓 20′, 8 diapositives)

Ce qui est retenu, et pourquoi. Les dix mesures de cybermalveillance.gouv.fr et le guide d'hygiène de l'ANSSI listent plus que ce qu'une séance peut porter. Sont gardées les cinq qui concernent directement des étudiants qui vont écrire du code et le publier : les secrets hors du dépôt (propre au module), les mots de passe, le deuxième facteur, l'hameçonnage, les mises à jour et sauvegardes. Antivirus, achats en ligne, réseaux sociaux et Wi-Fi public sont laissés aux notes.

28. Séparateur.
29. **Ce qui est un secret.** Tableau à garder / à partager : clé privée, mot de passe, jeton d'API (clé IGN, clé d'un service d'IA), fichier `.env` ; contre clé publique, code, README, données publiques.
30. **Un secret dans un dépôt y reste.** Sortie réelle de `git log -p` : le commit qui supprime `config.py` n'efface pas celui qui l'a ajouté. Légende : 28,65 millions de secrets ajoutés sur GitHub public en 2025, 64 % de ceux de 2022 encore valides en 2026 (GitGuardian, *State of Secrets Sprawl 2026*).
31. **Séparer le code et les secrets.** Schéma : dans le dépôt `carte.py`, `config.example.py`, `.gitignore` ; hors dépôt `config.py`. Le code lit une variable d'environnement ou un fichier ignoré.
32. **Si un secret a fui.** Chaîne : révoquer (régénérer la clé sur le service), remplacer (dans la configuration), nettoyer (réécrire l'historique ou recréer le dépôt), prévenir. La première étape passe avant tout, parce que l'historique a déjà été copié.
33. **Mots de passe.** Tableau des trois équivalents de la CNIL (2022) : 12 caractères de quatre classes, 14 de trois classes, une phrase de 7 mots ; un mot de passe par service ; un gestionnaire ; pas de renouvellement forcé.
34. **Deuxième facteur.** Schéma : ce que je sais, ce que j'ai, ce que je suis. GitHub l'impose depuis 2023 ; l'application d'authentification est le choix courant.
35. **Hameçonnage.** Un courriel dessiné, annoté : domaine de l'expéditeur, urgence, lien dont le domaine n'est pas celui affiché, pièce jointe. Le domaine d'une URL se lit comme au cours 1.
36. **Mises à jour et sauvegardes.** Tableau : une mise à jour ferme une faille connue et publiée ; une sauvegarde suit la règle 3-2-1 ; un dépôt poussé sur la forge est une copie du code ; les données ignorées par git sont à sauvegarder à part.

### ⌨️ TD 3a — Un secret dans l'historique (10′, facultatif)

Dossier `cours5/3a_secret_historique/`. Rejouer la diapositive 30 : `git init`, un `config.py` avec une fausse clé, commit ; supprimer, commit ; `git log -p` montre les deux. Puis `.gitignore` et `config.example.py`, et `git status` ne voit plus `config.py`.

## Clôture (1 diapositive)

37. **Vers le cours 6.** Tableau : prêt aujourd'hui (compte sur la forge, clé enregistrée, règle du `.gitignore`) ; au cours 6 (`clone`, `push`, `pull`, branches en équipe).

---

## Sources

- Latences : Brendan Gregg, *Systems Performance*, 2e éd., 2020, table 2.2 ; Jonas Bonér d'après Peter Norvig, « Latency numbers every programmer should know », <https://gist.github.com/hellerbarde/2843375>.
- Aller-retour Paris → villes : <https://wondernetwork.com/pings/Paris> (moyennes relevées le 20 septembre 2026).
- Clés SSH : GitHub Docs, « Generating a new SSH key and adding it to the ssh-agent » ; Microsoft Learn, « Key-based authentication in OpenSSH for Windows ».
- Secrets : GitGuardian, *The State of Secrets Sprawl 2026*, mars 2026, <https://blog.gitguardian.com/the-state-of-secrets-sprawl-2026/>.
- Mots de passe : CNIL, délibération n° 2022-100 du 21 juillet 2022, et <https://www.cnil.fr/fr/mots-de-passe-recommandations-pour-maitriser-sa-securite>.
- Mesures générales : cybermalveillance.gouv.fr, « Les 10 mesures essentielles pour assurer votre sécurité numérique » ; ANSSI, *Guide d'hygiène informatique*.
