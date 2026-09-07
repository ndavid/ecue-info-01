# Données — Cours 1 : formats de fichier

Ce dossier ne versionne **pas** les textes littéraires : il versionne le script qui
fabrique les fichiers de l'exercice à partir de sources du domaine public.

## Pourquoi

- Un dépôt git garde **tout, définitivement** : on n'y met pas de gros corpus recopiés
  (cf. leçon « secrets & `.gitignore` », cours 5B).
- Les fichiers de l'exercice sont **dérivés** (une-ligne, `.odt`, `.html`) : ce sont des
  artefacts générés, comme les frames du TD4. On versionne la recette, pas le produit.
- Bonus pédagogique : `make_data.py` est lui-même un exemple de `pathlib` + `subprocess`
  (cours 3).

## Sources utilisées (domaine public)

| Clé | Texte | Origine |
|-----|-------|---------|
| `raven` | *The Raven*, Edgar Allan Poe (1845) | Project Gutenberg |
| `scarborough` | *Scarborough Fair* (ballade traditionnelle anglaise) | Wikisource |

## Utilisation

```bash
# 1. récupérer les sources (une seule fois, nécessite le réseau)
python make_data.py fetch

#    …ou, hors ligne : déposer soi-même un .txt dans textes_sources/
#    (ex. textes_sources/raven.txt)

# 2. générer les fichiers de l'exercice dans genere/
python make_data.py build
```

## Ce qui est produit dans `genere/`

| Fichier | Rôle dans l'exercice |
|---------|----------------------|
| `<nom>_une_ligne.txt` | tout le texte sur **une seule ligne** → à re-formater |
| `<nom>_une_ligne.donnees` | le **même** contenu, mauvaise extension → à renommer |
| `<nom>.odt` | à ouvrir avec **LibreOffice Writer** |
| `<nom>_brut.html` | à ouvrir dans le **navigateur** (rendu sans mise en forme) |
| `<nom>_style.html` + `style.css` | même contenu **avec CSS** → comparer les deux |
| `_corrige/<nom>.txt` | version correctement formatée (pour l'enseignant) |

## Les autres dossiers de la séance

`make_data.py` et `genere/` ne servent qu'à la manipulation « un texte, quatre
formes ». Les autres manipulations ont leurs propres fichiers, versionnés
puisque ce sont des sources de quelques lignes et non des données dérivées.

| Dossier | Manipulation |
|---------|--------------|
| [`hello/`](hello/) | deux « hello world », en Python et en C++ |
| [`erreurs/`](erreurs/) | trois programmes fautifs, à corriger dans l'éditeur |
| [`formats/`](formats/) | `octets.py`, qui lit les premiers octets d'un fichier |
| [`trajet/`](trajet/) | le bonus vidéo « une vidéo, deux chemins » |
| [`illustrations/`](illustrations/) | les captures d'écran des diapositives, hors dépôt |

Chacun a son README.
