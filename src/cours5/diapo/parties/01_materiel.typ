// Cours 5, partie 1 — le matériel. Incluse par `cours5.typ`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-composants, schema-coeurs, pyramide-memoire, barres-temps, photo-reperee, legende-reperes, graphe-tendances, schema-puces, schema-pixels

#separateur(
  "Le matériel",
  annonce: "Les composants d'un ordinateur, le rôle de chacun et les ordres de grandeur associés.",
)

// --------------------------------------------
#d("Les composants d'un ordinateur")[
  #align(center, schema-composants())

  #notes[
    Six composants, un rôle chacun. La suite de la partie détaille les
    trois premiers : processeur, mémoire vive, disque.

    La carte graphique servait d'abord à calculer l'image envoyée à l'écran, pour décharger le processeur de ce calcul. 
    Elle sert aujourd'hui au calcul massivement parallèle : la même opération sur chacun des millions de pixels, ou des éléments d'un tenseur, d'où ses milliers de cœurs. Elle revient en fin de partie. 
    La carte réseau relie le poste au réseau, par câble ou par Wi-Fi ; elle ouvre la partie 2.

    L'alimentation convertit le 230 V du secteur en basses tensions (12 V, 5 V, 3,3 V) pour les autres composants.

    Un portable contient les mêmes composants, soudés sur une seule carte. Un téléphone aussi.
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
    Le processeur ne se voit pas : il est sous le ventilateur, qui évacue sa chaleur.

    Ce poste n'a pas de carte graphique : l'affichage est fait par le
    processeur, ce qui suffit à un poste de bureau. 
    Les emplacements vides sont là pour en ajouter une.

    Un portable contient les mêmes éléments, soudés sur une seule carte, sans emplacement libre.
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
#d("Température du processeur")[
  #v(1em)
  #question("?")[
    Quelle température atteint un processeur qui calcule sans arrêt, par
    exemple pendant un traitement d'image de plusieurs minutes ?
  ]

  #v(1.5em)
  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 14pt,
    etiquette("40 °C"), etiquette("60 °C"), etiquette("90 °C"), etiquette("150 °C"),
  )

  #notes[
    Faire voter à main levée avant de passer à la diapositive suivante. Les
    réponses se partagent en général entre 40 et 60 °C : on juge d'après la
    tiédeur du boîtier, pas d'après la puce.
  ]
]

// --------------------------------------------
#d("Température du processeur — réponses")[
  #annonce[
    En charge, un processeur travaille entre 60 et 100 °C. À la limite fixée
    par le fabricant, il baisse de lui-même sa fréquence pour ne pas
    s'abîmer.
  ]

  #tableau(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    [Situation], [Température de la puce],
    [au repos, bureautique], [30 à 50 °C],
    [en charge, poste de bureau], [60 à 90 °C],
    [en charge, portable fin], [80 à 100 °C],
    [limite du fabricant, où la fréquence baisse], [95 °C (AMD), 100 °C (Intel)],
    [sans radiateur ni ventilateur], [la limite en quelques secondes],
  )

  #legende[
    Ordres de grandeur ; limites des Ryzen 7000 et des Core de 13#super[e]
    génération, données par les fabricants.
  ]

  #notes[
    La chaleur vient de la puissance : 65 à 250 W sur une puce de 1 à
    2,5 cm², soit 50 à 100 W par cm². Une plaque de cuisson en fait moins de
    10. D'où le radiateur, le ventilateur, et leur bruit quand un calcul
    dure.

    C'est la même limite qui a arrêté la montée en fréquence vers 2005
    (« Trente ans de processeurs », plus loin). Un portable qui ralentit
    pendant un long calcul est souvent un portable qui chauffe : la
    fréquence baisse pour rester sous la limite.

    AMD a dit en 2022 que 95 °C en charge est le fonctionnement prévu des
    Ryzen 7000, pas une anomalie. La température se lit avec un outil du
    fabricant ; le gestionnaire des tâches de Windows ne l'affiche pas pour
    le processeur.
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
    De la nanoseconde à la demi-seconde, sur une échelle logarithmique :
    chaque graduation vaut dix fois la précédente.
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
#d("Processeur et carte graphique : la puce")[
  #annonce[
    Le processeur consacre sa surface au contrôle et au cache, la carte
    graphique au calcul.
  ]

  #align(center, schema-puces())

  #legende[
    D'après NVIDIA, *CUDA C++ Programming Guide*, figure 1 ; proportions
    indicatives.
  ]

  #notes[
    Le processeur enchaîne vite des instructions variées ; la carte graphique
    fait exécuter la même instruction à des milliers d'unités simples.

    Le contrôle lit les instructions, prévoit les sauts, réordonne ce qui
    peut l'être : c'est ce qui rend un cœur de processeur rapide sur un
    programme quelconque, et c'est ce qui prend de la place. Sur la carte
    graphique, un seul contrôle pilote toute une rangée d'unités, qui font
    donc toutes la même chose au même moment.

    Le cache sert à ne pas attendre la mémoire vive (diapositive « Le chemin
    d'une donnée »). La carte graphique en a peu : pendant qu'une rangée
    attend ses données, une autre calcule.

    Les rangées dessinées sont 10 de 22 unités ; une carte courante a 3 000
    à 16 000 unités de calcul, que les fabricants appellent des cœurs.
  ]
]

