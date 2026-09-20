// Cours 5, partie 4 — secrets et sécurité. Incluse par `cours5.typ`.
#import "../../../commun/prelude.typ": *
#import "../style.typ": terminal

#separateur(
  "Secrets et sécurité",
  annonce: "Ce qui ne doit jamais entrer dans un dépôt, et cinq gestes qui protègent un compte.",
)

// --------------------------------------------
#d("Ce qui est un secret")[
  #annonce[
    Un secret est ce qui donne accès à quelque chose. Il ne va ni dans un
    dépôt, ni dans un message, ni dans une capture d'écran.
  ]

  #face-a-face(
    panneau("À garder")[
      #tableau(
        columns: (auto, 1fr),
        align: (left + horizon, left + horizon),
        [Quoi], [Donne accès à],
        [#text(fill: brun, weight: demi-gras)[clé privée SSH]], [vos comptes, vos serveurs],
        [#text(fill: brun, weight: demi-gras)[mot de passe]], [un compte],
        [#text(fill: brun, weight: demi-gras)[jeton d'API]], [un service payant ou limité : clé IGN, clé d'un service d'IA],
        [#text(fill: brun, weight: demi-gras)[fichier `.env`, `config.py`]], [là où l'on range les trois précédents],
      )
    ],
    panneau("À partager")[
      #tableau(
        columns: (auto, 1fr),
        align: (left + horizon, left + horizon),
        [Quoi], [Pourquoi],
        [#text(fill: attention, weight: demi-gras)[clé publique SSH]], [ne sert à rien sans la privée],
        [#text(fill: attention, weight: demi-gras)[le code]], [c'est ce qu'on rend],
        [#text(fill: attention, weight: demi-gras)[README, `environment.yml`]], [c'est ce qui permet de le relancer],
        [#text(fill: attention, weight: demi-gras)[données publiques]], [orthophotos, BD TOPO],
      )
    ],
  )

  #notes[
    Un jeton d'API est un mot de passe pour programme : une chaîne que le
    script envoie au service. Les services de l'IGN, de cartographie ou d'IA
    en donnent un par compte ; la facture ou le quota va sur ce compte.

    Les données personnelles des autres (un CSV de noms et d'adresses) sont
    un cas à part, régi par le RGPD : pas dans un dépôt public non plus.
  ]
]

// --------------------------------------------
#d("Un secret dans un dépôt y reste")[
  #annonce[
    Le commit qui supprime le fichier ne supprime pas le commit qui l'a
    ajouté. `git log -p` montre les deux.
  ]

  #terminal("Anaconda Prompt", "> git log --oneline
449f325 Supprime la clé du dépôt
856b116 Premier script de carte
> git log -p -- config.py
commit 449f325  Supprime la clé du dépôt
    -CLE_IGN = \"d7f3a9c1e5b24086\"
commit 856b116  Premier script de carte
    +CLE_IGN = \"d7f3a9c1e5b24086\"")

  #legende[
    Sortie réelle, abrégée. En 2025, 28,65 millions de secrets ont été
    ajoutés dans des commits publics sur GitHub ; 64 % de ceux trouvés en 2022
    étaient encore valides en 2026 (GitGuardian, *State of Secrets Sprawl 2026*).
  ]

  #notes[
    Une fois poussé sur une forge publique, un secret a été copié avant
    d'être supprimé : des robots lisent chaque commit public en continu et
    testent les clés dans la minute.

    Le TD 3a rejoue cette sortie. Il est facultatif parce que la diapositive
    suffit à le montrer.
  ]
]

