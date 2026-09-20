// TD 2a du cours 3 — « Texte et binaire ».
//
// Inclus par `cours3.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`. Un
// fichier inclus n'hérite pas des imports de son appelant.
//
// Comme le TD 1a, ce fichier ouvre le notebook que la partie 2 fait exécuter
// section par section. La partie en suit deux : `fichiers.ipynb`, livré dans
// le dossier du TD 1a parce qu'il reprend les fichiers de la recette, puis
// `images.ipynb`, ouvert plus tard depuis l'exposé.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "2a",
  titre: "Texte et binaire",
  annonce: "Ouvrir fichiers.ipynb, puis images.ipynb quand l'exposé y arrive ; les deux notebooks se font pendant l'exposé, section par section",
  dossier: "cours3/2a_images/",
  duree: "45′",
)
// Dans le cours, l'ouverture est commune à la partie (`separateur-cours-td`,
// dans `cours3.typ`) ; seule la feuille de TD remet celle-ci.
#if feuille-seule { separateur-td(..td) }

#d("Ouvrir le notebook des fichiers")[
  #annonce[
    Les fonctions utiles de `recette.ipynb` ouvrent, lisent et écrivent des
    fichiers sans que ces lignes aient été expliquées. `fichiers.ipynb`
    reprend le code dans son dernier état et les explique. Il est dans le
    dossier du TD 1a, avec la recette.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [dans l'explorateur, copier `1a_recette/depart/notebook/fichiers.ipynb` dans `1a_recette/travail/`],
      reponse[`travail/fichiers.ipynb`, à côté de `recette.ipynb`],
    [2], [dans le panneau de gauche de JupyterLab, double-cliquer dessus],
      reponse[un second onglet, à côté du premier],
    [3], [exécuter la section 0],
      reponse[`True True` : les chemins de la section 3.3, retrouvés],
  )

  #legende[
    `recette.ipynb` reste ouvert. Le notebook des images, dans `2a_images/`,
    s'ouvre plus tard, quand l'exposé y arrive.
  ]

  #notes[
    Le second notebook repart de `Path.cwd()` et des mêmes variables ; rien
    à recopier. Il doit être dans `travail/`, comme le premier : ouvert
    depuis `depart/notebook/`, `RACINE` désignerait `depart/`.
  ]
]
