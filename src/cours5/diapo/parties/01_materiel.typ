// Cours 5, partie 1 — le matériel. Incluse par `cours5.typ`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-composants, schema-coeurs, pyramide-memoire, barres-temps, photo-reperee, legende-reperes, graphe-tendances

#separateur(
  "Le matériel",
  annonce: "Les composants d'un ordinateur, ce que chacun fait, et à quelle vitesse.",
)

// --------------------------------------------
#d("Les composants d'un ordinateur")[
  #align(center, schema-composants())

  #notes[
    Cinq composants, un rôle chacun. La suite de la partie détaille les
    trois premiers : processeur, mémoire vive, disque.

    La carte graphique revient en fin de partie. La carte réseau ouvre la
    partie 2.

    Un portable contient les mêmes composants, soudés sur une seule carte.
    Un téléphone aussi.
  ]
]

// Les deux photos ne sont produites qu'avec les images en place : sans
// elles, le schéma dessiné qui précède porte seul les composants.
#if captures-disponibles {
d("Un boîtier ouvert")[
  #grid(
    columns: (auto, 1fr), column-gutter: 22pt, align: top,
    photo-reperee("/illustrations/cours5/boitier_ouvert.jpg", 1400 / 1275, (
      (0.23, 0.21), (0.20, 0.77), (0.34, 0.50), (0.47, 0.42),
      (0.62, 0.53), (0.30, 0.66), (0.185, 0.58),
    ), hauteur: 290pt),
    legende-reperes(
      [l'alimentation : du 230 V aux tensions des composants],
      [la carte mère : tout s'y branche],
      [le processeur, sous son ventilateur],
      [la mémoire vive, deux barrettes],
      [le disque, dans son berceau],
      [des emplacements pour cartes, vides : pas de carte graphique séparée],
      [les connecteurs arrière : écran, réseau, USB],
    ),
  )

  #legende[
    Un PC de bureau des années 2010, panneau retiré. Photo PantheraLeo1359531,
    Wikimedia Commons, CC BY 4.0.
  ]

  #notes[
    Faire retrouver les cinq composants du schéma précédent avant de lire la
    légende. Le processeur ne se voit pas : il est sous le ventilateur, qui
    évacue sa chaleur.

    Ce poste n'a pas de carte graphique : l'affichage est fait par le
    processeur, ce qui suffit à un poste de bureau. Les emplacements vides
    sont là pour en ajouter une.

    Un portable contient les mêmes éléments, soudés sur une seule carte, sans
    emplacement libre.
  ]
]

d("La carte mère")[
  #grid(
    columns: (auto, 1fr), column-gutter: 22pt, align: top,
    photo-reperee("/illustrations/cours5/carte_mere.jpg", 1400 / 933, (
      (0.66, 0.52), (0.66, 0.80), (0.43, 0.42), (0.47, 0.60),
      (0.32, 0.72), (0.72, 0.08), (0.64, 0.93),
    ), hauteur: 290pt),
    legende-reperes(
      [le processeur, sous son ventilateur],
      [la mémoire vive : quatre emplacements, deux occupés],
      [les emplacements pour cartes ; le long reçoit la carte graphique],
      [un emplacement pour un SSD, de la taille d'une barrette de chewing-gum],
      [le jeu de puces, qui relie le reste au processeur],
      [les connecteurs arrière : USB, réseau, écran, son],
      [l'arrivée de l'alimentation, et les prises des disques],
    ),
  )

  #legende[
    Carte Gigabyte B550 de 2020, couchée, connecteurs arrière en haut. Photo
    Nicolasfoster, Wikimedia Commons, CC0.
  ]

  #notes[
    La carte mère ne calcule pas : elle relie. Chaque piste de cuivre est un
    fil, et un ensemble de fils entre deux composants s'appelle un bus.

    Ce qui se remplace sans changer de carte : la mémoire, les cartes, les
    disques. Ce qui impose la carte : le processeur, dont l'emplacement change
    avec la génération.
  ]
]
}

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
    (rouge, vert, bleu), sans compression. Le cours 3 compare la taille
    d'une même image dans plusieurs formats.
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
    Diapositive à retenir. Pendant qu'un programme attend une lecture sur
    le disque dur, le processeur aurait pu faire une journée d'accès à la
    mémoire ; pendant qu'il attend un serveur à New York, une semaine.

    Même construction chez Brendan Gregg, *Systems Performance*, avec le
    cycle du processeur pour unité : la mémoire vive y vaut 6 minutes, le
    disque dur des mois, un aller-retour intercontinental des années.

    Conséquences pour un programme, à dire : lire un fichier une fois et
    garder son contenu en mémoire, au lieu de le rouvrir à chaque tour de
    boucle ; du binaire pour des nombres, comme les images P5 du cours 3 ;
    numpy à la place d'une boucle Python (cours 6) ; `commit` en local et
    `push` quand on veut (partie 2). On mesure avant de changer ; le
    projet 7 mesure.
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
#d("Trente ans de processeurs")[
  #annonce[
    La fréquence a cessé de monter vers 2005 ; les transistors et les cœurs
    continuent.
  ]

  #align(center, graphe-tendances(hauteur: 7.9))

  #legende[
    Un point par processeur, échelle verticale logarithmique. Karl Rupp,
    *microprocessor-trend-data*, CC BY 4.0.
  ]

  #notes[
    Le nombre de transistors double tous les deux ans environ depuis 1970 :
    c'est la loi de Moore, encore à peu près vérifiée. La fréquence plafonne
    vers 3 GHz depuis 2005, parce que la puissance, donc la chaleur à
    évacuer, plafonne à 100 W. Depuis, le gain vient du nombre de cœurs : un
    programme qui n'en occupe qu'un gagne peu d'une génération à l'autre.

    Le reste de la machine sur la même période, en ordre de grandeur :
    mémoire vive 8 Mo en 1995, 16 Go en 2025 ; disque 1 Go, 1 To ; prix du
    Go de disque 1 000 \$, 2 centimes ; modem 28,8 kbit/s, fibre 1 Gbit/s.
  ]
]