// --------------------------------------------
#d("Séparer le code et les secrets")[
  #annonce[
    Le code lit le secret dans un fichier que git ignore. Le dépôt contient
    un modèle de ce fichier, sans la valeur.
  ]

  #face-a-face(
    panneau("Dans le dépôt, pour tout le monde")[
      #block(width: 100%, inset: (x: 12pt, y: 10pt), fill: gris)[
        #set text(size: 17pt)
        #raw(block: true, "carte.py            import config
                    cle = config.CLE_IGN
config.example.py   CLE_IGN = \"à remplir\"
.gitignore          config.py
README.md")
      ]
    ],
    panneau("Sur votre poste seulement")[
      #block(width: 100%, inset: (x: 12pt, y: 10pt), stroke: 1.2pt + brun)[
        #set text(size: 17pt)
        #raw(block: true, "config.py           CLE_IGN = \"d7f3a9c1e5b24086\"")
      ]
      #v(0.5em)
      #text(size: 15pt, fill: estompe)[
        Qui clone le dépôt copie `config.example.py` en `config.py` et y met
        sa propre clé. `git status` ne voit jamais `config.py`.
      ]
    ],
  )

  #notes[
    C'est le `.gitignore` du cours 2, avec une raison de plus de s'en
    servir. Le fichier ignoré peut aussi être un `.env` lu par le
    programme ; l'idée est la même.

    Vérifier avant de committer : `git status` ne doit pas lister le fichier
    du secret. Les forges détectent une partie des jetons poussés et
    préviennent ; ne pas compter dessus.
  ]
]

// --------------------------------------------
#d("Si un secret a fui")[
  #annonce[
    Supprimer le fichier ne suffit pas. Le secret est d'abord rendu inutile,
    puis remplacé.
  ]

  #chaine(
    ("Révoquer", "régénérer la clé sur le service qui l'a émise"),
    ("Remplacer", "mettre la nouvelle dans le fichier ignoré"),
    ("Nettoyer", "réécrire l'historique, ou recréer le dépôt"),
    ("Prévenir", "le responsable du projet ou du service"),
    gabarit: bloc, pleins: (0,),
  )

  #legende[
    La première étape passe avant les autres : l'historique a déjà été copié.
  ]

  #notes[
    Réécrire un historique se fait avec `git filter-repo` ; ce n'est pas au
    programme, et sur un petit projet il est plus simple de recréer le dépôt
    sans le commit fautif.

    Pour un mot de passe personnel qui a fui, la démarche est la même :
    changer, d'abord là, puis partout où il était réutilisé.
  ]
]

// --------------------------------------------
#d("Mots de passe")[
  #annonce[
    La longueur compte plus que la complexité, et un mot de passe ne sert
    qu'à un seul service.
  ]

  #tableau(
    columns: (1fr, auto),
    align: (left + horizon, left + horizon),
    [Trois niveaux équivalents], [Exemple],
    [12 caractères, majuscules, minuscules, chiffres et signes], [`Tr4v#l-9Kq!m`],
    [14 caractères, majuscules, minuscules et chiffres], [`ortho2026Lidar`],
    [une phrase de 7 mots], [`lune orange pont carte vélo sel pluie`],
  )

  #v(0.5em)
  #tableau(
    columns: (auto, 1fr),
    align: (left + horizon, left + horizon),
    [Règle], [Pourquoi],
    [un mot de passe par service], [un site piraté ne donne pas accès aux autres],
    [un gestionnaire de mots de passe], [il les invente et les retient ; vous n'en retenez qu'un],
    [pas de changement périodique], [un changement forcé produit des mots de passe plus faibles],
  )

  #legende[
    Niveaux et règles : CNIL, recommandation du 21 juillet 2022.
  ]

  #notes[
    La CNIL raisonne en entropie ; les trois lignes du premier tableau sont
    ses trois équivalents de 80 bits. Les exemples sont à ne pas réutiliser.

    Un gestionnaire : celui du navigateur ou du téléphone suffit pour
    commencer ; KeePassXC ou Bitwarden sont les deux libres courants.

    Le site haveibeenpwned.com dit si une adresse figure dans une fuite
    connue. À montrer si le temps le permet.
  ]
]

