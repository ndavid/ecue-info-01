// Réglages propres au cours 2 pour serrer le rendu Beamer du support d'origine.
//
// Le thème commun (`src/commun/theme.typ`) transpose Bruno à une page de
// 297 mm avec un facteur 1,909 sur les corps. Le PDF de Florent est une page
// Beamer de 160 x 90 mm : le facteur qui la porte à 297 mm est 1,856, et ses
// corps sont donc 2,8 % plus petits que ceux du thème. Ce fichier corrige ce
// que le cours 2 peut corriger sans toucher au thème, et laisse le reste
// documenté dans `README.md`.
//
// Ce qui est repris ici, mesuré sur le PDF d'origine :
//
//   page de titre     fond en trapèze, filet, auteur, institut et date
//   corps du texte    20,4 pt au lieu de 21, interligne de Beamer
//   puces             dessinées, et non prises dans une police de repli
//   code              Latin Modern Mono, la police de `listings`
//
// Rien de ce fichier n'est importé par le cours 1.

#import "../../commun/theme.typ": *

// ---------------------------------------------------------------------------
// Page de titre
//
// La structure de `page-titre` est déjà celle de Bruno : le trapèze va de 68 %
// de la largeur en haut à 49 % en bas, et le filet mesure 42,8 % de la page,
// aux valeurs relevées sur le PDF d'origine. Ce qui diffère est le contenu
// des emplacements : Beamer y met l'auteur sous le filet, puis l'institut et
// la date en plus petit. `page-titre` nomme ces trois emplacements
// `sous-titre`, `auteur` et `date` ; on les remplit dans cet ordre.
#let page-titre-beamer(
  titre: "",
  auteur: "",
  institut: "",
  date: "",
  fond: "/illustrations/cours2/fond_titre.png",
) = page-titre(
  titre: titre,
  sous-titre: auteur,
  auteur: institut,
  date: date,
  fond: fond,
)

// ---------------------------------------------------------------------------
// Titre de cadre
//
// Bruno compose le titre de cadre en Fira Sans Regular, à \LARGE — 17,28 pt
// sur la page de Beamer, soit 32,1 pt sur celle-ci. Le thème commun le met
// en demi-gras et à 33 pt, un choix qu'il documente. `d-beamer` reprend le
// gabarit `d` du thème avec les valeurs de Bruno ; les parties du cours 2
// l'importent sous le nom `d`, et leurs appels ne changent pas.
#let titre-beamer = 32.1pt

#let d-beamer(titre-diapo, sous-titre: none, corps) = {
  v(52.5pt)
  block(below: 0em)[
    #set text(size: titre-beamer, fill: accent, weight: "regular")
    #set par(leading: 0.4em)
    #titre-diapo
    #if sous-titre != none [
      #linebreak()
      #text(size: pt-normalsize, fill: estompe)[
        #petites-capitales(sous-titre)
      ]
    ]
  ]
  v(ecart-titre)
  // Le thème répartit l'espace libre à 0,85 contre 1 ; sur les diapositives
  // de Florent, le corps se place 2,7 % de la hauteur plus haut que cela.
  // Calibré sur ses pages 3 et 13 : 0,65 contre 1 annule l'écart.
  v(0.65fr)
  corps
  v(1fr)
  pagebreak(weak: true)
}

// ---------------------------------------------------------------------------
// Corps et interligne
//
// Sur la page de 255,12 pt de Beamer, le corps de 11 pt vaut 4,31 % de la
// hauteur et l'interligne 5,31 % : soit 20,4 pt et 25,2 pt sur la page de
// 473,56 pt. Le thème donne 21 pt et 28,1 pt.
#let corps-beamer = 20.4pt
#let interligne-beamer = 0.54em

// ---------------------------------------------------------------------------
// Puces
//
// Fira Sans n'a ni le carré ni le disque : le thème les prend dans une police
// de repli, différente selon le poste. Beamer les prend dans Computer Modern
// Symbol. Les dessiner règle les deux problèmes : même forme partout, et la
// forme de Beamer — un carré plein, puis un disque.
#let puce-carree = box(
  width: 0.46em, height: 0.46em, baseline: -0.06em, fill: accent,
)
#let puce-ronde = box(
  width: 0.4em, height: 0.4em, baseline: -0.08em, radius: 50%, fill: accent,
)

// Beamer espace ses items davantage que le thème : relevé à 6,1 % de la
// hauteur de page d'un item au suivant, contre 5,6 %.
#let espacement-items-beamer = 0.8em

// Le gris des items déjà vus, relevé au pixel : Beamer les couvre d'un voile
// blanc (`\setbeamercovered{transparent}`), plus clair que `estompe`.
#let estompe-beamer = rgb("#BABFC2")

// ---------------------------------------------------------------------------
// Code
//
// `listings` compose en `\ttfamily`, soit Latin Modern Mono dans le PDF
// d'origine — plus étroite et plus claire que DejaVu Sans Mono. Elle vient
// avec TeX Live ; à défaut, la pile retombe sur DejaVu Sans Mono, et le
// document compile.
#let police-code-beamer = ("Latin Modern Mono", "DejaVu Sans Mono")

// ---------------------------------------------------------------------------
// Symboles
//
// Fira Sans n'a ni ⇒, ni ✓, ni □ : le thème les prendrait dans une police de
// repli. Beamer les compose en Computer Modern Symbol, dont Latin Modern Math
// est l'héritière directe. Les écrire en mode mathématique — `$=>$`,
// `$checkmark$`, `$square$` — les y envoie, avec la même forme que dans le
// PDF d'origine.
#let police-math-beamer = ("Latin Modern Math", "DejaVu Math TeX Gyre")

// ---------------------------------------------------------------------------
// Application
//
//   #show: diapos.with(…)
//   #show: reglages-beamer
#let reglages-beamer(corps) = {
  set text(size: corps-beamer)
  set par(leading: interligne-beamer)
  // Retraits relevés sur le PDF d'origine : la puce à 13,8 pt de la marge
  // sur la page de Beamer, le texte 9 pt plus loin — soit 25,7 et 16,8 pt ici.
  set list(
    marker: (puce-carree, puce-ronde), spacing: espacement-items-beamer,
    indent: 19pt, body-indent: 17pt,
  )
  show raw: set text(font: police-code-beamer)
  show math.equation: set text(font: police-math-beamer)
  corps
}
