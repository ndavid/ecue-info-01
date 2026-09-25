# Données — Cours 4 : une animation, du notebook au programme

Trois TD au choix, construits sur les mêmes étapes : chaque élève en fait un.

| Dossier | Ce que c'est |
|---|---|
| `4a_montre/` | la montre du Lapin blanc : un cadran dessiné par ImageMagick, les aiguilles placées par Python, une vidéo par ffmpeg |
| `4b_tourbillon/` | *La Grande Vague* en tourbillon : l'image tordue par ImageMagick (`-swirl`), un angle par image, une vidéo par ffmpeg |
| `4c_train/` | la fenêtre du train, d'après le clip « Moon » de Kid Francescoli : un plan décalé par ImageMagick (`-roll`), posé entre un fond fixe et la fenêtre (`-composite`), un décalage par image, une vidéo par ffmpeg ; le décor est dessiné par `make_data.py`. Conception : `syllabus/cours/4_projet_animation/td_4c_train.md` |
| `corriges/` | le programme de chaque TD à la fin de chaque étape (`<td>/b1/` … `b5/`), versionné ici pour ne pas partir dans l'archive |
| `generer_corriges.py` | écrit les programmes des corrigés (B1, B2, B3 et B5), un morceau de code par commit, avec les mêmes morceaux pour les trois TD |
| `generer_guides.py` | écrit les trois guides `src/cours4/notebook/td/<td>/guide.md`, sur le même plan, avec le code des corrigés |
| `propositions/` | les notebooks d'essai du 20/09/2026, exécutés (non versionnés) |

Les trois TD ont le même déroulé :

- partie A : créer l'environnement `animation` depuis `environment.yml`,
  lancer JupyterLab depuis cet environnement, exécuter le notebook ;
- partie B : construire le programme `montre.py`, `tourbillon.py` ou `train.py`
  fonctionnalité par fonctionnalité, une branche git par fonctionnalité :
  B1 une image, B2 une série d'images, B3 la vidéo (avec un commit sur
  `master` pendant la branche, donc un commit de fusion), B4 le README ; en
  facultatif, B5 : `src/`, `pyproject.toml` et une commande installée.

```bash
conda activate info01
python ../cours3/make_data.py build   # vague.jpg, reprise par le TD 4b
python generer_corriges.py            # si le code des programmes a changé
python generer_guides.py              # si le texte des guides a changé
python make_data.py build             # produit/ des trois TD
python ../../outils/construire_notebooks.py
python ../../outils/compiler_guides.py --cours 4
```

Le guide détaillé de chaque TD est écrit dans
`src/cours4/notebook/td/<td>/guide.md` ; `outils/compiler_guides.py` en fait
un PDF A4 et une page HTML déposés dans le dossier du TD.