// --------------------------------------------
#d("Processeur et carte graphique : une image")[
  #annonce[
    Éclaircir une image applique la même multiplication à chaque pixel. Le
    processeur traite les pixels quatre par quatre, la carte graphique tous à
    la fois.
  ]

  #align(center, schema-pixels())

  #notes[
    Même raisonnement sur une dalle d'orthophoto de 5 000 × 5 000 pixels :
    25 millions de pixels, 3 millions d'étapes sur 8 cœurs, 1 500 sur une
    carte de 16 000 cœurs. L'écart réel est plus faible : un cœur de
    processeur est plus rapide, traite plusieurs valeurs par instruction, et
    l'image doit d'abord être copiée dans la mémoire de la carte.

    La carte graphique ne sert que pour ce genre de calcul : la même
    opération sur beaucoup de données. Un programme qui enchaîne des
    décisions différentes n'y gagne rien.

    Pour le module : numpy (cours 6) fait sur le processeur le même genre
    d'opération, la même sur tout un tableau. Ce qui va sur une carte
    graphique est l'affaire des cours de traitement d'image et
    d'apprentissage, plus tard dans le cursus.

    Si le temps le permet : la démonstration des MythBusters pour NVIDIA
    (2008, 1 min 30), un robot qui peint point par point puis 1 100 tubes
    qui peignent la Joconde en 80 ms.
    https://www.youtube.com/watch?v=fKK933KK6Gg
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
    [une question à un assistant d'IA], [0,3 à 2 Wh], [10 s à 1 min de télévision],
    [la même, modèle « qui raisonne »], [7 à 33 Wh], [4 à 20 min de télévision],
    [une heure de vidéo en streaming], [80 Wh], [une ampoule LED de 10 W, 8 h],
    [garder 1 To en ligne pendant un an], [40 à 150 kWh], [1 à 3 disques toujours allumés],
    [le même To dans un tiroir], [0], [],
    [centres de données du monde, 2024], [415 TWh], [1,5 % du mondial, la France entière],
  )

  #legende[
    IA : Jegham et al. 2025, serveurs seuls ; IEA 2020 et 2025 ; disque :
    5 W × 8 760 h × 1 à 3 copies ; France : RTE 2024 ; télévision : 100 W.
  ]

  #notes[
    Les chiffres d'une question à un assistant varient de un à cent selon
    qui mesure et ce qu'il compte. Google annonce 0,24 Wh pour une question
    médiane à Gemini (2025) : c'est le chiffre le plus bas publié, donné par
    le fournisseur, et il compte les serveurs, leur refroidissement et les
    machines en attente, mais ni l'entraînement du modèle, ni la fabrication
    du matériel, ni le réseau, ni l'appareil de l'utilisateur. Jegham et al.
    (université de Rhode Island, 2025) estiment 0,4 Wh pour une question
    courte à GPT-4o, 1,8 Wh pour une longue, et plus de 30 Wh pour o3 ou
    DeepSeek-R1, qui produisent un long raisonnement avant de répondre.

    Seule une analyse de cycle de vie compte tout. Celle de Mistral AI
    (Carbone 4, avec l'ADEME, relue par Resilio et Hubblo, 2025) donne, pour
    une réponse de 400 mots-unités (tokens) de Le Chat, 1,14 g de CO₂e et
    45 mL d'eau, fabrication et entraînement compris ; elle est aussi
    commandée par le fournisseur. Générer une image coûte environ soixante
    fois plus que générer du texte (Luccioni et al., 2024).

    Ce qui pèse est le volume : une question coûte peu, des milliards par
    jour, de plus en plus longues, font la prévision de l'IEA.

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
