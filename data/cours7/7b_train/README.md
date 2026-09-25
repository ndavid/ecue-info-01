# Deux effets pour la fenêtre du train — TD 7b, cours 7

La suite du TD 4c : une option `--effet` ajoutée au programme `train.py`,
qui modifie chaque image de la série avant la vidéo. L'effet `poteaux`
(des ombres qui passent très vite devant le paysage) pour tous, l'effet
`parallaxe` (un second plan, plus rapide) dans un second temps. Chaque effet
est écrit avec une boucle sur les pixels, puis avec numpy ; un test vérifie
que les deux versions donnent la même image ; la branche est publiée par une
pull request relue par un camarade.

Le guide `guide_7b_train.pdf` (aussi en `.html` et en notebook
`guide.ipynb`) détaille les étapes.

| Fichier | Ce qu'il contient |
|---|---|
| `depart/notebook/tableaux.ipynb` | le notebook des outils numpy : une image est un tableau, tranches, dépassement des `uint8`, masques, `np.roll`, mesure du temps |
| `depart/exemple.png` | une image de la série du TD 4c, lue par le notebook |
| `depart/decor/` | `plage.png` et `fenetre.png`, lues par le notebook (les mêmes que dans le dépôt `train`) |
| `depart/modeles/test_effet.py` | le test : les deux versions d'un effet donnent-elles la même image ? |
| `depart/modeles/mesurer.py` | le chronométrage des deux versions, sur une image et sur la série |
| `depart/modeles/RAPPORT.md` | le gabarit du rapport |
| `travail/` | vide : la copie du notebook, et le clone du dépôt `train` |
