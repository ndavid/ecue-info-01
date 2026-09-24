# Propositions d'animation pour le cours 4

Quatre notebooks d'essai, écrits le 20 septembre 2026 pour choisir l'animation
de la seconde partie du TD du cours 4. Chacun produit ses images avec
ImageMagick (`magick`, appelé par `subprocess.run`) et sa vidéo avec ffmpeg,
puis un GIF d'aperçu. Aucun n'est un TD : pas de cellule à trous, pas de
feuille. Retenus pour essai le 20/09 : le hareng, la Vague et la montre ; le
chat est gardé pour mémoire.

| Notebook | Ce qu'il fabrique | Ce qu'il fait apprendre |
|---|---|---|
| `hareng_saur.md` | *Le Hareng saur* de Charles Cros (1873, domaine public) : une image par strophe, dessinée en formes simples, le texte dessous ; le hareng se balance aux deux dernières strophes ; 31 s | `-draw` (rectangle, line, circle, et un `path` en syntaxe SVG pour le hareng), `-annotate`, une fonction qui construit la commande, une liste de strophes, la répétition d'une image pour sa durée, `translate`/`rotate` et `sin` pour le balancement, ffmpeg `-framerate` |
| `chat_en_ronds.md` | un chat dessiné forme par forme, une ligne de texte par forme (texte écrit pour l'occasion, six lignes), puis la queue qui bouge ; 21 s | les mêmes commandes, moins de formes, l'ordre d'empilement des `-draw`, `polygon` |
| `vague_effets.md` | sur *La Grande Vague* du cours 3 : un panoramique (`-crop` qui glisse) et un tourbillon (`-swirl` de 0 à 360 et retour) ; 5 s chacun | une animation = un paramètre qui varie ; `-crop`, `+repage`, `-resize`, `-swirl` ; d'autres opérateurs en fin de notebook |
| `montre.md` | la montre de gousset du Lapin blanc (*Alice*, Carroll 1865, trad. Bué 1869, domaine public) : les aiguilles avancent d'une minute par image, de 10 h à 12 h, l'heure écrite sous la citation ; 10 s | les coordonnées calculées par Python (`sin`, `cos`, une fonction `point`), l'angle d'une aiguille en fonction de l'heure, une chaîne `-draw` construite dans une boucle (les soixante graduations), `text` dans `-draw` |

Exécuter, depuis la racine du dépôt, dans l'environnement `info01` (qui a
`magick`, `ffmpeg` et une police DejaVu) :

```bash
jupytext --to notebook -o data/cours4/propositions/hareng_saur.ipynb src/cours4/notebook/propositions/hareng_saur.md
cd data/cours4/propositions && jupyter nbconvert --to notebook --execute --inplace hareng_saur.ipynb
```

Les fichiers produits vont dans `data/cours4/propositions/produit/<nom>/`
(hors dépôt). Le notebook de la Vague lit `data/cours3/2b_images/produit/depart/vague.jpg`,
fabriqué par `data/cours3/make_data.py build`.

Sur les postes de la salle : `MAGICK` doit désigner `magick.exe` (portable ou
installé par conda-forge, qui a le paquet `imagemagick` pour Windows) ; la
police est `C:/Windows/Fonts/arial.ttf`, cherchée en premier par les
notebooks. Le `.mp4` est encodé en `libx264` : la construction `gpl` de
ffmpeg sur conda-forge l'a, la construction `lgpl` non ; à vérifier sur une
VM, ou remplacer par `-c:v mpeg4`.

Deux façons de tourner un dessin : le hareng et le chat passent par
`translate` et `rotate` dans la chaîne `-draw` ; la montre calcule les points
avec `sin` et `cos`. La seconde est celle du syllabus (« Python calcule les
coordonnées ») ; la première tient en une ligne.

Idées non prototypées : un graphique en barres qui grandit (les quantités
d'une recette du cours 3, `lerp` entre 0 et la valeur) ; un zoom sur la
Vague (`-crop` décroissant puis `-resize`) ; un fondu entre deux images par
`-morph` ; un texte qui s'écrit lettre par lettre (`-annotate` sur des
sous-chaînes).
