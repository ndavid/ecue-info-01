// TD 4c du cours 4 — « La fenêtre du train ».
//
// Compilable seul par `outils/compiler_tds.py`, qui en tire la feuille
// `td_4c_train.pdf`. Les étapes en résumé : le détail, avec le code à coller,
// est dans le guide `guide_4c_train.pdf`. Les étapes sont celles des TD 4a et
// 4b (`etapes-animation`, dans `schemas.typ`). Pas encore inclus dans
// `cours4.typ`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": etapes-animation

#let td = (
  numero: "4c",
  titre: "La fenêtre du train",
  annonce: "Créer l'environnement animation, exécuter le notebook train.ipynb, puis construire le script train.py fonctionnalité par fonctionnalité : une image, une série, la vidéo ; une branche git par fonctionnalité",
  dossier: "cours4/4c_train/",
  duree: "105′",
)
#separateur-td(..td)

#etapes-animation(
  "train", "4c_train", [le dossier `depart/decor/`],
  ("python train.py --decalage 200", "sortie/train_0200.png"),
  ("python train.py --images 120", "--images", [les fonctions `decalages` et `serie`]),
  "python train.py --images 120 --video",
)
