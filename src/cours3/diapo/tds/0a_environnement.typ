// TD 0a du cours 3 — « Un environnement pour la séance », selon les groupes.
//
// Inclus par `cours3.typ`, après l'ouverture, qui porte les réglages globaux
// et importe `td` pour le sommaire des TD ; compilable seul par
// `outils/compiler_tds.py`. Un fichier inclus n'hérite pas des imports de son
// appelant.
//
// Ajouté pour 2026 (syllabus v1.5, 24/09/2026) : la partie 4 du cours 1
// (bibliothèques et environnements) n'a pas été jouée. Le TD crée
// l'environnement `cours3`, y installe les paquets que demandent les
// notebooks de la séance, et y lance JupyterLab. Les groupes qui ne le font
// pas lancent JupyterLab depuis `base`, comme prévu dans l'ouverture.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "0a",
  titre: "Un environnement pour la séance",
  annonce: "Créer l'environnement cours3, y installer les paquets que demandent les notebooks, et y lancer JupyterLab",
  dossier: "cours3/0a_environnement/",
  duree: "20′",
  facultatif: true,
)
#separateur-td(..td)

// --------------------------------------------
#d("Un environnement conda")[
  #annonce[
    Un environnement conda est un dossier qui contient un Python et des
    paquets. Chaque projet a le sien : installer un paquet pour un projet ne
    change pas les autres.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Commande], [Ce qu'elle fait],
    [`conda create -n cours3 -c conda-forge python=3.12`], [crée l'environnement `cours3`, avec Python],
    [`conda activate cours3`], [le terminal emploie le Python et les programmes de `cours3` ; l'invite commence par `(cours3)`],
    [`conda install -c conda-forge pandoc`], [installe un paquet dans l'environnement actif],
    [`conda list`], [liste les paquets de l'environnement actif],
    [`conda env list`], [liste les environnements du poste ; `*` marque l'environnement actif],
  )

  #legende[
    `-n` donne le nom de l'environnement. `-c conda-forge` donne le dépôt
    d'où viennent les paquets.
  ]

  #notes[
    `base` est l'environnement installé avec Anaconda. Il contient déjà
    pandoc et Pillow : c'est pour cela que les notebooks fonctionnent sans
    ce TD.

    conda plutôt que pip : conda installe aussi des programmes qui ne sont
    pas du Python, comme pandoc, ImageMagick ou ffmpeg (projet 4).
  ]
]

// --------------------------------------------
#d("Créer l'environnement")[
  #annonce[
    Dans l'Anaconda Prompt. L'environnement contient Python et JupyterLab,
    et rien d'autre.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [1], [`conda create -n cours3 -c conda-forge python=3.12 jupyterlab`, puis `y`],
      reponse[la liste des paquets à installer, puis `done`],
    [2], [`conda activate cours3`],
      reponse[`(cours3)` en tête de l'invite],
    [3], [`pandoc --version`],
      reponse[pandoc n'est pas reconnu : il est dans `base`, pas dans `cours3`],
    [4], [`python -c "import PIL"`],
      reponse[`ModuleNotFoundError: No module named 'PIL'`],
  )

  #legende[
    `python -c` exécute le code écrit entre guillemets. Pillow s'importe
    sous le nom `PIL`.
  ]

  #notes[
    Le téléchargement de JupyterLab prend plusieurs minutes. Mesurer la
    durée de l'étape 1 sur un poste de la salle avant la séance. Si elle
    dépasse cinq minutes : lancer l'étape 1 dès le début de la séance,
    commencer la partie 1 dans `base`, et revenir aux étapes 2 à 7 quand
    l'installation est finie.

    Étapes 3 et 4 : l'erreur est attendue. Le paquet manque dans
    l'environnement actif.
  ]
]

// --------------------------------------------
#d("Installer les paquets demandés")[
  #annonce[
    `recette.ipynb` appelle pandoc ; `images.ipynb` importe Pillow. On les
    installe dans `cours3`, puis on y lance JupyterLab.
  ]

  #tableau(
    columns: (auto, 1.4fr, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire], [Ce que vous constatez],
    [5], [`conda install -c conda-forge pandoc pillow`, puis `y`],
      reponse[les deux paquets, et ceux dont ils dépendent],
    [6], [`pandoc --version`, puis `python -c "import PIL"`],
      reponse[le numéro de version de pandoc ; aucune erreur pour Pillow],
    [7], [`cd` vers le dossier `cours3/` extrait sur le Bureau, puis `jupyter lab`],
      reponse[JupyterLab dans le navigateur, le dossier `cours3/` dans le panneau de gauche],
  )

  #legende[
    Le terminal qui a lancé `jupyter lab` reste ouvert jusqu'à la fin de la
    séance : c'est le serveur des notebooks. Les notebooks s'exécutent dans
    `cours3`.
  ]

  #notes[
    Pour écrire le chemin après `cd`, glisser le dossier `cours3/` depuis
    l'explorateur dans la fenêtre du terminal.

    À la section 4.3 de `recette.ipynb`, `shutil.which("pandoc")` renvoie
    alors un chemin dans `envs\cours3\Library\bin`, et non plus dans le
    dossier d'Anaconda.

    La prochaine fois : `conda activate cours3` suffit, l'environnement
    reste sur le poste s'il n'est pas effacé à la déconnexion (à vérifier).
    Le projet 4 crée un environnement depuis un fichier `environment.yml`.
  ]
]
