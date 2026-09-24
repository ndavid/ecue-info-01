// « Le format de la documentation » (parties/03_markdown_notebook.typ).
#import "_gabarit.typ": *
#show: schema-de-cours

#face-a-face(
  panneau[Ce qu'on écrit, `README.md`][
    #set text(size: 17pt)
    #raw(
      "# Trajet\n\nTrace le trajet de la gare à l'école.\n\n## Lancer\n\n    python trajet.py\n\nLe résultat est *trajet.png*.",
      block: true, lang: "md",
    )
  ],
  panneau("Ce que l'aperçu montre")[
    #block(width: 100%, inset: (x: 10pt, y: 7pt), stroke: 0.8pt + estompe.lighten(50%))[
      #text(size: 17pt, weight: "bold")[Trajet]
      #v(0.3em)
      #set text(size: 13.5pt)
      Trace le trajet de la gare à l'école.
      #v(0.35em)
      #text(size: 15pt, weight: "bold")[Lancer]
      #v(0.25em)
      #block(fill: gris, inset: (x: 7pt, y: 5pt), width: 100%)[
        #text(font: police-code, size: 12pt)[python trajet.py]
      ]
      #v(0.25em)
      Le résultat est #emph[trajet.png].
    ]
  ],
)
