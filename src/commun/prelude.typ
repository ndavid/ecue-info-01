// Point d'entrée unique des supports : un seul import à écrire en tête de
// chaque fichier, plutôt qu'une liste de gabarits à tenir à jour.
//
//     #import "../../commun/prelude.typ": *
//
// Les noms importés ici sont ré-exportés : `#import "prelude.typ": *` donne
// accès à tout ce que `theme.typ` et `schemas.typ` définissent. Un fichier
// inclus par `#include` n'hérite de rien du fichier qui l'inclut : il doit
// donc porter cette ligne lui aussi.

#import "theme.typ": *
#import "schemas.typ": *
