// Exporte en SVG, pour le book, trois schémas dessinés du cours 1 :
// les dépôts de paquets, le client et le serveur d'un notebook, les deux
// clients d'un notebook. Compilation, depuis la racine du dépôt :
//
//     typst compile --root . src/annexes/schemas/export.typ "src/annexes/schemas/{n}.svg" --format svg
//     cd src/annexes/schemas && mv 1.svg depots.svg && mv 2.svg client_serveur.svg && mv 3.svg deux_clients.svg
//
// Une page par schéma, dans l'ordre de `schemas` ci-dessous. Les SVG
// produits sont versionnés ; ce fichier sert à les refaire quand le dessin
// change dans le cours 1.
#import "../../commun/prelude.typ": *
#import "../../cours1/diapo/schemas.typ": schema-depots
#import "../../cours1/diapo/schemas_notebooks.typ": schema-client-serveur, schema-deux-clients

#set page(width: auto, height: auto, margin: 8pt, fill: white)
#set text(font: police-texte, fill: encre, lang: "fr")
#show raw: set text(font: police-code)

#let schemas = (schema-depots, schema-client-serveur, schema-deux-clients)
#for s in schemas {
  s()
  pagebreak(weak: true)
}