// --------------------------------------------
#d("Deuxième facteur")[
  #annonce[
    Un mot de passe volé ne suffit plus si le compte demande aussi quelque
    chose que le voleur n'a pas.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr), gutter: 14pt, rows: 100pt,
    bloc("Ce que je sais", "un mot de passe", plein: true, hauteur: 100%),
    bloc("Ce que j'ai", "un téléphone (application, SMS), une clé physique", plein: true, hauteur: 100%),
    bloc("Ce que je suis", "une empreinte digitale, un visage", hauteur: 100%),
  )

  #v(0.6em)
  #tableau(
    columns: (auto, 1fr),
    align: (left + horizon, left + horizon),
    [Où l'activer aujourd'hui], [Comment],
    [GitHub], [obligatoire pour tous les comptes depuis 2023 : Settings → Password and authentication],
    [la messagerie, la banque, l'école], [dans les réglages du compte ; une application d'authentification plutôt que le SMS],
  )

  #notes[
    Deux facteurs de natures différentes : deux mots de passe ne font pas
    deux facteurs.

    L'application d'authentification (Google Authenticator, Microsoft
    Authenticator, ou celle du gestionnaire de mots de passe) donne un code
    qui change toutes les 30 secondes. Garder les codes de secours que le
    service donne à l'activation : sans eux, un téléphone perdu est un compte
    perdu.
  ]
]

// --------------------------------------------
#d("Hameçonnage")[
  #annonce[
    Un message qui demande d'agir vite, par un lien. Quatre choses à lire
    avant de cliquer.
  ]

  #let repere(n) = box(
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
        text(fill: estompe)[De :], [Service informatique \<support\@securite-compte.net\> #repere(1)],
        text(fill: estompe)[Objet :], [Votre compte sera suspendu dans 24 h #repere(2)],
      )
      #v(0.5em)
      Bonjour,

      Suite à une mise à jour de nos systèmes, vous devez confirmer votre
      identité sous 24 heures, faute de quoi votre accès sera suspendu.

      #text(fill: attention)[#underline[https://ecole.fr/compte]] #repere(3)
      #text(size: 12pt, fill: estompe)[(le lien pointe vers `http://ecole-fr.verif-compte.net/…`)]

      Merci de votre compréhension. \
      #text(fill: estompe)[Pièce jointe : `Formulaire.pdf.exe` #repere(4)]
    ],
    tableau(
      columns: (auto, 1fr),
      align: (left + top, left + top),
      [], [À lire],
      [#repere(1)], [le domaine de l'expéditeur : ce n'est pas celui de l'école],
      [#repere(2)], [l'urgence et la menace],
      [#repere(3)], [le domaine réel du lien, en le survolant : ce n'est pas celui affiché],
      [#repere(4)], [une pièce jointe exécutable],
    ),
  )

  #notes[
    Le domaine se lit comme au cours 1 et à la partie 2 : ce qui précède le
    premier `/`, de droite à gauche jusqu'au deuxième point.
    `ecole-fr.verif-compte.net` est un sous-domaine de `verif-compte.net`.

    En cas de doute : ne pas cliquer, aller sur le site par son adresse
    habituelle, ou demander au service par un autre canal. Un vrai service
    informatique ne demande jamais un mot de passe par courriel.

    Message construit pour la diapositive ; le domaine n'existe pas.
  ]
]

// --------------------------------------------
#d("Mises à jour et sauvegardes")[
  #annonce[
    Une mise à jour ferme une faille connue et publiée. Une sauvegarde
    rend un poste perdu, volé ou chiffré sans conséquence.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    [], [Mises à jour], [Sauvegardes],
    [Quoi], [système, navigateur, Anaconda, les applications du téléphone], [ce qui ne se refait pas : documents, données, photos],
    [Quand], [dès qu'elles sont proposées], [régulièrement, sans y penser : automatique],
    [Règle], [redémarrer quand c'est demandé], [3-2-1 : trois copies, deux supports, une hors du poste],
    [Et le code ?], [`conda update`, de temps en temps], [un dépôt poussé sur la forge est une copie du code ; les données ignorées par git sont à sauvegarder à part],
  )

  #notes[
    Une faille publiée est exploitée dans les jours qui suivent : le délai
    entre la mise à jour proposée et la mise à jour faite est la fenêtre du
    pirate.

    Pour un étudiant : le dépôt sur la forge sauve le code et le rapport ;
    les données, si elles sont lourdes, sont dans `.gitignore` et donc
    ailleurs. Un disque externe ou l'espace de stockage de l'école suffit.

    Les autres mesures de cybermalveillance.gouv.fr, non traitées ici :
    antivirus (celui de Windows suffit), applications depuis les magasins
    officiels, Wi-Fi public, séparer usage personnel et professionnel.
  ]
]
