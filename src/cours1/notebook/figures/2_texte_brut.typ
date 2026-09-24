// « Texte brut et règles du langage » (parties/02_programmation.typ) : les
// trois panneaux du haut.
#import "_gabarit.typ": *
#show: schema-de-cours

#grid(
  columns: (1.15fr, 0.9fr, 0.95fr), column-gutter: 18pt,
  // Sans coloration à gauche et au milieu : seule la colonne de droite en
  // porte, comme sur la diapositive.
  panneau("Enregistré par un traitement de texte")[
    #raw(
      "<text:p text:style-name=\"P1\">\naltitude = 128.4</text:p>\n<text:p>print(altitude)</text:p>",
      block: true,
    )
  ],
  panneau("Le fichier d'un programme")[
    #raw("altitude = 128.4\nprint(altitude)", block: true)
  ],
  panneau("Affiché par l'éditeur de code")[
    ```python
    altitude = 128.4
    print(altitude)
    ```
  ],
)
