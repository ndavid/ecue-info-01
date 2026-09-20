// Cours 5, partie 1 — le matériel. Incluse par `cours5.typ`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-composants, schema-coeurs, pyramide-memoire, barres-temps

#separateur(
  "Le matériel",
  annonce: "Les composants d'un ordinateur, ce que chacun fait, et à quelle vitesse.",
)

// --------------------------------------------
#d("Les composants d'un ordinateur")[
  #align(center, schema-composants())

  #notes[
    Cinq composants, un rôle chacun. Le reste de la partie ne parle que des
    trois premiers : processeur, mémoire vive, disque.

    La carte graphique revient en fin de partie. La carte réseau ouvre la
    partie 2.

    Un portable contient les mêmes composants, soudés sur une seule carte.
    Un téléphone aussi.
  ]
]

// --------------------------------------------
#d("Le processeur")[
  #annonce[
    Il exécute les instructions du programme une par une. Un cœur suit une
    file d'instructions ; une cadence de 3 GHz est de 3 milliards de cycles
    par seconde.
  ]

  #align(center, schema-coeurs())

  #legende[
    Un programme Python ordinaire occupe un seul cœur. Les trois autres
    servent aux autres programmes ouverts.
  ]

  #notes[
    Une instruction est une opération élémentaire : lire une valeur en
    mémoire, additionner, comparer, sauter à une autre instruction. Une ligne
    de Python en vaut des dizaines à des centaines.

    Les postes de la salle ont 4 cœurs (à relever au TD 1a) ; un portable en
    a 4 à 8, un serveur de calcul 32 à 128.
  ]
]

// --------------------------------------------
#d("Mémoire vive et disque")[
  #annonce[
    Deux mémoires. La mémoire vive est rapide et s'efface à l'extinction ; le
    disque est lent et conserve.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [], [Mémoire vive (RAM)], [Disque (SSD, disque dur)],
    [Taille], [8 à 32 Go], [500 Go à 4 To],
    [Temps d'accès], [100 ns], [100 µs (SSD), 10 ms (disque dur)],
    [À l'extinction], [effacée], [conservé],
    [Ce qu'on y trouve], [les variables d'un programme en cours], [les fichiers, les programmes installés],
  )

  #legende[
    Au cours 1 : un fichier conserve un résultat après l'arrêt du programme.
    Il le peut parce qu'il est sur le disque.
  ]

  #notes[
    Ouvrir un fichier, c'est le copier du disque vers la mémoire vive ;
    l'enregistrer, c'est le recopier dans l'autre sens. Un travail non
    enregistré n'existe qu'en mémoire vive.

    SSD et disque dur : le premier est de la mémoire flash sans pièce mobile,
    le second un plateau qui tourne, cent fois plus lent à l'accès. Les
    postes de la salle ont un SSD (à relever au TD 1a).
  ]
]

// --------------------------------------------
#d("Le chemin d'une donnée")[
  #annonce[
    Une donnée traitée par le processeur passe par tous les étages : plus
    l'étage est proche du processeur, plus il est petit et rapide.
  ]

  #align(center, pyramide-memoire())

  #notes[
    Le cache est une petite mémoire dans le processeur, qui garde ce qui vient
    d'être lu en mémoire vive. Il n'est pas visible du programmeur, mais il
    explique qu'une boucle qui lit des valeurs voisines aille plus vite qu'une
    boucle qui saute d'un bout à l'autre d'un tableau (projet 7).

    Le réseau est un étage de plus : un fichier sur un serveur est plus loin
    encore que le disque.
  ]
]

// --------------------------------------------
#d("Ordres de grandeur : tailles")[
  #annonce[
    Un facteur mille entre chaque unité.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: (left + horizon, right + horizon, left + horizon),
    [Unité], [Octets], [Un exemple],
    [1 octet], [1], [une lettre : `a`],
    [1 Ko], [1 000], [le poème du cours 1, 1 341 caractères : 1,3 Ko],
    [1 Mo], [1 000 000], [une photo de téléphone : 3 Mo],
    [100 Mo], [10#super[8]], [une dalle d'orthophoto, 5 000 × 5 000 pixels × 3 octets : 75 Mo],
    [1 Go], [10#super[9]], [une heure de vidéo HD : 1 à 3 Go ; Anaconda installé : 5 Go],
    [1 To], [10#super[12]], [le disque d'un portable],
  )

  #notes[
    Ko, Mo, Go, To : kilo, méga, giga, téra, comme pour les mètres.

    Kio, Mio, Gio (1 024, 1 024², 1 024³) sont les puissances de deux.
    L'explorateur Windows affiche des Kio en les appelant « Ko » : un disque
    vendu 1 To y apparaît à 931 « Go ». Ne pas s'y attarder.

    La dalle d'orthophoto : 25 millions de pixels, trois octets par pixel
    (rouge, vert, bleu), sans compression. Le cours 3 a vu que le PNG et le
    JPEG compressent.
  ]
]

