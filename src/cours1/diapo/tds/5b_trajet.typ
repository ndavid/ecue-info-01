// TD 5b du cours 1 — « Une vidéo, deux chemins ».
//
// Inclus par `cours1.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille de TD déposée dans le dossier annoncé. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "5b",
  titre: "Une vidéo, deux chemins",
  annonce: "Le trajet de la gare à l'école en cinq étapes commentées : la même vidéo, produite en une commande, et ce qu'il en reste pour la refaire",
  dossier: "cours1/5b_trajet/",
  duree: "10′",
  facultatif: true,
)
#separateur-td(..td)
#d("Fabriquer la vidéo en une commande")[
  #annonce[
    Le fond de carte est fourni. Une commande lit les étapes, dessine une image
    par étape, écrit les sous-titres et monte la vidéo.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [ouvrir `cours1/5b_trajet/` dans l'éditeur, puis `etapes.csv` : une ligne par étape],
    [2], [Terminal #sym.arrow.r Nouveau terminal, puis `conda activate info01`],
    [3], [taper `./anime.sh`, puis Entrée],
    [4], [ouvrir `trajet.mp4`, puis changer un texte d'`etapes.csv` et relancer],
  )

  #legende[
    `ffmpeg` et `imagemagick` sont dans l'environnement `info01` : rien à
    installer. Le script est écrit pour le terminal de Linux et macOS ; sous
    Windows, il demande Git Bash, qui arrive au cours 2.
  ]

  #notes[
    L'argument n'est pas que la ligne de commande est meilleure. Il est que
    la deuxième exécution ne coûte rien d'un côté et tout de l'autre : refaire
    la vidéo à la souris, c'est tout recommencer ; ici, c'est corriger une
    ligne et relancer.

    Le fond de carte n'est pas à retélécharger : le serveur de tuiles
    d'OpenStreetMap est un service bénévole, dont les conditions d'usage
    interdisent qu'une promotion entière le sollicite en même temps.

    Sous Windows, faire lire le script et regarder la vidéo du voisin : le TD
    est facultatif, et la comparaison se comprend sans l'avoir tapée.
  ]
]
#d("Ce que la commande enchaîne")[
  #annonce[
    Quatre étapes, chacune produisant le fichier que la suivante consomme. Ce
    sont les quatre blocs numérotés d'`anime.sh`.
  ]

  #tableau(
    columns: (auto, auto, 1fr, 1fr),
    align: left + horizon,
    [Étape], [Outil], [Entrée], [Sortie],
    [tracé], [`magick -draw`], [`carte.png` + `etapes.csv`],
      reponse[`etape_01.png` … `etape_05.png`],
    [commentaires], [`printf`], [`etapes.csv`],
      reponse[`trajet.srt`, les sous-titres],
    [liste de montage], [`printf`], [les images et leurs durées],
      reponse[`montage.txt`],
    [montage], [`ffmpeg`], [les images + le `.srt`],
      reponse[`trajet.mp4`, 25 secondes],
  )

  #legende[
    `etapes.csv`, le `.csv` de la grille des extensions et le `content.xml` du
    `.odt` : trois fois le même constat, le contenu utile est du texte.
  ]

  #notes[
    Faire ouvrir `trajet.srt` dans l'éditeur : du texte, lisible, produit par
    un programme et consommé par un autre. C'est le fichier comme unité
    d'échange entre logiciels, vu de près.

    Les outils sont ceux du projet de la séance 4 : le TD n'est pas un
    détour, c'est une répétition.
  ]
]
