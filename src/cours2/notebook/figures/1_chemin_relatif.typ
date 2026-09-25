// « Arborescence de fichiers », quatrième étape (parties/01_ligne_commande.typ) :
// le chemin relatif de ssh_config.json, depuis le dossier c++.
#import "_gabarit.typ": *
#import "../../diapo/schemas.typ": arborescence, vert-chemin
#show: schema-de-cours.with(largeur: auto)

#arborescence(
  echelle: 1.3,
  racine-annotee: true,
  legende: ("Chemin relatif", vert-chemin),
  couleur-chemin: vert-chemin,
  chemin: (("etc", "ssh"), ("ssh", "config"), ("etc", "cpp")),
  courant: "cpp",
)
