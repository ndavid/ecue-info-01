// Cours 5, partie 3 — prouver qui l'on est. Incluse par `cours5.typ`.
//
// Le fil : le mot de passe, les quatre façons de le perdre, une parade par
// façon, puis la clé, qui remplace le mot de passe pour les machines et les
// programmes. Le TD 2a suit.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-cles, schema-echange-ssh
#import "../style.typ": terminal

#separateur(
  "Prouver qui l'on est",
  annonce: "Le mot de passe, les quatre façons de le perdre, les parades, et la clé qui le remplace.",
)

// --------------------------------------------
#d("Identifiant et mot de passe")[
  #annonce[
    Le serveur ne garde pas le mot de passe. Il garde son empreinte, calculée
    à l'inscription, et compare les empreintes à chaque connexion.
  ]

  #chaine(
    ("alice, puis le mot de passe", "ce que vous tapez"),
    ("empreinte", "un calcul à sens unique : SHA-256, bcrypt"),
    ("comparaison", "avec l'empreinte gardée à l'inscription"),
    gabarit: bloc, pleins: (1,),
  )

  #v(0.5em)
  #block(width: 100%, inset: (x: 12pt, y: 9pt), fill: gris)[
    #set text(font: police-code, size: 14pt)
    #grid(
      columns: (auto, 1fr), column-gutter: 16pt, row-gutter: 5pt,
      [bonjour], [2cb4b1431b84ec15d35ed83bb927e27e8967d75f4bcd9cc4b25c8d879ae23e18],
      [Bonjour], [9172e8eec99f144f72eca9a568759580edadb2cfd154857f07e657569493bc44],
    )
  ]
  #legende[
    SHA-256 de deux mots qui diffèrent d'une lettre : 64 caractères, et rien
    ne permet de remonter au mot.
  ]

  #notes[
    L'empreinte est le même calcul que l'identifiant d'un commit au cours 2 :
    un contenu donne toujours la même empreinte, une empreinte ne rend pas le
    contenu.

    Un site qui renvoie le mot de passe en clair par courriel ne l'a pas
    remplacé par son empreinte. Une empreinte volée ne donne pas le mot de
    passe ; elle permet de l'essayer hors ligne, ce que la diapositive des
    temps chiffre.

    Le nom d'utilisateur est public. Seul le mot de passe est secret.
  ]
]

// --------------------------------------------
#d("Quatre façons de perdre un mot de passe")[
  #annonce[
    Une seule dépend de sa longueur.
  ]

  #grid(
    columns: (1fr, 1fr), rows: (auto, auto), gutter: 12pt,
    bloc("1. Deviné", "essais en masse ; hors ligne, sur une fuite d'empreintes, des milliards par seconde", plein: true),
    bloc("2. Volé sur le serveur", "une fuite du site ; 22 % des intrusions commencent par un identifiant volé"),
    bloc("3. Volé chez vous", "hameçonnage, logiciel espion"),
    bloc("4. Intercepté", "réseau non chiffré, Wi-Fi ouvert"),
  )

  #legende[
    Verizon, *Data Breach Investigations Report* 2025. Les comptes déjà
    parus dans une fuite se vérifient sur haveibeenpwned.com.
  ]

  #notes[
    Deviner est la seule menace que la longueur du mot de passe traite. Les
    trois autres prennent le mot de passe tel quel, quelle que soit sa
    longueur.

    Une fuite se propage par la réutilisation : 60 à 84 % des personnes
    interrogées réutilisent un mot de passe (Bitwarden, GoDaddy, 2025). Le
    mot de passe volé sur un site est essayé sur les autres.

    L'interception concerne un réseau sans chiffrement ; HTTPS et SSH,
    partie 2, la rendent inutile, ce qui en fait la menace la moins
    fréquente aujourd'hui.
  ]
]

// --------------------------------------------
#d("Combien de temps pour le deviner")[
  #annonce[
    Hors ligne, sur une fuite d'empreintes, douze cartes graphiques essaient
    les combinaisons dans l'ordre le plus probable.
  ]

  #tableau(
    columns: (1.2fr, 1.5fr, auto),
    align: (left + horizon, left + horizon, right + horizon),
    [Mot de passe], [Comment il est trouvé], [Temps],
    [`123456`], [il est dans les listes de fuites], [instantané],
    [`Marseille2024!`], [un mot du dictionnaire, une année, un signe à la fin : les règles habituelles sont connues des programmes], [secondes à heures],
    [`k7#Qp2vL`, 8 caractères tirés au hasard], [toutes les combinaisons], [130 ans],
    [`lune orange pont carte vélo sel pluie`], [toutes les combinaisons], [hors de portée],
  )

  #legende[
    Hive Systems, table 2026 : empreintes bcrypt, deux fois huit RTX 5090. En
    ligne, le serveur limite les essais ; ces temps sont ceux d'une fuite.
  ]

  #notes[
    Le tableau se lit ligne par ligne. Les deux premières sont les mots de
    passe que les gens choisissent ; les programmes de devinette commencent
    par les listes de fuites, puis par les mots du dictionnaire avec un
    chiffre et un signe aux positions habituelles.

    Les deux dernières sont tirées au hasard ; le hasard et la longueur
    font le temps de calcul, les classes de caractères y contribuent peu.
    Sept mots pris au hasard dans une liste de 7 776 mots font 90 bits :
    au-delà de tout ce qui se calcule.

    Les formulaires qui imposent majuscule, chiffre et signe produisent la
    deuxième ligne. La CNIL (2022) raisonne en quantité de hasard :
    12 caractères de quatre classes, 14 de trois, ou une phrase de 7 mots
    sont ses trois équivalents. Ni elle ni le NIST ne recommandent plus le
    changement périodique.
  ]
]