// --------------------------------------------
#d("Ordres de grandeur : temps d'accès")[
  #annonce[
    De la nanoseconde à la demi-seconde. Chaque graduation vaut dix fois la
    précédente.
  ]

  #barres-temps((
    ([cache du processeur], 1e-9, [1 ns], accent),
    ([mémoire vive], 1e-7, [100 ns], accent),
    ([SSD], 1e-4, [100 µs], accent),
    ([disque dur], 1e-2, [10 ms], accent),
    ([réseau de la salle], 5e-4, [0,5 ms], attention),
    ([Paris – Marseille], 1.3e-2, [13 ms], attention),
    ([Paris – New York], 7.5e-2, [75 ms], attention),
    ([Paris – Sydney], 2.7e-1, [270 ms], attention),
  ))

  #legende[
    Temps d'un accès ou d'un aller-retour, valeurs typiques ; réseau mesuré
    depuis Paris (wondernetwork.com, septembre 2026).
  ]

  #notes[
    Lire la diapositive de haut en bas : chaque barre est mille fois plus
    longue que celle qui précède, à peu près. Le réseau, en bleu clair, part
    au niveau du disque dur et va bien au-delà.

    Ce sont des temps d'accès : le temps pour obtenir le premier octet.
    Les débits sont traités en partie 2.
  ]
]

// --------------------------------------------
#d("Si la mémoire vive valait une seconde")[
  #annonce[
    La même échelle, tout multiplié par dix millions.
  ]

  #tableau(
    columns: (1fr, auto, auto),
    align: (left + horizon, right + horizon, right + horizon),
    [Accès], [Temps réel], [À l'échelle],
    [cache du processeur], [1 ns], [un centième de seconde],
    [mémoire vive], [100 ns], [1 seconde],
    [SSD], [100 µs], [un quart d'heure],
    [disque dur], [10 ms], [une journée],
    [Paris – Marseille, aller-retour], [13 ms], [un jour et demi],
    [Paris – New York, aller-retour], [75 ms], [une semaine],
    [Paris – Sydney, aller-retour], [270 ms], [un mois],
  )

  #notes[
    C'est la diapositive à retenir de la partie. Pendant qu'un programme
    attend un fichier sur le disque, le processeur aurait pu faire une
    journée de travail en mémoire ; pendant qu'il attend un serveur à
    New York, une semaine.

    Même construction chez Brendan Gregg, *Systems Performance*, avec le
    cycle du processeur pour unité : la mémoire vive y vaut 6 minutes, le
    disque dur des mois, un aller-retour intercontinental des années.
  ]
]

// --------------------------------------------
#d("Processeur et carte graphique")[
  #annonce[
    Quelques cœurs rapides d'un côté, des milliers de cœurs simples de
    l'autre : la carte graphique sert quand la même opération s'applique à
    des millions de valeurs.
  ]

  #face-a-face(
    panneau("Processeur : 4 à 8 cœurs")[
      #align(center)[
        #grid(
          columns: (1fr,) * 4, gutter: 8pt,
          ..range(8).map(_ => rect(width: 100%, height: 34pt, fill: accent.lighten(80%), stroke: 1pt + accent)),
        )
      ]
      #v(0.4em)
      #text(size: 15pt, fill: estompe)[
        n'importe quel programme ; une instruction différente à chaque cycle
      ]
    ],
    panneau("Carte graphique : des milliers de cœurs")[
      #align(center)[
        #grid(
          columns: (1fr,) * 24, gutter: 2.5pt,
          ..range(24 * 8).map(_ => rect(width: 100%, height: 7.5pt, fill: accent.lighten(80%), stroke: 0.5pt + accent)),
        )
      ]
      #v(0.4em)
      #text(size: 15pt, fill: estompe)[
        la même instruction sur tous les pixels d'une image, tous les
        éléments d'un tableau, tous les poids d'un réseau de neurones
      ]
    ],
  )

  #notes[
    Les cœurs dessinés à droite sont 192 ; une carte courante en a 3 000 à
    16 000.

    Pour le module : numpy (cours 6) fait sur le processeur le même genre
    d'opération, la même sur tout un tableau. Ce qui va sur une carte
    graphique est l'affaire des cours de traitement d'image et
    d'apprentissage, plus tard dans le cursus.
  ]
]

// --------------------------------------------
#d("Ce que cela change pour un programme")[
  #annonce[
    Un programme passe le plus souvent son temps à attendre le disque ou le
    réseau.
  ]

  #tableau(
    columns: (1fr, 1fr, auto),
    align: (left + horizon, left + horizon, left + horizon),
    [Lent], [Plus rapide], [Vu],
    [rouvrir le fichier à chaque tour de boucle], [le lire une fois, garder son contenu en mémoire], [cours 3],
    [un fichier texte de nombres], [le même en binaire : pas de conversion à la lecture], [cours 3],
    [une boucle Python sur un tableau], [numpy : la boucle est compilée], [cours 6],
    [attendre le réseau à chaque enregistrement], [`commit` en local, `push` quand on veut], [partie 2],
  )

  #notes[
    Aucune de ces règles n'est à appliquer d'avance : on mesure d'abord, on
    change ensuite. Le projet 7 mesure.
  ]
]
