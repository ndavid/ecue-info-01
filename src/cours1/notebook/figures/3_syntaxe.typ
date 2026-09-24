// « La syntaxe de Markdown » (parties/03_markdown_notebook.typ).
#import "_gabarit.typ": *
#show: schema-de-cours

#face-a-face(
  panneau("Ce qu'on écrit")[
    ```markdown
    # Un titre
    ## Un sous-titre

    Du texte, de l'*emphase*,
    du **gras**.

    - une puce
    1. une étape

    [un lien](https://typst.app)
    ![une photo](poele.jpg)
    ```
  ],
  panneau("Ce qui s'affiche")[
    #block(inset: 9pt, stroke: 0.8pt + estompe.lighten(50%), width: 100%)[
      #set text(size: 13pt)
      #text(size: 19pt, weight: "bold")[Un titre] \
      #text(size: 15pt, weight: "bold")[Un sous-titre]
      #v(0.3em)
      Du texte, de l'#text(style: "italic")[emphase], du
      #text(weight: "bold")[gras].
      #v(0.3em)
      • une puce \
      1. une étape
      #v(0.3em)
      #text(fill: accent)[#underline[un lien]] \
      #text(fill: estompe)[▭ une photo]
    ]
  ],
)
