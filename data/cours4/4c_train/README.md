# La fenêtre du train — TD 4c, cours 4

Le TD a deux parties. Deux documents les décrivent : la feuille
`td_4c_train.pdf` donne les étapes en résumé ; le guide `guide_4c_train.pdf`
(aussi en `.html` et en notebook `guide.ipynb`) les détaille, avec le code à
coller et la vérification de chaque commande.

- Partie A : créer l'environnement `animation`, lancer JupyterLab depuis cet
  environnement et exécuter le notebook `train.ipynb`, qui fabrique la
  vidéo.
- Partie B : construire le programme `train.py`, lancé depuis un terminal,
  fonctionnalité par fonctionnalité (une image, une série d'images, la
  vidéo), une branche git par fonctionnalité.

| Fichier | Ce qu'il contient |
|---|---|
| `depart/environment.yml` | la description de l'environnement `animation` : Python, JupyterLab, ImageMagick, ffmpeg |
| `depart/notebook/train.ipynb` | le notebook qui fabrique la vidéo |
| `depart/decor/` | les images du décor : `fond.png` (le ciel, les nuages, la mer), `plan.png` (les voiles et la plage, une bande de 1 920 pixels), `fenetre.png` (la fenêtre, vitre transparente) ; `plage.png`, le premier plan, sert au TD 7 |
| `depart/CREDITS.md` | d'où vient le décor |
| `depart/modeles/` | `README.md` et `pyproject.toml` à compléter, partie B |
| `travail/` | vide : la copie du notebook (partie A) et le dossier du projet `train/` (partie B) |
