// TD 1a du cours 5 — « Les ordres de grandeur de votre poste ».
//
// Inclus par `cours5.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`.
#import "../../../commun/prelude.typ": *

#let td = (
  numero: "1a",
  titre: "Les ordres de grandeur de votre poste",
  annonce: "Relever les caractéristiques du poste, puis mesurer quatre temps avec un script fourni",
  dossier: "cours5/1a_mesures/",
  duree: "15′",
)
#separateur-td(..td)

#d("Le poste, dans le gestionnaire des tâches")[
  #annonce[
    `Ctrl` + `Maj` + `Échap`, onglet Performance. Relever quatre valeurs.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [Rubrique], [Où lire], [Sur votre poste],
    [Processeur], [en haut à droite : le nom ; en bas : « Cœurs », « Vitesse de base »], reponse[4 cœurs, 2 à 3 GHz selon les postes],
    [Mémoire], [en haut à droite : la taille totale], reponse[8 ou 16 Go],
    [Disque], [le titre de la rubrique : SSD ou HDD ; la capacité], reponse[SSD, 100 à 250 Go sur les VM],
    [Ethernet ou Wi-Fi], [la vitesse du lien, en bas], reponse[1 Gbit/s en Ethernet],
  )

  #legende[
    Si le gestionnaire ne s'ouvre pas : `systeminfo` dans Anaconda Prompt
    donne le processeur et la mémoire.
  ]

  #notes[
    Deux minutes. Les valeurs du corrigé sont supposées ; les relever sur
    une VM de la salle avant la séance.

    Comparer avec la diapositive « Mémoire vive et disque » : les postes sont
    dans les fourchettes données.
  ]
]

#d("Quatre mesures en Python")[
  #annonce[
    Dans Anaconda Prompt, depuis `cours5/1a_mesures/` : `python mesures.py`.
    Reporter les six lignes de résultat.
  ]

  #tableau(
    columns: (auto, 110pt, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [Mesure], [Sur votre poste], [Ce que vous constatez],
    [10 millions d'additions], [], reponse[30 à 100 ns l'addition : cent cycles du processeur],
    [copier 100 Mo en mémoire], [], reponse[quelques Go/s],
    [écrire 100 Mo sur le disque], [], reponse[100 à 500 Mo/s : dix fois moins que la mémoire],
    [relire les mêmes 100 Mo], [], reponse[plus rapide : le système en a gardé une copie en RAM],
    [un aller-retour vers github.com], [], reponse[10 à 80 ms : Europe ou États-Unis],
    [télécharger 10 Mo], [], reponse[quelques centaines de Mbit/s],
  )

  #notes[
    Le script est court : `time.perf_counter()` avant et après chaque
    opération, comme le chronomètre du projet 7.

    Sortie sur un poste Linux, septembre 2026 : 39 ns par addition ;
    1,4 Go/s en mémoire ; 90 Mo/s en écriture ; 1 300 Mo/s en relecture ;
    22 ms d'aller-retour ; 412 Mbit/s. Les valeurs des VM seront différentes,
    les rapports non.

    La relecture plus rapide que l'écriture est l'observation à commenter :
    c'est le cache du système, l'étage mémoire vive de la pyramide de la
    partie 1.

    Si le réseau ne répond pas, le script l'écrit et s'arrête là ; le reste
    des mesures est fait.
  ]
]
