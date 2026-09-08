# Données — Cours 1

Un dossier par manipulation, et deux noms réservés à l'intérieur.

| Nom | Ce qu'il contient | Versionné | Doit voyager |
|-----|-------------------|-----------|--------------|
| le dossier lui-même | les sources : scripts, `.csv`, `.md`, quelques lignes chacun | oui | par git |
| `produit/` | ce qu'une commande refabrique : `make_data.py`, `anime.sh`, une compilation | non | non, il se refait |
| `fourni/` | ce qui vient d'ailleurs et ne se refabrique pas | non | **oui** |

C'est la seule règle à connaître, et elle vaut pour toutes les séances. Perdre
un `produit/` ne coûte qu'un temps de calcul ; perdre un `fourni/` coûte un
retéléchargement qui n'est pas toujours possible — les tuiles OpenStreetMap de
[`trajet/`](trajet/) sont dans ce cas, leurs conditions d'usage interdisant le
téléchargement en masse.

Les `fourni/` ne se recopient donc pas à la main d'un poste à l'autre :

```bash
python outils/ressources.py exporter /media/…/info01-ressources   # vers la clé
python outils/ressources.py importer /media/…/info01-ressources   # depuis la clé
python outils/ressources.py verifier                              # rien ne manque ?
```

`verifier` compare le dépôt au manifeste versionné `outils/ressources.json` : sur
un poste neuf, il dit ce qui manque avant qu'une manipulation ne s'arrête faute
d'un fichier.

Les captures d'écran des diapositives ne sont pas ici : elles servent aux
supports et non aux travaux dirigés, et vivent dans
[`illustrations/`](../../illustrations/) à la racine du dépôt.

## Pourquoi le texte n'est pas versionné

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

#    …ou, hors ligne : déposer soi-même un .txt dans fourni/
#    (ex. fourni/raven.txt)

# 2. générer les fichiers de l'exercice dans produit/
python make_data.py build
```

## Ce qui est produit dans `produit/`

| Fichier | Rôle dans l'exercice |
|---------|----------------------|
| `<nom>_une_ligne.txt` | tout le texte sur **une seule ligne** → à re-formater |
| `<nom>_une_ligne.donnees` | le **même** contenu, mauvaise extension → à renommer |
| `<nom>.odt` | à ouvrir avec **LibreOffice Writer** |
| `<nom>_brut.html` | à ouvrir dans le **navigateur** (rendu sans mise en forme) |
| `<nom>_style.html` + `style.css` | même contenu **avec CSS** → comparer les deux |
| `_corrige/<nom>.txt` | version correctement formatée (pour l'enseignant) |

## Les dossiers de la séance

`make_data.py`, `fourni/` et `produit/` ne servent qu'à la manipulation « un
texte, quatre formes ». Les autres manipulations ont leurs propres dossiers.

| Dossier | Manipulation |
|---------|--------------|
| [`hello/`](hello/) | deux « hello world », en Python et en C++ |
| [`erreurs/`](erreurs/) | trois programmes fautifs, à corriger dans l'éditeur |
| [`formats/`](formats/) | `octets.py`, qui lit les premiers octets d'un fichier |
| [`markdown/`](markdown/) | une recette en texte brut, à mettre en forme en Markdown |
| [`environnement/`](environnement/) | un petit projet Python : créer un environnement neuf, y installer `markdown`, convertir la recette en page HTML |
| [`trajet/`](trajet/) | le bonus vidéo « une vidéo, deux chemins » |

Chacun a son README.
