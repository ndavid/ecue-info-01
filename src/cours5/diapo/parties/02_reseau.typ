// Cours 5, partie 2 — le réseau. Incluse par `cours5.typ`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-local-distant, schema-client-serveur, schema-tuyau, schema-commit-push

#separateur(
  "Le réseau",
  annonce: "Local et distant, client et serveur, débit et latence.",
)

// --------------------------------------------
#d("Local et distant")[
  #annonce[
    Entre votre poste et un serveur, une suite de liens. Chaque lien ajoute
    du temps, et la distance en ajoute le plus.
  ]

  #align(center, schema-local-distant())

  #notes[
    Le réseau local est celui de l'école : tout ce qui est avant le pare-feu.
    Au-delà, les réseaux des opérateurs, et le serveur, qui peut être
    n'importe où. GitHub est aux États-Unis, avec des relais en Europe.

    Les temps sont ceux d'un aller-retour. Ils s'additionnent : la salle
    coûte moins d'une milliseconde, la distance jusqu'au serveur des
    dizaines.
  ]
]

// --------------------------------------------
#d("Client et serveur")[
  #annonce[
    Le client envoie une requête, le serveur répond. Le serveur répond à
    beaucoup de clients à la fois.
  ]

  #align(center, schema-client-serveur())

  #v(0.15em)
  #tableau(
    columns: (1fr, 1fr, 1.4fr),
    align: left + horizon,
    [Client], [Serveur], [La requête],
    [le navigateur], [le site web], [« donne-moi cette page »],
    [`git push`], [la forge], [« voici mes nouveaux commits »],
    [`ssh`], [un serveur de calcul], [« ouvre-moi un terminal chez toi »],
  )

  #notes[
    Client et serveur ont été vus au cours 1 avec le notebook : le client
    affiche, le serveur exécute. Le cours 6 ajoute `git pull`, la requête
    dans l'autre sens.
  ]
]

// --------------------------------------------
#d("Adresse, nom et port")[
  #annonce[
    Pour joindre un serveur, il faut son adresse, et savoir à quel service on
    s'adresse dessus.
  ]

  #tableau(
    columns: (auto, auto, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [Élément], [Exemple], [Rôle],
    [adresse IP], [`140.82.121.4`], [le numéro de la machine sur le réseau],
    [nom de domaine], [`github.com`], [le nom qu'on retient ; le DNS le traduit en adresse],
    [port], [`443`, `22`], [le service visé sur la machine : le web, SSH],
    [protocole], [`https`, `ssh`], [la langue parlée sur ce port],
  )

  #v(0.5em)
  #grid(
    columns: (1fr, 1fr), align: center,
    [
      #set text(font: police-code, size: 18pt)
      #text(fill: estompe)[https://]#text(fill: brun, weight: demi-gras)[github.com]#text(fill: estompe)[/alice/projet]
    ],
    [
      #set text(font: police-code, size: 18pt)
      #text(fill: estompe)[ssh alice\@]#text(fill: brun, weight: demi-gras)[calcul.ecole.fr]
    ],
  )
  #legende[Le nom de domaine, en brun : c'est lui qui dit à qui l'on parle.]

  #notes[
    Le DNS est un annuaire : la question « quelle est l'adresse de
    github.com ? » est elle-même une requête réseau, faite une fois puis
    gardée en mémoire.

    Le port 443 est celui du web chiffré, le 22 celui de SSH. Un pare-feu
    d'école peut fermer le 22 en sortie : c'est à vérifier avant le TD 2a.

    Le nom de domaine est ce qu'on lit dans une adresse pour savoir à qui on
    parle : la partie 4 y revient, sur l'hameçonnage.
  ]
]

// --------------------------------------------
#d("Débit et latence")[
  #annonce[
    Deux grandeurs indépendantes : le temps d'arrivée du premier octet, et
    le nombre d'octets qui arrivent chaque seconde.
  ]

  #align(center, schema-tuyau())

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [temps = latence + taille ÷ débit], [1 Ko sur une fibre à 1 Gbit/s], [1 Go sur la même fibre],
    [Paris – New York, 75 ms], [75 ms + 0,008 ms : la latence seule compte], [75 ms + 8 s : le débit seul compte],
  )

  #notes[
    Un petit message ne coûte que la latence ; un gros fichier ne coûte que
    le débit. Un `git push` ordinaire est du premier cas : quelques Ko, et
    l'attente est celle des allers-retours.

    Le débit se compte en bits par seconde, la taille des fichiers en octets :
    la diapositive suivante.
  ]
]