// --------------------------------------------
#d("Hameçonnage")[
  #annonce[
    Troisième façon : le mot de passe est donné par son propriétaire, sur une
    page qui imite le site.
  ]

  #let repere-h(n) = box(
    baseline: 25%, inset: (x: 5pt, y: 1pt), fill: alerte, radius: 2pt,
    text(size: 11pt, fill: white, weight: demi-gras)[#n],
  )

  #grid(
    columns: (1.55fr, 1fr), column-gutter: 18pt, align: top,
    fenetre("Boîte de réception")[
      #set text(size: 14pt)
      #set par(leading: 0.6em)
      #grid(
        columns: (auto, 1fr), column-gutter: 10pt, row-gutter: 5pt,
        text(fill: estompe)[De :], [Service informatique \<support\@securite-compte.net\> #repere-h(1)],
        text(fill: estompe)[Objet :], [Votre compte sera suspendu dans 24 h #repere-h(2)],
      )
      #v(0.5em)
      Bonjour,

      Suite à une mise à jour de nos systèmes, vous devez confirmer votre
      identité sous 24 heures, faute de quoi votre accès sera suspendu.

      #text(fill: attention)[#underline[https://ecole.fr/compte]] #repere-h(3)
      #text(size: 12pt, fill: estompe)[(le lien pointe vers `http://ecole-fr.verif-compte.net/…`)]

      Merci de votre compréhension. \
      #text(fill: estompe)[Pièce jointe : `Formulaire.pdf.exe` #repere-h(4)]
    ],
    tableau(
      columns: (auto, 1fr),
      align: (left + top, left + top),
      [], [À lire],
      [#repere-h(1)], [le domaine de l'expéditeur : ce n'est pas celui de l'école],
      [#repere-h(2)], [l'urgence et la menace],
      [#repere-h(3)], [le domaine réel du lien, en le survolant : ce n'est pas celui affiché],
      [#repere-h(4)], [une pièce jointe exécutable],
    ),
  )

  #notes[
    Le domaine se lit comme une URL au cours 1 : ce qui précède le premier
    `/`, de droite à gauche jusqu'au deuxième point.
    `ecole-fr.verif-compte.net` est un sous-domaine de `verif-compte.net`.

    En cas de doute : ne pas cliquer, aller sur le site par son adresse
    habituelle, ou demander au service par un autre canal. Un service
    informatique ne demande pas de mot de passe par courriel.

    Message construit pour la diapositive ; le domaine n'existe pas.
  ]
]

// --------------------------------------------
#d("Une parade par menace")[
  #annonce[
    Le mot de passe de la messagerie est à protéger en premier : il
    réinitialise tous les autres.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [Menace], [Parade], [Ce que cela demande],
    [1. deviné], [long et tiré au hasard : 12 caractères, ou 7 mots], [un gestionnaire de mots de passe, qui tire au hasard et retient],
    [2. volé sur le serveur], [un mot de passe différent par service], [le même gestionnaire],
    [3. volé chez vous], [un deuxième facteur], [un téléphone, ou une clé physique],
    [4. intercepté], [le chiffrement du trajet], [HTTPS, SSH, WPA sur le Wi-Fi ; déjà en place presque partout],
  )

  #legende[
    Le gestionnaire du navigateur ou du téléphone suffit pour commencer ;
    KeePassXC et Bitwarden sont les deux libres courants.
  ]

  #notes[
    Avec un gestionnaire, on ne retient qu'un mot de passe, celui du
    gestionnaire : long, une phrase de sept mots, et nulle part ailleurs.

    Le changement périodique n'est plus recommandé (CNIL 2022, NIST) : il
    produit des mots de passe plus faibles, `Marseille2024!` puis
    `Marseille2025!`. On change un mot de passe quand il a fui.
  ]
]

