// TD 2b du cours 3 — « Texte et binaire : les images PGM ».
//
// Inclus par `cours3.typ`, entre les deux moitiés de la partie 2, qui porte
// les réglages globaux et importe `td` pour le sommaire des TD ; compilable
// seul par `outils/compiler_tds.py`. Un fichier inclus n'hérite pas des
// imports de son appelant.
//
// Ce fichier fait ouvrir `images.ipynb` ; les diapositives de
// `parties/02b_images.typ` suivent ensuite le notebook section par section.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "2b",
  titre: "Texte et binaire : les images PGM",
  annonce: "Ouvrir images.ipynb ; le notebook se fait pendant l'exposé, section par section",
  dossier: "cours3/2b_images/",
  duree: "15′",
)
#separateur-td(..td)

// --------------------------------------------
#d("Exemple de fichier binaire : les images PGM")[
  #annonce[
    Le format d'image PGM existe en deux variantes : texte et binaire. Le
    notebook `images.ipynb` compare les deux fichiers d'une même image.

    Ouvrir le notebook `images.ipynb` du dossier `cours3/2b_images/`.
  ]

  #legende[
    `depart/` contient trois images : un motif de seize pixels, *La Grande
    Vague* de Hokusai et un émoji. Les fichiers créés par le notebook sont
    écrits dans `travail/`.
  ]

  #notes[
    Les images sont libres : Twemoji est en CC BY, la Vague vient du
    Metropolitan Museum en CC0. `depart/CREDITS.md` le précise.
  ]
]
