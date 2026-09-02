# Diapositives — Cours 1

Structure **assertion-evidence** : le titre de chaque diapositive est une phrase
complète énonçant ce qu'elle démontre, et le corps est une preuve visuelle
(schéma, sortie de commande, comparaison). Aucune liste à puces. Les
conventions et leurs sources sont dans [`STYLE.md`](../../../STYLE.md).

```bash
conda activate info01

# diapositives seules
typst compile src/cours1/diapo/cours1.typ

# version avec les notes de conduite, pour l'enseignant
typst compile --input notes=true src/cours1/diapo/cours1.typ cours1-notes.pdf

# recompilation à chaque sauvegarde
typst watch src/cours1/diapo/cours1.typ
```

- `theme.typ` — mise en page, couleurs, polices, et les helpers `d` (une
  diapositive), `notes` (ce que l'enseignant dit et qui n'est pas projeté),
  `legende`, `face-a-face`, `panneau`.
- `cours1.typ` — 13 diapositives.

Aucune dépendance externe : pas de paquet importé, et uniquement des polices
embarquées dans typst. La compilation est identique sur tous les postes et
fonctionne hors ligne.