// --------------------------------------------
#d("Le deuxième facteur")[
  #annonce[
    Le voleur a le mot de passe ; il n'a pas le téléphone.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr), gutter: 14pt, rows: 66pt,
    bloc("Ce que je sais", "un mot de passe", plein: true, hauteur: 100%),
    bloc("Ce que j'ai", "un téléphone, une clé physique", plein: true, hauteur: 100%),
    bloc("Ce que je suis", "une empreinte digitale, un visage", hauteur: 100%),
  )

  #v(0.4em)
  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [Forme], [Comment], [Limite],
    [code par SMS], [un code reçu par message], [détournable en faisant transférer le numéro],
    [application à codes], [un code qui change toutes les 30 s], [le code se donne sur une page d'hameçonnage],
    [clé physique, passkey], [l'appareil vérifie l'adresse du site], [aucune des deux],
  )

  #legende[
    Comptes compromis : moins 99,2 % avec un deuxième facteur, moins 98,6 %
    si le mot de passe a déjà fui (Microsoft, 2023).
  ]

  #notes[
    Deux facteurs de natures différentes : deux mots de passe ne font pas
    deux facteurs.

    GitHub l'impose à tous les comptes depuis 2023 ; à activer à la création
    du compte, avec une application à codes (celle du téléphone ou du
    gestionnaire de mots de passe). Garder les codes de secours donnés à
    l'activation : sans eux, un téléphone perdu est un compte perdu.

    Passkey : une paire de clés gardée par le téléphone ou l'ordinateur, qui
    remplace le mot de passe. Même principe que la diapositive suivante.
  ]
]

// --------------------------------------------
#d("Une clé à la place du mot de passe")[
  #annonce[
    Pour une machine ou un programme : rien à taper, rien de secret chez le
    serveur, rien d'utile sur le réseau.
  ]

  #align(center, schema-cles())

  #notes[
    Les quatre menaces, reprises : deviner une clé de 256 bits est hors de
    portée ; le serveur ne garde que la clé publique, qui ne sert à rien
    seule ; rien n'est tapé, donc rien à hameçonner ; rien de secret ne
    passe sur le réseau.

    L'image du cadenas : des cadenas ouverts distribués à tout le monde ;
    n'importe qui peut fermer une boîte avec, et seul le détenteur de la clé
    l'ouvre. Le calcul derrière est de l'arithmétique sur de grands nombres,
    hors programme. On ne peut pas retrouver la clé privée à partir de la
    publique.

    La même paire sert à la forge (`git clone git@github.com:alice/projet.git`),
    à un serveur de calcul (`ssh alice@calcul.ecole.fr`), à la copie de
    fichiers (`scp`), à l'éditeur à distance (VS Code, Remote – SSH). Une
    clé publique copiée partout où il faut ; une clé privée, sur le poste.
    Un second poste a sa propre paire. Les forges acceptent aussi HTTPS avec
    un jeton : un autre secret à garder.
  ]
]

// --------------------------------------------
#d("La connexion SSH")[
  #annonce[
    Le serveur vérifie que vous détenez la clé privée sans la recevoir.
  ]

  #align(center, schema-echange-ssh())

  #notes[
    Le défi est un nombre tiré au hasard, fermé avec la clé publique. Le
    renvoyer ouvert prouve qu'on a la clé privée. Un défi et sa réponse ne
    resservent jamais : les intercepter ne donne rien.

    Le reste de la session est chiffré aussi : SSH, *secure shell*, est un
    terminal à distance dont le contenu ne se lit pas en chemin.
  ]
]

// --------------------------------------------
#d("Les deux fichiers de la paire")[
  #annonce[
    `ssh-keygen` écrit les deux fichiers dans `.ssh/`, dans votre dossier
    personnel.
  ]

  #terminal("Anaconda Prompt", "> ssh-keygen -t ed25519 -C \"alice.martin@etu.ecole.fr\"
Enter file in which to save the key (C:\\Users\\alice\\.ssh\\id_ed25519):
Your identification has been saved in C:\\Users\\alice\\.ssh\\id_ed25519
Your public key has been saved in C:\\Users\\alice\\.ssh\\id_ed25519.pub
The key fingerprint is:
SHA256:UdftFYrZHMVT1F9jJrEyd+9auv49Mi15wkj7o+uNUm4 alice.martin@etu.ecole.fr", taille: 13pt)

  #v(0.3em)
  #tableau(
    columns: (auto, auto, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [Fichier], [Taille], [Contenu],
    [#text(fill: brun, weight: demi-gras)[`id_ed25519`]], [419 octets],
      [la clé privée, lisible par vous seul ; jamais ouverte, jamais copiée],
    [#text(fill: attention, weight: demi-gras)[`id_ed25519.pub`]], [107 octets],
      [la clé publique, une seule ligne : `ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFKIay24YXuydFOmWVIyBfd3aAkOOtGncHYAqvz+ZW75 alice.martin\@etu.ecole.fr`],
  )

  #notes[
    Sortie réelle de `ssh-keygen` (OpenSSH 9.6), chemins Windows, les deux
    questions sur la phrase de passe omises. Les trois questions se passent
    avec Entrée : emplacement par défaut, pas de phrase de passe aujourd'hui.

    La phrase de passe chiffre la clé privée sur le disque : elle protège si
    le poste est volé. Sans elle, quiconque copie le fichier a la clé. À
    recommander sur un portable personnel ; sur les postes de la salle, on
    s'en passe pour ne pas la retaper à chaque `push`.

    `-C` ajoute un commentaire, une étiquette ; `ed25519` est le type de clé
    courant, court et rapide. La ligne `SHA256:Udft…` est l'empreinte de la
    clé, le même calcul que pour un mot de passe.
  ]
]
