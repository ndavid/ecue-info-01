// TD 5a du cours 1 — « Les premiers octets d'un fichier ».
//
// Inclus par `cours1.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "5a",
  titre: "Les premiers octets d'un fichier",
  annonce: "Après avoir vu que l'extension ne décrit pas le contenu, lire ce qui le décrit : un script de quarante lignes, à lire puis à lancer",
  dossier: "cours1/5a_octets/",
  duree: "8′",
  facultatif: true,
)
#separateur-td(..td)
#d("Ce que le script lit dans chaque fichier")[
  #annonce[
    Ouvrir `cours1/5a_octets/` dans l'éditeur, lire `octets.py`, puis le
    lancer au terminal : `python octets.py`. Il lit les fichiers du TD 1a.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Fichier lu], [Premiers octets], [Ce qu'ils signent],
    [`raven_une_ligne.txt`], [`4F 6E 63 65` — `Once`],
      reponse[aucune signature : un fichier texte n'en porte pas],
    [`raven_une_ligne.donnees`], [`4F 6E 63 65` — `Once`],
      reponse[les mêmes octets que la ligne précédente],
    [`raven.odt`], [`50 4B 03 04` — `PK..`],
      reponse[une archive ZIP, donc un `.odt`, un `.docx`, un `.xlsx`…],
    [`raven.pdf`], [`25 50 44 46` — `%PDF`],
      reponse[un document PDF],
  )

  #legende[
    `raven.pdf` est celui que vous avez exporté au TD 1a ; s'il manque, le
    script écrit `introuvable` sur sa ligne et continue.
  ]

  #notes[
    Le geste est celui du hello world, refait sur un programme qui sert à
    quelque chose. Faire lire le script avant de le lancer : trois fonctions,
    dont une compare le début du fichier à un dictionnaire de signatures.

    Deux étages de décision, et c'est tout le propos : le système choisit le
    logiciel d'après le nom, le logiciel lit les premiers octets. Ces octets
    de tête s'appellent des nombres magiques. Que les fichiers texte n'en
    aient aucun est une information, pas un manque.

    Ne pas développer le binaire : il est ouvert en hexadécimal au cours 3.
  ]
]
#d("Deux extensions échangées")[
  #annonce[
    Le script accepte des chemins en argument. Deux copies aux extensions
    échangées, et le nom contredit les octets.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [`cp ../1a_formats/depart/raven.odt raven_odt.pdf` (sous Windows, `copy`)],
    [2], [`cp ../1a_formats/travail/raven.pdf raven_pdf.odt`],
    [3], [double-cliquer sur `raven_odt.pdf`, et regarder ce que fait le lecteur PDF],
    [4], [`python octets.py raven_odt.pdf raven_pdf.odt`],
  )

  #tableau(
    columns: (auto, auto, 1fr),
    align: left + horizon,
    [Fichier], [Premiers octets], [Ce qui est dedans],
    [`raven_odt.pdf`], [`50 4B 03 04`], reponse[une archive ZIP : le `.odt` renommé],
    [`raven_pdf.odt`], [`25 50 44 46`], reponse[un document PDF : le `.pdf` renommé],
  )

  #notes[
    Faire essayer le double-clic avant de lancer le script : le lecteur PDF
    s'ouvre et refuse le fichier, et les deux étages se contredisent devant
    eux. Le nom a changé, les octets non, et c'est le second que le logiciel
    lit.

    Les copies sont faites dans le dossier du TD, pas dans celui du TD 1a :
    ce qu'on fabrique reste à côté de la commande qui l'a fabriqué.
  ]
]