// --------------------------------------------
#d("Puissance de calcul et consommation")[
  #annonce[
    Un smartphone calcule autant que le premier superordinateur à dépasser
    mille milliards d'opérations par seconde, en 1997, pour cent mille fois
    moins d'électricité.
  ]

  #tableau(
    columns: (1.4fr, auto, auto, auto),
    align: (left + horizon, right + horizon, right + horizon, right + horizon),
    [Appareil], [Opérations par seconde], [Puissance], [Électricité par an],
    [téléphone à touches], [10#super[7]], [0,01 à 0,5 W], [0,1 kWh],
    [smartphone], [10#super[12]], [1 à 5 W], [5 à 7 kWh],
    [ordinateur portable], [10#super[12]], [15 à 45 W], [30 à 60 kWh],
    [PC de bureau et carte graphique], [10#super[13] à 10#super[14]], [100 à 400 W], [200 à 400 kWh],
    [serveur, en continu], [10#super[13]], [300 à 800 W], [3 000 à 7 000 kWh],
    [ASCI Red, superordinateur, 1997], [1,3 · 10#super[12]], [850 000 W], [7 500 000 kWh],
  )

  #legende[
    Ordres de grandeur ; opérations en virgule flottante, processeur graphique
    compris. ASCI Red : 1,3 TFLOPS mesurés, 850 kW hors refroidissement.
  ]

  #notes[
    L'électricité par an suppose l'usage courant : le téléphone à touches se
    recharge une fois par semaine (batterie de 3 Wh), le smartphone tous les
    jours (15 Wh), le portable sert huit heures par jour, le serveur ne
    s'arrête jamais.

    Le téléphone à touches calcule cent mille fois moins qu'un smartphone ;
    sa batterie tient dix jours parce que sa puissance est de quelques
    dizaines de milliwatts.

    Le smartphone est un ordinateur complet : les mêmes composants que le
    boîtier, sur une puce de deux centimètres, avec une puissance limitée à
    5 W par la batterie et l'absence de ventilateur.
  ]
]

// --------------------------------------------
#d("L'électricité des services en ligne")[
  #annonce[
    Un fichier gardé en ligne consomme même quand personne ne le lit.
  ]

  #tableau(
    columns: (1fr, auto, 1fr),
    align: (left + horizon, right + horizon, left + horizon),
    [Quoi], [Électricité], [Équivalent],
    [une question à un assistant d'IA], [0,24 Wh], [neuf secondes de télévision],
    [une heure de vidéo en streaming], [80 Wh], [une ampoule LED de 10 W, huit heures],
    [garder 1 To en ligne pendant un an], [40 à 150 kWh], [un disque qui tourne sans arrêt, fois les copies],
    [le même To sur un disque dans un tiroir], [0], [],
    [les centres de données du monde, 2024], [415 TWh], [1,5 % de l'électricité mondiale, celle de la France],
  )

  #legende[
    Google, requêtes Gemini, 2025 ; IEA, streaming 2020, *Energy and AI* 2025 ;
    disque : 5 W × 8 760 h × 1 à 3 copies ; France : 450 TWh (RTE, 2024).
  ]

  #notes[
    La ligne du disque est un calcul : un disque dur qui
    tourne consomme 5 W, soit 44 kWh par an, et un centre de données garde
    deux ou trois copies de chaque fichier, plus le refroidissement.

    L'IEA prévoit le doublement de la consommation des centres de données
    d'ici 2030, surtout par l'IA. Ce qu'un étudiant peut faire : ne pas
    garder en ligne ce qui ne sert plus ; les données lourdes d'un projet
    restent sur un disque local.
  ]
]

// --------------------------------------------
#d("Ce que coûte un service en ligne")[
  #annonce[
    Le coût suit le nombre de machines qui tournent, et de personnes qui les
    font tourner.
  ]

  #tableau(
    columns: (1fr, 1.3fr, auto),
    align: (left + horizon, left + horizon, right + horizon),
    [Service], [Ce qui tourne], [Par an],
    [un site personnel, pages statiques], [une part d'un serveur partagé, ou GitHub Pages], [0 à 60 €],
    [OpenStreetMap, la carte du monde], [deux salles de serveurs, Amsterdam et Dublin], [100 000 à 170 000 €],
    [Wikipédia], [plusieurs centres de données], [3,4 M\$ d'hébergement],
    [Meta : Facebook, Instagram, WhatsApp], [des dizaines de centres de données], [72 milliards de \$ d'investissement],
  )

  #legende[
    Nom de domaine 10 € par an, hébergement partagé 3 à 5 € par mois ; OSMF,
    plan 2023, diffusion des tuiles offerte ; Wikimedia, exercice 2024-2025 ;
    Meta, résultats 2025.
  ]

  #notes[
    Trois ordres de grandeur entre un site personnel et OpenStreetMap, cinq
    entre OpenStreetMap et Meta. OpenStreetMap fonctionne avec deux salles
    parce que le rendu des tuiles est réparti entre plusieurs
    organisations et que la diffusion est offerte. La plus grande part des
    dépenses de Wikimedia est le personnel.

    Un site personnel sur GitHub Pages coûte le nom de domaine, s'il en a
    un. La forge du cours 6 le permet.
  ]
]
