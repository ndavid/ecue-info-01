// Graphes git des guides de TD : la branche d'une étape, avant et après sa
// fusion dans `master`, dans le style du cours 2 (`schemas_git.typ`).
//
// Chaque guide qui en a besoin a un fichier `illustrations/<nom>.typ` à côté
// de son `guide.md`, qui appelle `branche-avant-apres` ; le fichier est
// compilé en PNG par `outils/compiler_guides.py`.
#import "schemas_git.typ": graphe-git
#import "theme.typ": accent, brun, estompe, police-texte, demi-gras

// `branche` : le nom de la branche ; `avant` : le nombre de commits sur
// `master` avant la branche ; `sur-branche` : le nombre de commits faits sur
// la branche. Les commits sont numérotés c1, c2… dans l'ordre.
#let branche-avant-apres(branche, avant: 2, sur-branche: 3) = {
  let tronc = range(1, avant + 1).map(i => (
    nom: "c" + str(i), col: i - 1, voie: 0,
    parents: if i > 1 { ("c" + str(i - 1),) } else { () },
  ))
  let branche-commits(voie) = range(1, sur-branche + 1).map(j => {
    let i = avant + j
    (nom: "c" + str(i), col: i - 1, voie: voie, parents: ("c" + str(i - 1),))
  })
  let titre(t) = text(size: 12pt, weight: demi-gras, fill: accent)[#t]

  set text(font: police-texte, lang: "fr")
  grid(
    columns: 2, column-gutter: 1.2cm, row-gutter: 0.35cm,
    titre[Avant `git merge` : sur la branche #raw(branche)],
    titre[Après `git checkout master` et `git merge` #raw(branche)],
    graphe-git(
      commits: tronc + branche-commits(1),
      branches: (
        (nom: "master", voie: 0, commit: "c" + str(avant)),
        (nom: branche, voie: 1, commit: "c" + str(avant + sur-branche)),
      ),
      taille-etiquette: 10pt, echelle: 0.8,
    ),
    graphe-git(
      commits: tronc + branche-commits(0),
      branches: (
        (nom: "master", voie: 0, commit: "c" + str(avant + sur-branche)),
      ),
      taille-etiquette: 10pt, echelle: 0.8,
      // La branche existe toujours après la fusion : son cartouche, au-dessus
      // du même commit que `master`.
      extra: (pos, d) => {
        let p = pos("c" + str(avant + sur-branche))
        let q = (p.at(0), p.at(1) + 1.06)
        d.line((p.at(0), p.at(1) + 0.48), (q.at(0), q.at(1) - 0.3),
          stroke: (paint: brun, thickness: 1pt, dash: "dotted"))
        d.content(q, box(fill: brun, inset: (x: 6pt, y: 3.5pt), radius: 4pt,
          text(size: 11pt, weight: demi-gras, fill: white)[#branche]))
      },
    ),
  )
  v(0.2cm)
  block(width: 16cm, text(size: 10pt, fill: estompe)[
    La fusion est une avance rapide (_fast-forward_) : `master` n'a pas
    avancé pendant le travail sur la branche, git déplace `master` sur le
    dernier commit de #raw(branche). Les deux branches désignent alors le
    même commit.
  ])
}

// Une fusion avec commit de fusion : pendant le travail sur la branche, un
// commit a aussi été fait sur `master`. `depart` : le numéro du dernier
// commit commun ; la branche porte les commits depart+1 et depart+3,
// `master` le commit depart+2, et la fusion est le commit depart+4.
#let fusion-avant-apres(branche, depart: 5) = {
  let n(i) = "c" + str(depart + i)
  let base = (
    (nom: n(0), col: 0, voie: 0),
    (nom: n(1), col: 1, voie: 1, parents: (n(0),)),
    (nom: n(2), col: 2, voie: 0, parents: (n(0),), place: "dessous"),
    (nom: n(3), col: 3, voie: 1, parents: (n(1),)),
  )
  let fusion = (nom: n(4), col: 4, voie: 0, parents: (n(2), n(3)))
  let titre(t) = text(size: 12pt, weight: demi-gras, fill: accent)[#t]

  set text(font: police-texte, lang: "fr")
  grid(
    columns: 2, column-gutter: 1.2cm, row-gutter: 0.35cm,
    titre[Avant `git merge` : un commit sur chaque branche],
    titre[Après `git checkout master` et `git merge` #raw(branche)],
    graphe-git(
      commits: base,
      branches: (
        (nom: "master", voie: 0, commit: n(2)),
        (nom: branche, voie: 1, commit: n(3)),
      ),
      taille-etiquette: 10pt, echelle: 0.8,
    ),
    graphe-git(
      commits: base + (fusion,),
      branches: (
        (nom: "master", voie: 0, commit: n(4)),
        (nom: branche, voie: 1, commit: n(3)),
      ),
      taille-etiquette: 10pt, echelle: 0.8,
    ),
  )
  v(0.2cm)
  block(width: 16cm, text(size: 10pt, fill: estompe)[
    `master` a avancé pendant le travail sur la branche (#raw(n(2))) : git
    ne peut pas déplacer `master` sur le dernier commit de la branche. Il crée un commit de fusion,
    #raw(n(4)), qui a deux parents, #raw(n(2)) et #raw(n(3)) ; il est dessiné
    en double trait.
  ])
}
