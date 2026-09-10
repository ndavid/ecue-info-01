// Manipulation du cours 1 — « Formatage HTML et Markdown ».
//
// Incluse par `cours1.typ`, qui porte les réglages globaux, et compilable
// seule par `outils/compiler_manips.py`, qui en tire la feuille d'instructions
// déposée dans le dossier de données de la manipulation. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *


#separateur-manip(
  "Formatage HTML et Markdown",
  annonce: "Une page web et sa feuille de style, puis un texte brut mis en forme en Markdown",
  dossier: "data/cours1/markdown/",
)
#d("Mettre en forme une recette")[
  #annonce[
    Un texte brut sans aucune structure, à reprendre en Markdown. Le rendu se
    vérifie à côté, sans quitter l'éditeur.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [ouvrir `data/cours1/markdown/`, puis `recette_a_formater.txt`],
    [2], [l'enregistrer sous `recette.md`, et ouvrir l'aperçu par `Ctrl` + `K` puis `V`],
    [3], [un titre en `#`, deux sous-titres en `##`],
    [4], [les étapes de préparation en liste numérotée],
    [5], [les ingrédients en tableau, depuis `ingredients.csv`],
    [6], [l'ordre des opérations en bloc `mermaid`],
  )

  #legende[
    `recette.md`, dans le même dossier, donne le résultat attendu : ne
    l'ouvrir qu'après avoir essayé.
  ]

  #notes[
    Le texte de départ n'a aucune structure, et c'est voulu : ils doivent
    la décider, pas la recopier. La discussion utile est de savoir ce qui
    est un titre et ce qui est une étape — la mise en forme est une
    lecture du contenu.

    Geste à installer, l'aperçu côte à côte : `Ctrl` + `K` puis `V`. On
    écrit à gauche, on voit à droite, sans rien lancer.

    Étape 5 : le tableau se tape à la main, ou se produit depuis le CSV
    par une extension du catalogue. À la main la première fois,
    l'extension ensuite — un tableau Markdown n'est que des barres
    verticales, dont l'alignement n'est même pas obligatoire.

    Étape 6 : le diagramme de la diapositive précédente. Rien à installer.

    Pour ceux qui vont vite : une photo par `![](…)`, ce qui rappelle les
    chemins relatifs, et une citation par `>`.
  ]
]
// Le rendu attendu, quand la capture est disponible : sans elle, la
// diapositive n'aurait rien à montrer que le texte de la précédente.
#if captures-disponibles {
d("Le résultat attendu")[
  #annonce[
    Un titre, un tableau, une liste numérotée, et le diagramme dessiné à
    partir de ses six lignes de texte.
  ]

  #align(center)[
    #illustration(
      "/illustrations/cours1/apercu_recette.png",
      none,
      hauteur: 200pt,
    )
  ]

  #legende[
    Aperçu du `recette.md` du dossier. Le diagramme n'est pas une image : il
    est décrit en six lignes dans le fichier, et dessiné à l'affichage.
  ]

  #notes[
    À projeter après la manipulation : c'est le corrigé. Rien ici n'a
    demandé de logiciel de mise en page, et le fichier source reste
    lisible tel quel.

    Le diagramme a la même nature que le reste : du texte dans le fichier,
    une image seulement à l'écran. Troisième fois de la séance, après la
    coloration et les polices.
  ]
]
}