// --------------------------------------------
#d("La latence dépend de la distance")[
  #annonce[
    Dans la fibre, la lumière parcourt 200 000 km par seconde. Un aller-retour
    ne peut pas aller plus vite que la distance ne le permet.
  ]

  #tableau(
    columns: (auto, auto, auto, 1fr),
    align: (left + horizon, right + horizon, right + horizon, left + horizon),
    [Depuis Paris, vers], [Distance], [Aller-retour mesuré], [Part de la vitesse de la lumière],
    [Londres], [341 km], [7 ms], [49 %],
    [Marseille], [662 km], [13 ms], [55 %],
    [New York], [5 812 km], [75 ms], [77 %],
    [Johannesburg], [8 732 km], [155 ms], [57 %],
    [Tokyo], [9 717 km], [242 ms], [40 %],
    [Sydney], [16 964 km], [267 ms], [64 %],
  )

  #legende[
    Moyennes mesurées entre serveurs, wondernetwork.com, septembre 2026. La
    dernière colonne compare au temps qu'aurait mis la lumière dans une fibre
    tendue en ligne droite.
  ]

  #notes[
    Aucune amélioration matérielle ne fera passer Paris–Sydney sous
    170 ms, le temps de la lumière sur l'aller-retour. Ce qui se gagne
    encore est dans les détours des câbles et les équipements traversés,
    d'où la dernière colonne.

    Conséquence pour les services : les gros sites ont des serveurs sur
    chaque continent.
  ]
]

// --------------------------------------------
#d("Le débit dépend du lien")[
  #annonce[
    Le lien le plus lent du trajet fixe le débit. Le plus souvent, c'est le
    dernier : le Wi-Fi ou la 4G.
  ]

  #tableau(
    columns: (1fr, auto, auto),
    align: (left + horizon, right + horizon, right + horizon),
    [Lien], [Débit courant], [Transférer 1 Go],
    [Ethernet de la salle, câble], [1 Gbit/s], [8 s],
    [Fibre à domicile], [300 Mbit/s à 1 Gbit/s], [8 à 27 s],
    [Wi-Fi], [50 à 300 Mbit/s], [27 s à 3 min],
    [4G], [10 à 50 Mbit/s], [3 à 13 min],
    [ADSL], [10 Mbit/s], [13 min],
  )

  #avertissement[
    Les débits sont en bits par seconde, les fichiers en octets : 1 Gbit/s
    transfère 125 Mo par seconde.
  ]

  #notes[
    Le facteur 8 est l'erreur la plus fréquente sur ces calculs. Les débits
    des opérateurs sont toujours donnés en bits par seconde.

    Les débits du tableau sont ceux qu'on observe en pratique. Le TD 1a en
    mesure un depuis la salle.
  ]
]

// --------------------------------------------
#d("Le sans-fil")[
  #annonce[
    Portée, débit, latence et consommation changent d'une technologie à
    l'autre.
  ]

  #tableau(
    columns: (0.65fr, 0.95fr, 1.35fr, 0.7fr, 1.35fr),
    align: (left + horizon, left + horizon, left + horizon, left + horizon, left + horizon),
    [Lien], [Portée], [Débit], [Latence], [Sert à],
    [Bluetooth], [10 m], [1 à 2 Mbit/s], [10 ms], [écouteurs, capteurs],
    [Wi-Fi], [10 à 50 m], [100 à 1 000 Mbit/s, partagés], [2 à 10 ms], [la salle, la maison],
    [4G ; 5G], [1 à 10 km], [10 à 100 ; 100 à 1 000 Mbit/s], [40 ms ; 15 ms], [le terrain : RTK, cartes],
    [LoRa], [2 à 15 km], [0,3 à 50 kbit/s], [secondes], [un capteur, des années de pile],
    [GNSS], [satellites, 20 000 km], [50 bit/s, réception seule], [], [se positionner],
  )

  #legende[
    Une onde est partagée : le débit du Wi-Fi se divise entre les postes de
    la salle. Une onde s'écoute : sans chiffrement (WPA, puis HTTPS et SSH),
    quiconque est à portée lit ce qui passe.
  ]

  #notes[
    Débits et latences observés en pratique. Le Wi-Fi de la
    salle donne moins que le câble, et d'autant moins qu'il y a de postes
    connectés : c'est pourquoi les postes de la salle sont câblés.

    Le GNSS reçoit seulement : le récepteur écoute les satellites et calcule
    sa position ; il n'envoie rien. Les 50 bit/s sont le message de
    navigation, d'où les 30 secondes de la première position à froid. Les
    corrections RTK, elles, arrivent par la 4G.

    LoRa est le lien des capteurs : un relevé par heure, une pile qui dure
    cinq ans.

    Le chiffrement du Wi-Fi protège de qui est à portée ; celui de HTTPS et
    de SSH protège sur tout le trajet, y compris chez l'opérateur. La partie
    3 y revient, parmi les quatre façons de perdre un mot de passe.
  ]
]

// --------------------------------------------
#d("Un commit et un push")[
  #annonce[
    Le commit écrit sur le disque du poste, le push traverse le réseau. Git
    est fait pour qu'on puisse travailler sans réseau et pousser plus tard.
  ]

  #align(center, schema-commit-push())

  #notes[
    Un outil qui enregistrerait directement sur le serveur attendrait le
    réseau à chaque enregistrement, et ne fonctionnerait pas sans réseau.

    Le cours 6 fait le geste : `push`, puis `pull` pour recevoir ce que
    d'autres ont poussé.
  ]
]
