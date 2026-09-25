// « Arborescence de fichiers », troisième étape (parties/01_ligne_commande.typ) :
// le chemin absolu de ssh_config.json.
#import "_gabarit.typ": *
#import "../../diapo/schemas.typ": arborescence, rouge-chemin
#show: schema-de-cours.with(largeur: auto)

#arborescence(
  echelle: 1.3,
  racine-annotee: true,
  legende: ("Chemin absolu", rouge-chemin),
  chemin: (("racine", "etc"), ("etc", "ssh"), ("ssh", "config")),
)
