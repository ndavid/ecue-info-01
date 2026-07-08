# Annexe E — Culture informatique

**Durée** : 1,5–2 h · **Forme** : légère, incarnée par des exemples, **jamais** un cours magistral abstrait.

## Objectif

Donner des repères de « culture générale informatique » qui manquent : que se passe-t-il *sous* les outils, et quels ordres de grandeur gouvernent les choix techniques qu'ils feront en géomatique.

## Contenus

### Ordres de grandeur d'accès aux données (le plus important)
- Hiérarchie mémoire : registre → cache → RAM → SSD → disque → réseau. Chaque étage ~×10–1000 plus lent.
- **Incarner** : chronométrer (`time`) le chargement d'un petit vs gros fichier (annexe B).
- Cas géomatique : pourquoi on ne charge pas un fichier de traces GPS de 50 Go d'un coup en RAM sur un portable → introduit *streaming*, *chunking*.

### CPU vs GPU
- CPU = peu de cœurs polyvalents, séquentiel ; GPU = milliers de cœurs, parallélisme massif (raster, deep learning).
- Une phrase, un schéma. Pas de détail d'architecture.

### Client-serveur / cloud
- Modèle requête/réponse. **Incarner** : un `curl` vers une API géospatiale publique (IGN Géoplateforme, Overpass/OSM) → JSON en retour.
- « Le cloud » = l'ordinateur de quelqu'un d'autre, accessible par le réseau. Une diapo, pas plus.

## Ancrage géomatique

Tous les exemples tirés du métier : rasters, traces GPS, API géospatiales, QGIS.

## Aparté « pont algo »

- Dijkstra / plus court chemin → analyse de réseau/itinéraire (QGIS) : « l'outil que vous utiliserez calcule ça avec un algo que vous apprendrez à écrire ». Motivation, pas contenu.

## Écueils à éviter

- Ne pas dériver vers un cours d'architecture des ordinateurs.
- Chaque notion = un exemple concret + un ordre de grandeur, pas une définition théorique.

## Livrable / évaluation

Un court QCM ou une mini-restitution : « classe ces accès du plus rapide au plus lent », « CPU ou GPU pour cette tâche ? ».
