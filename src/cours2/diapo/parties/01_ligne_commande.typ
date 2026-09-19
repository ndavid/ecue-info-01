// Cours 2, partie 1 — la ligne de commande (diapositives 2 à 7 du support
// d'origine). Les diapositives qui se dévoilent sont écrites autant de fois
// qu'elles comptent d'étapes, `etape` faisant le reste.
#import "../../../commun/prelude.typ": *
#import "../beamer.typ": d-beamer as d
#import "../schemas.typ": *
#import "../style.typ": *

// --------------------------------------------- 2/26
#d("Terminal")[
  Terminal : *interface* homme-machine *textuelle*

  #v(0.9em)
  #align(center, invite-commentee())

  #notes[
    Montrer le terminal réellement ouvert plutôt que la diapositive : chacun
    doit repérer sur son propre écran l'utilisateur, le dossier courant et
    l'invite. Le préfixe `(base)` est celui de conda, et il reviendra au
    moment des environnements.

    Les couleurs ne sont pas décoratives : c'est bash qui les met, et elles
    aident à retrouver d'un coup d'œil où finit le chemin et où commence ce
    qu'on tape.
  ]
]

// --------------------------------------------- 3/26
#d("Le langage bash")[
  Sur unix (linux et mac), le langage utilisé dans le terminal est *bash*.\
  Les commandes bash s'appellent toujours de la même façon :

  #code("commande [-one_letter_options] [--other_options] <arguments>")

  Pour avoir la liste des options d'une commande :

  #code("commande --help")

  #notes[
    Sous Windows, le terminal par défaut est PowerShell, dont la syntaxe
    diffère ; Git Bash, installé avec git, donne le même bash qu'ici. Le
    préciser tout de suite évite que la moitié de la salle bute sur la
    première commande.
  ]
]

// --------------------------------------------- 4/26
#d("Liste de commandes utiles")[
  #code("#lister les fichiers et sous dossiers d'un dossier
ls [dossier]
#changer de dossier courant
cd <dossier>
#copier un fichier ou un dossier
cp [-r] <source> <destination>
#déplacer un fichier ou un dossier
mv <source> <destination>
#supprimer un fichier ou un dossier
rm [-r] <source>
#savoir dans quel dossier on se trouve
pwd
#créer un fichier
touch <nom_fichier>
#créer un dossier
mkdir <nom_dossier>")

  #notes[
    Les faire taper une à une plutôt que les lire. `rm` ne demande pas
    confirmation et il n'y a pas de corbeille : le dire avant qu'ils
    l'essaient.

    Le support d'origine écrivait `mkdire` ; la coquille est corrigée ici.
  ]
]

// --------------------------------------------- 5/26, en cinq étapes
//
// Même diapositive, même arbre : seuls le texte de gauche et le chemin coloré
// changent. Le gabarit est écrit une fois, les cinq étapes l'appellent.
#let _diapo-arbre(texte, ..options) = d("Arborescence de fichiers")[
  #grid(
    columns: (0.95fr, 1.7fr), column-gutter: 14pt, align: horizon,
    block(width: 100%)[#texte],
    align(center, arborescence(echelle: 1.48, ..options)),
  )
]

#_diapo-arbre[
  Les fichiers et dossiers sont organisés en *arbre*
]

#_diapo-arbre(racine-annotee: true)[
  *racine de l'arbre* : un dossier contenant tout. Chemin de la racine
  jusqu'à un dossier ou fichier = *chemin absolu*
]

#_diapo-arbre(
  racine-annotee: true,
  legende: ("Chemin absolu", rouge-chemin),
  chemin: (("racine", "etc"), ("etc", "ssh"), ("ssh", "config")),
)[
  Le chemin absolu se note :\
  #code-ligne("/dossier_1/.../dossier_n/destination")

  #v(0.9em)
  exemple :\
  #code-ligne("/etc/ssh/ssh_config.json")
]

#_diapo-arbre(
  racine-annotee: true,
  legende: ("Chemin relatif", vert-chemin),
  couleur-chemin: vert-chemin,
  chemin: (("etc", "ssh"), ("ssh", "config"), ("etc", "cpp")),
  courant: "cpp",
)[
  Chemin d'un dossier quelconque à un autre dossier ou fichier =
  *chemin relatif*

  #v(0.45em)
  *Le dossier de départ est le dossier courant du terminal !*

  #v(0.45em)
  Le chemin relatif se note :\
  #code-ligne("dossier_1/.../dossier_n/destination", taille: 14pt)
]

