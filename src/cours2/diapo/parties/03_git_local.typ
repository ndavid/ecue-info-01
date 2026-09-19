// Cours 2, partie 3 — le dépôt local : créer, enregistrer, annuler, étiqueter
// (diapositives 11 à 16).
#import "../../../commun/prelude.typ": *
#import "../../../commun/schemas_git.typ": *
#import "../schemas.typ": *
#import "../style.typ": *

// Une histoire linéaire, comme celle des diapositives sur le commit : les
// pastilles se suivent, et des tirets disent que le projet continue.
#let _chaine(noms, teintes: (:), echelle: 1.0, extra: none) = graphe-git(
  commits: noms.enumerate().map(((i, nom)) => (
    nom: "k" + str(i), col: i, voie: 0, etiquette: nom,
    teinte: teintes.at(str(i), default: white),
    parents: if i == 0 { () } else { ("k" + str(i - 1),) },
  )),
  fleches: ((depuis: "k" + str(noms.len() - 1), longueur: 0.9),),
  echelle: echelle,
  extra: extra,
)

// --------------------------------------------- 11/26
#d("Initialiser un projet git")[
  #grid(
    columns: (1.5fr, 1fr), column-gutter: 20pt, align: horizon,
    [
      Un projet git s'appelle un *repository* (ou *dépôt git* en français).

      #v(0.9em)
      Créer un repository = créer un dossier _.git_

      #v(0.9em)
      On utilise la commande suivante :
      #code("git init", centre: true, taille: 17pt)
    ],
    align(center, dossier-projet(echelle: 1.0)),
  )

  #notes[
    Insister : le dépôt, c'est le dossier `.git`. Le supprimer efface
    l'historique et ne touche pas aux fichiers de travail. C'est aussi
    pourquoi un dépôt ne se crée pas dans un dossier qui en contient déjà un.
  ]
]

// --------------------------------------------- 12/26
#d("Commit")[
  #grid(
    columns: (1.4fr, 1fr), column-gutter: 20pt, align: horizon,
    align(center)[
      Une fois le repository créé, il est dans son état initial,
      appelé *Initial commit*
    ],
    align(center, _chaine(("Initial commit",), echelle: 1.0)),
  )
]

// --------------------------------------------- 13/26
#d("Commit")[
  #grid(
    columns: (1.25fr, 1fr), column-gutter: 20pt, align: horizon,
    align(center)[
      Chaque nouvel état enregistré du projet s'appelle un *commit*
    ],
    align(center, _chaine(("Initial commit", "commit 1", "commit 2"), echelle: 0.85)),
  )

  #notes[
    Un commit n'est pas une sauvegarde de plus : c'est un état du projet
    entier, nommé, auquel on peut revenir. Le mot reviendra à chaque
    diapositive, autant le fixer ici.
  ]
]

// --------------------------------------------- 14/26, en cinq étapes
//
// Le texte de gauche et le schéma de droite avancent du même pas : à chaque
// étape, une commande et la transition qu'elle provoque.
#let _etapes-enregistrer = (
  [Chaque fichier créé est *non suivi*.],
  [
    Pour commencer à suivre un fichier, on utilise la commande :
    #code("#ajouter un fichier spécifique
git add <nom_de_fichier>

#ajouter un dossier et
#tout ses fichiers
git add <nom_de_dossier>

#ajouter le dossier courant
git add .", taille: 13pt, interligne: 0.5em)
  ],
  [
    On peut ensuite créer un *nouvel état* du projet avec les nouveaux
    fichiers.
    #code("git commit -m <message_de_commit>", taille: 13.5pt)
  ],
  [Pour valider un changement, on réutilise la commande *add*.],
  [
    Il faut régulièrement faire des *commits*, car on ne peut naviguer
    qu'entre deux états enregistrés.
  ],
)

#for etape in range(1, 6) {
  d("Enregistrer des modifications")[
    #grid(
      columns: (1fr, 1.25fr), column-gutter: 16pt, align: horizon,
      block(width: 100%)[#_etapes-enregistrer.at(etape - 1)],
      align(center, cycle-de-vie(etape: etape, echelle: 0.78)),
    )

    #if etape == 5 {
      notes[
        Les quatre états sont ceux que `git status` nomme. Faire le lien
        explicitement : « non suivi » = _untracked_, « nouvel état » = ce qui
        est déjà validé, « modifié » = _modified_.
      ]
    }
  ]
}

// --------------------------------------------- 15/26
#d("Annuler un commit")[
  #grid(
    columns: (1.15fr, 1fr), column-gutter: 20pt, align: horizon,
    [
      On peut annuler un commit avec la commande :
      #code("git revert <nom du commit>")
      Cette commande crée un nouveau commit !
    ],
    align(center, _chaine(
      ("", "", ""),
      teintes: ("1": rgb("#F5C6C6")),
      echelle: 1.0,
      extra: (pos, d) => {
        pont(d, pos("k0"), pos("k2"), "Même état")
        d.content((pos("k1").at(0) + 0.1, pos("k1").at(1) - 0.42),
                  text(size: 9pt, fill: accent)[git revert], anchor: "north-west")
        // Les tirets d'entrée : l'histoire ne commence pas à cette pastille.
        d.line((pos("k0").at(0) - 0.95, pos("k0").at(1)),
               (pos("k0").at(0) - 0.3, pos("k0").at(1)),
               stroke: (paint: accent, thickness: 0.9pt, dash: "densely-dashed"))
      },
    )),
  )

  #notes[
    `revert` n'efface rien : il ajoute un commit qui défait le précédent.
    C'est pour cela qu'il est sans danger sur un historique déjà partagé,
    contrairement à `reset`, qu'on ne voit pas aujourd'hui.
  ]
]

// --------------------------------------------- 16/26
#d("Tagger un commit")[
  #grid(
    columns: (1.3fr, 1fr), column-gutter: 20pt, align: horizon,
    [
      On peut tagger un commit avec la commande :
      #code("git tag -a <nom du tag> -m <message de tag>", taille: 13.5pt)
    ],
    align(center, _chaine(
      ("", "", ""),
      teintes: ("1": rgb("#BFE3BF")),
      echelle: 1.0,
      extra: (pos, d) => {
        d.content((pos("k1").at(0), pos("k1").at(1) - 0.42),
                  text(size: 9pt, fill: accent)[Tag : V1.0], anchor: "north")
        d.line((pos("k0").at(0) - 0.95, pos("k0").at(1)),
               (pos("k0").at(0) - 0.3, pos("k0").at(1)),
               stroke: (paint: accent, thickness: 0.9pt, dash: "densely-dashed"))
      },
    )),
  )

  #notes[
    Le tag nomme une version pour les humains, là où le commit porte une
    empreinte illisible. C'est ce qui est publié au moment d'une livraison —
    on s'en sert dans ce dépôt pour marquer chaque séance.
  ]
]
