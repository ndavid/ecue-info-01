# Données — Cours 5

Un dossier par TD, nommé comme le TD l'est dans les diapositives : le chiffre
est le bloc, joué au même moment du cours, la lettre l'ordre dans le bloc.
Le fichier typst du TD porte le même nom, `src/cours5/diapo/tds/1a_mesures.typ`
pour `1a_mesures/`.

| Dossier | TD | |
|---------|----|-|
| [`1a_mesures/`](1a_mesures/) | relever les caractéristiques du poste, puis mesurer quatre temps avec `mesures.py` : processeur, mémoire, disque, réseau | |
| [`2a_cle_ssh/`](2a_cle_ssh/) | fabriquer une paire de clés SSH, coller la clé publique sur GitHub, vérifier la connexion ; `config` de secours si le port 22 est fermé | |
| [`3a_secret_historique/`](3a_secret_historique/) | committer une fausse clé, la supprimer, constater qu'elle reste dans l'historique, puis l'en tenir à l'écart | facultatif |

Aucun `make_data.py` : les trois TD n'ont besoin d'aucune donnée fabriquée.
Le fichier de 100 Mo du TD 1a est écrit par le script lui-même, puis supprimé.

Chaque dossier a son README. Le TD facultatif n'est pas fait en séance ; ses
diapositives et ses fichiers sont là pour qui va plus vite, ou pour après.
