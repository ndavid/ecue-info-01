# Diapositives — Cours 3

Même organisation que le cours 1, dont le [README](../../cours1/diapo/README.md)
décrit les gabarits, les compilations et les vérifications :

```bash
python outils/compiler_diapos.py --cours 3            # cours3.pdf, à projeter
python outils/compiler_diapos.py --cours 3 --notes    # avec les notes de conduite
python outils/compiler_diapos.py --cours 3 --corrige  # les réponses des TD
python outils/compiler_diapos.py --cours 3 --sans-tds # un sommaire par bloc de TD
python outils/compiler_tds.py --cours 3               # une feuille par TD
python outils/verifier_diapos.py src/cours3/diapo/cours3.pdf
```

Ce que cette séance a de particulier : les parties 1 et 2 se jouent pendant
que les étudiants exécutent un notebook. Leurs diapositives passent
`cellule: n` au gabarit `d` : la ligne de titre reçoit le cartouche « § n »,
en brun, la couleur des TD, de la section du notebook à exécuter à ce
moment ; l'ouverture est commune à la partie et au TD,
`separateur-cours-td` dans `cours3.typ` (page partagée par une oblique, bleu
de l'exposé à gauche, brun du TD à droite), et `cours3.typ` inclut les TD 1a
et 2a avant les parties 1 et 2, et le TD 2b entre les deux moitiés de la
partie 2 (`02a_fichiers.typ`, `02b_images.typ`). Compilé seul en feuille de TD, le fichier du
TD remet son ouverture brune (`feuille-seule`).

`schemas.typ` porte trois gabarits propres à la séance : `pixels-gris` (une
grille de pixels depuis les valeurs d'un PGM), `pixel-art` (un dessin en
lettres et sa table de couleurs, comme dans le notebook) et `sortie` (une
sortie de terminal ou de cellule, en `raw`, sur fond gris).

Les nombres cités dans la partie 2 (tailles, temps de lecture) sont ceux
d'une exécution du notebook `images.ipynb` sur un poste ; ils changent d'un
poste à l'autre, pas leurs rapports.
