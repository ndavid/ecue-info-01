// « Chasse fixe et chasse proportionnelle » (parties/02_programmation.typ).
#import "_gabarit.typ": *
#show: schema-de-cours

#face-a-face(
  panneau("Chasse fixe (éditeur de code)")[
    #raw("def surface(longueur, largeur):\n    aire = longueur * largeur\n    if aire > 250:\n        categorie = \"grande\"\n    else:\n        categorie = \"petite\"\n    return aire, categorie", block: true)
  ],
  // Le même texte, à la même taille, dans la police du corps : seules les
  // largeurs de caractère changent.
  panneau("Chasse proportionnelle (traitement de texte)")[
    #{
      show raw: set text(font: police-texte)
      raw("def surface(longueur, largeur):\n    aire = longueur * largeur\n    if aire > 250:\n        categorie = \"grande\"\n    else:\n        categorie = \"petite\"\n    return aire, categorie", block: true)
    }
  ],
)
