// TD 2a du cours 5 — « Une clé SSH sur votre compte ».
//
// Inclus par `cours5.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`.
#import "../../../commun/prelude.typ": *
#import "../style.typ": terminal

#let td = (
  numero: "2a",
  titre: "Une clé SSH sur votre compte",
  annonce: "Fabriquer une paire de clés, coller la clé publique sur GitHub, vérifier la connexion",
  dossier: "cours5/2a_cle_ssh/",
  duree: "20′",
)
#separateur-td(..td)

#d("Fabriquer la paire de clés")[
  #annonce[
    Dans Anaconda Prompt. Entrée à chacune des trois questions.
  ]

  #terminal("Anaconda Prompt", "> ssh-keygen -t ed25519 -C \"prenom.nom@etu.ecole.fr\"
Generating public/private ed25519 key pair.
Enter file in which to save the key (C:\\Users\\vous\\.ssh\\id_ed25519):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in C:\\Users\\vous\\.ssh\\id_ed25519
Your public key has been saved in C:\\Users\\vous\\.ssh\\id_ed25519.pub", taille: 13pt)

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr),
    align: (left + horizon, left + horizon),
    [Question], [Réponse],
    [`Enter file in which to save the key`], [Entrée : l'emplacement proposé],
    [`Enter passphrase`], [Entrée, deux fois : pas de phrase de passe aujourd'hui],
    [`Overwrite (y/n)?`], [`n` : une paire existe déjà, la garder],
  )

  #notes[
    Remplacer l'adresse par la sienne : ce n'est qu'une étiquette, mais elle
    dit à qui est la clé quand on en a plusieurs sur un compte.

    `ssh-keygen` est installé d'origine sous Windows 10 et 11. Si la
    commande est introuvable, le dire : `C:\Windows\System32\OpenSSH\`
    manque au `PATH`, et Git Bash a la sienne.
  ]
]

#d("Coller la clé publique sur GitHub")[
  #annonce[
    Afficher la clé publique, copier la ligne entière, la coller dans le
    compte. Le fichier qui se termine par `.pub`, et lui seul.
  ]

  #terminal("Anaconda Prompt", "> type %USERPROFILE%\\.ssh\\id_ed25519.pub
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFKIay24YXuydFOmWVIyBfd3aAkOOtGncHYAqvz+ZW75 prenom.nom@etu.ecole.fr")

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr),
    align: (left + horizon, left + horizon),
    [Étape], [Où],
    [1. copier la ligne], [sélectionner dans le terminal, `Ctrl` + `C` ; du `ssh-ed25519` à l'adresse],
    [2. ouvrir la page des clés], [github.com → photo de profil → Settings → SSH and GPG keys → New SSH key],
    [3. coller], [Title : « poste école » ; Key : la ligne copiée ; Add SSH key],
  )


  #notes[
    Erreur fréquente : coller le contenu de `id_ed25519` (sans extension),
    la clé privée. GitHub le refuse, mais la clé a été copiée dans le
    presse-papier et peut finir dans un message. Vérifier que la ligne
    commence par `ssh-ed25519`.

    GitHub peut demander le mot de passe du compte ou le second facteur à
    l'ajout de la clé.
  ]
]

#d("Vérifier la connexion")[
  #terminal("Anaconda Prompt", "> ssh -T git@github.com
The authenticity of host 'github.com (140.82.121.4)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Hi alice-martin! You've successfully authenticated, but GitHub does not provide shell access.", taille: 12pt)

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr),
    align: (left + horizon, left + horizon),
    [Ce qui s'affiche], [Ce que cela veut dire],
    [`Are you sure you want to continue…`], reponse[première connexion : l'empreinte du serveur, `yes` une fois],
    [`Hi <compte>! You've successfully…`], reponse[la clé est reconnue],
    [`Permission denied (publickey)`], reponse[la clé publique n'est pas sur le compte, ou mauvaise ligne collée],
    [rien, puis `Connection timed out`], reponse[port 22 fermé en sortie : feuille du TD, section « port 443 »],
  )

  #notes[
    L'empreinte affichée est celle de la clé ED25519 de GitHub, publiée sur
    docs.github.com (« GitHub's SSH key fingerprints »). La comparer à la
    page est la vérification prévue. L'empreinte est ensuite gardée dans
    `.ssh/known_hosts` et n'est plus demandée.

    Si le port 22 est fermé par le pare-feu de l'école, GitHub écoute aussi
    en SSH sur le port 443 : le fichier `config` fourni dans le dossier du TD
    se copie dans `.ssh/`, et la commande est la même.
  ]
]
