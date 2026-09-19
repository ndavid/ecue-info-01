# Images — Cours 2

Contrairement à celles du cours 1, ces images **ne sont pas des captures
d'écran facultatives** : ce sont des logos, et la diapositive « Git : c'est
quoi ? » les affiche à chaque compilation. Elles sont donc versionnées, et le
document ne compile pas sans elles.

Elles ne passent pas par `illustration(…)`, qui n'affiche son image qu'avec
`--input captures=true`, mais par `image(…)` directement, dans
[`src/cours2/diapo/schemas.typ`](../../src/cours2/diapo/schemas.typ).

## `logos/`

Découpés dans le support d'origine de Florent Geniet, où ils figuraient déjà.
Poids total : moins de 50 ko.

| Fichier | Marque | Où |
|---|---|---|
| `git.png` | Git | au centre du schéma, et dans le cercle « Travail à plusieurs » |
| `github.png` | GitHub | cercle « Hébergement du code en ligne » |
| `gitlab.png` | GitLab | cercle « Hébergement du code en ligne » |
| `serveur.png` | — | le serveur du même cercle |
| `terminal.png` | — | cercle « ligne de commande, logiciels dédiés, IDE » |
| `vscode.png` | Visual Studio Code | même cercle |
| `gitkraken.png` | GitKraken | même cercle |
| `tortoisegit.png` | TortoiseGit | même cercle |

Ce sont des marques appartenant à leurs éditeurs, reproduites ici pour les
désigner dans un support d'enseignement. Le logo Git est de Jason Long,
sous licence CC BY 3.0.