#_diapo-arbre(
  racine-annotee: true,
  legende: ("Chemin relatif", vert-chemin),
  couleur-chemin: vert-chemin,
  chemin: (("etc", "ssh"), ("ssh", "config"), ("etc", "cpp")),
  courant: "cpp",
)[
  Le dossier parent d'un autre dossier se note ”..”\
  exemple :\
  #code-ligne("../etc/ssh/ssh_config.json")

  #notes[
    Le `..` est le point qui bloque le plus au TD suivant. Le faire manipuler
    tout de suite : `cd ..`, puis `pwd` pour vérifier où l'on est arrivé.
  ]
]

// --------------------------------------------- 6/26, en deux étapes
#d("fichiers cachés")[
  #grid(
    columns: (0.95fr, 1.7fr), column-gutter: 14pt, align: horizon,
    [
      Certains fichiers/dossiers peuvent être *cachés*. Pour cacher un
      fichier/dossier, il faut que son nom commence par un ”.”.

      #v(0.9em)
      Exemple : `.git`, `.cache`, `.ssh`
    ],
    align(center, arborescence(echelle: 1.48, caches: true)),
  )
]

#d("fichiers cachés")[
  #grid(
    columns: (1fr, 1.3fr), column-gutter: 18pt, align: horizon,
    [
      Pour afficher les éléments cachés d'un dossier :
      #list([En ligne de commande #code("ls -a [dossier]")])
    ],
    [
      #list([dans l'explorateur de fichiers :])
      #v(0.4em)
      #fenetre("Fichiers")[
        #set text(size: 14pt)
        #grid(
          columns: (1fr,), row-gutter: 0.45em,
          text(fill: estompe)[Nouvelle fenêtre #h(1fr) `Ctrl+N`],
          text(fill: estompe)[Nouvel onglet #h(1fr) `Ctrl+T`],
          block(width: 100%, inset: (x: 3pt, y: 2pt), stroke: 1pt + alerte)[
            $checkmark$ Afficher les fichiers cachés #h(1fr) `Ctrl+H`
          ],
          text(fill: estompe)[Préférences],
          text(fill: estompe)[Raccourcis clavier #h(1fr) `Ctrl+?`],
        )
      ]
    ],
  )

  #notes[
    Le raccourci `Ctrl+H` marche dans la plupart des explorateurs, y compris
    celui de Windows. À faire activer maintenant : sans lui, le dossier `.git`
    reste invisible tout le reste de la séance.
  ]
]

// --------------------------------------------- 7/26, en trois étapes
//
// Les règles s'accumulent, la précédente passant en gris ; les exemples, eux,
// sont remplacés à chaque étape, car ils illustrent la règle du moment.
#let _regles = (
  [”\*” : n'importe quelle chaîne de caractères],
  [”?” : n'importe quel caractère (un seul caractère)],
  [”[]” : permet de donner une liste de caractères.],
)

#let _diapo-regex(etape, exemples) = d("Expressions régulières")[
  On peut désigner des groupes de fichiers/dossiers en utilisant des
  *expressions régulières (ou regex)*.

  #liste-progressive(etape, _regles)
  #list([exemples : #list(..exemples)])
]

#_diapo-regex(1, (
  [#motif("/etc/*") : *tous les dossiers et fichiers* contenus dans etc],
  [#motif("/users/FGeniet/*.jpg") : toutes les images jpg du dossier FGeniet
   (ne comprend pas les images dans les sous-dossiers)],
  [#motif("*/*.pdf") : tous les pdf qui sont dans un sous-dossier du dossier
   courant],
))

#_diapo-regex(2, (
  [#motif("*_?.png") : tous les png avec un nom ayant un ”\_” en avant
   dernier caractère],
  [#motif("/users/*/????.*") : tous les fichiers dans les dossiers
   utilisateurs ayant un nom de 4 caractères],
))

#_diapo-regex(3, (
  [#motif("mo[tn]o.jpg") : désigne `moto.jpg` et `mono.jpg`],
  [#motif("reunion_[0-9][0-9].txt") : les fichiers texte dont le nom est de la
   forme `reunion_` suivi d'un nombre à 2 chiffres],
))

#notes[
  Ces motifs sont ceux du shell (*globbing*), pas les expressions régulières
  de `grep` ou de Python : `*` n'y a pas le même sens. Le dire, sinon la
  confusion resurgit au cours 3.
]
