// Cours 5, partie 3 — s'identifier auprès d'une machine distante.
// Incluse par `cours5.typ`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": schema-cles, schema-echange-ssh
#import "../style.typ": terminal

#separateur(
  "S'identifier auprès d'une machine distante",
  annonce: "Une paire de clés à la place d'un mot de passe : comment elle marche, et où elle sert.",
)

// --------------------------------------------
#d("Prouver qui l'on est")[
  #annonce[
    Un mot de passe est un secret que le serveur connaît aussi, et qui
    traverse le réseau. Une clé est un secret qui ne quitte pas votre poste.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [], [Mot de passe], [Paire de clés],
    [Le secret est], [chez vous et chez le serveur], [chez vous seulement],
    [Ce qui traverse le réseau], [le mot de passe lui-même], [une réponse à un défi, différente à chaque fois],
    [Si le serveur est piraté], [le mot de passe est pris, et tous les sites où il est réutilisé], [le pirate n'a que la clé publique, qui ne sert à rien seule],
    [Pour un script ou un outil], [à taper à chaque fois], [rien à taper],
  )

  #notes[
    Les forges acceptent les deux ; les serveurs de calcul de l'école
    demandent en général la clé. Le module choisit la clé parce qu'elle sert
    partout, et parce que git la demande à chaque `push`.

    Où la même paire sert, à dire : la forge (`git clone
    git@github.com:alice/projet.git`), un serveur de calcul (`ssh
    alice@calcul.ecole.fr`), la copie de fichiers (`scp`), l'éditeur à
    distance (VS Code, extension Remote – SSH). Une seule clé publique,
    copiée partout où il faut ; une seule clé privée, sur le poste. Un
    second poste veut sa propre paire. Les forges acceptent aussi HTTPS avec
    un jeton : un autre secret à garder.
  ]
]

// --------------------------------------------
#d("Une paire de clés")[
  #annonce[
    Deux fichiers fabriqués ensemble. Ce que la clé publique ferme, seule la
    clé privée l'ouvre.
  ]

  #align(center, schema-cles())

  #notes[
    L'image du cadenas : on peut distribuer des cadenas ouverts à tout le
    monde ; n'importe qui peut fermer une boîte avec, et seul le détenteur de
    la clé l'ouvre.

    Le calcul derrière est de l'arithmétique sur de grands nombres ; il n'est
    pas au programme. On ne peut pas retrouver la clé privée à partir de la
    publique.
  ]
]

// --------------------------------------------
#d("La connexion SSH")[
  #annonce[
    Le serveur vérifie que vous détenez la clé privée sans jamais la
    recevoir.
  ]

  #align(center, schema-echange-ssh())

  #notes[
    Le défi est un nombre tiré au hasard, fermé avec la clé publique. Le
    renvoyer ouvert prouve qu'on a la clé privée. Un pirate qui écoute la
    ligne voit un défi et sa réponse, qui ne resserviront jamais.

    Tout le reste de la session est chiffré aussi : SSH veut dire *secure
    shell*, un terminal à distance dont personne ne lit le contenu en chemin.
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

    `-C` ajoute un commentaire, qui n'est qu'une étiquette ; `ed25519` est
    le type de clé courant, court et rapide.
  ]
]

// --------------------------------------------
#d("Empreinte et chiffrement")[
  #annonce[
    Deux calculs différents. L'empreinte identifie sans qu'on puisse revenir
    en arrière ; le chiffrement cache, et la clé permet de revenir.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [], [Empreinte (hachage, SHA-256)], [Chiffrement],
    [Sens], [unique : impossible de retrouver l'entrée], [réversible, avec la clé],
    [Sert à], [identifier, vérifier], [cacher],
    [Vu], [l'identifiant d'un commit (cours 2), l'empreinte d'une clé], [SSH, HTTPS, la phrase de passe d'une clé],
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
    SHA-256 de deux mots qui diffèrent d'une lettre. Toujours 64 caractères,
    quelle que soit la taille de l'entrée.
  ]

  #notes[
    Le SHA du cours 2 est une empreinte du contenu du commit : deux commits
    au contenu différent ont des empreintes différentes, et l'empreinte
    change dès qu'un octet change. Même chose pour la ligne
    `SHA256:Udft…` de `ssh-keygen`.

    Un site correctement fait ne stocke pas les mots de passe mais leur
    empreinte : il vérifie sans connaître. Un site capable de renvoyer votre
    mot de passe en clair le stocke donc sans empreinte.
  ]
]
