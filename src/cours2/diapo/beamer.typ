// Réglages du cours 2 qui rapprochent le rendu du Beamer d'origine.
//
// Le thème commun transpose Bruno avec un facteur 1,909 sur les corps ; la
// page Beamer de 160 mm portée à 297 mm demande 1,856. Les valeurs ci-dessous
// sont relevées sur le PDF de Florent Geniet et converties à la page de
// 473,56 pt. Ce fichier n'est pas importé par le cours 1.

#import "../../commun/theme.typ": *

// ---------------------------------------------------------------------------
// Valeurs relevées
//
//                                                  Beamer        thème commun
#let titre-beamer = 32.1pt                       // 17,28 pt      33 pt, demi-gras
#let corps-beamer = 20.4pt                       // 11 pt         21 pt
#let interligne-beamer = 0.54em                  // avance 1,23 em  1,34 em
#let ressort-haut-beamer = 0.65                  // corps centré 0,65 : 1   0,85 : 1
#let espacement-items-beamer = 0.8em             // 6,1 % de la hauteur   5,6 %
#let retrait-puce-beamer = 19pt                  // 13,8 pt       11 pt
#let retrait-texte-beamer = 17pt                 // 9 pt          13 pt
#let estompe-beamer = rgb("#BABFC2")             // items déjà vus   #6B7683
#let corps-code-beamer = 18pt                    // 10,1 pt       15 pt
#let interligne-code-beamer = 0.42em             // avance 1,04 em

// Polices. Beamer compose le code en Latin Modern Mono (`\ttfamily`) et les
// symboles en Computer Modern Symbol ; Latin Modern Math en est l'héritière.
// Les deux viennent avec TeX Live ; à défaut, la pile retombe sur DejaVu.
#let police-code-beamer = ("Latin Modern Mono", "DejaVu Sans Mono")
#let police-math-beamer = ("Latin Modern Math", "DejaVu Math TeX Gyre")

// Puces. Fira Sans n'a ni ■ ni ● ; le thème les prend dans une police de
// repli. Elles sont dessinées : un carré plein, puis un disque.
#let puce-carree = box(width: 0.46em, height: 0.46em, baseline: -0.06em, fill: accent)
#let puce-ronde = box(width: 0.4em, height: 0.4em, baseline: -0.08em, radius: 50%, fill: accent)

// ---------------------------------------------------------------------------
// Page de titre
//
// La géométrie de `page-titre` est celle de Bruno : trapèze de 68 % à 49 % de
// la largeur, filet de 42,8 %. Beamer met sous le filet l'auteur, puis
// l'institut et la date en plus petit ; ce sont les emplacements que
// `page-titre` nomme `sous-titre`, `auteur` et `date`.
#let page-titre-beamer(
  titre: "",
  auteur: "",
  institut: "",
  date: "",
  fond: "/illustrations/cours2/fond_titre.png",
) = page-titre(titre: titre, sous-titre: auteur, auteur: institut, date: date, fond: fond)

// ---------------------------------------------------------------------------
// Diapositive
//
// Copie du gabarit `d` du thème avec le titre en Regular à `titre-beamer` et
// le ressort du haut à `ressort-haut-beamer`. Les parties du cours 2
// l'importent sous le nom `d`.
#let d-beamer(titre-diapo, sous-titre: none, corps) = {
  v(52.5pt)
  block(below: 0em)[
    #set text(size: titre-beamer, fill: accent, weight: "regular")
    #set par(leading: 0.4em)
    #titre-diapo
    #if sous-titre != none [
      #linebreak()
      #text(size: pt-normalsize, fill: estompe)[#petites-capitales(sous-titre)]
    ]
  ]
  v(ecart-titre)
  v(ressort-haut-beamer * 1fr)
  corps
  v(1fr)
  pagebreak(weak: true)
}

// ---------------------------------------------------------------------------
// Réglages globaux, à poser après le thème :
//
//   #show: diapos.with(…)
//   #show: reglages-beamer
#let reglages-beamer(corps) = {
  set text(size: corps-beamer)
  set par(leading: interligne-beamer)
  set list(
    marker: (puce-carree, puce-ronde),
    spacing: espacement-items-beamer,
    indent: retrait-puce-beamer,
    body-indent: retrait-texte-beamer,
  )
  show raw: set text(font: police-code-beamer)
  show math.equation: set text(font: police-math-beamer)
  corps
}
